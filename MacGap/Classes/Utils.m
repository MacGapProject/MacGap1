#import "Utils.h"

static Utils* sharedInstance = nil;

@implementation Utils

- (float) titleBarHeight:(NSWindow*)aWindow
{
    NSRect frame = [aWindow frame];
    NSRect contentRect = [NSWindow contentRectForFrameRect: frame
												 styleMask: NSTitledWindowMask];
	
    return (frame.size.height - contentRect.size.height);
}

- (NSString*) pathForResource:(NSString*)resourcepath
{
    NSBundle * mainBundle = [NSBundle mainBundle];
    NSMutableArray *directoryParts = [NSMutableArray arrayWithArray:[resourcepath componentsSeparatedByString:@"/"]];
    NSString       *filename       = [directoryParts lastObject];
    [directoryParts removeLastObject];
	
    NSString *directoryStr = [NSString stringWithFormat:@"%@/%@", kStartFolder, [directoryParts componentsJoinedByString:@"/"]];
    return [mainBundle pathForResource:filename
								ofType:@""
						   inDirectory:directoryStr];
}

#pragma mark -
#pragma mark Singleton methods

+ (Utils*) sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil){
			sharedInstance = [[Utils alloc] init];
		 }
    }
    return sharedInstance;
}

+ (id) allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [super allocWithZone:zone];
            return sharedInstance;  // assignment and return on first allocation
        }
    }
    return nil; // on subsequent allocation attempts return nil
}

- (id) copyWithZone:(NSZone *)zone
{
    return self;
}

@end