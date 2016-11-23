//
//  BluetoothDeviceManager.m
//  美游时代
//
//  Created by AnYanbo on 16/5/25.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "BluetoothDeviceManager.h"
#include <math.h>

#define DEVICE_PRE_FIX                  (@[@"MYSD_"])                       // 蓝牙设备名称前缀列表
#define FOUND_DEVICE_DUR                (2.6f)                              // 发现附近蓝牙设备的间隔
#define MIN_RSSI_THRESHOLD              (6)                                 // 最小强度阈值 (用于两次相同设备间对比,强度变化如果小于该阈值,不认为发生过多距离改变)
#define MIDDLE_RSSI_THRESHOLD           (10)                                // 中间强度阈值
#define MAX_RSSI_THRESHOLD              (25)                                // 最大强度阈值

#define RSSI_DAMPING_THRESHOLD          (15)                                // 信号强度衰减系数
#define MIN_RSSI_TO_DELETE_THRESHOLD    (-120)                              // 信号强度小于阈值将被删除
#define MIN_DIS_THRESHOLD               (0.08f)                             // 最小强度阈值 (用于两次相同设备间对比,强度变化如果小于该阈值,不认为发生过多距离改变)
#define MIDDLE_DIS_THRESHOLD            (0.25f)                             // 中间强度阈值
#define MAX_DIS_THRESHOLD               (0.50f)                             // 最大强度阈值

/******************************************* 蓝牙设备信息 *******************************************/
@interface BluetoothDeviceInfo ()
{
    
}

@property (nonatomic, strong) CBPeripheral* peripheral;         // 设备对象
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSMutableArray* RSSIs;            // 设备强度记录
@property (nonatomic, assign) float mRSSI;                      // 设备平均强度
@property (nonatomic, assign) float distance;                   // 设备距离

@end

@implementation BluetoothDeviceInfo

