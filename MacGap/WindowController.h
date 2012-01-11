//
//  WindowController.h
//  MacGap
//
//  Created by Liam Kaufman Simpkins on 12-01-11.
//  Copyright (c) 2012 Twitter. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ContentView.h"

@interface WindowController : NSWindowController{
    
}

- (id) initWithURL:(NSString *) url andFrame: (NSRect) frame;
@property (retain) NSURL * fileUrl;
@property (strong) IBOutlet ContentView *contentView;

@end
