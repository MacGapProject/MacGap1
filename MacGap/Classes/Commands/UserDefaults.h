//
//  UserDefaults.h
//  MacGap
//
//  Created by Jeff Hanbury on 16/04/2014.
//  Copyright (c) 2014 Twitter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaults : NSObject

- (void) setUserDefaultString:(NSString*)key withValue:(NSString*)value;
- (NSString*) getUserDefaultString:(NSString*)key;

@end
