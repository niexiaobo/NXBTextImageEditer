//
//  CJBSelectPhotosModel.m
//  chengjubei
//
//  Created by 博彦科技-聂小波 on 16/7/29.
//  Copyright © 2016年 城俱杯. All rights reserved.
//

#import "CJBSelectPhotosModel.h"
@interface CJBSelectPhotosModel ()<UIImagePickerControllerDelegate,UIActionSheetDelegate>
@property (nonatomic, strong) UIActionSheet *actionSheet;
@property (nonatomic, strong) UIViewController *fatherCtrl;

@end

@implementation CJBSelectPhotosModel

#pragma mark - 上传头像 代理方法
- (void)callActionSheetWithCtrl:(UIViewController*)Ctrl {
    [Ctrl.view endEditing:YES];
    self.fatherCtrl = Ctrl;
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    [self.actionSheet showInView:self.fatherCtrl.view];
}



- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    if (buttonIndex == 0) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            sourceType = UIImagePickerControllerSourceTypeCamera;
        } else
            return;
    } else if (buttonIndex == 1) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        } else
            return;
    } else {
        return;
    }
    UIImagePickerController *imageViewPicker = [[UIImagePickerController alloc] init];
    imageViewPicker.delegate = self.fatherCtrl;
    imageViewPicker.allowsEditing = YES;
    imageViewPicker.sourceType = sourceType;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.fatherCtrl presentViewController:imageViewPicker animated:YES completion:^{}];
}

/*
 
 控制器要遵循下面代理方法 获取图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
}
*/
@end
