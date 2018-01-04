//
//  GMH5Protocals.h
//  GMH5Controller
//
//  Created by Good Man on 2017/6/28.
//  Copyright © 2017年 Good Man. All rights reserved.
//
#import <Foundation/Foundation.h>
#ifndef GMH5Protocals_h
#define GMH5Protocals_h

NS_ASSUME_NONNULL_BEGIN

#pragma -mark GMJSBridge

@protocol GMH5UrlLoader;
@protocol GMH5ContainerProvider;

typedef void(^GMH5HandlerCompleteBlock) (_Nullable id data,id context, NSError * _Nullable  err);
typedef void(^GMH5HandlerBlock) (NSArray * _Nullable params,id context,GMH5HandlerCompleteBlock block);
typedef void(^GMH5CommandCallBack) (_Nullable id data,NSError * _Nullable err);

/**
 An interace for bridge object,any bridges must comform it.
 */

@class GMH5Handler;

@protocol GMJSBridge

- (NSDictionary *)handlers;

- (void)addHandler:(GMH5Handler *)handler;

- (void)addHandlerWithName:(NSString *)name handleBlock:(GMH5HandlerBlock) block;

- (void)sendCommandWithName:(NSString *)name params:(NSArray * _Nullable )params callBack:(_Nullable GMH5CommandCallBack)callBack;

/**
 link a bridge and a loader,this method gives a chance to configure some settings for bridges.

 @param loader A loader.
 */
- (void)linkWithLoader:(id<GMH5UrlLoader>) loader;

@end

/**
 A loader comforming `GMH5UrlLoader` protocal is used to show the content of a H5 app,They are responsibilities of a loader to load the H5 app with an url string,eval javascript code and return the result to a caller,inject some js codes in H5 app.
 */
@protocol GMH5UrlLoader

/**
 load the url of a H5 app.
 */
- (void)loadH5WithUrl:(NSString *) urlString;

/**
 loadc the html of a H5 app.
 */
- (void)loadH5WithHTML:(NSString *) htmlString;

/**
 eval javascript code.
 */
- (void)evalJavaScript:(NSString *) js completeHandler:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error)) handler;

/**
 inject javascipt code.
 */
- (void)injectJavaScript:(NSString *) js completeHandler:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error)) handler;


/**
 link a loader and a bridge,this method gives a chance to configure some settings for loaders.

 @param bridge A bridge.
 */
- (void)linkWithBridge:(id<GMJSBridge>) bridge;

@end


/**
 Any parser must archieve the method in `GMH5UrlParser` protocal below to offer the functionality parsing url address. 
 */
@protocol GMH5UrlParser <NSObject>

- (NSString *)parseUrlFromFormatString:(NSString *) url error:(NSError *_Nullable*) err;

@end

#pragma -mark GMH5ContainerProvider
@class GMH5AppSetting;

@protocol GMH5ContainerProvider

@property(strong,nonatomic)GMH5AppSetting * appSetting;
@property(strong,nonatomic)id<GMH5UrlParser> parser;
@property(strong,nonatomic)id<GMH5UrlLoader> loader;
@property(strong,nonatomic)id<GMJSBridge> jsBridge;

@end

NS_ASSUME_NONNULL_END

#endif /* GMH5Protocals_h */
