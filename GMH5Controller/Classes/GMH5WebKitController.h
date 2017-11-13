//
//  GMH5WebKitController.h
//  GMH5Controller
//
//  Created by Good Man on 2017/6/29.
//  Copyright © 2017年 Good Man. All rights reserved.
//

#import "GMH5BaseController.h"
#import <WebKit/WebKit.h>

/**
 `GMH5WebKitController` is one resolution for loading H5 app,it is based on WebKit framework,which is avaliable on ios8 and later.
 */
@interface GMH5WebKitController :GMH5BaseController<WKNavigationDelegate,WKUIDelegate>

@end
