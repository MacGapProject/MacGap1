//
//  AppDelegate.m
//  MacGap
//
//  Created by Alex MacCaw on 08/01/2012.
//  Copyright (c) 2012 Twitter. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window, contentView;

- (void) applicationWillFinishLaunching:(NSNotification *)aNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self.contentView 
                                             selector:@selector(windowResized:) 
                                                 name:NSWindowDidResizeNotification 
                                               object:[self window]];
    
    NSURL* fileUrl = [NSURL fileURLWithPath:[[Utils sharedInstance] pathForResource:kStartPage]];
    [self.contentView.webView setMainFrameURL:[fileUrl description]];

    
}

- (void) applicationDidFinishLaunching:(NSNotification *)aNotification {    
    self.contentView.webView.alphaValue = 1.0;
    self.contentView.alphaValue = 1.0;
    
}

@end
