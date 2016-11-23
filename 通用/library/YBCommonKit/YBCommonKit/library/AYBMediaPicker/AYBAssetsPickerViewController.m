//
//  AYBAssetsPickerViewController.m
//  果动校园
//
//  Created by AnYanbo on 15/2/6.
//  Copyright (c) 2015年 GDSchool. All rights reserved.
//

#import "AYBAssetsPickerViewController.h"
#import "AYBAssetsCollectionViewCell.h"
#import "AYBWrapperPickerController.h"

@interface AYBAssetsPickerViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    
}

@property (nonatomic, strong) ALAssetsGroup *assetsGroup;                       // 当前分组
@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;                   // 资源库

@property (nonatomic, strong) NSMutableArray *groups;                           // 分组信息 (元素:ALAssetsGroup)
@property (nonatomic, strong) NSMutableArray *assets;                           // 资源信息 (元素:ALAsset)

@property (nonatomic, strong) AYBGroupPickerView* groupPicker;                  // 分组选择器
@property (nonatomic, strong) AYBWrapperPickerController* wrapperPicker;        // 相机拍摄

@property (nonatomic, assign) NSInteger numberOfPhotos;                         // 图片数量
@property (nonatomic, assign) NSInteger numberOfVideos;                         // 视频数量
@property (nonatomic, assign) NSInteger maximumNumberOfSelection;               // 最大可选数量

@end

@implementation AYBAssetsPickerViewController

+ (instancetype)create
{
    AYBAssetsPickerViewController* pRet = nil;
    @try
    {
        UIStoryboard* stroyboard = [UIStoryboard storyboardWithName:@"AYBMediaPicker" bundle:nil];
        pRet = [stroyboard instantiateViewControllerWithIdentifier:@"AYBAssetsPickerViewController"];
    }
    @catch (NSException *exception)
    {
        NSLog(@"%s %@", __PRETTY_FUNCTION__, [exception description]);
    }
    
    return pRet;
}

+ (ALAssetsLibrary *)defaultAssetsLibrary
{
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary* library = nil;
    
    dispatch_once(&pred, ^(){
        library = [[ALAssetsLibrary alloc] init];
    });
    
    return library;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (self.topBarColor != nil)
    {
        self.topBar.backgroundColor = self.topBarColor;
    }
    
    [self initNotifiaction];
    [self initVariable];
    [self initImagePicker];
    
    [self setupLayer];
    [self setupOneMediaTypeSelection];
    
    // 加载assets
    __weak typeof(self) weakSelf = self;
    AssetsSuccessBlock success = ^()
    {
        [weakSelf.groupPicker.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    };
    [self setupGroup:success withSetupAsset:YES];
    
    [self setupCollectionView];
    [self setupGroupPickerview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    // 解决ios8中view的z次序不正确
    [self.view bringSubviewToFront:self.groupPicker];
    [self.view bringSubviewToFront:self.topBar];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)initNotifiaction
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(assetsLibraryUpdated:) name:ALAssetsLibraryChangedNotification object:nil];
}

- (void)initVariable
{
    self.groups                   = nil;
    self.assetsFilter             = [ALAssetsFilter allPhotos];
    self.maximumNumberOfSelection = self.maximumNumberOfSelectionPhoto;
    
    self.bottomHintLabel.text     = [NSString stringWithFormat:@"请选择最多%ld张图片", (long)(self.maximumNumberOfSelection)];
}

- (void)initImagePicker
{
    self.wrapperPicker = [[AYBWrapperPickerController alloc] init];
    self.wrapperPicker.delegate = self;
    self.wrapperPicker.allowsEditing = NO;
    self.wrapperPicker.videoQuality = UIImagePickerControllerQualityTypeMedium;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        self.wrapperPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.wrapperPicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    }
}

- (void)setupLayer
{
    self.doneButton.layer.cornerRadius  = 15.0f;
    self.doneButton.layer.masksToBounds = YES;
    self.doneButton.clipsToBounds       = YES;
}

- (void)setupOneMediaTypeSelection
{
    if (_maximumNumberOfSelectionMedia > 0)                         // 选择所有Media
    {
        self.assetsFilter = [ALAssetsFilter allAssets];
        self.maximumNumberOfSelection = self.maximumNumberOfSelectionMedia;
    }
    else
    {
        if (_maximumNumberOfSelectionPhoto == 0)                    // 只选择照片
        {
            self.assetsFilter = [ALAssetsFilter allVideos];
            self.maximumNumberOfSelection = self.maximumNumberOfSelectionVideo;
        }
        else if (_maximumNumberOfSelectionVideo == 0)               // 只选择视频
        {
            self.assetsFilter = [ALAssetsFilter allPhotos];
            self.maximumNumberOfSelection = self.maximumNumberOfSelectionPhoto;
        }
        else
        {
        }
    }
}

