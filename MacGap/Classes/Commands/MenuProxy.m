//
//  MenuProxy.m
//  MacGap
//
//  Created by Joe Hildebrand on 1/14/12.
//  Copyright (c) 2012 Twitter. All rights reserved.
//

#import <objc/runtime.h>
#import <JavaScriptCore/JavaScript.h>

#import "MenuProxy.h"
#import "MenuItemProxy.h"

static char REPRESENTED_OBJECT;

@interface NSMenu (represented)
@property (strong) id representedObject;
@end

@implementation NSMenu (represented)

- (id) representedObject
{
    return objc_getAssociatedObject(self, &REPRESENTED_OBJECT);
}

- (void) setRepresentedObject:(id)representedObject
{
    objc_setAssociatedObject(self, 
                             &REPRESENTED_OBJECT,
                             representedObject, 
                             OBJC_ASSOCIATION_RETAIN);
}

@end

@implementation MenuProxy

- (id) initWithContext:(JSContextRef)aContext andMenu:(NSMenu*)aMenu
{
    self = [super initWithContext:aContext];
    if (!self)
        return nil;
    menu = aMenu;
    menu.representedObject = self;
    return self;
}

+ (MenuProxy*)proxyWithContext:(JSContextRef)aContext andMenu:(NSMenu*)aMenu
{
    // singleton-ish.
    MenuProxy *ret = [aMenu representedObject];
    if (ret)
    {
        NSLog(@"MP cache hit");
        return ret;
    }
    return [[MenuProxy alloc] initWithContext:aContext andMenu:aMenu];
}

- (void) dealloc
{
    menu.representedObject = nil;
}

- (NSString*) description
{
    return [menu description];
}

static BOOL isNullish(id o)
{
    if (!o)
        return YES;
    if ([o isKindOfClass:[WebUndefined class]])
        return YES;
    return NO;
}

- (MenuItemProxy*)addItemWithTitle:(NSString*)title 
                     keyEquivalent:(NSString*)aKey
                          callback:(WebScriptObject*)aCallback
{
    if (isNullish(title))
        title = @"";
    if (isNullish(aKey))
        aKey = @"";
    NSMenuItem *item = [menu addItemWithTitle:title action:nil keyEquivalent:aKey];
    MenuItemProxy *mip = [MenuItemProxy proxyWithContext:context andMenuItem:item];
    if (!isNullish(aCallback))
        [mip setCallback:aCallback];
    return mip;
}

- (MenuItemProxy*)addSeparator
{
    NSMenuItem *sep = [NSMenuItem separatorItem];
    [menu addItem:sep];
    return [MenuItemProxy proxyWithContext:context andMenuItem:sep];
}

- (MenuItemProxy*)itemForKey:(id)key
{
    if (isNullish(key))
        return nil;
    NSMenuItem *item = nil;
    if ([key isKindOfClass:[NSNumber class]])
    {
        item = [menu itemAtIndex:[key intValue]];
    }
    else if ([key isKindOfClass:[NSString class]])
    {
        item = [menu itemWithTitle:key];
        if (!item)
        {
            // Try again, with ... appended. e.g. "Save..."
            item = [menu itemWithTitle:
                    [key stringByAppendingString:@"\u2026"]];
        }
    }
    if (!item)
        return nil;

    return [MenuItemProxy proxyWithContext:context andMenuItem:item];    
}

/*
- (id) valueForUndefinedKey:(NSString *)key
{
    NSLog(@"valueForUndefinedKey: %@", key);
    NSScanner *scan = [NSScanner scannerWithString:key];
    NSInteger index = 0;
    NSMenuItem *item;
    
    if ([scan scanInteger:&index])
        item = [menu itemAtIndex:index];
    else
        item = [menu itemWithTitle:key];
    if (!item)
        return nil;
    
    return [MenuItemProxy proxyWithContext:context andMenuItem:item];
}

- (id)invokeUndefinedMethodFromWebScript:(NSString *)name withArguments:(NSArray *)args
{
    NSLog(@"invokeUndefinedMethodFromWebScript: %@", name);
    // There is something magical about this method.  It must be used by
    // JavaScriptCore to detect if you're doing dynamic processing.  It must be here,
    // but is never called for undefined properties.
    return nil;
}

+ (BOOL)isKeyExcludedFromWebScript:(const char *)name
{
    return NO;
}
*/

+ (BOOL) isSelectorExcludedFromWebScript:(SEL)selector
{
    return [self webScriptNameForSelector:selector] == nil;
}

+ (BOOL) isKeyExcludedFromWebScript:(const char*)name
{
	return YES;
}

+ (NSString*) webScriptNameForSelector:(SEL)selector
{
	id	result = nil;

    if (selector == @selector(addItemWithTitle:keyEquivalent:callback:)) {
		result = @"addItem";
	}
    else if (selector == @selector(addSeparator)) {
        result = @"addSeparator";
    }
	else if (selector == @selector(itemForKey:)) {
		result = @"getItem";
	}
	
	return result;
}

@end
