//
//  GMH5WebKitController.m
//  GMH5Controller
//
//  Created by Good Man on 2017/6/29.
//  Copyright © 2017年 Good Man. All rights reserved.
//

#import "GMH5WebKitController.h"
#import "GMWKScriptBridge.h"
#import "WKWebView+loader.h"
#import "GMH5UrlParser.h"
#import "GMH5Indicator.h"
#import "GMH5ControllerBundle.h"
#import "GMH5AppSetting+provider.h"

@interface GMH5WebKitController ()

@property(strong,nonatomic)WKWebView * webView;
@property (nonatomic, strong) UIView<GMH5Indicator> *activity;

@end

@implementation GMH5WebKitController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    [self.view addSubview:self.activity];
}

- (void)dealloc {
    _webView.navigationDelegate=nil;
    [_webView stopLoading];
}

#pragma -mark WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    //    DLOG(@"msg = %@ frmae = %@",message,frame);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    
    
    [self presentViewController:alertController animated:YES completion:nil];
}



#pragma -mark WKNavigationDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    [self.activity startAnimating];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    [self.activity stopAnimating];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    [self.activity stopAnimating];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    [self.activity stopAnimating];
}


#pragma -mark setter

- (WKWebView *)webView {
    if (!_webView) {
        _webView=[[WKWebView alloc] init];
        _webView.appSetting=self.appSetting;
        CGRect frame=self.appSetting.navigationBarHidden?CGRectMake(0,[UIApplication sharedApplication].statusBarFrame.size.height, [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height - [UIApplication sharedApplication].statusBarFrame.size.height):CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-[UIApplication sharedApplication].statusBarFrame.size.height-self.navigationController.navigationBar.bounds.size.height);
        _webView.frame=frame;
        _webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
        [_webView addNavigationDelegate:self];
        _webView.UIDelegate=self;
        _webView.scrollView.bounces = NO;
    }
    return _webView;
}

- (id<GMH5UrlParser>)parser {
    if (_parser==nil) {
        _parser=[GMH5DefaultUrlParser urlParserWithAppSetting:self.appSetting];
    }
    return _parser;
}

- (id<GMH5UrlLoader>)loader {
    if (_loader==nil) {
        _loader=self.webView;
    }
    return _loader;
}

- (id<GMJSBridge>)jsBridge {
    if (!_jsBridge) {
        _jsBridge=[GMWKScriptBridge bridgeWithLoader:self.webView appSetting:self.appSetting];
    }
    return _jsBridge;
}

- (UIView<GMH5Indicator> *)activity {
    if (!_activity) {
        _activity =[[GMH5LoadingIndicator alloc] initWithImage:[GMH5ControllerBundle imageNamed:@"加载"] rate:2.0f];
        _activity.center = self.view.center;
    }
    return _activity;
}

@end
