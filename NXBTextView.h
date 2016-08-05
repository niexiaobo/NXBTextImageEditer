//
//  NXBTextView.h
//  NXBTextImageEditer
//
//  Created by 博彦科技-聂小波 on 16/8/5.
//  Copyright © 2016年 聂小波. All rights reserved.
//

#import "HMTextView.h"

@protocol NXBTextViewDelegate <NSObject>
- (void)selectImageBtnClick;
@end

@interface NXBTextView : HMTextView
@property(nonatomic, weak) id<NXBTextViewDelegate> textDelegate;

- (void)drawRect:(CGRect)rect delegate:(id)delegate FontOfSize:(CGFloat)fontSize placehoder:(NSString*)placehoder;
@end
