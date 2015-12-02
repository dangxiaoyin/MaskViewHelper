//
//  PubllicMaskViewHelper.m
//  JZH_BASE
//
//  Created by Points on 13-11-14.
//  Copyright (c) 2013年 Points. All rights reserved.
//

#define TAG_MASKVIEW  0xAB
#import "PubllicMaskViewHelper.h"
#import "MaskView.h"

@implementation PubllicMaskViewHelper

//弹出转圈圈
+ (void)showMaskViewIn:(NSString *)showTip
{
    MaskView *bg = [[MaskView alloc]initWithFrame:MAIN_FRAME];
    bg.tag = TAG_MASKVIEW;
    [[UIApplication sharedApplication].keyWindow addSubview:bg];
    [bg release];
    
    UIActivityIndicatorView *m_inditor = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake((MAIN_WIDTH-40)/2, (MAIN_HEIGHT-40)/2, 40, 40)];
    [m_inditor setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [m_inditor startAnimating];
    [bg addSubview:m_inditor];
    [m_inditor release];
    
    UILabel *tipLab =[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(m_inditor.frame), MAIN_WIDTH, 30)];
    [tipLab setBackgroundColor:[UIColor clearColor]];
    [tipLab setText:showTip];
    [tipLab setTextColor:[UIColor whiteColor]];
    [tipLab setFont:[UIFont systemFontOfSize:20]];
    [tipLab setTextAlignment:NSTextAlignmentCenter];
    [bg addSubview:tipLab];
    [tipLab release];

}

//移除转圈圈
+ (void)hideMaskView
{
    NSArray * arr = [UIApplication sharedApplication].keyWindow.subviews;
    for (UIView *subView in arr )
    {
        if(subView.tag == TAG_MASKVIEW)
        {
            [subView removeFromSuperview];
            break;
        }
    }
}

//给一个消息提示
+ (void)showTipViewWith:(NSString *)tip inSuperView:(UIView*)superView withDuration:(int)duration
{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:superView animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabelText = tip;
        hud.margin = 10.f;
        hud.yOffset = 0;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:duration];
}


+ (void)hideView:(UIView *)view  animated:(BOOL)animated
{
    [MBProgressHUD hideHUDForView:view animated:animated];
}

+ (CGSize)sizeOfString:(NSString *)str withFont:(UIFont *)font withWidth:(int)width
{
    CGSize bubbleSize =CGSizeZero;
    CGSize size = CGSizeMake(width,MAXFLOAT);
#if (defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000)
    NSDictionary *stringAttributes = [NSDictionary dictionaryWithObject:font forKey: NSFontAttributeName];
    bubbleSize =  [str  boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin) attributes:stringAttributes context:nil].size;
#else
    bubbleSize = [str sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
#endif
    return bubbleSize;
}


+ (void)showTipViewWith:(NSString *)tip WhenChattingWithCenter:(CGFloat)y withDuration:(int)duration
{
    CGSize bubbleSize =  [PubllicMaskViewHelper sizeOfString:tip withFont:[UIFont systemFontOfSize:16] withWidth:MAIN_WIDTH];
    
    UIImageView * BGview =[[UIImageView alloc]init];
    [BGview setBackgroundColor:[UIColor grayColor]];
    [BGview setFrame:CGRectMake((MAIN_WIDTH-bubbleSize.width)/2,y, bubbleSize.width, bubbleSize.height)];
    [[UIApplication sharedApplication].keyWindow addSubview:BGview];
    [BGview release];
    
    
    UILabel *tipLab =[[UILabel alloc]initWithFrame:BGview.bounds];
    [tipLab setBackgroundColor:[UIColor clearColor]];
    //tipLab.alpha =0.6;
    tipLab.numberOfLines = 0;
    tipLab.lineBreakMode = NSLineBreakByCharWrapping;
    [tipLab setText:tip];
    [tipLab setTextColor:[UIColor blackColor]];
    [tipLab setFont:[UIFont systemFontOfSize:16]];
    [tipLab setTextAlignment:NSTextAlignmentCenter];
    [BGview addSubview:tipLab];
    [tipLab release];
    
    [self performSelector:@selector(removeCurrentTipView:) withObject:BGview afterDelay:0.5];
}

+ (void)removeCurrentTipView:(id)tipView
{
    UIView * v = (UIView *)tipView;
    [UIView animateWithDuration:1
                     animations:^{ v.alpha = 0;}
                     completion:^(BOOL isFinished){[v removeFromSuperview];
                     }];
}


@end
