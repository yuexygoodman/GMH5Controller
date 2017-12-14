//
//  GMH5BaseController.h
//  GMH5Controller
//
//  Created by Good Man on 2017/6/29.
//  Copyright © 2017年 Good Man. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMH5Protocals.h"

@class GMH5AppSetting;


/**
 `GMH5BaseController` is a abstract class,you can`t use it directly.
 */
@interface GMH5BaseController : UIViewController<GMH5ContainerProvider>
{
    GMH5AppSetting * _appSetting;
    id<GMH5UrlParser> _parser;
    UIView<GMH5UrlLoader> * _loader;
    id<GMJSBridge> _jsBridge;
}

#pragma -mark propertes
/**
 appSetting
 */
@property(strong,nonatomic)GMH5AppSetting * appSetting;

@property(strong,nonatomic)NSString * url;

@property (nonatomic, strong) UILabel *shadeLabel;

@property(strong,nonatomic) id<GMH5UrlParser> parser;

@property(strong,nonatomic) UIView<GMH5UrlLoader> * loader;

@property(strong,nonatomic) id<GMJSBridge> jsBridge;

#pragma -mark init
/**
 Convenience initialize method,you would not have to change the codes for initailize if a new paramter should add to settings in future.
 
 @param settings A collection that contains all required parameters.
 @return A `GMH5Controller` object.
 */
- (instancetype)initWithAppSettings:(NSDictionary *) settings;

#pragma -mark A chance to set default handlers.
- (NSArray *)defaultHandlers;

@end
