//
//  GMWKScriptReport.m
//  TestNewH5
//
//  Created by 岳潇洋 on 2017/6/30.
//  Copyright © 2017年 岳潇洋. All rights reserved.
//

#import "GMWKScriptBridge.h"
#import "GMH5AppSetting+bridge.h"
#import <WebKit/WebKit.h>
#import "GMH5ControllerBundle.h"
#import "GMH5Command.h"

@interface GMWKScriptBridge ()<WKScriptMessageHandler>

@property(weak,nonatomic) id<GMH5ContainerProvider> provider;

@property(weak,nonatomic) WKWebView * webView;

@end

@implementation GMWKScriptBridge

+ (instancetype)bridgeWithLoader:(WKWebView *)loader appSetting:(GMH5AppSetting *)setting {
    GMWKScriptBridge *bridge=[super bridgeWithLoader:loader appSetting:setting];
    [loader linkWithBridge:bridge];
    [bridge linkWithLoader:loader];
    return bridge;
}

- (void)addCommand:(GMH5Command *)command {
    [super addCommand:command];
    [self.loader injectJavaScript:[NSString stringWithFormat:@"window.GMJSBridge.%@=function(){this.postMsg('%@',arguments);};",[[command class] name],[[command class] name]] completeHandler:^(id _Nullable data, NSError * _Nullable error) {
        NSLog(@"error:%@",error);
    }];
}

- (void)addCommandWithName:(NSString *)name commandBlock:(GMH5CommandBlock)block {
    [super addCommandWithName:name commandBlock:block];
    [self.loader injectJavaScript:[NSString stringWithFormat:@"window.GMJSBridge.%@=function(){this.postMsg('%@',arguments);};",name,name] completeHandler:^(id _Nullable data, NSError * _Nullable error) {
        NSLog(@"error:%@",error);
    }];
}

- (void)linkWithLoader:(id<GMH5UrlLoader>)loader {
    NSMutableString * script=[[NSString stringWithContentsOfFile:[[GMH5ControllerBundle mainBundle] pathForResource:@"gmbridge" ofType:@"js"] encoding:NSUTF8StringEncoding error:nil] mutableCopy];
    if (self.appSetting.bridgeName.length>0) {
        [script appendFormat:@"window.%@=window.GMJSBridge",self.appSetting.bridgeName];
    }
    [loader injectJavaScript:script completeHandler:^(id _Nullable data, NSError * _Nullable error) {
        NSLog(@"error:%@",error);
    }];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSArray * params=[message.body objectForKey:@"params"];
    GMH5Command * command=[self commandWithName:[message.body objectForKey:@"method"]];
    if (command) {
        id context=[message.body objectForKey:@"context"];
        NSString * callBack=[message.body objectForKey:@"callBack"];
        [command execWithParams:params context:context complete:^(id data, id context, NSError *err) {
            if (err) {
                NSLog(@"command error:%@",err);
                return;
            }
            if (callBack.length>0) {
                NSString * js;
                if ([data isKindOfClass:[NSString class]]) {
                    js=[NSString stringWithFormat:@"%@('%@','%@')",callBack,context,data];
                }
                else if ([data isKindOfClass:[NSArray class]] || [data isKindOfClass:[NSDictionary class]]){
                    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:0 error:nil];
                    NSString *str = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
                    js=[NSString stringWithFormat:@"%@('%@','%@')",callBack,context,str];
                }
                else{
                    js=[NSString stringWithFormat:@"%@('%@')",callBack,context];
                }
                [self.provider.loader evalJavaScript:js completeHandler:^(id _Nullable data, NSError * _Nullable error) {
                    NSLog(@"error:%@",error);
                }];
            }
        }];
    }
    
}

@end
