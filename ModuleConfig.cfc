component {

	// Module Properties
	this.title 				= "JavaScript Defer";
	this.author 			= "Brad Wood";
	this.webURL 			= "https://github.com/bdw429s/JavaScript-Defer/";
	this.description 		= "A nifty interceptor to move JS blocks to the bottom of your page";
	this.version			= "2.0.0";
	this.modelNamespace		= "javascript-defer";

	function configure(){
				
		// Interceptors
		interceptors = [
			{ name="javascriptDefer", class="#moduleMapping#.interceptors.JavascriptDefer" }
		];
		
	}

}