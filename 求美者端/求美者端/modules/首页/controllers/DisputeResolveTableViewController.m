//
//  DisputeResolveTableViewController.m
//  求美者端
//
//  Created by AnYanbo on 16/8/16.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "DisputeResolveTableViewController.h"
#import "InputAccessoryView.h"
#import "SegmentedControlConfiger.h"
#import "ImageAddCollectionViewCell.h"
#import "ImagePickerManager.h"
#import "MirrorServerInteraction.h"
#import "UserInfo.h"
#import "FindDisplayInfo.h"
#import "CommonServerInteraction.h"
#import "NotificationsDefine.h"
#import "DisputeResolveViewController.h"

#define MAX_IMAGE_PICKER_COUNT               (15)

@interface DisputeResolveTableViewController () <UITextFieldDelegate,
                                                 UITextViewDelegate,
                                                 UIActionSheetDelegate,
                                                 UICollectionViewDelegate,
                                                 UICollectionViewDataSource,
                                                 ImagePickerManagerDelegate,
                                                 ImageAddCollectionViewCellDelegate,
                                                 CHTCollectionViewDelegateWaterfallLayout,
                                                 DisputeResolveViewControllerDalegate>

@property(weak,nonatomic)DisputeResolveViewController *parentVC;
@property (strong, nonatomic) NSMutableArray* imageArray;
@property (weak, nonatomic) IBOutlet UISegmentedControl *countrySegmentedControl;           // 国家
@property (weak, nonatomic) IBOutlet UIImageView *topImage;                                 // 图片
@property (weak, nonatomic) IBOutlet UILabel *mainTitle;                                    // 主标题
@property (weak, nonatomic) IBOutlet UILabel *subTitle;                                     // 副标题
@property (weak, nonatomic) IBOutlet UILabel *Introduction;                                 // 介绍

@property (weak, nonatomic) IBOutlet UITextField *applyNameTextField;                       // 申请方名称
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;                         // 申请方地址
@property (weak, nonatomic) IBOutlet UITextField *legalPersonTextField;                     // 法人
@property (weak, nonatomic) IBOutlet UITextField *contactTextField;                         // 联系方式
@property (weak, nonatomic) IBOutlet UITextField *bApplyNameTextField;                      // 被申请方名称
@property (weak, nonatomic) IBOutlet UITextField *bAddressTextField;                        // 被申请方地址
@property (weak, nonatomic) IBOutlet UITextField *bLegalPersonTextField;                    // 被申请方法人
@property (weak, nonatomic) IBOutlet UITextField *bContactTextField;                        // 被申请方联系方式
@property (weak, nonatomic) IBOutlet UITextView *requestContentTextView;                    // 调节请求
@property (weak, nonatomic) IBOutlet UITextView *reasonContentTextView;                     // 事实与理由
@property (weak, nonatomic) IBOutlet UIButton *addImageButton;
@property (weak, nonatomic) IBOutlet UICollectionView *imageCollectionView;
@property (copy, nonatomic) NSString * labelStr;                                            // 获取的主标题

@end

@implementation DisputeResolveTableViewController

//+ (instancetype)viewController
//{
//    DisputeResolveTableViewController* ctrl = [[self class] viewControllerWithStoryboardName:@"Home"];
//    return ctrl;
//}
-(void)setParent:(DisputeResolveViewController *)parent
{
    self.parentVC=parent;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.parentVC.delegate=self;
    [self loadData];
    [self setup];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void) loadData
{
    @weakify_self;
    YB_RESPONSE_BLOCK_EX(block, FindDisplayInfo*)
    {
        if([response success])
        {
            if(!([dataOrList.title isEqualToString:@""] || dataOrList.title==nil))
            {
                _mainTitle.text=dataOrList.title;
            }
            if(!([dataOrList.subTitle isEqualToString:@""] || dataOrList.subTitle==nil))
            {
                _subTitle.text=dataOrList.subTitle;
            }
            if(!([dataOrList.details isEqualToString:@""] || dataOrList.details==nil))
            {
                _labelStr = dataOrList.details;
                CGSize labelSize = {0, 0};
                
                labelSize = [_labelStr sizeWithFont:[UIFont systemFontOfSize:14]
                             
                                  constrainedToSize:CGSizeMake(self.Introduction.frame.size.width, 5000)
                             
                                      lineBreakMode:UILineBreakModeWordWrap];
                weakSelf.Introduction.text = _labelStr;
                weakSelf.Introduction.numberOfLines = 0;
                weakSelf.Introduction.lineBreakMode = UILineBreakModeCharacterWrap;
                weakSelf.Introduction.frame = CGRectMake(self.Introduction.frame.origin.x, self.Introduction.frame.origin.y, self.Introduction.frame.size.width, labelSize.height);

            }
            if(!([dataOrList.url isEqualToString:@""] || dataOrList.url==nil))
            {
                NSURL *url=[NSURL URLWithString:dataOrList.url];
                [self.topImage sd_setImageWithURL:url];
            }
        }
    };
    [[CommonServerInteraction sharedInstance] findDisplayInfoWithType:@"6"
                                                        responseBlock:block];
}
- (void)setup
{
    self.imageArray = [NSMutableArray array];
    
    UINib* nib = [UINib nibWithNibName:[ImageAddCollectionViewCell className] bundle:nil];
    [self.imageCollectionView registerNib:nib forCellWithReuseIdentifier:[ImageAddCollectionViewCell className]];
    
    [self.tableView solveCrashWithIOS7];
    [self.tableView removeSeperatorBlank];
    
    self.requestContentTextView.layer.cornerRadius = 5.0f;
    self.reasonContentTextView.layer.cornerRadius = 5.0f;
    
    [SegmentedControlConfiger configSegmentedControl:self.countrySegmentedControl];
    
    [InputAccessoryView createWithInputView:self.requestContentTextView];
    [InputAccessoryView createWithInputView:self.reasonContentTextView];
        
    CHTCollectionViewWaterfallLayout* layout = (CHTCollectionViewWaterfallLayout*)self.imageCollectionView.collectionViewLayout;
    if ([layout isKindOfClass:[CHTCollectionViewWaterfallLayout class]])
    {
        layout.columnCount = 3;
        layout.minimumColumnSpacing = 10.0f;
        layout.minimumInteritemSpacing = 10.0f;
        layout.sectionInset = UIEdgeInsetsMake(5.0f, 10.0f, 10.0f, 10.0f);
    }
}

