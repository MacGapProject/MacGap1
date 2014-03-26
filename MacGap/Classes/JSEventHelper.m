//
//  Helper.m
//  MacGap
//
//  Created by Liam Kaufman Simpkins on 12-01-22.
//  Copyright (c) 2012 Twitter. All rights reserved.
//

#import "JSEventHelper.h"

@implementation JSEventHelper

+ (void) triggerEvent:(NSString *)event forWebView:(WebView *)webView {
    [self triggerEvent:event withArgs:[NSMutableDictionary dictionary] forObject:@"document" forWebView:webView];
}

+ (void) triggerEvent:(NSString *)event withArgs:(NSDictionary *)args forWebView:(WebView *)webView {
    [self triggerEvent:event withArgs:args forObject:@"document" forWebView:webView];
}

+ (void) triggerEvent:(NSString *)event withArgs:(NSDictionary *)args forObject:(NSString *)objName forWebView:(WebView *)webView {
    
    // Convert args Dictionary to JSON.
    NSError *error;
    NSData *jsonData = [NSJSONSerialization
                        dataWithJSONObject:args
                        options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                        error:&error];
    
    NSString *jsonString;
    if (! jsonData) {
        NSLog(@"Got an error converting to JSON: %@", error);
    }
    else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    // Create the event JavaScript and run it.
    NSString * str = [NSString stringWithFormat:@"var e = document.createEvent('Events'); e.initEvent('%@', true, false);  e.data=%@; %@.dispatchEvent(e); ", event, jsonString, objName];
    [webView stringByEvaluatingJavaScriptFromString:str];
}

@end
