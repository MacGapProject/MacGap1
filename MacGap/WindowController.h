#import <Cocoa/Cocoa.h>
#import "ContentView.h"

@interface WindowController : NSWindowController{
    
}

- (id) initWithURL:(NSString *) url andFrame: (NSRect) frame;
- (id) initWithRequest: (NSURLRequest *)request;
@property (retain) NSURL * fileUrl;
@property (strong) IBOutlet ContentView *contentView;

@end
