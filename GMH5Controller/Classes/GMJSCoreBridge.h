//
//  GMJSCoreReport.h
//  GMH5Controller
//
//  Created by 岳潇洋 on 2017/6/28.
//  Copyright © 2017年 岳潇洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GMJSBridge.h"
#import "UIWebView+loader.h"

@interface GMJSCoreBridge : GMJSBridge

+ (instancetype)bridgeWithLoader:(UIWebView *)loader appSetting:(GMH5AppSetting *)setting;

@end
