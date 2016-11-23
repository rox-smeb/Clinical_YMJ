//
//  ConsultationTableViewController.m
//  求美者端
//
//  Created by AnYanbo on 16/8/18.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "ConsultationTableViewController.h"
#import "ImagePickerManager.h"
#import "InputAccessoryView.h"
#import "ImageAddCollectionViewCell.h"
#import "SegmentedControlConfiger.h"

#import "YBCommonKit/UIPlaceHolderTextView.h"

#define MAX_IMAGE_PICKER_COUNT             (15)

@interface ConsultationTableViewController () <UICollectionViewDelegate,
                                               UICollectionViewDataSource,
                                               CHTCollectionViewDelegateWaterfallLayout,
                                               ImagePickerManagerDelegate,
                                               ImageAddCollectionViewCellDelegate>

@property (strong, nonatomic) NSMutableArray* imageArray;
@property (weak, nonatomic) IBOutlet UISegmentedControl *countrySegmentedControl;
@property (weak, nonatomic) IBOutlet UIPlaceHolderTextView *contentTextView;
@property (weak, nonatomic) IBOutlet UICollectionView *imageCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@end

@implementation ConsultationTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setup];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 隐藏当前导航栏的FakeBar
    UIView* fakeBar = [self.view viewWithTag:10000];
    if ([fakeBar isKindOfClass:[UIView class]])
    {
        [fakeBar setHidden:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)setup
{
    self.imageArray = [NSMutableArray array];
    
    UINib* nib = [UINib nibWithNibName:[ImageAddCollectionViewCell className] bundle:nil];
    [self.imageCollectionView registerNib:nib forCellWithReuseIdentifier:[ImageAddCollectionViewCell className]];
    
    [self.tableView solveCrashWithIOS7];
    [self.tableView removeSeperatorBlank];
    
    self.contentTextView.placeholder = @"请详细描述手术经历及手术诉求";
    [InputAccessoryView createWithInputView:self.contentTextView];
    
    [SegmentedControlConfiger configSegmentedControl:self.countrySegmentedControl];
    
    self.submitButton.layer.cornerRadius = 4.0f;
    
    CHTCollectionViewWaterfallLayout* layout = (CHTCollectionViewWaterfallLayout*)self.imageCollectionView.collectionViewLayout;
    if ([layout isKindOfClass:[CHTCollectionViewWaterfallLayout class]])
    {
        layout.columnCount = 3;
        layout.minimumColumnSpacing = 10.0f;
        layout.minimumInteritemSpacing = 10.0f;
        layout.sectionInset = UIEdgeInsetsMake(5.0f, 10.0f, 10.0f, 10.0f);
    }
}

// 上传佐证资料
- (IBAction)onAddImageTouch:(UIButton *)sender
{
    NSInteger count = MAX_IMAGE_PICKER_COUNT - [self.imageArray count];
    if (count > 0)
    {
        ImagePickerManager* manager = [ImagePickerManager instanceWithDelegate:self];
        [manager pickerImageInViewController:self];
    }
}

#pragma mark - ImagePickerManagerDelegate

- (NSInteger)imagePickerManagerMaxPickerCount:(ImagePickerManager*)manager
{
    NSInteger count = MAX_IMAGE_PICKER_COUNT - [self.imageArray count];
    count = count < 0 ? 0 : count;
    return count;
}

- (void)imagePickerManager:(ImagePickerManager*)manager didPickerImages:(NSArray<UIImage*>*)images
{
    if ([self.imageArray backInsertArray:images])
    {
        [self.imageCollectionView reloadData];
        [self.tableView reloadData];
    }
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.imageArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageAddCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ImageAddCollectionViewCell className] forIndexPath:indexPath];
    cell.delegate = self;
    if (indexPath.item < [self.imageArray count])
    {
        UIImage* image = [self.imageArray objectAtIndex:indexPath.item];
        [cell setupWithRes:image indexPath:indexPath];
    }
    return cell;
}

#pragma mark - ImageAddCollectionViewCellDelegate

- (void)imageAddCell:(ImageAddCollectionViewCell*)cell
didDeleteAtIndexPath:(NSIndexPath*)indexPath
           withAsset:(id)asset
{
    [self.imageArray removeObject:asset];
    [self.imageCollectionView reloadData];
    [self.tableView reloadData];
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([collectionViewLayout isKindOfClass:[CHTCollectionViewWaterfallLayout class]])
    {
        CHTCollectionViewWaterfallLayout* layout = (CHTCollectionViewWaterfallLayout*)collectionViewLayout;
        return [ImageAddCollectionViewCell sizeWithWidth:layout.itemWidth];
    }
    return CGSizeZero;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    UIView* subView = [cell viewWithTag:1000];
    if ([subView isKindOfClass:[UIButton class]])
    {
        UIButton* button = (UIButton*)subView;
        [button sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    else if ([subView respondsToSelector:@selector(becomeFirstResponder)])
    {
        [subView becomeFirstResponder];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [super tableView:tableView heightForRowAtIndexPath:indexPath];
    if (indexPath.row == 2)
    {
        NSInteger count = [self.imageArray count];
        if (count == 0)
        {
            height = 0.0f;
        }
        else
        {
            CHTCollectionViewWaterfallLayout* layout = (CHTCollectionViewWaterfallLayout*)self.imageCollectionView.collectionViewLayout;
            if ([layout isKindOfClass:[CHTCollectionViewWaterfallLayout class]])
            {
                NSInteger row = count / layout.columnCount;
                if (count % layout.columnCount)
                {
                    row += 1;
                }
                
                CGFloat itemWidth = [UIScreen screenWidth] - (layout.columnCount - 1) * layout.minimumColumnSpacing - layout.sectionInset.left - layout.sectionInset.right;
                itemWidth /= layout.columnCount;
                height = layout.sectionInset.top + layout.sectionInset.bottom + itemWidth * row + (row - 1) * layout.minimumInteritemSpacing;
            }
            else
            {
                height = 0.0f;
            }
        }
    }
    return height;
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    [cell solveCrashWithIOS7];
    return cell;
}

@end
