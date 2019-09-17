//
//  LocalizeHelper.h
//  mPBX
//
//  Created by Nguyễn Chí Thành on 19/01/2018.
//  Copyright © 2018 ViettelICT. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LocalizedString(key) [[LocalizeHelper shared] localizedStringForKey:(key)]
#define SetLanguageAndReset(key) [[LocalizeHelper shared] setLanguageAndReset:(key)]
#define LocalizationSetLanguage(language) [[LocalizeHelper shared] setLanguage:(language)]

@interface LocalizeHelper : NSObject

+ (LocalizeHelper*) shared;
- (NSString*) localizedStringForKey:(NSString*) key;
- (void) setLanguage:(NSString*) lang;
- (void) setLanguageAndReset:(NSString*) lang;

- (NSString *)currentLanguage;

@end

