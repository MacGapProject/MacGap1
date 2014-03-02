#import "fonts.h"

@implementation Fonts


- (NSArray*) availableFonts {
    return [[NSFontManager sharedFontManager] availableFonts];
}

- (NSArray*) availableFontFamilies {
    return [[NSFontManager sharedFontManager] availableFontFamilies];
}

- (NSArray*) availableMembersOfFontFamily:(NSString *)fontFamily {
    //- (NSArray*) availableMembersOfFontFamily {
    //    NSString *fontFamily = @"Helvetica";
    return [[NSFontManager sharedFontManager] availableMembersOfFontFamily:fontFamily];
}


#pragma mark WebScripting Protocol

+ (BOOL) isSelectorExcludedFromWebScript:(SEL)selector
{
    return NO;
}

+ (NSString*) webScriptNameForSelector:(SEL)selector
{
	id	result = nil;
	
	if (selector == @selector(availableMembersOfFontFamily:)) {
		result = @"availableMembersOfFontFamily";
	}
	
	return result;
}

+ (BOOL) isKeyExcludedFromWebScript:(const char*)name
{
	return NO;
}

@end
