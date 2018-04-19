//
//  GMWKScriptReport.m
//  TestNewH5
//
//  Created by Good Man on 2017/6/30.
//  Copyright © 2017年 Good Man. All rights reserved.
//

#import "GMWKScriptBridge.h"
#import "GMH5AppSetting+bridge.h"
#import <WebKit/WebKit.h>
#import "GMH5ControllerBundle.h"
#import "GMH5Handler.h"

@interface GMWKScriptBridge ()<WKScriptMessageHandler>

@end

@implementation GMWKScriptBridge

+ (instancetype)bridgeWithLoader:(WKWebView *)loader appSetting:(GMH5AppSetting *)setting {
    GMWKScriptBridge *bridge=[super bridgeWithLoader:loader appSetting:setting];
    loader.navigationDelegate=loader;
    [loader linkWithBridge:bridge];
    [bridge linkWithLoader:loader];
    return bridge;
}

- (void)addHandler:(GMH5Handler *)handler {
    [super addHandler:handler];
    [self.loader injectJavaScript:[NSString stringWithFormat:@"window.GMJSBridge.%@=function(){this._postMsg('%@',arguments);};",[[handler class] name],[[handler class] name]] atTime:GMH5InjectAtDocStart completeHandler:^(id _Nullable data, NSError * _Nullable error) {
        NSLog(@"error:%@",error);
    }];
}

- (void)addHandlerWithName:(NSString *)name handleBlock:(GMH5HandlerBlock)block {
    [super addHandlerWithName:name handleBlock:block];
    [self.loader injectJavaScript:[NSString stringWithFormat:@"window.GMJSBridge.%@=function(){this._postMsg('%@',arguments);};",name,name] atTime:GMH5InjectAtDocStart completeHandler:^(id _Nullable data, NSError * _Nullable error) {
        NSLog(@"error:%@",error);
    }];
}

- (void)linkWithLoader:(id<GMH5UrlLoader>)loader {
    NSMutableString * script=[[NSString stringWithContentsOfFile:[[GMH5ControllerBundle mainBundle] pathForResource:@"gmbridge" ofType:@"js"] encoding:NSUTF8StringEncoding error:nil] mutableCopy];
    if (self.appSetting.bridgeName.length>0) {
        [script appendFormat:@"window.%@=window.GMJSBridge",self.appSetting.bridgeName];
    }
    [loader injectJavaScript:script atTime:GMH5InjectAtDocStart completeHandler:^(id _Nullable data, NSError * _Nullable error) {
        NSLog(@"error:%@",error);
    }];
    if (self.appSetting.startJS.length>0) {
        [loader injectJavaScript:self.appSetting.startJS atTime:GMH5InjectAtDocStart completeHandler:^(id _Nullable data, NSError * _Nullable error) {
            NSLog(@"error:%@",error);
        }];
    }
    if (self.appSetting.endJS.length>0) {
        [loader injectJavaScript:self.appSetting.endJS atTime:GMH5InjectAtDocEnd completeHandler:^(id _Nullable data, NSError * _Nullable error) {
            NSLog(@"error:%@",error);
        }];
    }
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSArray * params=[message.body objectForKey:@"params"];
    GMH5Handler * handler=[self handlerWithName:[message.body objectForKey:@"commandName"]];
    if (handler) {
        id context=[message.body objectForKey:@"context"];
        NSString * callBack=[message.body objectForKey:@"callBack"];
        [handler execWithParams:params context:context complete:^(id data, id context, NSError *err) {
            if (err) {
                NSLog(@"handler error:%@",err);
                return;
            }
            if (callBack.length>0) {
                NSString * js;
                if (data) {
                    if ([data isKindOfClass:[NSArray class]] || [data isKindOfClass:[NSDictionary class]]){
                        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:0 error:nil];
                        NSString *str = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
                        js=[NSString stringWithFormat:@"%@('%@','%@')",callBack,context,str];
                    }
                    else {
                        js=[NSString stringWithFormat:@"%@('%@','%@')",callBack,context,data];
                    }
                }
                else{
                    js=[NSString stringWithFormat:@"%@('%@')",callBack,context];
                }
                [self.loader evalJavaScript:js completeHandler:^(id _Nullable data, NSError * _Nullable error) {
                    NSLog(@"error:%@",error);
                }];
            }
        }];
    }
    
}

@end
