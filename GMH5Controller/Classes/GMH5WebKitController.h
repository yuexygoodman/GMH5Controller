//
//  GMH5WebKitController.h
//  GMH5Controller
//
//  Created by 岳潇洋 on 2017/6/29.
//  Copyright © 2017年 岳潇洋. All rights reserved.
//

#import "GMH5BaseController.h"
#import <WebKit/WebKit.h>

/**
 `GMH5WebKitController` is one resolution for loading H5 app,it is based on WebKit framework,which is avaliable on ios8 and later.
 */
@interface GMH5WebKitController :GMH5BaseController<WKNavigationDelegate,WKUIDelegate>

@end
