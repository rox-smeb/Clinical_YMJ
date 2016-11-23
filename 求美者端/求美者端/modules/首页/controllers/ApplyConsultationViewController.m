//
//  ApplyConsultationViewController.m
//  求美者端
//
//  Created by apple on 2016/11/18.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "ApplyConsultationViewController.h"
#import "ImageAddCollectionViewCell.h"
#import "ImagePickerManager.h"
#import "DisputeResolveViewController.h"
#import "InputAccessoryView.h"
#import "UserInfo.h"
#import "MirrorServerInteraction.h"
#import "NotificationsDefine.h"


#define MAX_IMAGE_PICKER_COUNT               (15)

@interface ApplyConsultationViewController ()<UITextFieldDelegate,
                                              UITextViewDelegate,
                                              UIActionSheetDelegate,
                                              UICollectionViewDelegate,
                                              UICollectionViewDataSource,
                                              ImagePickerManagerDelegate,
                                              ImageAddCollectionViewCellDelegate,
                                              CHTCollectionViewDelegateWaterfallLayout,
                                              DisputeResolveViewControllerDalegate>
@property (strong, nonatomic) NSMutableArray* imageArray;
@property (strong, nonatomic) IBOutlet UIButton *btnsubmit;
@property (strong, nonatomic) IBOutlet UITextView *content;
@property (weak, nonatomic) IBOutlet UIButton *addImageButton;
@property (weak, nonatomic) IBOutlet UICollectionView *imageCollectionView;

@end

@implementation ApplyConsultationViewController
+(instancetype)viewController
{
    ApplyConsultationViewController* ctrl=[[self class] viewControllerWithStoryboardName:@"Home"];
    return ctrl;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}
-(void)setup
{
    self.imageArray = [NSMutableArray array];
    
    UINib* nib = [UINib nibWithNibName:[ImageAddCollectionViewCell className] bundle:nil];
    [self.imageCollectionView registerNib:nib forCellWithReuseIdentifier:[ImageAddCollectionViewCell className]];
    CHTCollectionViewWaterfallLayout* layout = (CHTCollectionViewWaterfallLayout*)self.imageCollectionView.collectionViewLayout;
    if ([layout isKindOfClass:[CHTCollectionViewWaterfallLayout class]])
    {
        layout.columnCount = 3;
        layout.minimumColumnSpacing = 10.0f;
        layout.minimumInteritemSpacing = 10.0f;
        layout.sectionInset = UIEdgeInsetsMake(5.0f, 10.0f, 10.0f, 10.0f);
    }
    _imageCollectionView.dataSource = self;
    _imageCollectionView.delegate=self;
    [InputAccessoryView createWithInputView:self.content];

    
    UIColor *colorOne = [UIColor colorWithRed:(53/255.0)  green:(136/255.0)  blue:(240/255.0)  alpha:0.0];
    UIColor *colorTwo = [UIColor colorWithRed:(53/255.0)  green:(136/255.0)  blue:(240/255.0)  alpha:0.5];
    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    //设置开始和结束位置(设置渐变的方向)
    //gradient.startPoint = CGPointMake(0, 0);
    //gradient.endPoint = CGPointMake(1, 0);
    gradient.colors = colors;
    CGRect rect = [[UIScreen mainScreen] bounds];
    gradient.frame = CGRectMake(0, 0, rect.size.width, 50);
    // [self.submitButton.layerinsertSublayer:gradient atIndex:0];
    [self.btnsubmit.layer addSublayer:gradient];
    
    CAShapeLayer *border = [CAShapeLayer layer];
    
    border.strokeColor = [[UIColor grayColor] CGColor];
    
    border.fillColor = nil;
    
    border.path = [UIBezierPath bezierPathWithRect:self.content.bounds].CGPath;
    
    border.frame = self.content.bounds;
    
    border.lineWidth = 1.f;
    
    border.lineCap = @"square";
    
    border.lineDashPattern = @[@4, @2];
    
    [self.content.layer addSublayer:border];
    

}
- (void)close
{
    [self hideKeyboard];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onSubmitTouch:(id)sender {
    if(_mType==0)
    {
        [self applyConsultation];
    }
    else if(_mType==1)
    {
        [self applypublicWelfareConsultation];
    }
}
//提交专家会诊
-(void)applyConsultation
{
    LOGIN_CHECK;
    
    NSString* country        =@"中国";
    //self.countrySegmentedControl.selectedSegmentIndex == 0 ? @"中国" : @"韩国";

    NSString* mcontent = self.content.text;
    
    ShowHudAndReturnIfInputNotAvailable(mcontent, @"请输入申请内容");
    
    UserInfo* userInfo = [UserInfo currentUser];
    
    @weakify_self;
    YB_RESPONSE_BLOCK_EX(block2, NSObject*)
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
    
    
    [[MirrorServerInteraction sharedInstance] applyConsultationWithCountry:country
                                                                       uid:userInfo.uid     ukey:userInfo.ukey
                                                                   content:mcontent doctorList:@""
                                                                  fileList:self.imageArray
                                                             progressBlock:^(double progress) {
        hud.labelText = [NSString stringWithFormat:@"正在上传佐证资料 %0.1f%%", progress * 100.0f];
    } responseBlock:block2];

}
//提交公益会诊
-(void)applypublicWelfareConsultation
{
    LOGIN_CHECK;
    
    NSString* country        =@"中国";
    //self.countrySegmentedControl.selectedSegmentIndex == 0 ? @"中国" : @"韩国";
    
    NSString* mcontent = self.content.text;
    
    ShowHudAndReturnIfInputNotAvailable(mcontent, @"请输入申请内容");
    
    UserInfo* userInfo = [UserInfo currentUser];
    
    @weakify_self;
    YB_RESPONSE_BLOCK_EX(block2, NSObject*)
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
    
    
    [[MirrorServerInteraction sharedInstance] publicWelfareConsultationWithCountry:country

                                                                               uid:userInfo.uid
                                                                              ukey:userInfo.ukey
     
                                                                           content:mcontent
     
                                                                          fileList:self.imageArray
     
                                                                     progressBlock:^(double progress) {
                                                                 hud.labelText = [NSString stringWithFormat:@"正在上传佐证资料 %0.1f%%", progress * 100.0f];
                                                             } responseBlock:block2];
    
}

- (IBAction)onAddImageTouch:(id)sender {
    UIActionSheet* sheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    [sheet showInView:self.view];
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
       // [self.tableView reloadData];
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
    //[self.tableView reloadData];
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

@end
