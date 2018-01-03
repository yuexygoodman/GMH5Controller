//
//  GMH5Handler.h
//  GMH5Controller
//
//  Created by Good Man on 2017/7/4.
//  Copyright © 2017年 Good Man. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GMH5Protocals.h"
#import "GMH5AppSetting.h"


/**
 `GMH5Handler` defines the interactions between controllers and H5 websites.A GMH5Handler object has an unique name,which is the only way that H5 can use to interact with controller,so be carefull to define the name.
 */
@interface GMH5Handler : NSObject

/**
 Some app settings may be used to concrete handlers.
 */
@property(strong,nonatomic) GMH5AppSetting * appSetting;

#pragma -mark methods whose should be overwrited by subclass

/**
 An unique name for current handler.
 */
+ (NSString *)name;

/**
 The interact codes is in this method.

 @param params Parameters passed by javascript.
 @param context A context indicate one handler invoke.
 @param complete A block used to return the result if success or return the error if failure.
 */
- (void)execWithParams:(NSArray *)params context:(id)context complete:(GMH5HandlerCompleteBlock) complete;

@end
