//
//  WKWebView+GMH5UrlLoader.h
//  TestNewH5
//
//  Created by Good Man on 2017/6/30.
//  Copyright © 2017年 Good Man. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "GMH5Protocals.h"

@interface WKWebView (loader)<GMH5UrlLoader,WKNavigationDelegate>

@property(strong,nonatomic)GMH5AppSetting * appSetting;

- (void)addNavigationDelegate:(id<WKNavigationDelegate>)delegate;

@end
