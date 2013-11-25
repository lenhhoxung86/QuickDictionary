//
//  WKDAOManager+Players.h
//  C.R. Flamengo
//
//  Created by Nguyen Duc Chinh on 5/4/13.
//  Copyright (c) 2013 wisekey. All rights reserved.
//

#import "WKDAOManager.h"
#import "DictionaryData.h"

@interface WKDAOManager (Dictionary)

/**
 *  get a specific word by rowId
 *  @param row id
 *  @return Dictionary Data
 */
- (DictionaryData *)getWordByRowId:(NSInteger)wordID;

/**
 *  search words by keyword
 *  @param keyword the word needs to search.
 */
- (NSArray*)searchWordsByKeyword:(NSString*)keyword;

@end
