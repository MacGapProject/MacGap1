#import "App.h"

#import "JSEventHelper.h"

@implementation App

@synthesize webView;

- (id) initWithWebView:(WebView *) view{
    self = [super init];
    
    if (self) {
        self.webView = view;
        [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver: self 
                                                               selector: @selector(receiveSleepNotification:) 
                                                                   name: NSWorkspaceWillSleepNotification object: NULL];
        [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver: self 
                                                               selector: @selector(receiveWakeNotification:) 
                                                                   name: NSWorkspaceDidWakeNotification object: NULL];
        [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver: self
                                                               selector: @selector(receiveActivateNotification:)
                                                                   name: NSWorkspaceDidActivateApplicationNotification object: NULL];
    }

    return self;
}

- (void) terminate {
    [NSApp terminate:nil];
}

- (void) activate {
    [NSApp activateIgnoringOtherApps:YES];
}

- (void) hide {
    [NSApp hide:nil];
}

- (void) unhide {
    [NSApp unhide:nil];
}

- (void)beep {
    NSBeep();
}

- (void) bounce {
    [NSApp requestUserAttention:NSInformationalRequest];
}

- (void) open:(NSString*)url {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:url]];
}

- (void) launch:(NSString *)name {
    [[NSWorkspace sharedWorkspace] launchApplication:name];
}

- (void)receiveSleepNotification:(NSNotification*)note{
    [JSEventHelper triggerEvent:@"sleep" forWebView:self.webView];
}

- (void) receiveWakeNotification:(NSNotification*)note{
    [JSEventHelper triggerEvent:@"wake" forWebView:self.webView];
}

- (void) receiveActivateNotification:(NSNotification*)notification{
    NSDictionary* userInfo = [notification userInfo];
    NSRunningApplication* runningApplication = [userInfo objectForKey:NSWorkspaceApplicationKey];
    if (runningApplication) {
        NSMutableDictionary* applicationDidGetFocusDict = [[NSMutableDictionary alloc] initWithCapacity:2];
        [applicationDidGetFocusDict setObject:runningApplication.localizedName
                                       forKey:@"localizedName"];
        [applicationDidGetFocusDict setObject:[runningApplication.bundleURL absoluteString]
                                       forKey:@"bundleURL"];
        
        [JSEventHelper triggerEvent:@"appActivated" withArgs:applicationDidGetFocusDict forWebView:self.webView];
    }
}

+ (NSString*) webScriptNameForSelector:(SEL)selector
{
	id	result = nil;
	
	if (selector == @selector(open:)) {
		result = @"open";
	} else if (selector == @selector(launch:)) {
        result = @"launch";
    }
	
	return result;
}

+ (BOOL) isSelectorExcludedFromWebScript:(SEL)selector
{
    return NO;
}

+ (BOOL) isKeyExcludedFromWebScript:(const char*)name
{
	return YES;
}

@end
