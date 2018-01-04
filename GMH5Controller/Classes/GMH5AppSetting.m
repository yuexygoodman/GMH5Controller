//
//  GMH5AppSetting.m
//  GMH5Controller
//
//  Created by Good Man on 2017/6/28.
//  Copyright © 2017年 Good Man. All rights reserved.
//

#import "GMH5AppSetting.h"

@interface GMH5AppSetting ()

@property(nonatomic,strong) NSMutableDictionary * settings;

@end

@implementation GMH5AppSetting

- (id)objectForKey:(NSString *)key {
    return [self.settings objectForKey:key];
}

- (void)setObject:(id)object forKey:(NSString *)key {
    if (object) {
        [self.settings setObject:object forKey:key];
    }
}

- (void)removeObjectForKey:(NSString *)key {
    [self.settings removeObjectForKey:key];
}

- (NSMutableDictionary *)settings {
    if (!_settings) {
        _settings=[NSMutableDictionary new];
    }
    return _settings;
}

+ (instancetype)settingWithDictionary:(NSDictionary *) dict {
    GMH5AppSetting * appSetting=[GMH5AppSetting new];
    [appSetting.settings addEntriesFromDictionary:dict];
    return appSetting;
}

@end
