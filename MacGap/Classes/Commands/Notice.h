//
//  Notice.h
//  MacGap
//
//  Created by Christian Sullivan on 7/26/12.
//  Copyright (c) 2012 Twitter. All rights reserved.
//

#import <Foundation/Foundation.h>

#define APP_NOTICE_NOTIFICATION @"Notice"

@interface Notice : NSObject <NSUserNotificationCenterDelegate> {
    
}

- (void) notify:(NSDictionary*)message;

@end