- (void)setupCollectionView
{
    CGRect appFrame    = [[UIScreen mainScreen] applicationFrame];
    CGFloat itemLength = (appFrame.size.width - 2.0) / 3.0f;
    
    UICollectionViewFlowLayout* layout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    if ([layout isKindOfClass:[UICollectionViewFlowLayout class]])
    {
        layout.itemSize                = CGSizeMake(itemLength, itemLength);
        layout.sectionInset            = UIEdgeInsetsMake(1.0, 0, 0, 0);
        layout.minimumInteritemSpacing = 1.0;
        layout.minimumLineSpacing      = 1.0;
    }
    
    self.collectionView.bounces                 = YES;
    self.collectionView.alwaysBounceVertical    = YES;
    self.collectionView.allowsMultipleSelection = YES;
}

- (void)setupGroupPickerview
{
    __weak typeof(self) weakSelf = self;
    self.groupPicker = [[AYBGroupPickerView alloc] initWithGroups:self.groups];
    self.groupPicker.blockTouchCell = ^(NSInteger row){
        [weakSelf changeGroup:row filter:weakSelf.assetsFilter];
    };
    
    [self.view insertSubview:self.groupPicker aboveSubview:self.bottomBar];
    [self.view bringSubviewToFront:self.groupPicker];
    [self.view bringSubviewToFront:self.topBar];
    
    [self topBarTitleArrowRotate];
}

- (void)setupGroup:(AssetsSuccessBlock)endblock withSetupAsset:(BOOL)doSetupAsset
{
    if (self.assetsLibrary == nil)
    {
        self.assetsLibrary = [self.class defaultAssetsLibrary];
    }
    
    if (self.groups == nil)
    {
        self.groups = [[NSMutableArray alloc] init];
    }
    else
    {
        [self.groups removeAllObjects];
    }
    
    __weak typeof(self) weakSelf = self;
    ALAssetsFilter* assetsFilter = [ALAssetsFilter allAssets];
    ALAssetsLibraryGroupsEnumerationResultsBlock resultsBlock = ^(ALAssetsGroup *group, BOOL *stop)
    {
        if (group != nil)
        {
            [group setAssetsFilter:assetsFilter];
            NSInteger groupType = [[group valueForProperty:ALAssetsGroupPropertyType] integerValue];
            if (groupType == ALAssetsGroupSavedPhotos)
            {
                [weakSelf.groups insertObject:group atIndex:0];
                if (doSetupAsset)
                {
                    weakSelf.assetsGroup = group;
                    [weakSelf setupAssets:nil];
                }
            }
            else
            {
                if (group.numberOfAssets > 0)
                {
                    [weakSelf.groups addObject:group];
                }
            }
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.groupPicker reloadData];
                if (endblock)
                {
                    endblock();
                }
            });
        }
    };

    ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error) {

        // 未开启相册服务
        if (error.code == ALAssetsLibraryAccessUserDeniedError ||
            error.code == ALAssetsLibraryAccessGloballyDeniedError)
        {
            self.photoHintView.hidden          = NO;
            self.navTitleLabel.text            = @"无法访问相册";
            self.navTitleArrowImageView.hidden = YES;
        }
    };
    
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll
                                      usingBlock:resultsBlock
                                    failureBlock:failureBlock];
}

- (void)setupAssets:(AssetsSuccessBlock)successBlock
{
    if (self.assets == nil)
    {
        self.assets = [[NSMutableArray alloc] init];
    }
    else
    {
        [self.assets removeAllObjects];
    }
    
    if (self.assetsGroup == nil && [self.groups count] > 0)
    {
        self.assetsGroup = self.groups[0];
    }
    [self.assetsGroup setAssetsFilter:self.assetsFilter];
    
    self.navTitleLabel.text = [self.assetsGroup valueForProperty:ALAssetsGroupPropertyName];
    
    NSInteger assetCount = [self.assetsGroup numberOfAssets];
    ALAssetsGroupEnumerationResultsBlock resultsBlock = ^(ALAsset *asset, NSUInteger index, BOOL *stop) {
        if (asset != nil)
        {
            [self.assets addObject:asset];
            
            NSString *type = [asset valueForProperty:ALAssetPropertyType];
            
            if ([type isEqual:ALAssetTypePhoto])
            {
                self.numberOfPhotos++;
            }
            if ([type isEqual:ALAssetTypeVideo])
            {
                self.numberOfVideos++;
            }
        }
        else if (self.assets.count >= assetCount)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.collectionView reloadData];
                if (successBlock)
                {
                    successBlock();
                }
            });
        }
    };
    [self.assetsGroup enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:resultsBlock];
}

