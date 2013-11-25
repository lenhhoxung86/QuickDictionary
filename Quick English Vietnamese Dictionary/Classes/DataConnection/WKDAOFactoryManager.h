/***
 **  $Date: 2013-01-09 22:44:54 +0700 (Wed, 09 Jan 2013) $
 **  $Revision: 3366 $
 **  $Author: ChinhND $
 **  $HeadURL: https://chinhnd@scs01.wisekey.ch:8443/svn/wiseid/iphone/trunk/SRC/WISeID/Classes/Data/DAO/WKDAOFactoryManager.h $
 **  $Id: WKDAOFactoryManager.h 3366 2013-01-09 15:44:54Z ChinhND $
***/
//
//  WKDAOFactoryManager.h
//  WiseID
//
//  Created by Tu Do on 7/8/11.
//  Copyright 2011 Savvycom JSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WKDAOManager.h"

extern NSString * const kWKDAOManagerTypeMain;
extern NSString * const kDictE_VTypeDB;
extern NSString * const kDictV_ETypeDB;
extern NSString * const kUserDB;

@interface WKDAOFactoryManager : NSObject
{
        
}

+(WKDAOManager *)getDaoManager:(NSString *)managerType;

@end
