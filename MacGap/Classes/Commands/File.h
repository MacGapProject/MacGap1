//
//  File.h
//  MacGap
//
//  Created by Liam Kaufman Simpkins on 12-01-28.
//  Copyright (c) 2012 Twitter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WindowController.h"

@interface File : NSObject{
    
}

@property (nonatomic, retain) WebView *webView;
- (id) initWithWebView:(WebView *)view;
-(NSArray *) files;
-(NSString *) readAsText:(NSString *) path;
-(NSString *) readAsDataURL:(NSString *) path;

@property (retain) NSArray* selectedFiles;
@end
