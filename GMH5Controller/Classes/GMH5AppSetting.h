//
//  GMH5AppSetting.h
//  GMH5Controller
//
//  Created by 岳潇洋 on 2017/6/28.
//  Copyright © 2017年 岳潇洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kGMH5Setting_Headers @"headers" //http default headers setted to all requests.
#define kGMH5Setting_Cookies @"cookies" //cookies for h5.
#define kGMH5Setting_ErrPageHTML @"ErrPageHTML" // showed when an error ocurred.

@interface GMH5AppSetting : NSObject

@property(copy,nonatomic,readonly) NSDictionary * appSettings;

- (id)objectForKey:(NSString *)key;

+ (instancetype) settingWithDictionary:(NSDictionary *) dict;

@end
