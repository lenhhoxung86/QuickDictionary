//
//  WFPlayerData.h
//  C.R. Flamengo
//
//  Created by Nguyen Duc Chinh on 5/4/13.
//  Copyright (c) 2013 wisekey. All rights reserved.
//

#import "WKBaseData.h"

@interface DictionaryData : WKBaseData {
    @private
    NSInteger   rowId;
    NSString *word_str;
    NSInteger word_data_offset;
    NSInteger word_data_size;
}

@property (nonatomic, assign) NSInteger rowId;
@property (nonatomic, retain) NSString *word_str;
@property (nonatomic, assign) NSInteger word_data_offset;
@property (nonatomic, assign) NSInteger word_data_size;
@end
