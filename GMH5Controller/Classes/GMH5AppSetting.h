//
//  GMH5AppSetting.h
//  GMH5Controller
//
//  Created by Good Man on 2017/6/28.
//  Copyright © 2017年 Good Man. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GMH5AppSetting : NSObject

- (id)objectForKey:(NSString *)key;

+ (instancetype) settingWithDictionary:(NSDictionary *) dict;

@end
