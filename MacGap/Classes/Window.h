#import <Foundation/Foundation.h>

#import "WindowController.h"

@interface Window : NSObject{
    
}

@property (retain, nonatomic) WindowController *windowController;
@property (nonatomic, retain) WebView *webView;


- (void) open:(NSDictionary *)properties;
- (void) move:(NSDictionary *)properties;
- (void) resize:(NSDictionary *) properties;

@end
