//
//  SettingData.m
//  Quick English Vietnamese Dictionary
//
//  Created by Coder on 11/20/13.
//  Copyright (c) 2013 Academic Software. All rights reserved.
//

#import "SettingData.h"

@implementation SettingData
@synthesize rowId,dictionary_type,language,voice,reversed1,reversed2;
#pragma mark -
#pragma mark memory management methods
- (void)dealloc
{
    RELEASE_SAFELY(dictionary_type);
    RELEASE_SAFELY(language);
    RELEASE_SAFELY(voice);
    RELEASE_SAFELY(reversed1);
    RELEASE_SAFELY(reversed2);
    
    [super dealloc];
}

#pragma mark -

/**
 * @see WIDBaseData tableName
 */
+ (NSString *)tableName
{
	return kSettingTable;
}
/**
 * @see WIDBaseData columns
 */
+ (NSArray *)columns
{
	return [NSArray arrayWithObjects:
            kSettingRowId,
            kSettingDictType,
            kSettingLang,
            kSettingVoice,
            kSettingReserved1,
            kSettingReserved2,
            nil];
}

/**
 * @see WIDBaseData columnNamesToPropertyName
 */
+ (NSDictionary *)columnNamesToPropertyName
{
	return [NSDictionary dictionaryWithObjectsAndKeys:
            @"rowId",kSettingRowId,
            @"dictionary_type",kSettingDictType,
            @"language",kSettingLang,
            @"voice",kSettingVoice,
            @"reversed1",kSettingReserved1,
            @"reversed2",kSettingReserved2,
            nil];
}

/**
 * @see WIDBaseData pkName
 */
+ (NSString *)pkName
{
	return kSettingRowId;
}

-(id)copy
{
    
	SettingData *copyObj = [[SettingData alloc] init];
	copyObj.rowId = self.rowId;
    copyObj.dictionary_type = self.dictionary_type;
    copyObj.language = language;
    copyObj.voice = self.voice;
    copyObj.reversed1 = self.reversed1;
    copyObj.reversed2 = self.reversed2;
    
	return copyObj;
}

@end
