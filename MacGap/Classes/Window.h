#import <Foundation/Foundation.h>

#import "WindowController.h"

@interface Window : NSObject{
    
}

@property (retain, nonatomic) WindowController *windowController;

- (int) getId: (NSString *) title;
- (int) open:(NSDictionary *)properties;
- (void) move:(NSDictionary *)properties;
- (void) resize:(NSDictionary *) properties;
@end
