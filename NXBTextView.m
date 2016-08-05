//
//  NXBTextView.m
//  NXBTextImageEditer
//
//  Created by 博彦科技-聂小波 on 16/8/5.
//  Copyright © 2016年 聂小波. All rights reserved.
//

#import "NXBTextView.h"
@interface NXBTextView ()
@property (nonatomic, strong) UIView *toolView;

@end

@implementation NXBTextView

- (void)drawRect:(CGRect)rect delegate:(id)delegate FontOfSize:(CGFloat)fontSize placehoder:(NSString*)placehoder {
    if (self) {
        self.frame = rect;
        self.placehoder = placehoder;
        self.delegate = delegate;
        self.textDelegate = delegate;
        self.font = [UIFont systemFontOfSize:fontSize];
        [self setupToolView];
    }
}

- (void)setupToolView {
    _toolView  = [[UIView alloc]init];
    _toolView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    _toolView.frame = CGRectMake(0, screen_Height, screen_Width, 50);
    self.inputAccessoryView  = _toolView;
    
    UIButton *losebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    losebtn.frame = CGRectMake(20, 0, 50, 50);
    [losebtn addTarget:self action:@selector(doneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [losebtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [losebtn setTitle:@"完成" forState:UIControlStateNormal];
    [_toolView addSubview:losebtn];
    
    UIButton *imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [imageBtn setTitle:@"图片" forState:UIControlStateNormal];
    imageBtn.frame = CGRectMake(screen_Width-100, 0, 50, 50);
    [imageBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [imageBtn addTarget:self action:@selector(imageBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_toolView addSubview:imageBtn];
}

- (void)doneBtnClick {
    [self endEditing:YES];
}

- (void)imageBtnClick {
    [self endEditing:YES];
    if ([self.textDelegate respondsToSelector:@selector(selectImageBtnClick)]) {
        [self.textDelegate selectImageBtnClick];
    }
    
}
@end
