//
//  GMWKScriptReport.h
//  TestNewH5
//
//  Created by 岳潇洋 on 2017/6/30.
//  Copyright © 2017年 岳潇洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GMJSBridge.h"
#import "WKWebView+loader.h"

@interface GMWKScriptBridge :GMJSBridge

+ (instancetype)bridgeWithLoader:(WKWebView *)loader appSetting:(GMH5AppSetting *)setting;

@end
