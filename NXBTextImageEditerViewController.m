//
//  NXBTextImageEditerViewController.m
//  NXBTextImageEditer
//
//  Created by 博彦科技-聂小波 on 16/8/5.
//  Copyright © 2016年 聂小波. All rights reserved.
//

#import "NXBTextImageEditerViewController.h"
#import "UIImage+SLImage.h"
#import "NSAttributedString+SLTextViewText.h"
#import "CJBSelectPhotosModel.h"
#import "NXBTextView.h"

@interface NXBTextImageEditerViewController ()<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,SelectPhotosDelegate,NXBTextViewDelegate>
{
    UILabel *placeholder;
    NSInteger keyBoardHeight;
    NSMutableString *text;
    float image_h;
}
@property (nonatomic, strong) NXBTextView *textView;
@property (nonatomic, strong) CJBSelectPhotosModel *selectPhotosModel;
@end

@implementation NXBTextImageEditerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"富文本编辑器";
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatUI];
}

- (CJBSelectPhotosModel *)selectPhotosModel {
    if (!_selectPhotosModel) {
        _selectPhotosModel = [[CJBSelectPhotosModel alloc] init];
        _selectPhotosModel.delegate = self;
    }
    return _selectPhotosModel;
}

- (NXBTextView*)textView {
    if (!_textView) {
        //编辑框
        _textView = [[NXBTextView alloc]init];
        [_textView drawRect:CGRectMake(0, 0, screen_Width, screen_Height-nav_Height) delegate:self FontOfSize:16.0 placehoder:@"点击编辑"];
        
    }
    return _textView;
}

- (void)creatUI {
    [self.view addSubview:self.textView];
    
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

#pragma mark 当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification {
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    keyBoardHeight = keyboardRect.size.height;
    //    NSLog(@"%ld",(long)keyBoardHeight);
    [UIView animateWithDuration:0.1 animations:^{
        _textView.height = screen_Height-keyBoardHeight;
        
    }];
    
}

#pragma mark 当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification {
    [UIView animateWithDuration:0.1 animations:^{
        _textView.height = screen_Height;
        
    }];
}

#pragma mark NXBTextViewDelegate 相册
- (void)selectImageBtnClick {
    [self.selectPhotosModel callActionSheetWithCtrl:self];

}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *uiImage =  [info objectForKey:UIImagePickerControllerEditedImage];
    //适配屏幕宽度
    UIImage *image1 = uiImage;
    
    image1 = [uiImage scaleToSize:CGSizeMake(screen_Width, uiImage.size.height*screen_Width/uiImage.size.width)];
    
    image1 = [uiImage scaleToSize:CGSizeMake(screen_Width, screen_Width)];
    
    image_h = image1.size.height;
    //裁剪
    CGImageRef img = CGImageCreateWithImageInRect(uiImage.CGImage, CGRectMake(0, screen_Height/2-image_h/2, screen_Width, image_h));
    UIImage *newImage = [UIImage imageWithCGImage:img];
    
    
    NSTextAttachment *imgTextAtta = [[NSTextAttachment alloc]init];
    imgTextAtta.image = newImage;
    //插入图片
    [_textView.textStorage insertAttributedString:[NSAttributedString attributedStringWithAttachment:imgTextAtta]atIndex:_textView.selectedRange.location];
    //设置光标位置
    _textView.selectedRange = NSMakeRange(_textView.selectedRange.location + 1, _textView.selectedRange.length);
    //设置样式
    [self resetTextStyle];
    [self dismissViewControllerAnimated:YES completion:nil];
    //每次添加完图片后  返回编辑状态
    [_textView becomeFirstResponder];
    
}

#pragma mark 改变字体大小
- (void)resetTextStyle {
    //After changing text selection, should reset style.
    NSRange wholeRange = NSMakeRange(0, self.textView.textStorage.length);
    [self.textView.textStorage removeAttribute:NSFontAttributeName range:wholeRange];
    [self.textView.textStorage addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0f] range:wholeRange];
    
}

#pragma mark 添加小图片到textView
- (void)addIcon {
    NSTextAttachment *attachment = [[NSTextAttachment alloc]initWithData:nil ofType:nil];
    UIImage *image = [UIImage imageNamed:@"k-portrait"];
    attachment.image = image;
    attachment.bounds = CGRectMake(0, 0, 40, 40);
    
    NSAttributedString *Attributext = [NSAttributedString attributedStringWithAttachment:attachment];
    [_textView.textStorage insertAttributedString:Attributext atIndex:0];
}

@end
