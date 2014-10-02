JavaScript Defer

A nifty interceptor to move JS blocks to the bottom of your page

When this module is activated, it will take JavaScript blocks and move them to the bottom of the page.  This can be handy for performance since browser will not continue loading the page until JavaScript files are downloaded and parsed.  This may cause issues if you use inline calls to document.write().