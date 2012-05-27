#import <Foundation/Foundation.h>
#import <Growl/Growl.h>

#define APP_GROWL_NOTIFICATION @"Growl Notification"

@interface Growl : NSObject <GrowlApplicationBridgeDelegate> {

}

- (void) notify:(NSDictionary*)message;
- (NSString *)applicationNameForGrowl;
- (NSImage *)applicationIconForGrowl;
- (NSDictionary *)registrationDictionaryForGrowl;
- (void) growlNotificationWasClicked:(id)clickContext;

@end