- (void)close
{
    [self hideKeyboard];
    [self.navigationController popViewControllerAnimated:YES];
}

// 上传佐证资料
- (IBAction)onAddImageTouch:(UIButton *)sender
{
    UIActionSheet* sheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    [sheet showInView:self.view];

}

// 提交
- (void)userFooterView
{
    LOGIN_CHECK;
    
    NSString* country        =@"中国";
    //self.countrySegmentedControl.selectedSegmentIndex == 0 ? @"中国" : @"韩国";
    NSString* applyName      = self.applyNameTextField.text;
    NSString* address        = self.addressTextField.text;
    NSString* legalPerson    = self.legalPersonTextField.text;
    NSString* contact        = self.contactTextField.text;
    NSString* bApplyName     = self.bApplyNameTextField.text;
    NSString* bAddress       = self.bAddressTextField.text;
    NSString* bLegalPerson   = self.bLegalPersonTextField.text;
    NSString* bContact       = self.bContactTextField.text;
    NSString* requestContent = self.requestContentTextView.text;
    NSString* reasonContent  = self.reasonContentTextView.text;
    
    ShowHudAndReturnIfInputNotAvailable(applyName, @"请输入申请方名称");
    ShowHudAndReturnIfInputNotAvailable(address, @"请输入申请方住所地");
    ShowHudAndReturnIfInputNotAvailable(legalPerson, @"请输入申请方法定代表人");
    ShowHudAndReturnIfInputNotAvailable(bApplyName, @"请输入被申请方名称");
    ShowHudAndReturnIfInputNotAvailable(bAddress, @"请输入被申请方住所地");
    ShowHudAndReturnIfInputNotAvailable(bLegalPerson, @"请输入被申请方法定代表人");
    ShowHudAndReturnIfInputNotAvailable(requestContent, @"请输入调节请求");
    
    UserInfo* userInfo = [UserInfo currentUser];
    
    @weakify_self;
    YB_RESPONSE_BLOCK_EX(block, NSObject*)
    {
        [MBProgressHUD hideHUDForView:weakSelf.view.superview animated:YES];
        //[sender setEnabled:YES];
        [response showHUD];
        
        if ([response success])
        {
            [weakSelf close];
        }
    };
    
    [self hideKeyboard];
    
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view.superview animated:YES];
    hud.labelText = STRING_PROCESSING;
    //[sender setEnabled:NO];
    
    [[MirrorServerInteraction sharedInstance] disputeResolveWithCountry:country
                                                                    uid:userInfo.uid
                                                                   ukey:userInfo.ukey
                                                              applyName:applyName
                                                                address:address
                                                            legalPerson:legalPerson
                                                                contact:contact
                                                             bApplyName:bApplyName
                                                               bAddress:bAddress
                                                           bLegalPerson:bLegalPerson
                                                               bContact:bContact
                                                         requestContent:requestContent
                                                          reasonContent:reasonContent
                                                               fileList:self.imageArray
                                                          progressBlock:^(double progress) {
        
                                                              hud.labelText = [NSString stringWithFormat:@"正在上传佐证资料 %0.1f%%", progress * 100.0f];
                                                          }
                                                          responseBlock:block];
}

- (void)pickImageFromCamera
{
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera] == NO)
    {
        [SVProgressHUD showErrorWithStatus:@"系统不支持照相机"];
        return;
    }
    
    NSInteger count = MAX_IMAGE_PICKER_COUNT - [self.imageArray count];
    if (count <= 0)
    {
        NSString* text = [NSString stringWithFormat:@"最多可以选择%d张图片", MAX_IMAGE_PICKER_COUNT];
        [SVProgressHUD showErrorWithStatus:text];
        return;
    }
    
    UIImagePickerController* picker = [[UIImagePickerController alloc] init];//初始化
    picker.delegate = self;
    picker.allowsEditing = YES;//设置可编辑
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:^{
        
    }];
}


#pragma mark - UIActionSheetDelegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        //拍照
        [self pickImageFromCamera];
    }
    else if (buttonIndex==1)
    {
        //相册
            NSInteger count = MAX_IMAGE_PICKER_COUNT - [self.imageArray count];
            if (count > 0)
            {
                ImagePickerManager* manager = [ImagePickerManager instanceWithDelegate:self];
                [manager pickerImageInViewController:self];
            }
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

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return YES;
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
    if (indexPath.row == 14)
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
