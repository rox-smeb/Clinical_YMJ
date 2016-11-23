//
//  BluetoothDeviceManager.h
//  美游时代
//
//  Created by AnYanbo on 16/5/25.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CBCentral.h>
#import <CoreBluetooth/CBPeripheral.h>
#import <CoreBluetooth/CBCentralManager.h>

#define NOTIFICATION_DEVICE_STATE_UPDATE                  (@"NOTIFICATION_DEVICE_STATE_UPDATE")                   // 蓝牙状态更新
#define NOTIFICATION_FOUND_NEAREST_BLUETOOTH_DEVICE       (@"NOTIFICATION_FOUND_NEAREST_BLUETOOTH_DEVICE")        // 发现最近的蓝牙设备 (Notification.object => 蓝牙设备Name)

/******************************************* 蓝牙设备信息 *******************************************/
@interface BluetoothDeviceInfo : NSObject <NSCopying>
{
    
}

@end
/**************************************************************************************************/

/******************************************* 蓝牙设备管理 *******************************************/
@class BluetoothDeviceManager;

@protocol BluetoothDeviceManagerDelegate <NSObject>

- (BOOL)manger:(BluetoothDeviceManager*)manager isFilterDeviceWithName:(NSString*)name;

@end

@interface BluetoothDeviceManager : NSObject

@property (assign, nonatomic) BOOL isMonitoring;
@property (assign, nonatomic) CBCentralManagerState state;
@property (weak, nonatomic) id<BluetoothDeviceManagerDelegate> delegate;
@property (strong, nonatomic) NSSet* filterSet;

+ (instancetype)sharedInstance;

- (void)startMonitor;
- (void)startMonitorWithFilterSet:(NSSet*)set;
- (void)stopMonitor;

@end
