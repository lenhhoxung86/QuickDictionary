//
//  SettingData.h
//  Quick English Vietnamese Dictionary
//
//  Created by Coder on 11/20/13.
//  Copyright (c) 2013 Academic Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WKBaseData.h"
#import "WKDatabaseSchema.h"

@interface SettingData : WKBaseData {
@private
    NSInteger   rowId;
    NSString *dictionary_type;
    NSString *language;
    NSString *voice;
    NSString *reversed1;
    NSString *reversed2;
}

@property (nonatomic, assign) NSInteger rowId;
@property (nonatomic, retain) NSString *dictionary_type;
@property (nonatomic, retain) NSString *language;
@property (nonatomic, retain) NSString *voice;
@property (nonatomic, retain) NSString *reversed1;
@property (nonatomic, retain) NSString *reversed2;

@end

