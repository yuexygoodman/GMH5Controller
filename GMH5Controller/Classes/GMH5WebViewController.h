//
//  GMH5Controller.h
//  GMH5Controller
//
//  Created by 岳潇洋 on 2017/5/23.
//  Copyright © 2017年 岳潇洋. All rights reserved.
//

#import "GMH5BaseController.h"

/**
 `GMH5Controller` class,based on JavaScriptCore framework,is the container of a H5 app.By providing the home page url,the app key of a H5 app,and some other settings if needed,you can load a H5 app through this class.
 */
@interface GMH5WebViewController :GMH5BaseController<UIWebViewDelegate>

@end
