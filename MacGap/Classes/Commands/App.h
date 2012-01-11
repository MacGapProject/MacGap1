#import <Foundation/Foundation.h>

@interface App : NSObject {

}

- (void) terminate;
- (void) activate;
- (void) hide;
- (void) unhide;
- (void) beep;
- (void) setWindowFrame: (NSDictionary *)frame;

@end
