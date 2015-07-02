//
//  EditPhotoViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/4/30.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "EditPhotoViewController.h"
#import "ShowQrCodeViewController.h"
#import "UserViewController.h"
#import "EditPhoto.h"
#import "ApIClient.h"
#import "SMS_MBProgressHUD.h"

@interface EditPhotoViewController ()

@end

@implementation EditPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"k1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    

    UILabel *lineLabel = [[UILabel alloc]init];
    lineLabel.frame = CGRectMake(0, backBtn.frame.size.height+backBtn.frame.origin.y+50, WIDTH, 0.5);
    lineLabel.backgroundColor = RGBACOLOR(204, 204, 204, 1.0f);
    [self.view addSubview:lineLabel];
    
    UIButton *editPhotoButton = [[UIButton alloc]init];
    editPhotoButton.frame = CGRectMake(0, lineLabel.frame.origin.y+lineLabel.frame.size.height, WIDTH, 60);
    [editPhotoButton setTitle:@"修改头像" forState:UIControlStateNormal];
    [editPhotoButton setTitleColor:RGBACOLOR(100, 100, 100, 1.0f)forState:UIControlStateNormal];
    editPhotoButton.contentEdgeInsets = UIEdgeInsetsMake(0,20, 0, 0);
    editPhotoButton.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    [editPhotoButton addTarget:self action:@selector(onClickImageView) forControlEvents:UIControlEventTouchUpInside];
    editPhotoButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:editPhotoButton];
    
    UILabel *lineLabel1 = [[UILabel alloc]init];
    lineLabel1.frame = CGRectMake(0, editPhotoButton.frame.size.height+editPhotoButton.frame.origin.y, WIDTH, 0.5);
    lineLabel1.backgroundColor = RGBACOLOR(204, 204, 204, 1.0f);
    [self.view addSubview:lineLabel1];
    
    UIButton *myQrCodeButton = [[UIButton alloc]init];
    myQrCodeButton.frame = CGRectMake(0, lineLabel1.frame.origin.y+lineLabel1.frame.size.height, WIDTH, 60);
    [myQrCodeButton setTitle:@"我的二维码" forState:UIControlStateNormal];
    [myQrCodeButton setTitleColor:RGBACOLOR(100, 100, 100, 1.0f)forState:UIControlStateNormal];
    myQrCodeButton.contentEdgeInsets = UIEdgeInsetsMake(0,20, 0, 0);
    myQrCodeButton.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    [myQrCodeButton addTarget:self action:@selector(lookQrCode) forControlEvents:UIControlEventTouchUpInside];
    myQrCodeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:myQrCodeButton];
    
    UILabel *lineLabel2 = [[UILabel alloc]init];
    lineLabel2.frame = CGRectMake(0, myQrCodeButton.frame.size.height+myQrCodeButton.frame.origin.y, WIDTH, 0.5);
    lineLabel2.backgroundColor = RGBACOLOR(204, 204, 204, 1.0f);
    [self.view addSubview:lineLabel2];
    
}


-(void)doBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)lookQrCode{

    ShowQrCodeViewController *showQrCodeVC = [[ShowQrCodeViewController alloc]init];
    [self.navigationController pushViewController:showQrCodeVC animated:YES];
}

// 调用相机
-(void)onClickImageView{
    
    
    UIActionSheet *sheet;
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"设置头像" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择",nil];
    }
    else {
        
        sheet = [[UIActionSheet alloc] initWithTitle:@"设置头像" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
    }
    sheet.tag = 255;
    [sheet showInView:self.view];
    
}

// 跳转到相机 或 相册界面
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:
                    // 取消
                    return;
                case 1:
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 2:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
            
        }
        
        else {
            
            if (buttonIndex == 0) {
                
                return;
                
            } else {
                
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                
            }
            
        }
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }
}


// 实现 picker delegte
#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self saveImage:image withName:@"currentImage.png"];
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    UserViewController *userVC = [[UserViewController alloc]init];
    
    [userVC.userPhotoImageView setImage:savedImage];
    //[userVC uploadUserImage:savedImage];
    
    [self presentViewController:userVC animated:YES completion:nil];
    
    // isFullScreen = NO;
//    [_avatarImageView setImage:savedImage];
//    
//    _avatarImageView.tag = 100;
    
    
   // [self UploadPhoto];
    
}


#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}



-(void)UploadPhoto{
    
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:@"4" forKey:@"token"];

    [SMS_MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [EditPhoto uploadUserProfileImageParameters:dic WithBlock:^(EditPhoto *e) {
        
       // NSLog(@"%@",e);
        
        [SMS_MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([e.res isEqualToString:@"1"]) {
            
            [APIClient showSuccess:@"头像上传成功" title:@"成功"];
        }
        
    }];

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

@end
