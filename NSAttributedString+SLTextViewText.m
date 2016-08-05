//
//  NSAttributedString+SLTextViewText.m
//  HeShi
//
//  Created by 博彦科技-聂小波 on 16/8/5.
//  Copyright © 2016年 聂小波. All rights reserved.
//

#import "NSAttributedString+SLTextViewText.h"

@implementation NSAttributedString (SLTextViewText)
- (NSString *)getPlainString {
    NSMutableString *plainString = [NSMutableString stringWithString:self.string];
    __block NSUInteger base = 0;
    
    [self enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, self.length)options:0 usingBlock:^(id value, NSRange range, BOOL *stop)
    {
          if (value && [value isKindOfClass:[NSTextAttachment class]])
          {
              [plainString replaceCharactersInRange:NSMakeRange(range.location + base, range.length)withString:@"www.baidu.com"];
              base += 12;
          }
    }];
    return plainString;
}

@end
