#import "Path.h"

@implementation Path

@synthesize application;
@synthesize resource;

- (NSString *)application {
    return [[NSBundle mainBundle] bundlePath];
}

- (NSString *)resource {
    return [[NSBundle mainBundle] resourcePath];
}

#pragma mark WebScripting Protocol

/* checks whether a selector is acceptable to be called from JavaScript */
+ (BOOL) isSelectorExcludedFromWebScript:(SEL)selector
{
    return NO;
}

// right now exclude all properties (eg keys)
+ (BOOL) isKeyExcludedFromWebScript:(const char*)name
{
	return NO;
}

@end
