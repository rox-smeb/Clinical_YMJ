//
//  ConsultationCollectionViewController.m
//  求美者端
//
//  Created by apple on 2016/11/17.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "ConsultationCollectionViewController.h"
#import "CommonServerInteraction.h"
#import "DoctorCollectionViewCell.h"
#import "FindSpecialInfo.h"
#import "ApplyConsultationViewController.h"
@interface ConsultationCollectionViewController ()<UICollectionViewDataSource,
                                                   UICollectionViewDelegate,
                                                   UICollectionViewDelegateFlowLayout>
@property(strong,nonatomic)NSMutableArray* dataSource;
@property (weak, nonatomic) IBOutlet UIImageView *topImage;                                 // 图片
@property (weak, nonatomic) IBOutlet UILabel *mainTitle;                                    // 主标题
@property (weak, nonatomic) IBOutlet UILabel *subTitle;                                     // 副标题
@property (weak, nonatomic) IBOutlet UILabel *Introduction;

@property(weak,nonatomic) IBOutlet UIView* btnView1;//专家会诊
@property(weak,nonatomic) IBOutlet UIView* btnView2;//专家会诊

@property (strong, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (copy, nonatomic) NSString * labelStr;                                            // 获取的主标题
@end

@implementation ConsultationCollectionViewController
+(instancetype)viewController
{
    ConsultationCollectionViewController *ctrl=[[self class]viewControllerWithStoryboardName:@"Home"];
    return ctrl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self loadData];
    // Do any additional setup after loading the view.
}
-(void) setup
{
    self.dataSource=[NSMutableArray array];
    CGRect rect = [[UIScreen mainScreen] bounds];

    _myCollectionView.dataSource = self;
    _myCollectionView.delegate=self;
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    
    _myCollectionView.collectionViewLayout = layout;
    int w=rect.size.width;
    layout.itemSize = CGSizeMake(w/2-10, w/2-10);
    
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
//
//    layout.headerReferenceSize = CGSizeMake(320, 200);
    //[self loadData];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];

    [self.collectionView registerNib:[UINib nibWithNibName:[DoctorCollectionViewCell className] bundle:nil] forCellWithReuseIdentifier:[DoctorCollectionViewCell className]];

}
-(void) loadData
{
    @weakify_self;
    YB_RESPONSE_BLOCK_EX(block2, NSArray<FindSpecialInfo*>*)
    {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        if([response success])
        {
            [weakSelf.dataSource removeAllObjects];
            [weakSelf.dataSource frontInsertArray:dataOrList];
            [weakSelf.collectionView reloadData];
        }
        else
        {
            [response showHUD];
        }
    };
    [[CommonServerInteraction sharedInstance] findSpecial:@"1" responseBlock:block2];
}
-(void) loadHeaderData
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
    [[CommonServerInteraction sharedInstance] findDisplayInfoWithType:@"8"
                                                        responseBlock:block];
}
-(void)goToConsultation
{
    ApplyConsultationViewController* consultationVC=[ApplyConsultationViewController viewController];
    consultationVC.mType=0;
    [self.navigationController pushViewController:consultationVC animated:YES];
}
-(void)goToConsultation2
{
    ApplyConsultationViewController* consultationVC=[ApplyConsultationViewController viewController];
    consultationVC.mType=1;
    [self.navigationController pushViewController:consultationVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataSource count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DoctorCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[DoctorCollectionViewCell className] forIndexPath:indexPath];
    if(indexPath.row<[self.dataSource count])
    {
        FindSpecialInfo *findSpecialInfo=[self.dataSource objectAtIndex:indexPath.row];
        [cell setupWithInfo:findSpecialInfo];
    }
    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake(rect.size.width/2, rect.size.width/2);
//}
//返回头headerView的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size={320,461};
    return size;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath

{
    
    UICollectionReusableView *reusableview = nil ;
    
    if (kind == UICollectionElementKindSectionHeader ){
        
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind : UICollectionElementKindSectionHeader withReuseIdentifier : @"HeaderView" forIndexPath :indexPath];
        
        _topImage=(UIImageView*)[headerView viewWithTag:1];
        _mainTitle=(UILabel*)[headerView viewWithTag:2];
        _subTitle=(UILabel*)[headerView viewWithTag:3];
        _Introduction=(UILabel*)[headerView viewWithTag:4];
        _btnView1=(UIView*)[headerView viewWithTag:5];
        _btnView2=(UIView*)[headerView viewWithTag:6];

        UITapGestureRecognizer* tapGRe=[[UITapGestureRecognizer alloc]initWithTarget:self  action:@selector(goToConsultation)];
        [_btnView1 addGestureRecognizer:tapGRe];
        
        UITapGestureRecognizer* tapGRe2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goToConsultation2)];
        [_btnView2 addGestureRecognizer:tapGRe2];
        [self loadHeaderData];
        reusableview = headerView;
        
    }
    
//    if (kind == UICollectionElementKindSectionFooter){
//        
//        UICollectionReusableView *footerview = [collectionView dequeueResuableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@”FooterView” forIndexPath:indexPath];
//        
//        reusableview = footerview;
//        
//    }
    
    return reusableview;
    
}


@end
