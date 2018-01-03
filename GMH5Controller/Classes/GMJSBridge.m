//
//  GMH5Report.m
//  GMH5Controller
//
//  Created by Good Man on 2017/7/14.
//  Copyright © 2017年 Good Man. All rights reserved.
//

#import "GMJSBridge.h"
#import "GMH5BlockHandler.h"

@interface GMJSBridge ()
{
    NSMutableDictionary *_handlers;
}
@end

@implementation GMJSBridge

+ (instancetype)bridgeWithLoader:(id<GMH5UrlLoader>)loader appSetting:(GMH5AppSetting *)setting {
    GMJSBridge * bridge=[[self alloc] initWithAppSetting:setting];
    bridge.loader=loader;
    return bridge;
}

- (id)initWithAppSetting:(GMH5AppSetting *)setting {
    self=[super init];
    if (self) {
        _handlers=[NSMutableDictionary new];
        _appSetting=setting;
    }
    return self;
}

- (NSDictionary *)handlers {
    return [_handlers copy];
}

- (void)addHandler:(GMH5Handler *)handler {
    if ([handler isKindOfClass:[GMH5Handler class]] && [[handler class] name].length>0) {
        handler.appSetting=self.appSetting;
        [_handlers setObject:handler forKey:[[handler class] name]];
    }
}

- (void)addHandlerWithName:(NSString *)name handleBlock:(GMH5HandlerBlock)block {
    if ([name isKindOfClass:[NSString class]] && name.length>0 && block) {
        GMH5BlockHandler * handler=[GMH5BlockHandler new];
        handler.block = [block copy];
        handler.appSetting=self.appSetting;
        [_handlers setObject:handler forKey:name];
    }
}

- (GMH5Handler *)handlerWithName:(NSString *)name {
    GMH5Handler * handler=[_handlers objectForKey:name];
    return handler;
}

- (void)linkWithLoader:(id<GMH5UrlLoader>)loader {

}

- (void)sendCommandWithName:(NSString *)name params:(NSArray *)params callBack:(GMH5CommandCallBack)callBack {
    if (name.length==0)return;
    NSMutableString * script=[NSMutableString new];
    [script appendFormat:@"window.GMJSBridge._getCommand('%@'",name];
    if (params) {
        for (id param in params) {
            [script appendFormat:@",'%@'",param];
        }
    }
    [script appendString:@")"];
    [self.loader evalJavaScript:script completeHandler:^(id _Nullable data, NSError * _Nullable error) {
        callBack(data,error);
    }];
}

@end
