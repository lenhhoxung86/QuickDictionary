//
//  WFPlayerData.m
//  C.R. Flamengo
//
//  Created by Nguyen Duc Chinh on 5/4/13.
//  Copyright (c) 2013 wisekey. All rights reserved.
//

#import "DictionaryData.h"
#import "WKDatabaseSchema.h"

@implementation DictionaryData

@synthesize rowId, word_str, word_data_offset, word_data_size;

#pragma mark -
#pragma mark memory management methods
- (void)dealloc
{
    RELEASE_SAFELY(word_str);
    
    [super dealloc];
}

#pragma mark -

/**
 * @see WIDBaseData tableName
 */
+ (NSString *)tableName
{
	return kDictDataTable;
}
/**
 * @see WIDBaseData columns
 */
+ (NSArray *)columns
{
	return [NSArray arrayWithObjects:
            kDictRowId,
            kDictWordStr,
            kDictWordDataOffset,
            kDictWordDataSize,
            nil];
}

/**
 * @see WIDBaseData columnNamesToPropertyName
 */
+ (NSDictionary *)columnNamesToPropertyName
{
	return [NSDictionary dictionaryWithObjectsAndKeys:
            @"rowId",kDictRowId,
            @"word_str",kDictWordStr,
            @"word_data_offset",kDictWordDataOffset,
            @"word_data_size",kDictWordDataSize,
            nil];
}

/**
 * @see WIDBaseData pkName
 */
+ (NSString *)pkName
{
	return kDictRowId;
}

-(id)copy
{
    
	DictionaryData *copyObj = [[DictionaryData alloc] init];
	copyObj.rowId = self.rowId;
    copyObj.word_str = self.word_str;
    copyObj.word_data_offset = self.word_data_offset;
    copyObj.word_data_size = self.word_data_size;
    
	return copyObj;
}

@end
