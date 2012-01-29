//
//  Helper.m
//  MacGap
//
//  Created by Liam Kaufman Simpkins on 12-01-22.
//  Copyright (c) 2012 Twitter. All rights reserved.
//

#import "JSEventHelper.h"

@implementation JSEventHelper


+ (void) triggerEvent:(NSString *) event withExtraJS: (NSString *) extraJS forWebView: (WebView *) webView{
    NSString * str = [NSString stringWithFormat:@"var e = document.createEvent('Events'); e.initEvent('%@', true, false); %@; document.dispatchEvent(e); ", event, extraJS];
    [webView stringByEvaluatingJavaScriptFromString:str];
}

+ (void) triggerEvent:(NSString *) event forWebView: (WebView *) webView{
    [JSEventHelper triggerEvent:event withExtraJS:@"" forWebView:webView];
}



@end
