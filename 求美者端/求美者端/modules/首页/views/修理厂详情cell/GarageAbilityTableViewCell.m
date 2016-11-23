//
//  GarageAbilityTableViewCell.m
//  车联网-车主端
//
//  Created by AnYanbo on 16/7/26.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "GarageAbilityTableViewCell.h"
#import "GarageAbilityCollectionSectionHeader.h"
#import "GarageAbilityItemCollectionViewCell.h"

#define COLLECTION_COLUMN_COUNT             (4)
#define COLLECTION_CELL_H_SPACE             (1.0f)
#define COLLECTION_CELL_V_SPACE             (1.0f)
#define COLLECTION_SECTION_TOP              (10.0f)
#define COLLECTION_SECTION_LEFT             (10.0f)
#define COLLECTION_SECTION_RIGHT            (10.0f)
#define COLLECTION_SECTION_BOTTOM           (10.0f)

@interface GarageAbilityTableViewCell () <UICollectionViewDelegate, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout>

@property (strong, nonatomic) NSMutableArray* dataSource;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *titleName;                       // 标签名字
@property (nonatomic, strong) NSArray *imageName;                       // 图片名字

@end

@implementation GarageAbilityTableViewCell

+ (CGFloat)height
{
    return 315.0f;
}

+ (CGFloat)heightWithInfos:(NSString*)firstInfo, ...
{
    CGFloat height            = 0.0f;
    NSMutableArray* argsArray = [NSMutableArray array];
    
    @try
    {
        id arg;
        va_list argList;
        if (firstInfo != nil)
        {
            [argsArray addObject:firstInfo];
            
            va_start(argList, firstInfo);
            do
            {
                arg = va_arg(argList, id);
                
                if (arg != nil)
                {
                    [argsArray addObject:arg];
                }
            } while (arg != nil);
            va_end(argList);
        }
        
        NSInteger section = 0;
        for (NSString* arg in argsArray)
        {
            NSArray* infos        = [arg componentsSeparatedByString:@","];
            CGFloat sectionHeight = [[self class] sectionHeightWithInfos:infos section:section++];
            
            height = height + sectionHeight;
        }
    }
    @catch (NSException *exception)
    {
        
    }
    return height;
}

/**
 *  获取section的高度
 *
 *  @param infos
 *  @param section section索引
 *
 *  @return 高度
 */
+ (CGFloat)sectionHeightWithInfos:(NSArray*)infos section:(NSInteger)section
{
    CGFloat height              = 0.0f;
    CGFloat sectionHeaderHeight = [GarageAbilityCollectionSectionHeader height];
    CGFloat cellHeight          = [GarageAbilityItemCollectionViewCell height];
    
    @try
    {
        NSInteger count = 12;
//        for (NSString* item in infos)
//        {
//            if ([item isAvailability])
//            {
//                count += 1;
//            }
//        }
        
        // 计算行数
        NSInteger row = count / COLLECTION_COLUMN_COUNT;
        if (count != 0 && count % COLLECTION_COLUMN_COUNT != 0)
        {
            row += 1;
        }
        
        // 计算section高度
        if (row != 0)
        {
            CGFloat rowsHeight = cellHeight * row + COLLECTION_CELL_V_SPACE * (row - 1);
            height = sectionHeaderHeight    +
                     COLLECTION_SECTION_TOP +
                     rowsHeight             +
                     COLLECTION_SECTION_BOTTOM;
        }
    }
    @catch (NSException *exception)
    {
        
    }
    
    return height;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setup];
}

- (void)setup
{
    self.titleName = @[@"验医生",@"验机构",@"验用材",@"问专家",@"查病历",@"我要求美",@"直通韩国",@"委托保障",@"专家会诊",@"争议辩解",@"医美999",@"医美110"];
    self.imageName = @[@"1验医生",@"2验机构",@"3验器材",@"4问专家",@"5查病历",@"6我要求美",@"7直通韩国",@"8委托保障",@"9专家问诊",@"10争议调解",@"11医美999",@"12医美110"];
    
    // 配置layout
    CHTCollectionViewWaterfallLayout* layout = self.collectionView.collectionViewLayout;
    if ([layout isKindOfClass:[CHTCollectionViewWaterfallLayout class]])
    {
        layout.columnCount             = COLLECTION_COLUMN_COUNT;
        layout.minimumColumnSpacing    = COLLECTION_CELL_H_SPACE;
        layout.minimumInteritemSpacing = COLLECTION_CELL_V_SPACE;
        layout.sectionInset            = UIEdgeInsetsMake(COLLECTION_SECTION_TOP,
                                                          COLLECTION_SECTION_LEFT,
                                                          COLLECTION_SECTION_BOTTOM,
                                                          COLLECTION_SECTION_RIGHT);
    }
    
    // 注册section
    UINib* nib = [UINib nibWithNibName:[GarageAbilityCollectionSectionHeader className] bundle:nil];
    [self.collectionView registerNib:nib
          forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader
                 withReuseIdentifier:[GarageAbilityCollectionSectionHeader className]];
    
    // 注册cell
    nib = [UINib nibWithNibName:[GarageAbilityItemCollectionViewCell className] bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:[GarageAbilityItemCollectionViewCell className]];
    
    self.dataSource = [[NSMutableArray alloc] initWithArray:self.titleName];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)beginConfig
{
    [self.dataSource removeAllObjects];
}

