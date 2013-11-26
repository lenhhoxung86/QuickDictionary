//
//  WKDAOManager+Players.m
//  C.R. Flamengo
//
//  Created by Nguyen Duc Chinh on 5/4/13.
//  Copyright (c) 2013 wisekey. All rights reserved.
//

#import "WKDAOManager+Dictionary.h"

@implementation WKDAOManager (Dictionary)

- (NSArray *)selectAll:(NSString *)tableName withConditions:(NSString *)condition andParams:(NSArray *)params
{
    NSMutableArray *words = [[NSMutableArray alloc] init];
    NSString *sql = @"SELECT * FROM %@ %@";
    sql = [NSString stringWithFormat:sql, tableName, condition];
    NSArray *results = nil;
    if (params) {
        results = [self executeSql:sql withParameters:params];
    } else {
        results = [self executeSql:sql];
    }
    for (NSDictionary *dict in results) {
        DictionaryData *record = [DictionaryData dataWithResultDictionary:dict];
        if (record) {
            [words addObject:record];
        }
    }
	return [words autorelease];
}
//
///**
// * Get players with parameters - internal method
// * @param prams for sql querry
// * @return array of players
// */
//- (NSMutableArray *)getWordsWithCondition:(NSString *)condition andParams:(NSArray *)params {
//    
//    NSMutableArray *words = [[NSMutableArray alloc] init];
//    
//    if (condition == nil || params == nil) {
//        //-all players
//        NSArray *result = [self selectAll:kDictDataTable withConditions:@"" andParams:nil];
//        for (NSDictionary *dictionary in result) {
//            WFPlayerData *data = [WFPlayerData dataWithResultDictionary:dictionary];
//            [players addObject:data];
//        }
//    } else {
//        //-favorite case
//        NSArray *result = [self selectAll:kWFPlayerTable withConditions:condition andParams:params];
//        for (NSDictionary *dictionary in result) {
//            WFPlayerData *data = [WFPlayerData dataWithResultDictionary:dictionary];
//            [players addObject:data];
//        }
//    }
//    return [players autorelease];
//}
//
///**
// * Get all players from wisefan db
// */
//- (NSArray *)getAllPlayers {
//    
//    NSMutableArray *playersArray = [[NSMutableArray alloc] init];
//    [playersArray addObjectsFromArray:[self getPlayersWithCondition:nil andParams:nil]];
//    return [playersArray autorelease];
//}
//
///**
// * Get all favorite players from wisefan db
// */
//- (NSArray *)getFavoritePlayers {
//    
//    NSMutableArray *playersArray = [[NSMutableArray alloc] init];
//    NSArray *params = [NSArray arrayWithObject:[NSNumber numberWithInt:1]];
//    NSString *condition =  @"WHERE isFavorite = ?";
//    [playersArray addObjectsFromArray:[self getPlayersWithCondition:condition andParams:params]];
//    return [playersArray autorelease];
//    
//}
//
- (DictionaryData *)getWordByRowId:(NSInteger)wordID {
    
    NSMutableArray *wordsArray = [[NSMutableArray alloc] init];
    NSArray *params = [NSArray arrayWithObject:[NSNumber numberWithLong:wordID]];
    NSString *condition = @"WHERE rowId = ?";
    [wordsArray addObjectsFromArray:[self selectAll:kDictDataTable withConditions:condition andParams:params]];
    if (wordsArray.count > 0) {
        return [wordsArray objectAtIndex:0];
    } else {
        return nil;
    }
}

- (NSArray*)searchWordsByKeyword:(NSString*)keyword {
    NSMutableArray *wordsArray = [[NSMutableArray alloc] init];
//    NSArray *params = [NSArray arrayWithObject:keyword];
//    NSString *condition = @"WHERE word_str = ?";
    NSString *condition = [NSString stringWithFormat:@"WHERE word_str LIKE '%@%%' LIMIT 8",keyword];
    [wordsArray addObjectsFromArray:[self selectAll:kDictDataTable withConditions:condition andParams:nil]];
    if (wordsArray.count > 0) {
        return [wordsArray autorelease];
    } else {
        return nil;
    }
}

//
//- (BOOL)checkPlayerIsFavorite:(WFPlayerData *)aPlayer {
//    
//    NSMutableArray *playersArray = [[NSMutableArray alloc] init];
//    NSArray *params = [NSArray arrayWithObject:[NSNumber numberWithInt:aPlayer.playerID]];
//    NSString *condition = @"WHERE id = ? and isFavorite = 1";
//    [playersArray addObjectsFromArray:[self getPlayersWithCondition:condition andParams:params]];
//    if (playersArray.count > 0) {
//        return YES;
//    } else {
//        return NO;
//    }
//}
//
//- (void)updateListPlayers:(NSArray *) listPlayers
//{
//    // deactive all player before update, to fix issue - server remove player without set status
//    [self deactiveAllPlayer];
//    
//    for (int counter=0; counter < [listPlayers count]; counter++) {
//        WFPlayerData *aPlayer = (WFPlayerData *)[listPlayers objectAtIndex: counter];
//        NSInteger status = aPlayer.status;
//        
//        if (![self select:aPlayer]) {
//            if (status == 1) {
//                [self insert:aPlayer];
//            }
//        } else {
//            if (status == 1) {
//                [self update:aPlayer];
//            } else {
//                [self del:aPlayer];
//            }
//        }
//    }
//    
//    // delete deactive player
//    [self deleteDeactivePlayers];
//}
//
//- (void) deactiveAllPlayer
//{
//    NSArray *allPlayers = [self getAllPlayers];
//    for (WFPlayerData *player in allPlayers) {
//        player.status = 0;
//        
//        [self update:player];
//    }
//}
//
//
//- (void) deleteDeactivePlayers
//{
//    NSArray *allPlayers = [self getAllPlayers];
//    for (WFPlayerData *player in allPlayers) {
//        if (player.status == 0) {
//            [self del:player];
//        }
//    }
//}
@end
