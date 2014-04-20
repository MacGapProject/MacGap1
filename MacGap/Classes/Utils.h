#import <Foundation/Foundation.h>

#define DEG_EPS 0.001
#define fequal(a,b) (fabs((a) - (b)) < DEG_EPS)
#define fequalzero(a) (fabs(a) < DEG_EPS)

@class LoadingView;

@interface Utils : NSObject {
}

- (float) titleBarHeight:(NSWindow*)aWindow;
- (NSString*) pathForResource:(NSString*)resourcepath;
- (NSString*) convertDictionaryToJSON:(NSDictionary*)dict;

+ (Utils*) sharedInstance;

@end
