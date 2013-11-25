/***
 **  $Date: 2013-03-26 15:52:31 +0700 (Tue, 26 Mar 2013) $
 **  $Revision: 3504 $
 **  $Author: ChinhND $
 **  $HeadURL: https://chinhnd@scs01.wisekey.ch:8443/svn/wiseid/iphone/trunk/SRC/WISeID/Classes/Data/DAO/WKDAOFactoryManager.m $
 **  $Id: WKDAOFactoryManager.m 3504 2013-03-26 08:52:31Z ChinhND $
***/
//
//  WKDAOFactoryManager.m
//  WiseID
//
//  Created by Tu Do on 7/8/11.
//  Copyright 2011 Savvycom JSC. All rights reserved.
//

#import "WKDAOFactoryManager.h"

#import "WKFileHelper.h"
#import "WFConstants.h"

NSString * const kWKDAOManagerTypeMain = @"MainDAOManager";
NSString * const kDictE_VTypeDB = @"EVDictionary";
NSString * const kDictV_ETypeDB = @"VEDictionary";
NSString * const kUserDB = @"UserDB";

static NSMutableDictionary * daos;

@implementation WKDAOFactoryManager

+(NSMutableDictionary *)daoDictionary
{
	//Check if map dictionary not init
    if(daos == nil)
	{
        daos = [[NSMutableDictionary alloc] init];//Don't need to release it yet!
	}
	
	return daos;
}

+(WKDAOManager *)getDaoManager:(NSString *)managerType
{
    WKDAOManager *manager = [daos objectForKey:managerType];
    if(manager == nil)
	{
		if(managerType==kWKDAOManagerTypeMain) {
			manager = [[WKDAOManager alloc] initWithPath:[WKFileHelper pathForApplicationDataFile:kDatabaseFileName]];
		} else if (managerType==kDictE_VTypeDB) {
            manager = [[WKDAOManager alloc] initWithPath:[WKFileHelper pathForApplicationDataFile:kDictEV]];
        } else if (managerType==kDictV_ETypeDB) {
            manager = [[WKDAOManager alloc] initWithPath:[WKFileHelper pathForApplicationDataFile:kDictVE]];
        } else if (managerType==kUserDB) {
            //-copy if needed
            NSString *documentFolder = [WKFileHelper applicationDocumentsDirectory];
            NSString *dbFilePath = [documentFolder stringByAppendingPathComponent:kUserData];
            if (![WKFileHelper isfileExisting:dbFilePath]) {
                [WKFileHelper duplicateFileFromPath:[[NSBundle mainBundle] pathForResource:@"User" ofType:@"sqlite"] toPath:dbFilePath];
            }
            manager = [[WKDAOManager alloc] initWithPath:dbFilePath];
        }

        [[self daoDictionary] setObject:manager forKey:managerType];
        [manager release];
    }
    
    return manager;
}

@end