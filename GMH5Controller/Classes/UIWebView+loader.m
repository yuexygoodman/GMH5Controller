//
//  UIWebView+GMH5UrlLoader.m
//  TestNewH5
//
//  Created by Good Man on 2017/6/30.
//  Copyright © 2017年 Good Man. All rights reserved.
//

#import "UIWebView+loader.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <objc/runtime.h>
#import "GMH5AppSetting+loader.h"

@interface GMH5WebViewDelegate : NSObject

@property(weak,nonatomic)id<UIWebViewDelegate>delegate;

@end

@implementation GMH5WebViewDelegate

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[GMH5WebViewDelegate class]]) {
        GMH5WebViewDelegate * delegate=object;
        return [self.delegate isEqual:delegate.delegate];
    }
    return [super isEqual:object];
}

- (NSUInteger)hash {
    return [self.delegate hash];
}

@end

#define kJSContextKeyPath @"documentView.webView.mainFrame.javaScriptContext"
#define kJSContextRootOBJ @"_gm_jsbridge"

static char kUIWebView_AppSettingKey;
static char kUIWebView_DelegatesKey;

@implementation UIWebView (loader)

- (void)setAppSetting:(GMH5AppSetting *)appSetting {
    objc_setAssociatedObject(self, &kUIWebView_AppSettingKey, appSetting, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (GMH5AppSetting *)appSetting {
    return objc_getAssociatedObject(self, &kUIWebView_AppSettingKey);
}

- (NSMutableArray *)delegates {
    NSMutableArray * delegates=objc_getAssociatedObject(self, &kUIWebView_DelegatesKey);
    if (!delegates) {
        delegates=[NSMutableArray new];
        objc_setAssociatedObject(self, &kUIWebView_DelegatesKey, delegates, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return delegates;
}

- (void)addDelegate:(id<UIWebViewDelegate>)delegate {
    if (!self.delegate)self.delegate=self;
    GMH5WebViewDelegate * delegateV=[GMH5WebViewDelegate new];
    delegateV.delegate=delegate;
    if (![[self delegates] containsObject:delegateV]) {
        [[self delegates] addObject:delegateV];
    }
}

- (void)loadH5WithUrl:(NSString *)urlString {
    [self applyLoaderSetting];
    NSURL * url=[NSURL URLWithString:urlString];
    [self loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)loadH5WithHTML:(NSString *) htmlString {
    [self applyLoaderSetting];
    [self loadHTMLString:htmlString baseURL:nil];
}

- (void)applyLoaderSetting {
    
}

- (void)evalJavaScript:(NSString *)js completeHandler:(void (^)(id _Nullable, NSError * _Nullable))handler {
    handler([self stringByEvaluatingJavaScriptFromString:js],nil);
}

- (void)injectJavaScript:(NSString *)js completeHandler:(void (^)(id _Nullable, NSError * _Nullable))handler {
    handler([self stringByEvaluatingJavaScriptFromString:js],nil);
}

- (void)linkWithBridge:(id<GMJSBridge>)bridge {
    JSContext * jsContext = [self valueForKeyPath:kJSContextKeyPath];
    jsContext[kJSContextRootOBJ] =bridge;
    jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue){
        context.exception = exceptionValue;
        NSLog(@"异常信息:%@",exceptionValue);
    };
}

#pragma -mark UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSArray * delegates=[self delegates];
    for (GMH5WebViewDelegate *delegate in delegates) {
        if (delegate.delegate && [delegate.delegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) {
            return [delegate.delegate webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
        }
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSArray * delegates=[self delegates];
    for (GMH5WebViewDelegate *delegate in delegates) {
        if (delegate.delegate && [delegate.delegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
            [delegate.delegate webViewDidStartLoad:webView];
        }
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSArray * delegates=[self delegates];
    for (GMH5WebViewDelegate *delegate in delegates) {
        if (delegate.delegate && [delegate.delegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
            [delegate.delegate webViewDidFinishLoad:webView];
        }
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSArray * delegates=[self delegates];
    for (GMH5WebViewDelegate *delegate in delegates) {
        if (delegate.delegate && [delegate.delegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
            [delegate.delegate webView:webView didFailLoadWithError:error];
        }
    }
}

@end
