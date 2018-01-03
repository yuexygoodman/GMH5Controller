//
//  GMH5Controller.h
//  GMH5Controller
//
//  Created by Good Man on 2017/6/29.
//  Copyright © 2017年 Good Man. All rights reserved.
//

#ifndef GMH5Controller_h
#define GMH5Controller_h

/** What can you do by using this framework.
    
 */

/** Introduction
 This library is used for loading H5 website in gome app.one H5 website has one configuration,which called `GMH5AppSetting` in this library.To load H5 website,we provide a provider that comform `GMH5ContainerProvider` protocal.a provider always contains four primary parts:
    A appSetting,configuration of a H5 website.
    A parser,which comform `GMH5UrlParser` protocal,to render service parsing the url address of a H5 website`s homepage.
    A loader,which comform `GMH5UrlLoader` protocal,to show the content of a H5 website.
    A bridge,which comform `GMJSBridge` protocal,to interact with javascript code in a H5 website.
 For more detial,please see the `GMH5Protocals` header file,in where all the protocals used by this library are defined.
 */

/** Parser
 Any parser must archieve the method in `GMH5UrlParser` protocal defined in GMH5Protocals.h to offer the functionality parsing url address.Different parsers have different parsing rules,which depend on your business.In this library,the default rule defined by `GMH5DefaultUrlParser` class is that parsing url address by placeholders.Let`s see an example:
    
      `https://www.gome.com/[appid]/index.html?userid=[userId]&timestamp=[TimeStamp]&sign={md5:12345[userId][TimeStamp]12345}`
      The url string above contains square braces and curly braces.The square braces contain a key that can be parsed by default parser.
 
      The curly braces contain a method that can calculate based on the content after the colon and return a value to be filled in the range of the curly braces.
 
      If you want to define your custom keys,please call the method:
            - (void)registerKey:(NSString *) key valueblock:(GMH5DefaultUrlParserValueForKeyBlock) block;
      If you want to define your custom methods,please call the method:
            - (void)registerMethod:(NSString *) method valueblock:(GMH5DefaultUrlParserValueForMethodBlock) block;
      Note:All the calls must happen before parsing a url address,otherwise,they are not valid.
 See:GMH5UrlParser.h
 */

/** Loader
 A loader always is a UIWebView object or a WKWebView object,which comform to `GMH5UrlLoader` protocal.You can define your custom loader by this protocal,but it is unneccessary in most cases.
 */

/** Bridge
 In this libray,we defined two bridges,one for UIWebView and another one for WKWebView,both of them comform to `GMJSBridge` protocal.You can define your custom bridge by this protocal,but it is unnecessary in most cases.
 */

/** Handler
 A handler defines one kind of interaction with javascript.
 
 You can define your custom handlers by three steps if needed.
    first.  you subclass the `GMH5Handler` abstract class.
    second. you overwrite the `+ (NSString *)name` mehod and offer a unique name for this handler you have
            defined.
    third.  you overwrite the `- (void)execWithParams:(NSArray *)params complete:(GMH5HandlerCompleteBlock) complete` method to achieve youself special interaction.
 */

/** How to use
 We defined two concrete classes called `GMH5WebKitController` and `GMH5WebViewController` to provide the loading service.`GMH5WebKitController` is based on WebKit framework,efficient,but only avaliable for iOS8 and later,alternatively,you can use `GMH5WebViewController`,which is based on UIWebView and support more low versions.
 Almostly,you can just only initialize one of the two class above to load a H5 website.Sample codes like this:
 
[CODE:] NSDictionary * dic;
        GMH5WebKitController * h5=[[GMH5WebKitController alloc] initWithAppSettings:dic];
        [self.navigationController pushViewController:h5 animated:YES];
 
 By default,we provide some handlers that can satisfy majority H5 websites.if you want to define any custom interactions,you can call the bridge`s method `- (void)addHandler:(GMH5Handler *) handler` after defining your custom method or the another `- (void)addHandlerWithName:(NSString *)name handlerBlock:(GMH5HandlerBlock) block` method if your interaction is very simple.
 */

#import "GMH5Protocals.h"

#import "GMH5BaseController.h"
#import "GMH5WebViewController.h"
#import "GMH5WebKitController.h"

#import "GMH5Indicator.h"

#import "GMH5AppSetting.h"
#import "GMH5AppSetting+bridge.h"
#import "GMH5AppSetting+provider.h"

#import "GMJSBridge.h"
#import "GMJSCoreBridge.h"
#import "GMWKScriptBridge.h"

#import "GMH5UrlParser.h"
#import "UIWebView+loader.h"
#import "WKWebView+loader.h"

#import "GMH5Handler.h"

#endif /* GMH5Controller_h */
