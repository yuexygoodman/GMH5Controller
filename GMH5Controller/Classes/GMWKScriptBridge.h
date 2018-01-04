//
//  GMWKScriptReport.h
//  TestNewH5
//
//  Created by Good Man on 2017/6/30.
//  Copyright © 2017年 Good Man. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GMJSBridge.h"
#import "WKWebView+loader.h"

@interface GMWKScriptBridge :GMJSBridge

+ (instancetype)bridgeWithLoader:(WKWebView *)loader appSetting:(GMH5AppSetting *)setting;

@end
