#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@class WebViewDelegate;

@interface ContentView : NSView {
	IBOutlet WebView* webView;
	WebViewDelegate* delegate;
}

- (void) triggerEvent:(NSString *)type;

@property (retain) WebView* webView;
@property (retain) WebViewDelegate* delegate;

@end
