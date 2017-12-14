//
//  GMH5BaseController.m
//  GMH5Controller
//
//  Created by Good Man on 2017/6/29.
//  Copyright © 2017年 Good Man. All rights reserved.
//

#import "GMH5BaseController.h"
#import "GMH5UrlParser.h"
#import "GMH5AppSetting+provider.h"
#import "GMH5Handler.h"

#define kSTATUSCOLOR [UIColor blueColor]

@interface GMH5BaseController ()
{
    UIColor * _oldTintColor;
    UIColor * _oldTitleColor;
}
@end

@implementation GMH5BaseController

#pragma -mark init
- (instancetype)initWithAppSettings:(NSDictionary *)settings {
    self=[self init];
    if (self) {
        self.appSetting=[GMH5AppSetting settingWithDictionary:settings];
    }
    return self;
}

#pragma -mark life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //apply app setting to provider
    [self applyProviderSetting];
    
    //parse url
    NSError * error=nil;
    self.url=[self.parser parseUrlFromFormatString:self.appSetting.url error:&error];
    if (error){
        NSLog(@"parse error:%@",error);
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //register default handlers if exist.
    NSArray *handlers=[self defaultHandlers];
    if (handlers) {
        for (GMH5Handler *handler in handlers) {
            [self.jsBridge addHandler:handler];
        }
    }
    //load H5
    [self.loader loadH5WithUrl:self.url];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barTintColor=_oldTintColor;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : _oldTitleColor?_oldTitleColor:[UIColor blackColor]}];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
}

#pragma -mark internal methods
- (void)applyProviderSetting {
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    [self.navigationController setNavigationBarHidden:self.appSetting.navigationBarHidden animated:NO];
    self.navigationItem.title=[NSString stringWithFormat:@"%@",self.appSetting.name];
    
    _oldTintColor=self.navigationController.navigationBar.barTintColor;
    if (self.appSetting.navBackgroundColor) {
        self.navigationController.navigationBar.barTintColor=self.appSetting.navBackgroundColor;
    }
    _oldTitleColor=[[self.navigationController.navigationBar titleTextAttributes] objectForKey:NSForegroundColorAttributeName];
    if (self.appSetting.titleColor) {
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : self.appSetting.titleColor}];
    }
    
    if (self.appSetting.navigationBarHidden) {
        [self.view addSubview:self.shadeLabel];
    }
}

#pragma mark - Setter Getter

- (UILabel *)shadeLabel {
    if (!_shadeLabel) {
        _shadeLabel =  [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
        self.shadeLabel.backgroundColor =self.appSetting.statusColor?self.appSetting.statusColor:kSTATUSCOLOR;
    }
    return _shadeLabel;
}

#pragma -mark - abstractmethods

- (NSArray *)defaultHandlers {
    return nil;
}

@end
