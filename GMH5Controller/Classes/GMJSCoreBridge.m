//
//  GMJSCoreReport.m
//  GMH5Controller
//
//  Created by Good Man on 2017/6/28.
//  Copyright © 2017年 Good Man. All rights reserved.
//

#import "GMJSCoreBridge.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "GMH5AppSetting+bridge.h"
#import "GMH5BlockHandler.h"
#import "GMH5ControllerBundle.h"

@protocol GMJSObjcDelegate <JSExport>

JSExportAs(getCommand, - (void)getCommand:(NSString *)name);

@end

@interface GMJSCoreBridge ()<GMJSObjcDelegate,UIWebViewDelegate>

@end

@implementation GMJSCoreBridge

+ (instancetype)bridgeWithLoader:(UIWebView *)loader appSetting:(GMH5AppSetting *)setting {
    GMJSCoreBridge *bridge=[super bridgeWithLoader:loader appSetting:setting];
    [loader addDelegate:bridge];
    return bridge;
}

- (void)linkWithLoader:(id<GMH5UrlLoader>)loader {
    NSMutableString * script=[[NSString stringWithContentsOfFile:[[GMH5ControllerBundle mainBundle] pathForResource:@"gmbridge2" ofType:@"js"] encoding:NSUTF8StringEncoding error:nil] mutableCopy];
    for (NSString *name in self.handlers.allKeys) {
        [script appendFormat:@"window.GMJSBridge.%@=function(){this._postMsg('%@',arguments);};",name,name];
    }
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

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.loader linkWithBridge:self];
    [self linkWithLoader:self.loader];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.loader linkWithBridge:self];
    [self linkWithLoader:self.loader];
}

#pragma mark - GMJSObjcDelegate
- (void)getCommand:(NSString *)name {
    NSArray *fuc = [NSArray arrayWithArray: [JSContext currentArguments]];
    if (fuc.count>2) {
        id context=[NSString stringWithFormat:@"%@",fuc[1]];
        GMH5Handler * handler=[self handlerWithName:name];
        if (handler) {
            NSArray * params=fuc.count>3?[fuc subarrayWithRange:NSMakeRange(3, fuc.count-3)]:nil;
            [handler execWithParams:params context:context complete:^(id data, id context, NSError *err) {
                if (err) {
                    NSLog(@"handler error:%@",err);
                    return;
                }
                NSString *funStr = [NSString stringWithFormat:@"%@",fuc[2]];
                NSArray * objs=[funStr componentsSeparatedByString:@"."];
                JSValue *shareCallback=[JSContext currentContext][objs[0]];
                for (int i=0; i<objs.count-1; i++) {
                    shareCallback=[shareCallback valueForProperty:objs[i+1]];
                }
                NSMutableArray * args=[@[context] mutableCopy];
                if ([data isKindOfClass:[NSString class]]) {
                    [args addObject:data];
                }
                else if ([data isKindOfClass:[NSArray class]] || [data isKindOfClass:[NSDictionary class]]){
                    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:0 error:nil];
                    NSString *str = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
                    [args addObject:str];
                }
                [shareCallback callWithArguments:args];
            }];
        }
    }
    
}

@end