- (void)topBarTitleArrowRotate
{
    [UIView animateWithDuration:0.25 animations:^{
        if(self.groupPicker.isOpen)
        {
            self.navTitleArrowImageView.transform = CGAffineTransformMakeRotation(M_PI);
        }
        else
        {
            self.navTitleArrowImageView.transform = CGAffineTransformIdentity;
        }
    } completion:^(BOOL finished) {
    }];
}

- (void)changeGroup:(NSInteger)item filter:(ALAssetsFilter *)filter
{
    if (item < [self.groups count])
    {
        self.assetsFilter = filter;
        self.assetsGroup = self.groups[item];
        
        [self setupAssets:nil];
        [self.groupPicker.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:item inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        [self.groupPicker dismiss:YES];
        [self topBarTitleArrowRotate];
        
        [self setAssetsCountWithSelectedIndexPaths:nil];
    }
}

- (void)setAssetsCountWithSelectedIndexPaths:(NSArray *)indexPaths
{
    [self.doneButton setTitle:[NSString stringWithFormat:@"%lu", (unsigned long)indexPaths.count] forState:UIControlStateNormal];
}

- (void)finishPickingAssets
{
    NSMutableArray* assets = [[NSMutableArray alloc] init];
    
    for (NSIndexPath* indexPath in self.collectionView.indexPathsForSelectedItems)
    {
        if (indexPath.item < [self.assets count])
        {
            [assets addObject:[self.assets objectAtIndex:indexPath.item]];
        }
    }
    
    if ([assets count] > 0)
    {
        AYBAssetsPickerViewController* picker = (AYBAssetsPickerViewController*)self;
        
        if ([picker.delegate respondsToSelector:@selector(AYBAssetsPickerViewController:didFinishPickingAssets:)])
        {
            [picker.delegate AYBAssetsPickerViewController:picker didFinishPickingAssets:assets];
        }
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

// 顶部工具栏关闭按钮点击事件
- (IBAction)onNavCloseButtonTouch:(id)sender
{
    if([self.delegate respondsToSelector:@selector(AYBAssetsPickerViewControllerDidCancel:)])
    {
        [self.delegate AYBAssetsPickerViewControllerDidCancel:self];
    }
    
    [self dismissViewControllerAnimated:YES completion:^(){
        
    }];
}

- (IBAction)onNavTitleLabelTap:(UITapGestureRecognizer*)sender
{
    [self.groupPicker toggle];
    [self topBarTitleArrowRotate];
}

- (IBAction)onBottomCameraButtonTouch:(id)sender
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"错误"
                                                              message:@"设备不支持拍照"
                                                             delegate:nil
                                                    cancelButtonTitle:@"确认"
                                                    otherButtonTitles: nil];
        [myAlertView show];
    }
    else
    {
        __weak typeof(self) weakSelf = self;
        [self presentViewController:self.wrapperPicker animated:YES completion:^{
            if (![weakSelf.assetsGroup isEqual:weakSelf.groups[0]])
            {
                weakSelf.assetsGroup = weakSelf.groups[0];
                [weakSelf changeGroup:0 filter:weakSelf.assetsFilter];
            }
        }];
    }
}

- (IBAction)onBottomDoneButtonTouch:(id)sender
{
    [self finishPickingAssets];
}

#pragma mark - Collection View Data Source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.assets.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellID = @"AYBAssetsCollectionViewCell";
    AYBAssetsCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    [cell applyData:[self.assets objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark - Collection View Delegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([collectionView indexPathsForSelectedItems].count < self.maximumNumberOfSelection)
    {
        return YES;
    }
    else
    {
        NSIndexPath* lastSelected = [[collectionView indexPathsForSelectedItems] lastObject];
        if (lastSelected != nil)
        {
            [collectionView deselectItemAtIndexPath:lastSelected animated:YES];
            return YES;
        }
        return NO;
    }
    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self setAssetsCountWithSelectedIndexPaths:collectionView.indexPathsForSelectedItems];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self setAssetsCountWithSelectedIndexPaths:collectionView.indexPathsForSelectedItems];
}

