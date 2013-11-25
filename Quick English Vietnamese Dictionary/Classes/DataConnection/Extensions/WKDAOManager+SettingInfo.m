//
//  WKDAOManager+SettingInfo.m
//  C.R. Flamengo
//
//  Created by Nguyen Duc Chinh on 5/4/13.
//  Copyright (c) 2013 wisekey. All rights reserved.
//

#import "WKDAOManager+SettingInfo.h"

@implementation WKDAOManager (SettingInfo)

- (SettingData *)getSettingsInfo
{
    NSArray *results = [self selectAll:kSettingTable];
    if (results.count==1) {
        NSDictionary *dictionary = [results objectAtIndex:0];
        SettingData *data = [SettingData dataWithResultDictionary:dictionary];
        data.rowId = 1;
		return data;
    }
	
	return nil;
}

- (BOOL)saveSettingsInfo:(SettingData *)settingsInfo
{
    return [self update:settingsInfo];
}

@end
