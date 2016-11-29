//
//  ApplyFailRepairTableViewController.m
//  求美者端
//
//  Created by AnYanbo on 16/8/18.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "ApplyFailRepairTableViewController.h"
#import "ImagePickerManager.h"
#import "InputAccessoryView.h"
#import "ImageAddCollectionViewCell.h"
#import "GuaranteeOrderViewController.h"
#import "YBCommonKit/UIPlaceHolderTextView.h"
#import "UserInfo.h"
#import "NotificationsDefine.h"
#import "MirrorServerInteraction.h"

#define MAX_IMAGE_PICKER_COUNT             (15)

@interface ApplyFailRepairTableViewController () <UICollectionViewDelegate,
                                                  UICollectionViewDataSource,
                                                  CHTCollectionViewDelegateWaterfallLayout,
                                                  ImagePickerManagerDelegate,
                                                  ImageAddCollectionViewCellDelegate,
                                                  ApplyFailRepairViewControllerDelegate>
@property (weak, nonatomic) ApplyFailRepairViewController *parentVC;

@property (strong, nonatomic) NSMutableArray* imageArray;
@property (weak, nonatomic) IBOutlet UITextField *projectTextField;
@property (weak, nonatomic) IBOutlet UITextField *doctorNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *doctorPhoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *agencyTextField;
@property (weak, nonatomic) IBOutlet UITextField *contactTextField;
@property (weak, nonatomic) IBOutlet UITextField *contactPhoneTextField;
@property (weak, nonatomic) IBOutlet UIPlaceHolderTextView *contentTextView;
@property (weak, nonatomic) IBOutlet UICollectionView *imageCollectionView;

@end

@implementation ApplyFailRepairTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _parentVC.delegate = self;

    [self setup];
}
- (void)setParent:(ApplyFailRepairViewController*)parent
{
    _parentVC = parent;
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
- (void)close
{
    [self hideKeyboard];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setup
{

    self.imageArray = [NSMutableArray array];
    
    UINib* nib = [UINib nibWithNibName:[ImageAddCollectionViewCell className] bundle:nil];
    [self.imageCollectionView registerNib:nib forCellWithReuseIdentifier:[ImageAddCollectionViewCell className]];
    
    [self.tableView solveCrashWithIOS7];
    [self.tableView removeSeperatorBlank];
    
    self.contentTextView.placeholder = @"请填写详细情况描述";
    [InputAccessoryView createWithInputView:self.contentTextView];
    
    
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
    if (indexPath.row == 8)
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
#pragma mark - SubmitDelegate

-(void)userFooterView:(GuaranteeOrderViewController *)vc
{
    LOGIN_CHECK;
    
    
    NSString* project      = self.projectTextField.text;
    NSString* doctor       = self.doctorNameTextField.text;
    NSString* doctorPhone  = self.doctorPhoneTextField.text;
    NSString* agency       = self.agencyTextField.text;
    NSString* contact = self.contactTextField.text;
    NSString* contactPhone  = self.contactPhoneTextField.text;
    NSString* content        = self.contentTextView.text;
    
    ShowHudAndReturnIfInputNotAvailable(project, @"请输入手术项目");
    ShowHudAndReturnIfInputNotAvailable(doctor, @"请输入医生姓名");
    ShowHudAndReturnIfInputNotAvailable(doctorPhone, @"请输入医生电话");
    ShowHudAndReturnIfInputNotAvailable(agency, @"请输入医疗机构");
    ShowHudAndReturnIfInputNotAvailable(contact, @"请输入医疗机构联系人");
    ShowHudAndReturnIfInputNotAvailable(contactPhone, @"请输入医疗机构联系电话");
    ShowHudAndReturnIfInputNotAvailable(content, @"请输入详细情况描述");
    
    UserInfo* info = [UserInfo currentUser];
    
    @weakify_self;
    YB_RESPONSE_BLOCK_EX(block, NSObject*)
    {
        [MBProgressHUD hideHUDForView:weakSelf.view.superview animated:YES];
        //[sender setEnabled:YES];
        [response showHUD];
        
        if ([response success])
        {
            // 发送委托保单提交成功消息
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_GUARANTEE_ORDER_SUBMIT_SUCCESS object:nil];
            
            [weakSelf close];
        }
    };
    
    [self hideKeyboard];
    
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view.superview animated:YES];
    hud.labelText = STRING_PROCESSING;
    // [sender setEnabled:NO];
    
    [[MirrorServerInteraction sharedInstance] applyFailRepairWithuid:info.uid
                                                                ukey:info.ukey
                                                             project:project
                                                          doctorName:doctor
                                                         doctorPhone:doctorPhone
                                                              agency:agency
                                                             contact:contact
                                                        contactPhone:contactPhone
                                                             content:content
                                                            fileList: self.imageArray
                                                       progressBlock:^(double progress) {
                                                           
                                                           hud.labelText = [NSString stringWithFormat:@"正在上传佐证资料 %0.1f%%", progress * 100.0f];
                                                       }
                                                       responseBlock:block];
    
}

@end
