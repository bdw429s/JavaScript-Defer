<cfcomponent hint="I extract all script tags from the rendered HTML and move them to the end of the source code." output="false">

	<cffunction name="preRender" access="public" returntype="void" hint="Executes before event data is rendered" output="false" >
		<cfargument name="event">
		<cfargument name="interceptData">
		
		<cfscript>
		// Note, this interceptor will not affect JavaScript placed on the page via cfhtmlhead or cfajaxproxy tags. 
		// Those are appended to the output buffer after ColdBox is finished. It is possible to snag those too, but you 
		// will have to dig into undocumented portions the Java HTTPRequest object. 
		// 
		// Also note, if you have any JavaScript doing something like document.write() you probably DON'T want it moved.
		// In that instance, a way needs to be established to "exempt" a script tag from this regex.	
		
		var local = {};
		// Regex to match script tags.
		local.regex = "<[\s\/]*script\b[^>]*>[^>]*<\/script>";
		// String buffer to avoid exessive string memory usage.
		local.javaScriptToDefer = createObject("java","java.lang.StringBuffer").init(javaCast("int", 4000));
		// carriage return, line feed
		local.crlf = chr(13) & chr(10);
		
		local.result = reFindNoCase(local.regex,interceptData.renderedContent,1,true);
		// Loop as long as their are more <script> tags in the document.
		while(local.result.len[1])
		{
			// Add this script tag into the buffer...
			local.javaScriptToDefer.append(javaCast("string", local.crlf));
			local.javaScriptToDefer.append(javaCast("string", mid(interceptData.renderedContent,local.result.pos[1],local.result.len[1])));
			// ...and keep searching
			local.result = reFindNoCase(local.regex,interceptData.renderedContent,local.result.pos[1]+local.result.len[1],true);
		}
		// Strip out all script tags and append them to the end. interceptData is a struct so it is passed by reference. No need to return any data.
		interceptData.renderedContent = reReplaceNoCase(interceptData.renderedContent,local.regex,"","all") & local.javaScriptToDefer.toString();
		</cfscript>
		
	</cffunction>
		
</cfcomponent>