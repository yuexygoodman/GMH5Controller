//
//  UIWebView+GMH5UrlLoader.h
//  TestNewH5
//
//  Created by Good Man on 2017/6/30.
//  Copyright © 2017年 Good Man. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMH5Protocals.h"

@interface UIWebView (loader)<GMH5UrlLoader,UIWebViewDelegate>

@property(strong,nonatomic)GMH5AppSetting * appSetting;

- (void)addDelegate:(id<UIWebViewDelegate>)delegate;

@end