- (void)endConfig
{
    [self.collectionView reloadData];
}

- (void)addAbilityInfo:(NSString*)info title:(NSString*)title
{
    [self addAbilityInfo:info title:title infoSeparator:@","];
}

- (void)addAbilityInfo:(NSString*)info title:(NSString*)title infoSeparator:(NSString*)separator
{
    @try
    {
        title     = title == nil ? @"" : title;
        separator = separator == nil ? @"" : separator;
        
        // 拆分
        NSArray* array = [info componentsSeparatedByString:separator];
        array = array == nil ? @[] : array;
        
        // 构建数据
        NSDictionary* dict = @{@"name"  : title,
                               @"array" : array};
        [self.dataSource addObject:dict];
    }
    @catch (NSException *exception)
    {
        NSLog(@"%s %@", __PRETTY_FUNCTION__, exception);
    }
}

/**
 *  获取section对应的cell个数
 *
 *  @param section section索引
 *
 *  @return cell数量
 */
- (NSInteger)itemCountAtSection:(NSInteger)section
{
//    NSInteger count = 0;
//    if (section < [self.dataSource count])
//    {
//        NSDictionary* dict = [self.dataSource objectAtIndex:section];
//        if ([dict isKindOfClass:[NSDictionary class]])
//        {
//            NSArray* array = [dict objectForKey:@"array"];
//            if ([array isKindOfClass:[NSArray class]])
//            {
//                for (NSString* item in array)
//                {
//                    if ([item isAvailability])
//                    {
//                        count += 1;
//                    }
//                }
//            }
//        }
//    }
    return 12;
}

/**
 *  获取IndexPath对应Cell
 *
 *  @param indexPath Cell索引
 *
 *  @return 标题
 */
- (NSString*)cellNameAtIndexPath:(NSIndexPath*)indexPath
{
    NSString* name = @"";
    @try
    {
        if (indexPath.section < [self.dataSource count])
        {
            NSDictionary* dict = [self.dataSource objectAtIndex:indexPath.section];
            if ([dict isKindOfClass:[NSDictionary class]])
            {
                NSArray* array = [dict objectForKey:@"array"];
                if ([array isKindOfClass:[NSArray class]])
                {
                    name = [array objectAtIndex:indexPath.item];
                }
            }
        }
    }
    @catch (NSException *exception)
    {
        
    }
    return name;
}

/**
 *  获取IndexPath对应SectionHeader的标题
 *
 *  @param indexPath SectionHeader索引
 *
 *  @return 标题
 */
- (NSString*)sectionNameAtIndexPath:(NSIndexPath*)indexPath
{
    NSString* name = @"";
    @try
    {
        if (indexPath.section < [self.dataSource count])
        {
            NSDictionary* dict = [self.dataSource objectAtIndex:indexPath.section];
            if ([dict isKindOfClass:[NSDictionary class]])
            {
                name = [dict objectForKey:@"name"];
            }
        }
        name = name == nil ? @"" : name;
    }
    @catch (NSException *exception)
    {
        
    }
    return name;
}

#pragma mark - UICollectionViewDelegate

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    GarageAbilityCollectionSectionHeader* header = [collectionView dequeueReusableSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader withReuseIdentifier:[GarageAbilityCollectionSectionHeader className] forIndexPath:indexPath];
    NSString* name = [self sectionNameAtIndexPath:indexPath];
    [header setupWithText:name];
    return header;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(header:didSelectItemAtIndex:)])
    {
        [self.delegate header:self didSelectItemAtIndex:indexPath.item];
    }
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.dataSource count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self itemCountAtSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GarageAbilityItemCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:[GarageAbilityItemCollectionViewCell className] forIndexPath:indexPath];
    [cell setupWithText:[self.dataSource objectAtIndex:indexPath.row]];
    [cell setImageViewWithImage:[self.imageName objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForHeaderInSection:(NSInteger)section
{
    return [GarageAbilityCollectionSectionHeader height];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CHTCollectionViewWaterfallLayout* layout = collectionViewLayout;
    if ([layout isKindOfClass:[CHTCollectionViewWaterfallLayout class]])
    {
        return CGSizeMake(layout.itemWidth, [GarageAbilityItemCollectionViewCell height]);
    }
    return CGSizeZero;
}

@end
