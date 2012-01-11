#import "Window.h"

@implementation Window


@synthesize windowController;


- (void) open:(NSDictionary *)properties{
    double width = [[properties valueForKey:@"width"] doubleValue];
    double height =  [[properties valueForKey:@"height"] doubleValue];
    
    NSRect frame = NSMakeRect(0, 0, width, height);
    self.windowController = [[WindowController alloc] initWithURL: [properties valueForKey:@"url"]
                                                      andFrame:frame];
    [self.windowController showWindow: [NSApplication sharedApplication].delegate];
 
}


+ (BOOL) isSelectorExcludedFromWebScript:(SEL)selector
{
    return NO;
}

+ (NSString*) webScriptNameForSelector:(SEL)selector{
	id	result = nil;
	
	if (selector == @selector(open:)) {
		result = @"open";
	}
	
	return result;
}

+ (BOOL) isKeyExcludedFromWebScript:(const char*)name
{
	return YES;
}

@end
