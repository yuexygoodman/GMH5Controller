//
//  GMH5AppSetting.m
//  GMH5Controller
//
//  Created by 岳潇洋 on 2017/6/28.
//  Copyright © 2017年 岳潇洋. All rights reserved.
//

#import "GMH5AppSetting.h"

@interface GMH5AppSetting ()

@property(nonatomic,strong) NSDictionary * settings;

@end

@implementation GMH5AppSetting

- (NSDictionary *)appSettings {
    return self.settings;
}

- (id)objectForKey:(NSString *)key {
    return [self.settings objectForKey:key];
}

+ (instancetype)settingWithDictionary:(NSDictionary *) dict {
    GMH5AppSetting * appSetting=[GMH5AppSetting new];
    appSetting.settings=[dict copy];
    return appSetting;
}

@end
