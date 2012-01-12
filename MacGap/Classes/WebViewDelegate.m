#import "WebViewDelegate.h"
#import "Sound.h"
#import "Dock.h"
#import "Growl.h"
#import "Path.h"
#import "App.h"
#import "Window.h"
#import "WindowController.h"
@implementation WebViewDelegate

@synthesize sound;
@synthesize dock;
@synthesize growl;
@synthesize path;
@synthesize app;
@synthesize window;
@synthesize requestedWindow;

- (void) webView:(WebView*)webView didClearWindowObject:(WebScriptObject*)windowScriptObject forFrame:(WebFrame *)frame
{
	if (self.sound == nil) { self.sound = [Sound new]; }
	if (self.dock == nil) { self.dock = [Dock new]; }
	if (self.growl == nil) { self.growl = [Growl new]; }
	if (self.path == nil) { self.path = [Path new]; }
	if (self.app == nil) { self.app = [App new]; }
    if (self.window == nil) { 
        self.window = [Window new]; 
        self.window.webView = webView; 
    }
    
    [windowScriptObject setValue:self forKey:kWebScriptNamespace];
}

- (void) webView:(WebView*)webView addMessageToConsole:(NSDictionary*)message
{
	if (![message isKindOfClass:[NSDictionary class]]) { 
		return;
	}
	
	NSLog(@"JavaScript console: %@:%@: %@", 
		  [[message objectForKey:@"sourceURL"] lastPathComponent],	// could be nil
		  [message objectForKey:@"lineNumber"],
		  [message objectForKey:@"message"]);
}

- (void)webView:(WebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WebFrame *)frame
{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert addButtonWithTitle:@"OK"];
    [alert setMessageText:message];
    [alert setAlertStyle:NSWarningAlertStyle];
    [alert runModal];
}

- (NSArray *)webView:(WebView *)sender contextMenuItemsForElement:(NSDictionary *)element defaultMenuItems:(NSArray *)defaultMenuItems 
{
    NSMutableArray *webViewMenuItems = [defaultMenuItems mutableCopy];
    
    if (webViewMenuItems)
    {
        NSEnumerator *itemEnumerator = [defaultMenuItems objectEnumerator];
        NSMenuItem *menuItem = nil;
        while ((menuItem = [itemEnumerator nextObject]))
        {
            NSInteger tag = [menuItem tag];
            
            switch (tag)
            {
                case WebMenuItemTagOpenLinkInNewWindow:
                case WebMenuItemTagDownloadLinkToDisk:
                case WebMenuItemTagCopyLinkToClipboard:
                case WebMenuItemTagOpenImageInNewWindow:
                case WebMenuItemTagDownloadImageToDisk:
                case WebMenuItemTagCopyImageToClipboard:
                case WebMenuItemTagOpenFrameInNewWindow:
                case WebMenuItemTagGoBack:
                case WebMenuItemTagGoForward:
                case WebMenuItemTagStop:
                case WebMenuItemTagOpenWithDefaultApplication:
                case WebMenuItemTagReload:
                    [webViewMenuItems removeObjectIdenticalTo: menuItem];
            }
        }
    }
    
    return webViewMenuItems;
}

- (WebView *)webView:(WebView *)sender createWebViewWithRequest:(NSURLRequest *)request{
    requestedWindow = [[WindowController alloc] initWithRequest:request];
    return requestedWindow.contentView.webView;    
}

- (void)webViewShow:(WebView *)sender{
    [requestedWindow showWindow:sender];
}

#pragma mark WebScripting protocol

+ (BOOL) isSelectorExcludedFromWebScript:(SEL)selector
{
	return YES;
}

+ (BOOL) isKeyExcludedFromWebScript:(const char*)name
{
	return NO;
}


@end
