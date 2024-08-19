//
//  YLEvaluateVC.m
//  luckrental
//
//  Created by kiikqjzq on 2023/10/5.
//

#import "YLEvaluateVC.h"
#import "YLSatisfactionCell.h"
#import "YLImpressionCell.h"
#import "YLScoreCell.h"
#import "YLOptionBean.h"
#import "RCDUploadAPI.h"


@interface YLEvaluateVC ()<UICollectionViewDelegate, UICollectionViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *cv1;
@property (weak, nonatomic) IBOutlet UICollectionView *cv2;
@property (weak, nonatomic) IBOutlet UICollectionView *cv3;
@property (weak, nonatomic) IBOutlet UILabel *scoreLb;
@property (weak, nonatomic) IBOutlet UITextView *tv;
@property (weak, nonatomic) IBOutlet UIImageView *addIV;
@property (weak, nonatomic) IBOutlet UIButton *summitBtn;
@property (weak, nonatomic) IBOutlet UIView *contentV;

@property (strong, nonatomic)NSMutableArray *dataArray1;
@property (strong, nonatomic)NSMutableArray *dataArray2;
@property (strong, nonatomic)NSMutableArray *dataArray3;

@property (strong, nonatomic) NSString *imgUrl;
@property (nonatomic, strong) NSData *data;
@property (nonatomic, strong) UIImage *image;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *title2Lb;
@property (weak, nonatomic) IBOutlet UILabel *title3Lb;
@property (weak, nonatomic) IBOutlet UILabel *title4Lb;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollV;
@property (weak, nonatomic) IBOutlet UILabel *titlte5;
@end

@implementation YLEvaluateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = MyString(@"order_review");
    self.titleLb.text = MyString(@"satisfaction_question");
    self.title2Lb.text = MyString(@"impression_of_vehicle_condition");
    self.title3Lb.text = MyString(@"rate_car_rental_service");
    self.title4Lb.text = MyString(@"leave_your_feedback");
    self.titlte5.text = MyString(@"upload_image_or_video");
    self.scoreLb.text = [NSString stringWithFormat:MyString(@"score_format"),5];

    [self.summitBtn setTitle:MyString(@"confirm") forState:UIControlStateNormal];
    
    self.scrollV.delegate = self;

}