- (id)init
{
    self = [super init];
    if (self)
    {
        self.RSSIs = [NSMutableArray array];
        self.mRSSI = -1000;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone;
{
    BluetoothDeviceInfo* copy = [[[self class] allocWithZone:zone] init];
    copy.peripheral           = [self.peripheral copyWithZone:zone];
    copy.RSSIs                = [self.RSSIs mutableCopyWithZone:zone];
    copy.name                 = [self.name copyWithZone:zone];
    copy.mRSSI                = self.mRSSI;
    copy.distance             = self.distance;
    return copy;
}

// 计算平均强度
- (float)middleRSSI
{
    float RSSI = self.mRSSI;
    
    // 如果超过2个强度值,去掉最大最小强度
    if ([self.RSSIs count] > 2)
    {
        // 排序
        [self.RSSIs sortUsingComparator:^NSComparisonResult(NSNumber* obj1, NSNumber* obj2) {
            
            NSInteger RSSI1 = [obj1 integerValue];
            NSInteger RSSI2 = [obj2 integerValue];
            
            if (RSSI1 > RSSI2)
            {
                return NSOrderedDescending;
            }
            else if (RSSI1 == RSSI2)
            {
                return NSOrderedSame;
            }
            else
            {
                return NSOrderedAscending;
            }
        }];
        
        // 去掉最小,最大的极端值
        NSNumber* first = [self.RSSIs firstObject];
        NSNumber* last = [self.RSSIs lastObject];
        
        [self.RSSIs removeFirstObject];
        [self.RSSIs removeLastObject];
        
        NSLog(@"%@ remove min:%d max:%d", self.name, (int)[first integerValue], (int)[last integerValue]);
    }
    
    // 计算强度
    if (self.RSSIs.count > 1)                           // 计算平均强度
    {
        NSInteger sum = 0;
        for (NSNumber* item in self.RSSIs)
        {
            sum += [item integerValue];
        }
        float middle = (float)sum / (float)self.RSSIs.count;
        RSSI = middle;
        
        NSLog(@"count > 1");
    }
    else if (self.RSSIs.count == 1)                     // 只有一个强度信息
    {
        RSSI = (float)[[self.RSSIs firstObject] intValue] * 1.0f;
        
        NSLog(@"count = 1");
    }
    
    NSLog(@"%@ middle RSSI:%f", self.name, RSSI);
    
    return RSSI;
}

// 通过强度计算距离
- (float)distanceWithRSSI:(float)rssi
{
    rssi = rssi < 0.0f ? -rssi : rssi;
    
    float x = 10.0f;
    float y = ((float)(rssi - 59)) / (10.0f * 2.0f);
    float d = 0.0f;
    
    d = pow(x, y);
    d = d < 0.0f ? 0.0f : d;
    
    return d;
}

// 计算设备距离
- (void)computeDistance
{
    // 计算平均强度
    @try
    {
        self.mRSSI = [self middleRSSI];
    }
    @catch (NSException *exception)
    {
        self.mRSSI = -1000;
    }
    
    // 根据强度计算距离
    self.distance = [self distanceWithRSSI:self.mRSSI];
}

- (void)addRSSI:(NSNumber*)RSSI
{
    if (self.RSSIs == nil)
    {
        self.RSSIs = [NSMutableArray array];
    }
    
    if (RSSI != nil && [RSSI isKindOfClass:[NSNumber class]])
    {
        [self.RSSIs addObject:RSSI];
    }
}

- (void)setupWithPeripheral:(CBPeripheral*)peripheral
          advertisementData:(NSDictionary*)advertisementData
                    addRSSI:(NSNumber*)RSSI
{
    self.peripheral = peripheral;
    self.name = peripheral.name;
    if ([advertisementData isKindOfClass:[NSDictionary class]])
    {
        NSString* localName = [advertisementData objectForKey:CBAdvertisementDataLocalNameKey];
        if ([localName isKindOfClass:[NSString class]])
        {
            self.name = [localName copy];
        }
    }
    [self addRSSI:RSSI];
}

// 信号衰减
- (void)dampingRSSI
{
    self.mRSSI -= RSSI_DAMPING_THRESHOLD;
}

// 清空信号列表
- (void)resetRSSIs
{
    [self.RSSIs removeAllObjects];
}

@end
/**************************************************************************************************/

/******************************************* 蓝牙设备管理 *******************************************/
@interface BluetoothDeviceManager () <CBCentralManagerDelegate>
{
    dispatch_once_t _onceFoundDevice;
}

@property (strong, nonatomic) NSMutableDictionary* peripheralDict;      // 附近设备 (name->peripheral)
@property (strong, nonatomic) CBCentralManager* centralManager;         // 设备管理
@property (strong, nonatomic) BluetoothDeviceInfo* nearestDeviceInfo;   // 距离最近的设备信息

@end

@implementation BluetoothDeviceManager

+ (instancetype)sharedInstance
{
    static dispatch_once_t once  = 0;
    static BluetoothDeviceManager* instance = nil;
    
    dispatch_once(&once, ^(){
        instance = [[BluetoothDeviceManager alloc] init];
    });
    
    return instance;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.peripheralDict = [NSMutableDictionary dictionary];
        self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    }
    return self;
}

- (BOOL)isMonitoring
{
    return self.centralManager.isScanning;
}

- (CBCentralManagerState)state
{
    if (self.centralManager != nil)
    {
        return self.centralManager.state;
    }
    return CBCentralManagerStateUnknown;
}

// 发现蓝牙设备列表
- (void)onBluetoothDeviceFound
{
    // 获取周围设备信息列表
    NSArray* devices = [self.peripheralDict allValues];
    if ([devices count] == 0)
    {
        return;
    }
    
    // 计算每个设备的距离
    for (BluetoothDeviceInfo* device in devices)
    {
        [device computeDistance];
    }
    
    // 对发现设备列表排序找到强度最大的设备
    NSArray* nearestDevices = [devices sortedArrayUsingComparator:^NSComparisonResult(BluetoothDeviceInfo* obj1, BluetoothDeviceInfo* obj2) {
        
        if (obj1.distance > obj2.distance)
        {
            return NSOrderedDescending;
        }
        else if (obj1.distance == obj2.distance)
        {
            return NSOrderedSame;
        }
        else
        {
            return NSOrderedAscending;
        }
    }];
    BluetoothDeviceInfo* sortedNearestDeviceInfo = [nearestDevices firstObject];            // 排序的最近设备
    BluetoothDeviceInfo* finalNearestDeviceInfo  = sortedNearestDeviceInfo;                 // 最终确定的最近设备默认为排序出的最近设备
    
    // 判断当前设备列表中是否包含上次获取的最近设备
    BluetoothDeviceInfo* containedDeviceInfo = nil;
    if (self.nearestDeviceInfo.name != nil)
    {
        containedDeviceInfo = [self.peripheralDict objectForKey:self.nearestDeviceInfo.name];
    }
    
    NSLog(@"------------------------------------------------------");
    NSLog(@"last nearest:%@ sorted nearest:%@", self.nearestDeviceInfo.name, sortedNearestDeviceInfo.name);
    
    // 包含之前的最近设备信息
    if (containedDeviceInfo != nil && containedDeviceInfo != sortedNearestDeviceInfo)
    {
        /**
         *  A.上次发现的最近设备距离
         *  B.上次最近的设备在本次发现中的距离
         *  C.本次发现中通过排序找到的最近设备的距离
         */
        float absDis1 = containedDeviceInfo.distance - self.nearestDeviceInfo.distance;
        float absDis2 = containedDeviceInfo.distance - sortedNearestDeviceInfo.distance;

        if (absDis2 > MAX_DIS_THRESHOLD)                                              // B相对于C的强度变化大于最大阈值
        {
            finalNearestDeviceInfo = sortedNearestDeviceInfo;
            NSLog(@"condition --- 1");
        }
        else if (absDis2 > MIDDLE_DIS_THRESHOLD)                                      // B相对于C的强度变化大于中间阈值
        {
            if (absDis1 < MIN_DIS_THRESHOLD)                                          // B相对于A的强度变化小于阈值
            {
                finalNearestDeviceInfo = containedDeviceInfo;
                NSLog(@"condition --- 2");
            }
            else
            {
                finalNearestDeviceInfo = sortedNearestDeviceInfo;
                NSLog(@"condition --- 3");
            }
        }
        else
        {
            finalNearestDeviceInfo = containedDeviceInfo;
            NSLog(@"condition --- 4");
        }
        
        NSLog(@"last DIS:%f now DIS:%f nearest DIS:%f", self.nearestDeviceInfo.distance,
                                                        containedDeviceInfo.distance,
                                                        sortedNearestDeviceInfo.distance);
        NSLog(@"absDIS1=%f absDIS2=%f", absDis1, absDis2);
    }
    else
    {
        NSLog(@"nearest RSSI:%f DIS:%f", finalNearestDeviceInfo.mRSSI, finalNearestDeviceInfo.distance);
    }

    if ([self.nearestDeviceInfo.name isEqualToString:finalNearestDeviceInfo.name])
    {
        NSLog(@"final nearest:%@", finalNearestDeviceInfo.name);
    }
    else
    {
        NSLog(@"++++ final nearest:%@", finalNearestDeviceInfo.name);
    }
    NSLog(@"------------------------------------------------------\n");
    
    // 发现最近的蓝牙设备
    self.nearestDeviceInfo = [finalNearestDeviceInfo copy];
    
    // 发送发现最近设备通知
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FOUND_NEAREST_BLUETOOTH_DEVICE object:finalNearestDeviceInfo.name];
    
//     删除设备列表
//    [self.peripheralDict removeAllObjects];
    
    // 对设备进行衰减
    NSArray* allKeys = [[self.peripheralDict allKeys] copy];
    for (NSString* key in allKeys)
    {
        BluetoothDeviceInfo* info = [self.peripheralDict objectForKey:key];
        
        // 衰减设备
        [info dampingRSSI];
        
        // 清空RSSI列表
        [info resetRSSIs];
        
        // 设备信号强度过弱->认为设备离开
        if (info.mRSSI < MIN_RSSI_TO_DELETE_THRESHOLD)
        {
            [self.peripheralDict removeObjectForKey:key];
            NSLog(@"%@ damping to deleted.", key);
        }
    }
    
    // 重新开启监控发现设备的调用
    _onceFoundDevice = 0;
}

