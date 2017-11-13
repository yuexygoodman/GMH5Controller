//
//  GMH5UrlParser.h
//  GMH5Controller
//
//  Created by 岳潇洋 on 2017/6/29.
//  Copyright © 2017年 岳潇洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GMH5Protocals.h"
#import "GMH5AppSetting.h"


typedef id(^GMH5DefaultUrlParserValueForKeyBlock)(NSString * key);

typedef id(^GMH5DefaultUrlParserValueForMethodBlock)(NSString * method,NSString * content);

typedef NS_ENUM(NSInteger,GMH5UrlParserErrCode) {
    GMH5UrlParserErrNone=0,
    GMH5UrlParserErrUrlNull=9,
    GMH5UrlParserErrBadSyntax=8,
    GMH5UrlParserErrUndefinedKey=7,
    GMH5UrlParserErrUndefinedMethod=6
};

/**
 This is the default parser used by this library.
 */
@interface GMH5DefaultUrlParser : NSObject<GMH5UrlParser>

@property(strong,nonatomic) GMH5AppSetting * appSetting;

/**
 Convenience initialize method.

 @param appSetting app setting.
 @return GMH5DefaultUrlParser object.
 */
+ (instancetype)urlParserWithAppSetting:(GMH5AppSetting *) appSetting;

/**
 To set default keys for parsing.

 @param keys An array of string key.
 @param block By invoke this block,parser get the value for a key.
 */
+ (void)registerDefaultKeys:(NSArray *)keys valuesBlock:(GMH5DefaultUrlParserValueForKeyBlock)block;

/**
 To set default methods for parsing.

 @param methods An array of string method.
 @param block By invoke this block,parser get the value for a method.
 */
+ (void)registerDefaultMethods:(NSArray *)methods valuesBlock:(GMH5DefaultUrlParserValueForMethodBlock)block;

/**
 Give you a chance to add custom key to this parser`s system,must be called before parsing a url address.

 @param key An unique string for key.
 @param block A block that can return the value for this key.
 */
- (void)registerKey:(NSString *) key valueblock:(GMH5DefaultUrlParserValueForKeyBlock) block;

/**
 Give you a chance to add custom method to this parser`s system,must be called before parsing a url address.
 
 @param method An unique string for method.
 @param block A block that can return the value for this method.
 */
- (void)registerMethod:(NSString *) method valueblock:(GMH5DefaultUrlParserValueForMethodBlock) block;

#pragma -mark an archive for `GMH5UrlParser` protocal
- (NSString *)parseUrlFromFormatString:(NSString *) url error:(NSError **) err;

@end
