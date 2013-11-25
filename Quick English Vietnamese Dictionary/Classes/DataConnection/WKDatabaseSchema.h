/***
 **  $Date: 2012-08-14 21:08:15 +0700 (Tue, 14 Aug 2012) $
 **  $Revision: 2916 $
 **  $Author: ChinhND $
 **  $HeadURL: https://chinhnd@scs01.wisekey.ch:8443/svn/wiseid/iphone/trunk/SRC/WISeID/Classes/Data/WKDatabaseSchema.h $
 **  $Id: WKDatabaseSchema.h 2916 2012-08-14 14:08:15Z ChinhND $
***/
//
//  WKDatabaseSchema.h
//  WiseID
//
//  Created by Van Dang on 7/13/11.
//  Copyright 2011 Savvycom JSC. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - table Data

extern NSString * const kDictDataTable;//-table name
extern NSString * const kDictRowId; //-primary key
extern NSString * const kDictWordStr; //-keyword to search
extern NSString * const kDictWordDataOffset; //-data offset from the beginning of file
extern NSString * const kDictWordDataSize; //- size of current searching keyword

NSString * const kDictFavDataTable;
NSString * const kDictFavRowId;
NSString * const kDictFavWordStr;
NSString * const kDictFavWordDataOffset;
NSString * const kDictFavWordDataSize;
NSString * const kDictFavType;

#pragma mark - table Setting
extern NSString * const kSettingTable;//-table Setting
extern NSString * const kSettingRowId;//-primary key
extern NSString * const kSettingDictType;
extern NSString * const kSettingLang;
extern NSString * const kSettingVoice;
extern NSString * const kSettingReserved1;
extern NSString * const kSettingReserved2;

#pragma mark - table Favorite

@interface WKDatabaseSchema : NSObject
@end