//
//  WKDAOManager+SettingInfo.h
//  C.R. Flamengo
//
//  Created by Nguyen Duc Chinh on 5/4/13.
//  Copyright (c) 2013 wisekey. All rights reserved.
//

#import "WKDAOManager.h"
#import "SettingData.h"

@interface WKDAOManager (SettingInfo)

/**
 *  get setting information
 */
- (SettingData *)getSettingsInfo;

/**
 *  save setting information into database
 *  @param setting infor record
 *  @return YES if successful, otherwise NO
 */
- (BOOL)saveSettingsInfo:(SettingData *)settingsInfo;

@end
