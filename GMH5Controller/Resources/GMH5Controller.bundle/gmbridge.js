window.GMJSBridge={
	version:"1.0",
	event:{
		handlers:[],
		addHandler:function (context,handler) {
			this.handlers.push({"context":context,"handler":handler});
		},
		fireHandler:function (context,param) {
			var index=-1;
			for (var i = 0; i < this.handlers.length; i++) {
				if (this.handlers[i].context==context) {
					var handler=this.handlers[i].handler;
					if (typeof handler == "function") {
						handler("",param);
					}
					else if (typeof handler == "string") {
						eval(handler)("",param);
					};
					index=i;
					break;
				};
			}
			if (index>-1) {
				this.handlers.splice(index,1);
			};
		}
	},
	complete:function (context,param) {
        this.event.fireHandler(context,param);
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
            this.event.addHandler(context,args[args.length-1]);
            b=true;
        }
        var params=[];
        for (var i = 0; i < args.length-(b?1:0); i++) {
            params.push(args[i]);
        };
        msg.params=params;
		msg.callBack="GMJSBridge.complete";
		window.webkit.messageHandlers["getCommand"].postMessage(msg);
    }
}
window.Report=window.GMJSBridge;
