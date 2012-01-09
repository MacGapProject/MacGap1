#import "ContentView.h"
#import "WebViewDelegate.h"
#import "AppDelegate.h"

@implementation ContentView

@synthesize webView, delegate;

- (void) awakeFromNib
{
	self.delegate = [[WebViewDelegate alloc] init];
	[self.webView setFrameLoadDelegate:self.delegate];
	[self.webView setUIDelegate:self.delegate];
	[self.webView setResourceLoadDelegate:self.delegate];
	[self.webView setDownloadDelegate:self.delegate];
	[self.webView setPolicyDelegate:self.delegate];	
    [self.webView setDrawsBackground:NO];
    [self.webView setShouldCloseWithWindow:NO];
}

- (void) windowResized:(NSNotification*)notification;
{
	NSWindow* window = (NSWindow*)notification.object;
	NSSize size = [window frame].size;
	
	DebugNSLog(@"window width = %f, window height = %f", size.width, size.height);
	[self.webView setFrame:NSMakeRect(0, 0, size.width, size.height - [[Utils sharedInstance] titleBarHeight:window])];
    [self.webView stringByEvaluatingJavaScriptFromString:@"var e = document.createEvent('Events'); e.initEvent('orientationchange', true, false); document.dispatchEvent(e); "];
}

@end
