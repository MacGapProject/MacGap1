#import "Window.h"

@implementation Window

@synthesize windowController, webView;

- (id) initWithWebView:(WebView*)view
{
    if(self = [super init]) {
        self.webView = view;
    }
    return self;
}

- (void) open:(NSDictionary *)properties
{
    self.windowController = [[WindowController alloc] initWithURL:[properties valueForKey:@"url"]];
    [self.windowController showWindow: [NSApplication sharedApplication].delegate];
    [self.windowController.window makeKeyWindow];
}

- (void) move:(NSDictionary *)properties
{
    NSRect frame = [self.webView window].frame;
    frame.origin.x = [[properties valueForKey:@"x"] doubleValue];
    frame.origin.y = [[properties valueForKey:@"y"] doubleValue];
    [[self.webView window] setFrame:frame display:YES];
    
}

- (void) resize:(NSDictionary *) properties
{
    NSRect frame = [self.webView window].frame;
    frame.size.width = [[properties valueForKey:@"width"] doubleValue];
    frame.size.height = [[properties valueForKey:@"height"] doubleValue];
    [[self.webView window] setFrame:frame display:YES];    
}


+ (BOOL) isSelectorExcludedFromWebScript:(SEL)selector
{
    return NO;
}

+ (NSString*) webScriptNameForSelector:(SEL)selector{
	id	result = nil;
	
	if (selector == @selector(open:)) {
		result = @"open";
	}else if (selector == @selector(move:)){
        result = @"move";
    }else if (selector == @selector(resize:)){
        result = @"resize";
    }
	
	return result;
}

+ (BOOL) isKeyExcludedFromWebScript:(const char*)name
{
	return YES;
}

@end
