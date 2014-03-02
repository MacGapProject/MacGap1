@interface Fonts : NSObject {
}

- (NSArray*) availableFonts;
- (NSArray*) availableFontFamilies;
- (NSArray*) availableMembersOfFontFamily:(NSString*)fontFamily;

@end