#pragma mark - UIImagerPickerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (CFStringCompare((CFStringRef) [info objectForKey:UIImagePickerControllerMediaType], kUTTypeImage, 0) == kCFCompareEqualTo)
    {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        [self.assetsLibrary writeImageToSavedPhotosAlbum:image.CGImage metadata:info[UIImagePickerControllerMediaMetadata] completionBlock:^(NSURL *assetURL, NSError *error) {
            if (error != nil)
            {
                NSLog(@"%s error:%@", __PRETTY_FUNCTION__, error);
                [SVProgressHUD showErrorWithStatus:@"图片保存失败!"];
            }
        }];
    }
    else
    {
        [self.assetsLibrary writeVideoAtPathToSavedPhotosAlbum:info[UIImagePickerControllerMediaURL] completionBlock:^(NSURL *assetURL, NSError *error){
            
        }];
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{

    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - Notification

- (void)assetsLibraryUpdated:(NSNotification *)notification
{
    dispatch_async(dispatch_get_main_queue(), ^{
        // Recheck here
        if ([notification.name isEqualToString:ALAssetsLibraryChangedNotification])
        {
            NSDictionary* info        = [notification userInfo];
            NSSet *updatedAssets      = [info objectForKey:ALAssetLibraryUpdatedAssetsKey];
            NSSet *updatedAssetGroup  = [info objectForKey:ALAssetLibraryUpdatedAssetGroupsKey];
            NSSet *deletedAssetGroup  = [info objectForKey:ALAssetLibraryDeletedAssetGroupsKey];
            NSSet *insertedAssetGroup = [info objectForKey:ALAssetLibraryInsertedAssetGroupsKey];
            
            NSLog(@"updated assets:%@", updatedAssets);
            NSLog(@"updated asset group:%@", updatedAssetGroup);
            NSLog(@"deleted asset group:%@", deletedAssetGroup);
            NSLog(@"inserted asset group:%@", insertedAssetGroup);
            
            if (notification.userInfo == nil)
            {
                // AllClear
                [self setupGroup:nil withSetupAsset:YES];
                return;
            }
            if (insertedAssetGroup.count > 0 || deletedAssetGroup.count > 0)
            {
                [self setupGroup:nil withSetupAsset:NO];
                return;
            }
            if (notification.userInfo.count == 0)
            {
                return;
            }
            
            if (updatedAssets.count < 2 && updatedAssetGroup.count == 0 && deletedAssetGroup.count == 0 && insertedAssetGroup.count == 0)
            {
                [self.assetsLibrary assetForURL:[updatedAssets allObjects][0] resultBlock:^(ALAsset *asset) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if([[[self.assets[0] valueForProperty:ALAssetPropertyAssetURL] absoluteString] isEqualToString:[[asset valueForProperty:ALAssetPropertyAssetURL] absoluteString]])
                        {
                            NSIndexPath *newPath = [NSIndexPath indexPathForRow:0 inSection:0];
                            [self.collectionView selectItemAtIndexPath:newPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
                            [self setAssetsCountWithSelectedIndexPaths:self.collectionView.indexPathsForSelectedItems];
                        }
                    });
                    
                } failureBlock:nil];
                return;
            }
            NSMutableArray *selectedItems = [NSMutableArray array];
            NSArray *selectedPath = self.collectionView.indexPathsForSelectedItems;
            
            for (NSIndexPath *idxPath in selectedPath)
            {
                [selectedItems addObject:[self.assets objectAtIndex:idxPath.row]];
            }
            NSInteger beforeAssets = self.assets.count;
            [self setupAssets:^{
                for (ALAsset *item in selectedItems)
                {
                    for (ALAsset *asset in self.assets)
                    {
                        if([[[asset valueForProperty:ALAssetPropertyAssetURL] absoluteString] isEqualToString:[[item valueForProperty:ALAssetPropertyAssetURL] absoluteString]])
                        {
                            NSUInteger idx = [self.assets indexOfObject:asset];
                            NSIndexPath *newPath = [NSIndexPath indexPathForRow:idx inSection:0];
                            [self.collectionView selectItemAtIndexPath:newPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
                        }
                    }
                }
                [self setAssetsCountWithSelectedIndexPaths:self.collectionView.indexPathsForSelectedItems];
                if(self.assets.count > beforeAssets)
                {
                    [self.collectionView setContentOffset:CGPointMake(0, 0) animated:NO];
                }
            }];
        }
    });
}

@end
