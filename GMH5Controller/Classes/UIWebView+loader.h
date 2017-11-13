//
//  UIWebView+GMH5UrlLoader.h
//  TestNewH5
//
//  Created by 岳潇洋 on 2017/6/30.
//  Copyright © 2017年 岳潇洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMH5Protocals.h"

@interface UIWebView (loader)<GMH5UrlLoader,UIWebViewDelegate>

@property(strong,nonatomic)GMH5AppSetting * appSetting;

- (void)addDelegate:(id<UIWebViewDelegate>)delegate;

@end
