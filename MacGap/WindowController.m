#import "WindowController.h"


@interface WindowController() {

}
-(void) notificationCenter;
@end


@implementation WindowController

@synthesize  contentView, fileUrl;

- (id) initWithURL:(NSString *) url andFrame: (NSRect) frame{
    self = [super initWithWindowNibName:@"Window"];
    self.fileUrl = [NSURL fileURLWithPath:[[Utils sharedInstance] pathForResource:url]];
    [self.window setFrame: frame display: YES];
    [self notificationCenter];

    return self;
}

-(id) initWithRequest: (NSURLRequest *)request{
    self = [super initWithWindowNibName:@"Window"];
    [self notificationCenter];
    [[self.contentView.webView mainFrame] loadRequest:request];
    
    return self;
}

-(void) notificationCenter{
    [[NSNotificationCenter defaultCenter] addObserver:self.contentView 
                                             selector:@selector(windowResized:) 
                                                 name:NSWindowDidResizeNotification 
                                               object:[self window]];   
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    if (self.fileUrl != nil) {
        [self.contentView.webView setMainFrameURL:[self.fileUrl description]];
    }
    
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

@end
