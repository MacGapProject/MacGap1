//
//  UserDefaults.m
//  MacGap
//
//  Created by Jeff Hanbury on 16/04/2014.
//  Copyright (c) 2014 Twitter. All rights reserved.
//

#import "UserDefaults.h"

@implementation UserDefaults

- (void) setUserDefaultString:(NSString*)key withValue:(NSString*)value {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:value forKey:key];
    
    NSLog(@"setting...");
    NSLog(key, value);
}

- (NSString*) getUserDefaultString:(NSString *)key {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSLog(@"getting...");
    NSLog(key);

    return [prefs stringForKey:key];
}

// getting an NSInteger
//NSInteger myInt = [prefs integerForKey:@"integerKey"];

// getting an Float
//float myFloat = [prefs floatForKey:@"floatKey"];

#pragma mark WebScripting Protocol

+ (BOOL) isSelectorExcludedFromWebScript:(SEL)selector {
    return NO;
}

+ (NSString*) webScriptNameForSelector:(SEL)selector {
	id	result = nil;
	
	if (selector == @selector(setUserDefaultString:withValue:)) {
		result = @"setUserDefaultString";
    } else if (selector == @selector(getUserDefaultString:)) {
        result = @"getUserDefaultString";
    }
    
	return result;
}

+ (BOOL) isKeyExcludedFromWebScript:(const char*)name {
	return NO;
}

@end
