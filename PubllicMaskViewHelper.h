//
//  PubllicMaskViewHelper.h
//  JZH_BASE
//
//  Created by Points on 13-11-14.
//  Copyright (c) 2013年 Points. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewController.h"

@interface PubllicMaskViewHelper : NSObject

//弹出转圈圈
+ (void)showMaskViewIn:(NSString *)showTip ;

//移除转圈圈
+ (void)hideMaskView;

//给一个消息提示
+ (void)showTipViewWith:(NSString *)tip inSuperView:(UIView*)superView withDuration:(int)duration;

+ (void)hideView:(UIView *)view  animated:(BOOL)animated;

//提示的内容,提示的位置，延迟消失时间
+ (void)showTipViewWith:(NSString *)tip WhenChattingWithCenter:(CGFloat)y withDuration:(int)duration;
@end
