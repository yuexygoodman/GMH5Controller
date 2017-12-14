//
//  WKWebView+GMH5UrlLoader.m
//  TestNewH5
//
//  Created by Good Man on 2017/6/30.
//  Copyright © 2017年 Good Man. All rights reserved.
//

#import "WKWebView+loader.h"
#import "GMH5Handler.h"
#import <objc/runtime.h>
#import "GMH5AppSetting+loader.h"

@interface GMH5WKWebViewDelegate : NSObject

@property(weak,nonatomic)id<WKNavigationDelegate>delegate;

@end

@implementation GMH5WKWebViewDelegate

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[GMH5WKWebViewDelegate class]]) {
        GMH5WKWebViewDelegate * delegate=object;
        return [self.delegate isEqual:delegate.delegate];
    }
    return [super isEqual:object];
}

- (NSUInteger)hash {
    return [self.delegate hash];
}

@end

#define kWebKitRootMsgHandlerName @"getHandler"

static char kWKWebView_AppSettingKey;
static char kWKWebView_DelegatesKey;

@implementation WKWebView (loader)

- (void)setAppSetting:(GMH5AppSetting *)appSetting {
    objc_setAssociatedObject(self, &kWKWebView_AppSettingKey, appSetting, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (GMH5AppSetting *)appSetting {
    return objc_getAssociatedObject(self, &kWKWebView_AppSettingKey);
}

- (NSMutableArray *)delegates {
    NSMutableArray * delegates=objc_getAssociatedObject(self, &kWKWebView_DelegatesKey);
    if (!delegates) {
        delegates=[NSMutableArray new];
        objc_setAssociatedObject(self, &kWKWebView_DelegatesKey, delegates, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return delegates;
}

- (void)addNavigationDelegate:(id<WKNavigationDelegate>)delegate {
    if (!self.navigationDelegate)self.navigationDelegate=self;
    GMH5WKWebViewDelegate * delegateV=[GMH5WKWebViewDelegate new];
    delegateV.delegate=delegate;
    if (![[self delegates] containsObject:delegateV]) {
        [[self delegates] addObject:delegateV];
    }
}

- (void)loadH5WithUrl:(NSString *)urlString {
    NSURL * url=[NSURL URLWithString:urlString];
    [self loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)loadH5WithHTML:(NSString *) htmlString {
    [self loadHTMLString:htmlString baseURL:nil];
}

- (void)evalJavaScript:(NSString *)js completeHandler:(void (^)(id _Nullable, NSError * _Nullable))handler {
    [self evaluateJavaScript:js completionHandler:handler];
}

- (void)injectJavaScript:(NSString *)js completeHandler:(void (^)(id _Nullable, NSError * _Nullable))handler {
    WKUserScript *script = [[WKUserScript alloc] initWithSource:js injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
    [self.configuration.userContentController addUserScript:script];
}

- (void)linkWithBridge:(id<GMJSBridge,WKScriptMessageHandler>)bridge {
    [self.configuration.userContentController addScriptMessageHandler:bridge name:kWebKitRootMsgHandlerName];
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSArray *delegates=[self delegates];
    for (GMH5WKWebViewDelegate *delegate in delegates) {
        if (delegate.delegate && [delegate.delegate respondsToSelector:@selector(webView:decidePolicyForNavigationAction:decisionHandler:)]) {
            [delegate.delegate webView:webView decidePolicyForNavigationAction:navigationAction decisionHandler:decisionHandler];
            return;
        }
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    NSArray *delegates=[self delegates];
    for (GMH5WKWebViewDelegate *delegate in delegates) {
        if (delegate.delegate && [delegate.delegate respondsToSelector:@selector(webView:decidePolicyForNavigationResponse:decisionHandler:)]) {
            [delegate.delegate webView:webView decidePolicyForNavigationResponse:navigationResponse decisionHandler:decisionHandler];
            return;
        }
    }
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSArray *delegates=[self delegates];
    for (GMH5WKWebViewDelegate *delegate in delegates) {
        if (delegate.delegate && [delegate.delegate respondsToSelector:@selector(webView:didStartProvisionalNavigation:)]) {
            [delegate.delegate webView:webView didStartProvisionalNavigation:navigation];
        }
    }
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSArray *delegates=[self delegates];
    for (GMH5WKWebViewDelegate *delegate in delegates) {
        if (delegate.delegate && [delegate.delegate respondsToSelector:@selector(webView:didReceiveServerRedirectForProvisionalNavigation:)]) {
            [delegate.delegate webView:webView didReceiveServerRedirectForProvisionalNavigation:navigation];
        }
    }
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSArray *delegates=[self delegates];
    for (GMH5WKWebViewDelegate *delegate in delegates) {
        if (delegate.delegate && [delegate.delegate respondsToSelector:@selector(webView:didFailProvisionalNavigation:withError:)]) {
            [delegate.delegate webView:webView didFailProvisionalNavigation:navigation withError:error];
        }
    }
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    NSArray *delegates=[self delegates];
    for (GMH5WKWebViewDelegate *delegate in delegates) {
        if (delegate.delegate && [delegate.delegate respondsToSelector:@selector(webView:didCommitNavigation:)]) {
            [delegate.delegate webView:webView didCommitNavigation:navigation];
        }
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    NSArray *delegates=[self delegates];
    for (GMH5WKWebViewDelegate *delegate in delegates) {
        if (delegate.delegate && [delegate.delegate respondsToSelector:@selector(webView:didFinishNavigation:)]) {
            [delegate.delegate webView:webView didFinishNavigation:navigation];
        }
    }
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSArray *delegates=[self delegates];
    for (GMH5WKWebViewDelegate *delegate in delegates) {
        if (delegate.delegate && [delegate.delegate respondsToSelector:@selector(webView:didFailNavigation:withError:)]) {
            [delegate.delegate webView:webView didFailNavigation:navigation withError:error];
        }
    }
}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    NSArray *delegates=[self delegates];
    for (GMH5WKWebViewDelegate *delegate in delegates) {
        if (delegate.delegate && [delegate.delegate respondsToSelector:@selector(webView:didReceiveAuthenticationChallenge:completionHandler:)]) {
            [delegate.delegate webView:webView didReceiveAuthenticationChallenge:challenge completionHandler:completionHandler];
            return;
        }
    }
    if (completionHandler) {
        completionHandler(NSURLSessionAuthChallengePerformDefaultHandling,nil);
    }
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView API_AVAILABLE(macosx(10.11), ios(9.0)) {
    NSArray *delegates=[self delegates];
    for (GMH5WKWebViewDelegate *delegate in delegates) {
        if (delegate.delegate && [delegate.delegate respondsToSelector:@selector(webViewWebContentProcessDidTerminate:)]) {
            [delegate.delegate webViewWebContentProcessDidTerminate:webView];
        }
    }
}

@end
