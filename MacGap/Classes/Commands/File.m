//
//  File.m
//  MacGap
//
//  Created by Liam Kaufman Simpkins on 12-01-28.
//  Copyright (c) 2012 Twitter. All rights reserved.
//

#import "File.h"
#import "Utils.h"
#import "JSEventHelper.h"

#define NOT_READABLE_ERR 4

@implementation File

@synthesize selectedFiles, webView;


- (id) initWithWebView:(WebView*)view
{
    if(self = [super init]) {
        self.webView = view;
    }
    return self;
}

-(NSArray *) files{
    return self.selectedFiles;
}

-(NSString *) readAsText:(NSString *) path{    
    NSStringEncoding *encoding;
    NSError *error;
    NSString *results = [NSString stringWithContentsOfFile:path usedEncoding:encoding error:&error];
    
    if (error != nil) {
        //onerror
        NSString *eventWithError = [NSString stringWithFormat:@"e.error=%d", NOT_READABLE_ERR];
        [JSEventHelper triggerEvent:@"onerror" withExtraJS:eventWithError forWebView:self.webView];
        results = @"";
    }
    
    return results;
}

-(NSString *) readAsDataURL:(NSString *) path{
    NSString * encodingData = [Utils encodeBase64WithData:[NSData dataWithContentsOfFile:path]];
    
    if (encodingData == nil) {
        //onerror
        NSString *eventWithError = [NSString stringWithFormat:@"e.error=%d", NOT_READABLE_ERR];
        [JSEventHelper triggerEvent:@"onerror" withExtraJS:eventWithError forWebView:self.webView];
        return @"";
    }

    NSString * mimeType = [Utils getMIMETypesFromFile:path];
    if ([mimeType isEqualToString:@""]) {
        return [NSString stringWithFormat:@"data:base64,%@",encodingData];
    }else{
        return [NSString stringWithFormat:@"data:%@;base64,%@",mimeType,encodingData];
    }
}


#pragma mark WebScripting Protocol

/* checks whether a selector is acceptable to be called from JavaScript */
+ (BOOL) isSelectorExcludedFromWebScript:(SEL)selector
{
    return NO;
}


+ (NSString*) webScriptNameForSelector:(SEL)selector
{
	id	result = nil;
	
	if (selector == @selector(readAsText:)) {
		result = @"readAsText";
    }else if (selector == @selector(readAsDataURL:)){
        result = @"readAsDataURL";
    }
	
	return result;
}

// right now exclude all properties (eg keys)
+ (BOOL) isKeyExcludedFromWebScript:(const char*)name
{
	return NO;
}
@end
