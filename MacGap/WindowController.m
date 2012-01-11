//
//  WindowController.m
//  MacGap
//
//  Created by Liam Kaufman Simpkins on 12-01-11.
//  Copyright (c) 2012 Twitter. All rights reserved.
//

#import "WindowController.h"

@implementation WindowController

@synthesize  contentView, fileUrl;

- (id) initWithURL:(NSString *) url andFrame: (NSRect) frame{
    self = [super initWithWindowNibName:@"Window"];
    self.fileUrl = [NSURL fileURLWithPath:[[Utils sharedInstance] pathForResource:url]];
    [self.window setFrame: frame display: YES];
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    [self.contentView.webView setMainFrameURL:[self.fileUrl description]];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

@end
