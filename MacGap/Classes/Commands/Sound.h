#import <Cocoa/Cocoa.h>


@interface Sound : NSObject {

}

- (void) play:(NSString*)file;
- (void) playSystem:(NSString*)name;

@end
