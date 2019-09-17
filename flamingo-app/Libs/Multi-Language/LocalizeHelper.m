//
//  LocalizeHelper.m
//  mPBX
//
//  Created by Nguyễn Chí Thành on 19/01/2018.
//  Copyright © 2018 ViettelICT. All rights reserved.
//

#import "LocalizeHelper.h"

// Singleton
static LocalizeHelper* SingleLocalSystem = nil;

// my Bundle (not the main bundle!)
static NSBundle* myBundle = nil;

@interface LocalizeHelper ()
@property (nonatomic, strong) NSString* lang;
@end


@implementation LocalizeHelper


+ (LocalizeHelper*) shared {
    if (SingleLocalSystem == nil) {
        SingleLocalSystem = [[LocalizeHelper alloc] init];
        NSUserDefaults *base = [NSUserDefaults standardUserDefaults];
        // GET LANGUAGE DEVICE
        NSString *language = [[NSLocale preferredLanguages] objectAtIndex:0];
        NSDictionary *languageDic = [NSLocale componentsFromLocaleIdentifier:language];
        NSString *langDevice = [languageDic objectForKey:@"kCFLocaleLanguageCodeKey"];
        // GET CURRENT LANG
        NSString * code = [base valueForKey:@"currentLanguage"];
        if (code != nil && [code isKindOfClass:[NSString class]]) {
            if (code.length > 0) {
                [SingleLocalSystem setLanguage:code];
            }
        } else {
            if ([SingleLocalSystem checkExistLanguage:langDevice]) {
                SingleLocalSystem.lang = langDevice;
            } else {
                SingleLocalSystem.lang = @"en";
            }
        }
    }
    return SingleLocalSystem;
}
- (id) init {
    self = [super init];
    if (self) {
        myBundle = [NSBundle mainBundle];
    }
    return self;
}

- (NSString*) localizedStringForKey:(NSString*) key {
    return [myBundle localizedStringForKey:key value:@"" table:nil];
}


//-------------------------------------------------------------
// set a new language
//-------------------------------------------------------------
// you can use this macro:
// LocalizationSetLanguage(@"German") or LocalizationSetLanguage(@"de");

-(BOOL)checkExistLanguage:(NSString*)language{
    NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj" ];
    if (path == nil) {
        return false;
    } else {
        return true;
    }
}

- (void) setLanguage:(NSString*) lang {
    NSUserDefaults *base = [NSUserDefaults standardUserDefaults];
    NSString *path = [[NSBundle mainBundle] pathForResource:lang ofType:@"lproj" ];
    if (path == nil) {
        myBundle = [NSBundle mainBundle];
        self.lang = nil;
        return;
    } else {
        myBundle = [NSBundle bundleWithPath:path];
        if (myBundle == nil) {
            myBundle = [NSBundle mainBundle];
            self.lang = nil;
        } else {
            self.lang = lang;
            [base setValue:lang forKey:@"currentLanguage"];
            [base synchronize];
        }
    }
}
- (void) setLanguageAndReset:(NSString*) lang {
    NSUserDefaults *base = [NSUserDefaults standardUserDefaults];
    NSString *path = [[NSBundle mainBundle] pathForResource:lang ofType:@"lproj" ];
    if (path == nil) {
        myBundle = [NSBundle mainBundle];
        self.lang = nil;
        return;
    } else {
        myBundle = [NSBundle bundleWithPath:path];
        if (myBundle == nil) {
            myBundle = [NSBundle mainBundle];
            self.lang = nil;
        } else {
            self.lang = lang;
            [base setValue:lang forKey:@"currentLanguage"];
            [base synchronize];
        }
    }
}


#pragma mark - Use Current Language
- (NSString *)currentLanguage{
    NSUserDefaults *base = [NSUserDefaults standardUserDefaults];
    if (self.lang)
        return self.lang;
    NSString *_curLan = [[myBundle preferredLocalizations] objectAtIndex:0];
    if ([_curLan containsString:@"en"]) {
        return @"en";
    } else if([_curLan isEqualToString:@"vi"]){
        return @"vi";
    } else {
        if ([base valueForKey:@"currentLanguage"] != nil) {
            return [base valueForKey:@"currentLanguage"];
        }
    }
    return @"vi";
}

@end
