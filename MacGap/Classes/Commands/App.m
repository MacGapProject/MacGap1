#import "App.h"

@implementation App

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


- (void) setWindowFrame: (NSDictionary *)frame{
    NSRect rect = NSMakeRect([[frame valueForKey:@"x"] doubleValue],
                             [[frame valueForKey:@"y"] doubleValue],
                             [[frame valueForKey:@"width"] doubleValue],
                             [[frame valueForKey:@"height"] doubleValue]);
    [[[NSApp windows] objectAtIndex:0] setFrame: rect display: YES];
}

+ (BOOL) isSelectorExcludedFromWebScript:(SEL)selector
{
    return NO;
}

+ (NSString*) webScriptNameForSelector:(SEL)selector{
	id	result = nil;
	
	if (selector == @selector(setWindowFrame:)) {
		result = @"setWindowFrame";
	}
	
	return result;
}

+ (BOOL) isKeyExcludedFromWebScript:(const char*)name
{
	return YES;
}

@end
