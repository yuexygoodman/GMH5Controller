//
//  GMH5Report.m
//  GMH5Controller
//
//  Created by Good Man on 2017/7/14.
//  Copyright © 2017年 Good Man. All rights reserved.
//

#import "GMJSBridge.h"
#import "GMH5BlockCommand.h"

@interface GMJSBridge ()
{
    NSMutableDictionary *_commands;
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
        _commands=[NSMutableDictionary new];
        _appSetting=setting;
    }
    return self;
}

- (NSDictionary *)commands {
    return [_commands copy];
}

- (void)addCommand:(GMH5Command *)command {
    if ([command isKindOfClass:[GMH5Command class]] && [[command class] name].length>0) {
        command.appSetting=self.appSetting;
        [_commands setObject:command forKey:[[command class] name]];
    }
}

- (void)addCommandWithName:(NSString *)name commandBlock:(GMH5CommandBlock) block {
    if ([name isKindOfClass:[NSString class]] && name.length>0 && block) {
        GMH5BlockCommand * command=[GMH5BlockCommand new];
        command.block = [block copy];
        command.appSetting=self.appSetting;
        [_commands setObject:command forKey:name];
    }
}

- (GMH5Command *)commandWithName:(NSString *)name {
    GMH5Command * command=[_commands objectForKey:name];
    return command;
}

- (void)linkWithLoader:(id<GMH5UrlLoader>)loader {

}

@end
