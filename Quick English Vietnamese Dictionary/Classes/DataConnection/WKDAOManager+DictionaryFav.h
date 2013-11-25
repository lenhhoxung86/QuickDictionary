//
//  WKDAOManager+Players.h
//  C.R. Flamengo
//
//  Created by Nguyen Duc Chinh on 5/4/13.
//  Copyright (c) 2013 wisekey. All rights reserved.
//

#import "WKDAOManager.h"
#import "DictionaryFavData.h"

@interface WKDAOManager (DictionaryFavData)

/**
 *  get a specific word by rowId
 *  @param row id
 *  @return Dictionary Data
 */
- (DictionaryFavData *)getWordByRowId:(NSInteger)wordID;

/**
 *  search words by keyword
 *  @param keyword the word needs to search.
 */
- (NSArray*)searchFavWordsByKeyword:(NSString*)keyword;

/**
 *  Check if the keyword exists in the favorite list
 */
- (BOOL)isFavorite:(NSString*)keyword;

/**
 *  Get all favorite words
 */
- (NSArray*)getAllFavoriteEntries;

@end