- (void)initUI{
    

    
    [_summitBtn addTarget:self action:@selector(summit) forControlEvents:UIControlEventTouchUpInside];
    
    self.addIV.userInteractionEnabled = YES;
    [self.addIV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToImagePickerController)]];
    
    // 设置UICollectionViewFlowLayout，定义布局
    UICollectionViewFlowLayout *flowLayout1 = [[UICollectionViewFlowLayout alloc] init];
    flowLayout1.itemSize = CGSizeMake(80, 20); // 每个 cell 的大小
    flowLayout1.minimumInteritemSpacing = 0; // 列间距
    flowLayout1.minimumLineSpacing = 0; // 行间距
    _cv1.collectionViewLayout=flowLayout1;
    [_cv1 setShowsHorizontalScrollIndicator:NO];
    [_cv1 setShowsVerticalScrollIndicator:NO];
    _cv1.scrollEnabled = NO;
    _cv1.delegate = self;
    _cv1.dataSource = self;
    _cv1.tag = 111;
    [_cv1 registerNib:[UINib nibWithNibName:NSStringFromClass([YLSatisfactionCell class])bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"YLSatisfactionCell"];
    
    UICollectionViewFlowLayout *flowLayout2 = [[UICollectionViewFlowLayout alloc] init];
    flowLayout2.itemSize = CGSizeMake(74, 28); // 每个 cell 的大小
    flowLayout2.minimumInteritemSpacing = 0; // 列间距
    flowLayout2.minimumLineSpacing = 0; // 行间距
    _cv2.collectionViewLayout=flowLayout2;
    [_cv2 setShowsHorizontalScrollIndicator:NO];
    [_cv2 setShowsVerticalScrollIndicator:NO];
    _cv2.scrollEnabled = NO;
    _cv2.delegate = self;
    _cv2.dataSource = self;
    _cv2.tag = 222;
    [_cv2 registerNib:[UINib nibWithNibName:NSStringFromClass([YLImpressionCell class])bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"YLImpressionCell"];
    
    UICollectionViewFlowLayout *flowLayout3 = [[UICollectionViewFlowLayout alloc] init];
    flowLayout3.itemSize = CGSizeMake(30, 20); // 每个 cell 的大小
    flowLayout3.minimumInteritemSpacing = 11; // 列间距
    flowLayout3.minimumLineSpacing = 0; // 行间距
    _cv3.collectionViewLayout=flowLayout3;
    [_cv3 setShowsHorizontalScrollIndicator:NO];
    [_cv3 setShowsVerticalScrollIndicator:NO];
    _cv3.scrollEnabled = NO;
    _cv3.delegate = self;
    _cv3.dataSource = self;
    _cv3.tag = 333;
    [_cv3 registerNib:[UINib nibWithNibName:NSStringFromClass([YLScoreCell class])bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"YLScoreCell"];
    [self setData];
    
}

- (void)setData{
    _dataArray1 = [NSMutableArray new];
    YLOptionBean *bean1 = [YLOptionBean new];
    bean1.text = MyString(@"very_satisfied");
    bean1.isSelected = YES;
    [_dataArray1 addObject:bean1];
    
    YLOptionBean *bean2 = [YLOptionBean new];
    bean2.text = MyString(@"satisfied");
    [_dataArray1 addObject:bean2];
    
    YLOptionBean *bean3 = [YLOptionBean new];
    bean3.text = MyString(@"average");
    [_dataArray1 addObject:bean3];
    
    YLOptionBean *bean4 = [YLOptionBean new];
    bean4.text = MyString(@"dissatisfied");
    [_dataArray1 addObject:bean4];
    
    [_cv1 reloadData];
    
    _dataArray2 = [NSMutableArray new];
    YLOptionBean *bean21 = [YLOptionBean new];
    bean21.text = MyString(@"high_safety");
    [_dataArray2 addObject:bean21];
    
    YLOptionBean *bean22 = [YLOptionBean new];
    bean22.text = MyString(@"easy_operation");
    [_dataArray2 addObject:bean22];
    
    YLOptionBean *bean23 = [YLOptionBean new];
    bean23.text = MyString(@"attractive_interior");
    [_dataArray2 addObject:bean23];
    
    YLOptionBean *bean24 = [YLOptionBean new];
    bean24.text = MyString(@"clean_and_tidy");
    [_dataArray2 addObject:bean24];
    
    YLOptionBean *bean25 = [YLOptionBean new];
    bean25.text = MyString(@"low_fuel_consumption");
    [_dataArray2 addObject:bean25];
    
    [_cv2 reloadData];
    
    _dataArray3 = [NSMutableArray new];
    YLOptionBean *bean31 = [YLOptionBean new];
    bean31.isSelected = YES;
    [_dataArray3 addObject:bean31];
    
    YLOptionBean *bean32 = [YLOptionBean new];
    bean32.isSelected = YES;
    [_dataArray3 addObject:bean32];
    
    YLOptionBean *bean33 = [YLOptionBean new];
    bean33.isSelected = YES;
    [_dataArray3 addObject:bean33];
    
    YLOptionBean *bean34 = [YLOptionBean new];
    bean34.isSelected = YES;
    [_dataArray3 addObject:bean34];
    
    YLOptionBean *bean35 = [YLOptionBean new];
    bean35.isSelected = YES;
    [_dataArray3 addObject:bean35];
    [_cv3 reloadData];
    
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(collectionView.tag == 111){
        return _dataArray1.count;
    }else if(collectionView.tag == 222){
        return _dataArray2.count;
    }else{
        return _dataArray3.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(collectionView.tag == 111){
        static NSString *identify = @"YLSatisfactionCell";
        YLOptionBean *bean = self.dataArray1[indexPath.row];
        YLSatisfactionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
        [cell initWithDate:bean];
        return cell;
    }else if(collectionView.tag == 222){
        static NSString *identify = @"YLImpressionCell";
        YLOptionBean *bean = self.dataArray2[indexPath.row];
        YLSatisfactionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
        [cell initWithDate:bean];
        return cell;
    }else{
        static NSString *identify = @"YLScoreCell";
        YLOptionBean *bean = self.dataArray3[indexPath.row];
        YLSatisfactionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
        [cell initWithDate:bean];
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(collectionView.tag == 111){
        for(YLOptionBean *bean in _dataArray1){
            bean.isSelected = NO;
        }
        YLOptionBean *bean = self.dataArray1[indexPath.row];
        bean.isSelected = YES;
    }else if(collectionView.tag == 222){
        YLOptionBean *bean = self.dataArray2[indexPath.row];
        bean.isSelected = !bean.isSelected;
    }else if(collectionView.tag == 333){
        int num = 0;
        for (int i = 0; i < _dataArray3.count; i++) {
            YLOptionBean *bean = self.dataArray3[i];
            if(i<=indexPath.row){
                bean.isSelected = YES;
                num++;
            }else{
                bean.isSelected = NO;
            }
        }
        _scoreLb.text = [NSString stringWithFormat:MyString(@"score_format"),num];
    }
    [collectionView reloadData];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(0.01,0.01);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0.1, 0.1, 0.1, 0.1);
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}


-(void)pushToImagePickerController{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.allowsEditing = NO;
        picker.delegate = self;
//        if (sourceType == UIImagePickerControllerSourceTypeCamera) {
//            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//                picker.sourceType = sourceType;
//            } else {
//                NSLog(@"模拟器无法连接相机");
//            }
//        } else {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        }
        picker.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:picker animated:YES completion:nil];
    });
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqual:@"public.image"]) {
        //获取原图
        UIImage *originImage = [info objectForKey:UIImagePickerControllerOriginalImage];
//        //获取截取区域
//        CGRect captureRect = [[info objectForKey:UIImagePickerControllerCropRect] CGRectValue];
//        //获取截取区域的图像
//        UIImage *captureImage =
//        [UIImage getSubImage:originImage Rect:captureRect imageOrientation:originImage.imageOrientation];
//        UIImage *scaleImage = [UIImage scaleImage:captureImage toScale:0.8];
        self.data = UIImageJPEGRepresentation(originImage, 0.0001);
    }
    self.image = [UIImage imageWithData:self.data];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self uploadImage];
}


