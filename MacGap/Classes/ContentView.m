#import "ContentView.h"
#import "WebViewDelegate.h"
#import "AppDelegate.h"

@interface WebPreferences (WebPreferencesPrivate)
    - (void)_setLocalStorageDatabasePath:(NSString *)path;
@end

@implementation ContentView

@synthesize webView, delegate;

- (void) awakeFromNib
{
    WebPreferences *webPrefs = [WebPreferences standardPreferences];
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *cappBundleName = [mainBundle objectForInfoDictionaryKey:@"CPBundleName"];
    NSString *applicationSupportFile = [@"~/Library/Application Support/" stringByExpandingTildeInPath];
    NSString *savePath = [NSString pathWithComponents:[NSArray arrayWithObjects:applicationSupportFile, cappBundleName, @"LocalStorage", nil]];
    [webPrefs _setLocalStorageDatabasePath:savePath];
    [self.webView setPreferences:webPrefs];
    

	self.delegate = [[WebViewDelegate alloc] init];
	[self.webView setFrameLoadDelegate:self.delegate];
	[self.webView setUIDelegate:self.delegate];
	[self.webView setResourceLoadDelegate:self.delegate];
	[self.webView setDownloadDelegate:self.delegate];
	[self.webView setPolicyDelegate:self.delegate];	
    [self.webView setDrawsBackground:NO];
    [self.webView setShouldCloseWithWindow:NO];
    
    [self.webView setGroupName:@"MacGap"];

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
