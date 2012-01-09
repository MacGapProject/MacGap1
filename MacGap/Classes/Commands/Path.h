#import <Foundation/Foundation.h>

@interface Path : NSObject {
    
}

- (NSString *) application;
- (NSString *) resource;

@property (readonly,copy) NSString* application;
@property (readonly,copy) NSString* resource;

@end
