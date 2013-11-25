/***
 **  $Date: 2013-03-21 15:56:16 +0700 (Thu, 21 Mar 2013) $
 **  $Revision: 3488 $
 **  $Author: ChinhND $
 **  $HeadURL: https://chinhnd@scs01.wisekey.ch:8443/svn/wiseid/iphone/trunk/SRC/WISeID/Classes/Data/WKDatabaseSchema.m $
 **  $Id: WKDatabaseSchema.m 3488 2013-03-21 08:56:16Z ChinhND $
***/
//
//  WKDatabaseSchema.m
//  WiseID
//
//  Created by Van Dang on 7/13/11.
//  Copyright 2011 Savvycom JSC. All rights reserved.
//

#import "WKDatabaseSchema.h"

@implementation WKDatabaseSchema

#pragma mark - table Data

NSString * const kDictDataTable = @"data";
NSString * const kDictRowId = @"rowId";
NSString * const kDictWordStr = @"word_str";
NSString * const kDictWordDataOffset = @"word_data_offset";
NSString * const kDictWordDataSize = @"word_data_size";

#pragma mark - table Favorite Data

NSString * const kDictFavDataTable = @"data";
NSString * const kDictFavRowId = @"rowId";
NSString * const kDictFavWordStr = @"word_str";
NSString * const kDictFavWordDataOffset = @"word_data_offset";
NSString * const kDictFavWordDataSize = @"word_data_size";
NSString * const kDictFavType = @"type";

#pragma mark - table Setting

NSString * const kSettingTable = @"Setting" ;//-table Setting
NSString * const kSettingRowId = @"rowId";//-primary key
NSString * const kSettingDictType = @"dictionary_type";
NSString * const kSettingLang = @"language";
NSString * const kSettingVoice = @"voice";
NSString * const kSettingReserved1 = @"reversed1";
NSString * const kSettingReserved2 = @"reversed2";

@end