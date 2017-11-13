//
//  GMH5Report.h
//  GMH5Controller
//
//  Created by Good Man on 2017/7/14.
//  Copyright © 2017年 Good Man. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GMH5Protocals.h"

@class GMH5Command;

@interface GMJSBridge : NSObject<GMJSBridge>

@property(weak,nonatomic)id<GMH5UrlLoader>loader;

@property(strong,nonatomic,readonly) GMH5AppSetting * appSetting;

@property(strong,nonatomic,readonly) NSDictionary * commands;

- (void)addCommand:(GMH5Command *)command;

- (void)addCommandWithName:(NSString *)name commandBlock:(GMH5CommandBlock) block;

- (GMH5Command *)commandWithName:(NSString *)name;

+ (instancetype)bridgeWithLoader:(id<GMH5UrlLoader>)loader appSetting:(GMH5AppSetting *)setting;

@end
