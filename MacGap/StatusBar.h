#import <Foundation/Foundation.h>
#import "WindowController.h"

@class MenuProxy;

@interface StatusBar : NSObject {
    MenuProxy *statusMenu;
}

@property (nonatomic, retain) IBOutlet NSMenu *menu;
@property (nonatomic, retain) MenuProxy *statusMenu;
@property (nonatomic, retain) NSString *imageName;
@property (nonatomic, retain) NSString *title;

- (id)initWithContext:(JSContextRef)aContext;
- (void)show;
- (void)showWithImageName:(NSString *)name;
- (void)showWithTitle:(NSString *)title;
- (void)hide;

@end
