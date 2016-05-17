#import "StatusBar.h"
#import "MenuProxy.h"

@interface StatusBar()
@property (nonatomic, retain) NSStatusItem *statusItem;

- (void)setupMenu;
@end


@implementation StatusBar

@synthesize statusMenu;

- (id) initWithContext:(JSContextRef)aContext
{
    if(self = [super init]) {
        if ([[NSBundle mainBundle] loadNibNamed:@"StatusMenu" owner:self topLevelObjects:nil]) {
            self.statusMenu = [MenuProxy proxyWithContext:aContext andMenu:self.menu];
        }
    }
    
    return self;
}

- (void)show {
    // Give the image priority in-case both imageName and title are set
    if (self.imageName != nil) {
        [self showWithImageName:self.imageName];
    }
    else if (self.title != nil) {
        [self showWithTitle:self.title];
    }
}

- (void)showWithImageName:(NSString *)name {
    self.imageName = name;
    self.title = nil;
    [self setupMenu];
}

- (void)showWithTitle:(NSString *)title {
    self.imageName = nil;
    self.title = title;
    [self setupMenu];
}

- (void)hide {
    [[NSStatusBar systemStatusBar] removeStatusItem:self.statusItem];
    self.statusItem = nil;
}

- (NSStatusItem *)statusItem {
    if (!_statusItem) {
        _statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
        
        _statusItem.button.title = self.title;
        _statusItem.button.image = [self image];

        [_statusItem.image setTemplate:YES];
        _statusItem.highlightMode = YES;
    }
    return _statusItem;
}

- (NSImage *)image {
    return [NSImage imageNamed:self.imageName];
}

- (void)setupMenu {
    self.statusItem.menu = self.menu;
}

#pragma mark WebScripting Protocol

+ (BOOL) isSelectorExcludedFromWebScript:(SEL)selector
{
    BOOL result = YES;
    if (selector == @selector(showWithImageName:))
        result = NO;
    if (selector == @selector(showWithTitle:))
        result = NO;
    if (selector == @selector(show))
        result = NO;
    if (selector == @selector(hide))
        result = NO;
    if (selector == @selector(statusMenu))
        result = NO;
    
    return result;
}

+ (NSString*) webScriptNameForSelector:(SEL)selector
{
    id	result = nil;
    
    if (selector == @selector(showWithImageName:)) {
        result = @"showWithImageName";
    }
    if (selector == @selector(showWithTitle:)) {
        result = @"showWithTitle";
    }
    if (selector == @selector(show)) {
        result = @"show";
    }
    if (selector == @selector(close)) {
        result = @"hide";
    }
    if (selector == @selector(statusMenu)) {
        result = @"statusMenu";
    }
    
    return result;
}

// right now exclude all properties (eg keys)
+ (BOOL) isKeyExcludedFromWebScript:(const char*)name
{
    BOOL result = YES;
    
    if (strcmp(name, "statusMenu")) {
        result = NO;
    }
    else if (strcmp(name, "title")) {
        result = NO;
    }
    else if (strcmp(name, "imageName")) {
        result = NO;
    }
    
    return result;
}

@end
