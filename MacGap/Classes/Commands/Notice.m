//
//  Notice.m
//  MacGap
//
//  Created by Christian Sullivan on 7/26/12.
//  Copyright (c) 2012 Twitter. All rights reserved.
//

#import "Notice.h"

@implementation Notice

- (void) notify:(NSDictionary *)message {
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    [notification setTitle:[message valueForKey:@"title"]];
    [notification setInformativeText:[message valueForKey:@"content"]];
    [notification setDeliveryDate:[NSDate dateWithTimeInterval:0 sinceDate:[NSDate date]]];
    [notification setSoundName:NSUserNotificationDefaultSoundName];
    NSUserNotificationCenter *center = [NSUserNotificationCenter defaultUserNotificationCenter];
    [center scheduleNotification:notification];
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
