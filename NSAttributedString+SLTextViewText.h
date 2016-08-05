//
//  NSAttributedString+SLTextViewText.h
//  HeShi
//
//  Created by 博彦科技-聂小波 on 16/8/5.
//  Copyright © 2016年 聂小波. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (SLTextViewText)
//替代特殊字符
- (NSString *)getPlainString;
@end
