//
//  CJBSelectPhotosModel.h
//  chengjubei
//
//  Created by 博彦科技-聂小波 on 16/7/29.
//  Copyright © 2016年 城俱杯. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SelectPhotosDelegate <NSObject>
//- (void)getSelectImage:(UIImage*)image;
@end

@interface CJBSelectPhotosModel : NSObject

@property(nonatomic, weak) id<SelectPhotosDelegate> delegate;

#pragma mark - 上传头像 代理方法
- (void)callActionSheetWithCtrl:(UIViewController*)Ctrl;
@end