- (void)startMonitor
{
    // 正在监听
    if ([self.centralManager isScanning])
    {
        return;
    }
    
    // 重新开启监控发现设备的调用
    _onceFoundDevice = 0;
    
    // 设置默认状态
    self.nearestDeviceInfo = nil;
    
    NSDictionary* options = @{CBCentralManagerScanOptionAllowDuplicatesKey : @(YES)};
    [self.centralManager scanForPeripheralsWithServices:nil options:options];
}

- (void)startMonitorWithFilterSet:(NSSet*)set
{
    // 设置过滤集合
    self.filterSet = set;
    
    // 开始监听
    [self startMonitor];
}

- (void)stopMonitor
{
    // 未监听
    if ([self.centralManager isScanning] == NO)
    {
        return;
    }
    
    // 重新开启监控发现设备的调用
    _onceFoundDevice = 0;
    
    // 停止蓝牙扫描
    [self.centralManager stopScan];
    
    // 设置默认状态
    self.nearestDeviceInfo = nil;
    self.filterSet = nil;
    
    // 移除所有附近设备
    [self.peripheralDict removeAllObjects];
}

#pragma mark - CBCentralManagerDelegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_DEVICE_STATE_UPDATE object:nil];
}

- (void)centralManager:(CBCentralManager *)central
 didDiscoverPeripheral:(CBPeripheral *)peripheral
     advertisementData:(NSDictionary<NSString *, id> *)advertisementData
                  RSSI:(NSNumber *)RSSI
{
    NSString* name = peripheral.name;
    if ([advertisementData isKindOfClass:[NSDictionary class]])
    {
        NSString* localName = [advertisementData objectForKey:CBAdvertisementDataLocalNameKey];
        if ([localName isAvailability])
        {
            name = localName;
        }
    }
    for (NSString* prefix in DEVICE_PRE_FIX)
    {
        if ([name hasPrefix:prefix])          // 找到需要的蓝牙盒子
        {
            // 无效的信号强度
            if ([RSSI integerValue] == 127)
            {
                return;
            }
            
            // 判断是否过滤 (默认为过滤设备)
            BOOL isInFilter = YES;
            if ([self.delegate respondsToSelector:@selector(manger:isFilterDeviceWithName:)])
            {
                isInFilter = [self.delegate manger:self isFilterDeviceWithName:name];
            }
            else
            {
                // set进行过滤
                if (self.filterSet != nil)
                {
                    isInFilter = NO;
                    
                    // 在过滤集合中包含的蓝牙设备才进行收集
                    if ([self.filterSet containsObject:name])
                    {
                        isInFilter = YES;
                    }
                }
            }
            
            // 过滤设备->添加蓝牙设备字典中
            if (isInFilter)
            {
                // 创建设备信息对象
                BluetoothDeviceInfo* info = [self.peripheralDict objectForKey:name];
                if (info == nil)
                {
                    info = [[BluetoothDeviceInfo alloc] init];
                }
                [info setupWithPeripheral:peripheral
                        advertisementData:advertisementData
                                  addRSSI:RSSI];
                
                // 添加蓝牙设备
                if (info != nil )
                {
                    [self.peripheralDict setObject:info forKey:name];
                }
            }
            
            dispatch_once(&_onceFoundDevice, ^{
                
                // 定期执行发现设备
                [self performSelector:@selector(onBluetoothDeviceFound) withObject:nil afterDelay:FOUND_DEVICE_DUR];
            });
            
            break;
        }
    }
}

@end
