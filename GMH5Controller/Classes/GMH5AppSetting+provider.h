//
//  GMH5AppSetting+provider.h
//  GMH5Controller
//
//  Created by Good Man on 2017/11/3.
//  Copyright © 2017年 Good Man. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMH5AppSetting.h"

#define kGMH5Setting_Url @"url" // The url address refer to a H5 app.
#define kGMH5Setting_Name @"title" // The app name of a H5 app,this name would be showed as navigation title.
#define kGMH5Setting_NavBarHidden @"navigationBarHidden" // A boolean value to show or hide the navigation bar of the view controller.
#define kGMH5Setting_NavBgColor @"navBackgroundColor" // A color string for navigation bar,such as '#000000'.
#define kGMH5Setting_TitleColor @"titleColor" // A color string for navigation title,such as '#000000'.
#define kGMH5Setting_StatusColor @"statusColor"

@interface GMH5AppSetting (provider)

@property(assign,nonatomic) BOOL navigationBarHidden;

@property(strong,nonatomic) UIColor * navBackgroundColor;

@property(strong,nonatomic) UIColor * titleColor;

@property(strong,nonatomic) UIColor * statusColor;

@property(copy,nonatomic) NSString * name;

@property(copy,nonatomic) NSString * url;

@end
