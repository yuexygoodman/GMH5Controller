//
//  GMH5AppSetting+loader.m
//  GMH5Controller
//
//  Created by 岳潇洋 on 2017/11/3.
//  Copyright © 2017年 岳潇洋. All rights reserved.
//

#import "GMH5AppSetting+loader.h"

@implementation GMH5AppSetting (loader)

- (NSDictionary *)cookies {
    return [self objectForKey:kGMH5Setting_Cookies];
}

- (NSDictionary *)headers {
    return [self objectForKey:kGMH5Setting_Headers];
}

- (GMH5HTML *)errPageHTML {
    return [self objectForKey:kGMH5Setting_ErrPageHTML];
}

@end
