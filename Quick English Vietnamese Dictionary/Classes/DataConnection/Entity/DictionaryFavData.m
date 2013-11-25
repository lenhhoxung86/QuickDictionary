//
//  WFPlayerData.m
//  C.R. Flamengo
//
//  Created by Nguyen Duc Chinh on 5/4/13.
//  Copyright (c) 2013 wisekey. All rights reserved.
//

#import "DictionaryFavData.h"
#import "WKDatabaseSchema.h"

@implementation DictionaryFavData

@synthesize /*rowId,*/ word_str, word_data_offset, word_data_size,type;

#pragma mark -
#pragma mark memory management methods
- (void)dealloc
{
    RELEASE_SAFELY(word_str);
    RELEASE_SAFELY(type);
    
    [super dealloc];
}

#pragma mark -

/**
 * @see WIDBaseData tableName
 */
+ (NSString *)tableName
{
	return kDictFavDataTable;
}
/**
 * @see WIDBaseData columns
 */
+ (NSArray *)columns
{
	return [NSArray arrayWithObjects:
//            kDictFavRowId,
            kDictFavWordStr,
            kDictFavWordDataOffset,
            kDictFavWordDataSize,
            kDictFavType,
            nil];
}

/**
 * @see WIDBaseData columnNamesToPropertyName
 */
+ (NSDictionary *)columnNamesToPropertyName
{
	return [NSDictionary dictionaryWithObjectsAndKeys:
//            @"rowId",kDictRowId,
            @"word_str",kDictWordStr,
            @"word_data_offset",kDictWordDataOffset,
            @"word_data_size",kDictWordDataSize,
            @"type",kDictFavType,
            nil];
}

/**
 * @see WIDBaseData pkName
 */
+ (NSString *)pkName
{
	return kDictFavWordStr;
}

-(id)copy
{
    
	DictionaryFavData *copyObj = [[DictionaryFavData alloc] init];
//	copyObj.rowId = self.rowId;
    copyObj.word_str = self.word_str;
    copyObj.word_data_offset = self.word_data_offset;
    copyObj.word_data_size = self.word_data_size;
    copyObj.type = self.type;
    
	return copyObj;
}

@end
