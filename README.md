# GMH5Controller
GMH5Controller 用于native和H5端进行交互的场景，支持UIWebView和WKWebView两种方式。下面我们来看怎么使用它：

1、native端，我们可以用多种方式实现native端的代码
  
  1）直接通过viewcontroller的形式加载一个H5的网站

    NSDictionary * dic=@{};//需要根据GMH5AppSetting中的宏定义来设置相关的参数
    GMH5WebViewController * h5=[[GMH5WebViewController alloc] initWithAppSettings:dic];//UIWebView
  或
  
    GMH5WebKitController * h5=[[GMH5WebKitController alloc] initWithAppSettings:dic];//WKWebView
    
    //添加处理消息的handlers
    GMH5Handler * yourHandler=[YourHandler new];//subclass from GMH5Controller please.
    [h5.jsBridge addHandler:yourHandler];
    GMH5HandlerBlock handleBlock;//包含三个参数params,context,completeBlock。params为当前消息携带的参数集合，context标记当前消息主要用于异步的场景,completeBlock为回调，当有数据返回給h5端时，可调用盖block
    [h5.jsBridge addHandlerWithName:@"commandName" handleBlock:handleBlock];
    [self.navigationController pushViewController:h5 animated:YES];
  
  2) h5页面只是整个UI界面中的一部分的情况下，我们可以直接用UIWebView，WKWebView来实现
  
    GMH5AppSetting * settings=[GMH5AppSetting new];
    WKWebView * webView=[WKWebView new];
    webView.appSetting=settings;
    
    GMJSBridge * bridge=[GMWKScriptBridge bridgeWithLoader:webView appSetting:settings];
    
    //添加处理消息的handlers
    [bridge addHandler:[GMH5Handler new]];
    [bridge addHandlerWithName:@"commandName" 
    handleBlock:^(NSArray * _Nullable params, id  _Nonnull context, GMH5HandlerCompleteBlock  _Nonnull block) {
       //处理并返回
    }];
    
    [webView loadH5WithUrl:@"your h5 url"];
    
  3) 向h5端发送消息

    [bridge sendCommandWithName:@"CommandName" params:@[] 
    callBack:^(id  _Nullable data, NSError * _Nullable err) {
        
    }];
    
2、h5端
  
  1) 添加处理消息的handlers
     
          window.GMJSBridge.addHandler('commandName',function(){
            var args=arguments;
            //根据参数做相应处理
            //如何有数据返回
            var data;
            return data;
          });
   2) 向native端发送消息
   
          var callBack=function(context,rst){
              //处理
          };//callback是发送消息給native端，native处理完任务过后的回调，如果没有数据返回可不传
          window.GMJSBridge.sendCommand('commandName',param1,param2,param3,callBack);
 
 
使用方式大致就是这样，详细的信息请看源码，欢迎指证和提意见。
  
