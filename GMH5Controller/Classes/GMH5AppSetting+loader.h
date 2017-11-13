//
//  GMH5AppSetting+loader.h
//  GMH5Controller
//
//  Created by Good Man on 2017/11/3.
//  Copyright © 2017年 Good Man. All rights reserved.
//

#import "GMH5AppSetting.h"

#define kGMH5Setting_Headers @"headers" //http default headers setted to all requests.
#define kGMH5Setting_Cookies @"cookies" //cookies for h5.
#define kGMH5Setting_ErrPageHTML @"ErrPageHTML" // showed when an error ocurred.

typedef NSString GMH5HTML;

@interface GMH5AppSetting (loader)

@property(copy,nonatomic,readonly) NSDictionary * headers;

@property(copy,nonatomic,readonly) NSDictionary * cookies;

@property(copy,nonatomic,readonly) GMH5HTML * errPageHTML;

@end
