#import "ContentView.h"
#import "WebViewDelegate.h"
#import "AppDelegate.h"

@interface WebPreferences (WebPreferencesPrivate)
    - (void)_setLocalStorageDatabasePath:(NSString *)path;
    - (void) setLocalStorageEnabled: (BOOL) localStorageEnabled;
    - (void) setDatabasesEnabled:(BOOL)databasesEnabled;
@end

@implementation ContentView

@synthesize webView, delegate;

- (void) awakeFromNib
{
    WebPreferences *webPrefs = [WebPreferences standardPreferences];
    NSString *cappBundleName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];    
    NSString *applicationSupportFile = [@"~/Library/Application Support/" stringByExpandingTildeInPath];
    NSString *savePath = [NSString pathWithComponents:[NSArray arrayWithObjects:applicationSupportFile, cappBundleName, @"LocalStorage", nil]];
    [webPrefs _setLocalStorageDatabasePath:savePath];
    [webPrefs setLocalStorageEnabled:YES];
    [webPrefs setDatabasesEnabled:YES];
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
    [self triggerEvent:@"orientationchange"];
}

- (void) triggerEvent:(NSString*)type 
{
    NSString* script = [NSString stringWithFormat:@"\
                        var e = document.createEvent('Events'); \
                        e.initEvent('%@', true, false); document.dispatchEvent(e);", type];
    [self.webView stringByEvaluatingJavaScriptFromString:script];
    
}

@end
