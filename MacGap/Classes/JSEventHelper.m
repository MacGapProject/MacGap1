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
    [self triggerEvent:event forObject:@"document" forWebView:webView];
}

+ (void) triggerEvent:(NSString *)event forObject:(NSString *)objName forWebView:(WebView *)webView {
    NSString * str = [NSString stringWithFormat:@"var e = document.createEvent('Events'); e.initEvent('%@', true, false); %@.dispatchEvent(e); ", event, objName];
    [webView stringByEvaluatingJavaScriptFromString:str];
}

+ (void) triggerEvent:(NSString *)event forDetail:(NSString *)detail forWebView:(WebView *)webView {
    [self triggerEvent:event forDetail:detail forObject:@"document" forWebView:webView];
}
+ (void) triggerEvent:(NSString *)event forDetail:(NSString *)detail forObject:(NSString *)objName forWebView:(WebView *)webView {
    NSString *detailEscaped = [detail stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSString *str = [NSString stringWithFormat:@"var e = new CustomEvent('%@', { 'detail': decodeURIComponent(\"%@\") }); %@.dispatchEvent(e); ", event, detailEscaped, objName];
    [webView stringByEvaluatingJavaScriptFromString:str];
}

@end
