#import "WebViewDelegate.h"
#import "Sound.h"
#import "Dock.h"
#import "Growl.h"
#import "Path.h"
#import "App.h"

@implementation WebViewDelegate

@synthesize sound;
@synthesize dock;
@synthesize growl;
@synthesize path;
@synthesize app;

- (void) webView:(WebView*)webView didClearWindowObject:(WebScriptObject*)windowScriptObject forFrame:(WebFrame *)frame
{
	if (self.sound == nil) { self.sound = [Sound new]; }
	if (self.dock == nil) { self.dock = [Dock new]; }
	if (self.growl == nil) { self.growl = [Growl new]; }
	if (self.path == nil) { self.path = [Path new]; }
	if (self.app == nil) { self.app = [App new]; }
    
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

- (void)webView:(WebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WebFrame *)frame {
	[NSAlert alertWithMessageText:@"Alert" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:message];
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
