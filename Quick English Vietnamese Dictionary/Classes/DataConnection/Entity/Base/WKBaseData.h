/***
 **  $Date: 2013-03-27 18:35:06 +0700 (Wed, 27 Mar 2013) $
 **  $Revision: 3512 $
 **  $Author: ChinhND $
 **  $HeadURL: https://chinhnd@scs01.wisekey.ch:8443/svn/wiseid/iphone/trunk/SRC/WISeID/Classes/Data/Entity/Base/WKBaseData.h $
 **  $Id: WKBaseData.h 3512 2013-03-27 11:35:06Z ChinhND $
***/
//
//  WKBaseData.h
//  WiseID
//
//  Created by Han Dang on 7/5/11.
//  Copyright 2011 Savvycom JSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WKTools.h"
//#import "SQLiteDatabase.h"
/**
 * WKBaseData
 * Base class model that is mapped with a table in database
 */
@interface WKBaseData : NSObject
{
	@private
    	NSMutableDictionary *relationShips;
}

#pragma mark Initializers

- (id)init;

/**
 * Init a object model with result set selected from database
 */
- (id)initWithResultDictionary:(NSDictionary *)dictionary;

/**
 * Mapping sql result to WKBaseData object
 * @return a object that is mapped data
 */
+ (id)dataWithResultDictionary:(NSDictionary *)dictionary;

#pragma mark -
#pragma property setter and getters

//+ (SQLiteDatabase *)database;
//+ (void)setDatabase:(SQLiteDatabase *)newDatabase;

#pragma mark -
#pragma mark SQL TABLE-CLASS MAPPING FUNCTIONS 

/**
 * @return values of propety list get from columns
 */
- (NSArray *) propertyValues;

/**
 * @return values of propety list get from columns except primary key
 */
- (NSArray *) propertyValuesWithoutPK;

/**
 * @return propety primary key value of model
 */
- (NSObject *)pkValue;

/**
 * @return table name of model
 */
+ (NSString *) tableName;

/**
 * @return a hash that map list of columns (table) to a list of properties (class)
 */
+ (NSDictionary *) columnNamesToPropertyName;

/**
 * @return list of table column name
 */
+ (NSArray *)columns;

/**
 * @return name of primary key column
 */
+ (NSString *)pkName;

#pragma mark -
#pragma mark SQL GENERATE FUNCTIONS

/**
 * Generate Insert SQL template
 * All fields configured in [columns] will be set by parameter in this statement
 * @return Insert SQL template for the model. 
 */
+ (NSString *) getInsertSql;

/**
 * Generate Update SQL template
 * Except primary key, All fields configured in [columns] will be set by parameter in this statement
 * @return Update SQL template for the model. 
 */
+ (NSString *) getUpdateSql;

/**
 * Generate Delete SQL template
 * Delete condition is primary key
 * @return Delete SQL template for the model. 
 */
+ (NSString *) getDeleteSql;

/**
 * Generate Delete SQL template without where statement
 * @return Delete SQL template for the model. 
 */
+ (NSString *) getDeleteAllSql;

/**
 * Generate Select SQL template
 * Select condition is primary key
 * @return Select SQL template for the model. 
 */
+ (NSString *) getSelectSql;

/**
 * Generate Select SQL template without where statement
 * @return Select SQL template for the model. 
 */
+ (NSString *) getSelectAllSql;

#pragma mark -
#pragma mark relational model methods

/**
 * override to add relationship process
 */
-(void)setValue:(id)value forKeyPath:(NSString *)key;

/**
 * gets the value for key in relational model
 */
- (id)valueForKeyPath:(NSString *)keyPath;

/**
 * Get the object represent value of relationship column
 */
- (id)relationShipObjectForKeyPath:(NSString *)key;

/**
 * Compare with other instance
 */
- (BOOL) isEqualWithOtherInstance:(WKBaseData *)basedata;

#pragma mark -
@end