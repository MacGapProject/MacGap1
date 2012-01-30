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
#define TEXT 1
#define BASE64 2

@interface File()
-(NSString *) addMimeTypeToFileOutput: (NSString *) fileOutput withFile:(NSString *) file;
-(void) readFileError;
-(void) readFileSuccessForOutput: (NSString *) fileOutput withOutputType: (int) outputType;
-(void) readFile: (NSString *) file withOutputType:(int) outputType;
-(void) readText:(NSString *) path;
-(void) readData: (NSString *) path;
@end

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

/*
 The File API adds a prefix to base64 encoded files that includes its mimetype. If
 the mimetype is not present, it can be ommited.
 */
-(NSString *) addMimeTypeToFileOutput: (NSString *) fileOutput withFile:(NSString *) file{
    NSString *output;
    NSString * mimeType = [Utils getMIMETypesFromFile:file];
    if ([mimeType isEqualToString:@""]) {
        output = [NSString stringWithFormat:@"data:base64,%@",fileOutput];
    }else{
        output = [NSString stringWithFormat:@"data:%@;base64,%@",mimeType,fileOutput];
    }
    return output;
}

/*
 Since the file error is dependent on the function that is reading the file, and the same error,
 from two different functions might result in a different error code, we simply return
 NOT_READABLE_ERR, which is part of the File API.
 */
-(void) readFileError{
    NSString *eventWithError = [NSString stringWithFormat:@"e.error=%d", NOT_READABLE_ERR];
    [JSEventHelper triggerEvent:@"onerror" withExtraJS:eventWithError forWebView:self.webView];
}

/*
 Once the file reading is successful, we assign it to the event object in the JS string.
 */
-(void) readFileSuccessForOutput: (NSString *) fileOutput withOutputType: (int) outputType{
    NSString * result;
    if (outputType == TEXT) {
        //If file's output is not escaped it results in a JavaScript EOF error
        result = [NSString stringWithFormat:@"e.result=decodeURIComponent('%@')",
                             [fileOutput stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];        
    }else if(outputType == BASE64){
        result = [NSString stringWithFormat:@"e.result='%@'",fileOutput];
    }
    
    [JSEventHelper triggerEvent:@"onload" withExtraJS:result forWebView:self.webView];
}

-(void) readFile: (NSString *) file withOutputType:(int) outputType{
    NSString *fileOutput;
    [JSEventHelper triggerEvent:@"onloadstart" forWebView:self.webView];
    
    if (outputType == TEXT) {
        NSStringEncoding *encoding;        
        fileOutput = [NSString stringWithContentsOfFile:file usedEncoding:encoding error:nil];        
    }else if (outputType == BASE64){
        fileOutput = [self addMimeTypeToFileOutput:[Utils encodeBase64WithData:[NSData dataWithContentsOfFile:file]] withFile:file];
    }
    
    if (fileOutput) {
        //onload
        [self readFileSuccessForOutput:fileOutput withOutputType:outputType];
    }else{
        //onerror
        [self readFileError];
    }
    
    [JSEventHelper triggerEvent:@"onloadend" forWebView:self.webView];
}


-(void) readText:(NSString *) path{
    [self readFile:path withOutputType:TEXT];
}

-(void) readAsText:(NSString *)path{
    //Make read nonblocking!
    [self performSelectorOnMainThread:@selector(readText:) withObject:path waitUntilDone:NO];
}

- (void) readData: (NSString *) path{
    [self readFile:path withOutputType:BASE64];
}

-(void) readAsDataURL:(NSString *) path{
    [self performSelectorOnMainThread:@selector(readData:) withObject:path waitUntilDone:NO];
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