- (void)uploadImage {
    [RCDUploadAPI uploadImage:self.data
                         complete:^(NSString *url) {
                             dispatch_async(dispatch_get_main_queue(), ^{
                                 self.imgUrl = url;
                                 [self.addIV sd_setImageWithURL:[NSURL URLWithString:self.imgUrl]];
                             });
                         }];
}

-(void)summit{
    NSString *content = _tv.text;
    
    NSString *experience = @"";
    
    for (YLOptionBean *item in _dataArray1) {
        if(item.isSelected){
            experience = item.text;
            break;
        }
    }
    
    NSString *mapping = @"";
    
    for (YLOptionBean *item in _dataArray2) {
        if(item.isSelected){
            if(mapping.length>0){
                mapping = [NSString stringWithFormat:@"%@,",mapping];
            }
            mapping = [NSString stringWithFormat:@"%@%@",mapping,item.text];
        }
    }
    
    int rate = 0;
    for (YLOptionBean *item in _dataArray3) {
        if(item.isSelected){
            rate++;
        }
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[@"content"] = content;
    dic[@"experience"] = experience;
    dic[@"img"] = self.imgUrl;
    dic[@"mapping"] = mapping;
    dic[@"orderId"] = self.orderId;
    dic[@"rate"] = [NSString stringWithFormat:@"%d", rate];
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodPost URLString:@"/api/order/addComment" parameters:dic complete:^(id ob) {
        [self showCompletionAlert];
    }];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES]; // 关闭键盘
}

- (void)hideKeyboard {
    [self.view endEditing:YES];
}

- (void)showCompletionAlert {
    PXWeakSelf
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:MyString(@"submission_complete")
                                                                             message:MyString(@"thank_you_for_feedback")
                                                                      preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *okAction = [UIAlertAction actionWithTitle:MyString(@"confirm")
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
                                                     }];

    [alertController addAction:okAction];

    [self presentViewController:alertController animated:YES completion:nil];
}

@end
