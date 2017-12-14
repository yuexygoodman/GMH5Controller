window.GMJSBridge={
	version:"1.0",
	event:{
		callbacks:[],
		addCallback:function (context,callback) {
			this.callbacks.push({"context":context,"callback":callback});
		},
		fireCallback:function (context,param) {
			var index=-1;
			for (var i = 0; i < this.callbacks.length; i++) {
				if (this.callbacks[i].context==context) {
					var callback=this.callbacks[i].callback;
					if (typeof callback == "function") {
						callback("",param);
					}
					else if (typeof callback == "string") {
						eval(callback)("",param);
					};
					index=i;
					break;
				};
			}
			if (index>-1) {
				this.callbacks.splice(index,1);
			};
		}
	},
	complete:function (context,param) {
        this.event.fireCallback(context,param);
	},
	getContext:function (methodName) {
		var timestamp=new Date().getTime();
		return methodName+timestamp;
	},
	sendCommand:function (commandName) {
        var args=[];
        for(var i=1;i<arguments.length;i++){
            args.push(arguments[i]);
        }
        this[commandName].apply(this,args);
	},
	log:function (text) {
        //alert(text);
	},
    functionString:function (text) {
        try{
            if(typeof eval(text) == "function") return true;
        }
        catch(err){ // igore err
        }
        return false;
    },
    postMsg:function (method,args) {
        var context=this.getContext(method);
        var msg={"method":method,"context":context};
        var b=false;
        if(args.length>0 && ( typeof args[args.length-1] == "function" || this.functionString(args[args.length-1] ))){
            this.event.addCallback(context,args[args.length-1]);
            b=true;
        }
        var params=[];
        for (var i = 0; i < args.length-(b?1:0); i++) {
            params.push(args[i]);
        };
        msg.params=params;
		msg.callBack="GMJSBridge.complete";
		window.webkit.messageCallbacks["getCommand"].postMessage(msg);
    }
}
window.Report=window.GMJSBridge;
