#import <Foundation/Foundation.h>

#import "WindowController.h"

@interface Window : NSObject{
    
}

@property (retain, nonatomic) WindowController *windowController;

- (void) open:(NSDictionary *)properties;
@end
