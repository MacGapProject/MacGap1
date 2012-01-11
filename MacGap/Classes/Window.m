#import "Window.h"

@implementation Window


@synthesize windowController;

- (int) getId: (NSString *) title{
    NSArray *windows = [NSApp windows];
    NSWindow *window;
    NSString *t;
    for (int i=0; i<windows.count; i++) {
        window = [windows objectAtIndex:i];
        t = [window title];
        if ([[window title] isEqualToString:title]) {
            return i;
        }
    }
    return 0;
}

- (int) open:(NSDictionary *)properties{
    double width = [[properties valueForKey:@"width"] doubleValue];
    double height =  [[properties valueForKey:@"height"] doubleValue];
    
    NSRect frame = NSMakeRect(0, 0, width, height);
    self.windowController = [[WindowController alloc] initWithURL: [properties valueForKey:@"url"]
                                                      andFrame:frame];
    [self.windowController showWindow: [NSApplication sharedApplication].delegate];
    [self.windowController.window makeKeyWindow];
    
    return (int)[NSApp windows].count - 1;
}

- (void) move:(NSDictionary *)properties{
    NSWindow *window = [[NSApp windows] objectAtIndex:[[properties valueForKey:@"id"] intValue]];
    NSRect frame = window.frame;
    frame.origin.x = [[properties valueForKey:@"x"] doubleValue];
    frame.origin.y = [[properties valueForKey:@"y"] doubleValue];
    [window setFrame:frame display:YES];
    
}
- (void) resize:(NSDictionary *) properties{
    NSWindow *window = [[NSApp windows] objectAtIndex:[[properties valueForKey:@"id"] intValue]];
    NSRect frame = window.frame;
    frame.size.width = [[properties valueForKey:@"width"] doubleValue];
    frame.size.height = [[properties valueForKey:@"height"] doubleValue];
    [window setFrame:frame display:YES];    
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
    }else if (selector == @selector(getId:)){
        result = @"getId";
    }
	
	return result;
}

+ (BOOL) isKeyExcludedFromWebScript:(const char*)name
{
	return YES;
}

@end
