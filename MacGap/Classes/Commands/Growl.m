#import "Growl.h"

@implementation Growl

- (id) init {
    if (self = [super init]) {
        NSBundle *myBundle = [NSBundle bundleForClass:[self class]];
        NSString *growlPath = [[myBundle privateFrameworksPath]
                               stringByAppendingPathComponent:@"Growl.framework"];
        NSBundle *growlBundle = [NSBundle bundleWithPath:growlPath];
        if (growlBundle && [growlBundle load]) {
            // Register ourselves as a Growl delegate
            [GrowlApplicationBridge setGrowlDelegate:self];
        } else {
            NSLog(@"Could not load Growl.framework");
        }  
    }
    
    return self;
}

- (void) notify:(NSDictionary *)message {
    [GrowlApplicationBridge notifyWithTitle:[message valueForKey:@"title"]
                                description:[message valueForKey:@"content"]
                           notificationName:APP_GROWL_NOTIFICATION
                                   iconData:nil
                                   priority:0
                                   isSticky:false
                               clickContext:@""];
}

- (NSString *)applicationNameForGrowl {
    return @"Callback";
}

- (NSImage *)applicationIconForGrowl {
	return [NSImage imageNamed:@"NSApplicationIcon"];
}

- (NSDictionary *)registrationDictionaryForGrowl {
	NSArray *allowedNotifications = [NSArray arrayWithObject:APP_GROWL_NOTIFICATION];
	NSArray *defaultNotifications = [NSArray arrayWithObject:APP_GROWL_NOTIFICATION];
    
	NSDictionary *ticket = [NSDictionary dictionaryWithObjectsAndKeys:
                            allowedNotifications, GROWL_NOTIFICATIONS_ALL,
                            defaultNotifications, GROWL_NOTIFICATIONS_DEFAULT,
                            nil];
    
	return ticket;
}

- (void) growlNotificationWasClicked:(id)clickContext {
    [NSApp activateIgnoringOtherApps:YES];
}


#pragma mark WebScripting Protocol

+ (BOOL) isSelectorExcludedFromWebScript:(SEL)selector
{
    if (selector == @selector(notify:))  
        return NO;  
    
    return YES;  
}

+ (NSString*) webScriptNameForSelector:(SEL)selector
{
	id	result = nil;
	
	if (selector == @selector(notify:)) {
		result = @"notify";
	}
	
	return result;
}

// right now exclude all properties (eg keys)
+ (BOOL) isKeyExcludedFromWebScript:(const char*)name
{
	return YES;
}

@end
