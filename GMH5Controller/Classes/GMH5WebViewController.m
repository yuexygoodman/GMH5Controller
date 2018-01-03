//
//  GMH5Controller.m
//  GMH5Controller
//
//  Created by Good Man on 2017/5/23.
//  Copyright © 2017年 Good Man. All rights reserved.
//

#import "GMH5WebViewController.h"
#import "GMJSCoreBridge.h"
#import "GMH5AppSetting.h"
#import "UIWebView+loader.h"
#import "GMH5UrlParser.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "GMH5Indicator.h"
#import "GMH5ControllerBundle.h"
#import "GMH5AppSetting+provider.h"

@interface GMH5WebViewController ()

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIView<GMH5Indicator> *activity;

@end

@implementation GMH5WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    [self.view addSubview:self.activity];
}

- (void)dealloc {
    [_webView setDelegate:nil];
    [_webView stopLoading];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.activity startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.activity stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    [self.activity stopAnimating];
    NSLog(@"加载出错%@",[error description]);
}

#pragma mark - Setter Getter

- (UIWebView *)webView {
    if (!_webView) {
        CGRect frame=self.appSetting.navigationBarHidden?CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height, [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height - [UIApplication sharedApplication].statusBarFrame.size.height):CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-[UIApplication sharedApplication].statusBarFrame.size.height-self.navigationController.navigationBar.bounds.size.height);
        _webView = [[UIWebView alloc]initWithFrame:frame];
        _webView.appSetting=self.appSetting;
        _webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
        [_webView addDelegate:self];
        _webView.scrollView.bounces = NO;
        _webView.opaque=NO;
        _webView.backgroundColor=[UIColor clearColor];
        self.view.backgroundColor=[UIColor whiteColor];
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
        _jsBridge=[GMJSCoreBridge bridgeWithLoader:self.webView appSetting:self.appSetting];
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
