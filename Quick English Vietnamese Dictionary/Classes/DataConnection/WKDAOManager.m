/***
 **  $Date: 2013-04-22 12:57:34 +0700 (Mon, 22 Apr 2013) $
 **  $Revision: 3577 $
 **  $Author: rmurukesan $
 **  $HeadURL: https://chinhnd@scs01.wisekey.ch:8443/svn/wiseid/iphone/trunk/SRC/WISeID/Classes/Data/DAO/WKDAOManager.m $
 **  $Id: WKDAOManager.m 3577 2013-04-22 05:57:34Z rmurukesan $
***/
//
//  WKDAOManager.m
//  WiseID
//
//  Created by Han Dang on 7/5/11.
//  Copyright 2011 Savvycom JSC. All rights reserved.
//

#import "WKDatabaseSchema.h"

//DAO
#import "WKDAOManager.h"
#import "WKDAOFactoryManager.h"

//DAO entities

//helpers
//#import "WKSecurityHelper.h"
#import "WKFileHelper.h"

//common
#import "WKTools.h"
#import "WFConstants.h"
//#import "WKCommonHelper.h"

//extensions
//#import "NSString+Extensions.h"
//#import "NSArray+NSDictionary+Extensions.h"
//#import "NSData+Extensions.h"
//#import "NSDate+Extensions.h"

@interface WKDAOManager (PrivateMethods)

@end

@implementation WKDAOManager

@synthesize databaseFilePath;
@synthesize dbProcessStatus;

#pragma mark constructors
- (id)init
{
	if (self = [super init]) {
        
	}
	return self;
}

/*
 * Creates a new dao manager instance pointing to the file in the path specified
 * @param path: path where the db to be pointed exists.
 * @return a new dao manager instance.
 */
- (id)initWithPath:(NSString*)path
{
	if (self = [super init]) {
		self.databaseFilePath=path;
        database = [FMDatabaseQueue databaseQueueWithPath:self.databaseFilePath];
	}
	return self;
}

#pragma mark -
#pragma mark destructors

- (void)dealloc
{
	[database release];
	[databaseFilePath release];
	[super dealloc];
}

#pragma mark -
#pragma mark Database Interaction

-(BOOL)isFileExisting
{
	NSString *appDataDir=[WKFileHelper applicationDataDirectory];
	
	NSString *filename=[self.databaseFilePath stringByReplacingOccurrencesOfString:appDataDir withString:strEmpty];
	
	if([filename isEqualToString:strEmpty])
	{
		return NO;
	}
	
	return [WKFileHelper isfileExisting:self.databaseFilePath];
}

-(NSNumber*) getDatabaseFileSize
{
	return [WKFileHelper sizeForFileInBytes:self.databaseFilePath];
}

#pragma mark -
#pragma database creation

//- (void)createNewDatabase
//{
//	dbProcessStatus=TRUE;
//	
//	BOOL fileExists=[WKFileHelper isfileExisting:self.databaseFilePath];
//	
//	dbProcessStatus=FALSE;
//}

#pragma mark -
#pragma mark open DB

- (BOOL)openDatabase
{
	@try {
		//Create new database
		database = [FMDatabaseQueue databaseQueueWithPath:self.databaseFilePath];
		return YES;
	}
	@catch (NSException *exception) {
		return NO;
	}
	return NO;
}

/*
 * check if there is already an existing connection to db
 */
- (BOOL)isDatabaseOpened
{
    return YES;
}

#pragma mark -
#pragma mark close DB

- (void)cleanUp
{
    if (database) {
        [database close];
    }
}

#pragma mark -
#pragma mark database transaction functions

/**
 * starts the transaction on the current database object
 */
-(void) beginTransaction
{
	//if(database!=nil)
	//	[database beginTransaction];
}

/**
 * commits the changes done by the last transaction on the current database object
 */
-(void) commitTransaction
{
	//if(database!=nil)
	//	[database commit];
}

/**
 * commits the changes done by the last transaction on the current database object
 */
-(void)rollbackTransaction
{
	//if(database!=nil)
	//	[database rollback];
}

#pragma mark -
#pragma mark handy methods for db interaction

/**
 * execute a sql statement
 * @param sql SQL statement
 * @param parameters parameter of statement
 * @return array of record in case of Select statement
 */
- (NSArray *)executeSql:(NSString *)sql withParameters:(NSArray *)parameters
{
    __block NSMutableArray *values = [NSMutableArray array];
//    if (!database || (database == NULL)) {
        database = [FMDatabaseQueue databaseQueueWithPath:databaseFilePath];
//    }
    [database inDatabase:^(FMDatabase *db) {
        FMResultSet *resultSet = [db executeQuery:sql withArgumentsInArray:parameters];
        while ([resultSet next]) {
            NSDictionary *d = [resultSet resultDictionary];
            [values addObject:d];
        }
        [resultSet close];
    }];

    return values;
}

/**
 * execute a sql statement
 * @param sql SQL statement
 * @return array of record in case of Select statement
 */
- (NSArray *)executeSql:(NSString *)sql
{
    __block NSMutableArray *values = [NSMutableArray array];
//    if (!database || (database == NULL)) {
        database = [FMDatabaseQueue databaseQueueWithPath:databaseFilePath];
//    }
    [database inDatabase:^(FMDatabase *db) {
        FMResultSet *resultSet = [db executeQuery:sql];
        while ([resultSet next]) {
            NSDictionary *d = [resultSet resultDictionary];
            [values addObject:d];
        }
    }];

    return values;
}

/**
 * execute a sql statement that doesn't returns a recordset
 * @param sql SQL statement
 * @param parameters parameter of statement
 * @return boolean to decide the status of execution
 */
- (BOOL)executeSqlNonQuery:(NSString *)sql withParameters:(NSArray *)parameters
{
	__block BOOL success = NO;
//    if (!database || (database == NULL)) {
        database = [FMDatabaseQueue databaseQueueWithPath:databaseFilePath];
//    }
    [database inDatabase:^(FMDatabase *db) {
        success = [db executeUpdate:sql withArgumentsInArray:parameters];
    }];
    
    return success;
}

/**
 * Execute a sql statement that doesn't returns a recordset
 * @param sql SQL statement
 * @return boolean to decide the status of execution
 */
- (BOOL)executeSqlNonQuery:(NSString *)sql
{
	__block BOOL success = NO;
    if (!database) {
        database = [FMDatabaseQueue databaseQueueWithPath:databaseFilePath];
    }
    [database inDatabase:^(FMDatabase *db) {
        success = [db executeUpdate:sql];
    }];
    
    return success;
}

#pragma mark -
#pragma mark DB basic functions

/*
 * compact the db file
 */
-(BOOL)compactDatabase
{
	return [self executeSqlNonQuery:@"vacuum"];
}

/**
 * Check if a table exists in db
 * @param tableName name of the table to check for
 * @return bool stating table's existence
 */
-(BOOL)hasTable:(NSString*)tableName
{
    BOOL fRetVal = NO;
    NSArray *tableNames = [self executeSql:@"SELECT * FROM sqlite_master WHERE type = 'table'"];
    for (id name in tableNames) {
        if ([name isKindOfClass:[NSDictionary class]]) {
            NSString *tbName = [(NSDictionary*)name objectForKey:@"name"];
            if ([tbName isEqualToString:tableName]) {
                fRetVal = YES;
            }
        }
    }
    return fRetVal;
}

-(BOOL)hasColumn:(NSString*)columnName inTable:(NSString*)tableName {
    BOOL fRetVal = NO;
    NSString *sqlCmd = [NSString stringWithFormat:@"SELECT %@ from %@",columnName,tableName];
    NSArray *results = [self executeSql:sqlCmd];
    if (results.count!=0) {
        fRetVal = YES;
    }
    return fRetVal;
}

-(void)addColumn:(NSString*)columnName withType:(NSString*)dataType intoTable:(NSString*)tableName {
    NSString *sqlCmd = [NSString stringWithFormat:@"ALTER TABLE %@ ADD COLUMN %@ %@",tableName,columnName,dataType];
    [self executeSqlNonQuery:sqlCmd];
}

/**
 * insert a record based on a model object into database
 * @param data model to insert
 * @return
 */
- (BOOL)insert:(WKBaseData *) data
{
	//insert
	NSString *sql = [[data class] getInsertSql];
	NSArray *values = [data propertyValues];
    
    return [self executeSqlNonQuery:sql withParameters:values];
}

/**
 * update a record based on a model object into database by primary key
 * @param data model to update
 * @return
 */
- (BOOL)update:(WKBaseData *)data
{
	if (data == nil || [data pkValue] == nil) {
		return FALSE;
	}
    
	NSString *sql = [[data class] getUpdateSql];
    NSLog(@"sql command: %@",sql);
	NSArray *values = [data propertyValuesWithoutPK];
    values = [values arrayByAddingObject:[data pkValue]];
    
    return [self executeSqlNonQuery:sql withParameters:values];
}

/**
 * select a record from database by primary key get from model.
 * this function can be used to check if a player is exist
 * @param data (IN-OUT) model to select, model to save result
 * @return TRUE if the data model that primary key match, otherwise FALSE
 */
-(BOOL)select:(WKBaseData *) data
{
	if (data == nil || [data pkValue] == nil) {
		return FALSE;
	}
    
	NSString *sql = [[data class] getSelectSql];
	NSMutableArray *para = [NSMutableArray arrayWithObject:[data pkValue]];
    
    __block BOOL success = NO;
    database = [FMDatabaseQueue databaseQueueWithPath:databaseFilePath];
    [database inDatabase:^(FMDatabase *db) {
        FMResultSet *resultSet = [db executeQuery:sql withArgumentsInArray:para];
        while (resultSet.next) {
            success = YES;
            break;
        }
        [resultSet close];
    }];
    
	return success;
}

/**
 * Fetch all record from a table
 * @param tableName table to fetch
 * @return array of records
 */
-(NSArray *)selectAll:(NSString *)tableName
{
	return [self selectAll:tableName orderBy:nil];
}

/**
 * Fetch all record from a table in a ordered way
 * @param tableName table to fetch
 * @param columnName name of the column in specified table to sort with
 * @return array of sorted records
 */
- (NSArray *)selectAll:(NSString *)tableName orderBy:(NSString *)columnName
{
	NSString *sql = @"SELECT * FROM %@";
	sql = [NSString stringWithFormat:sql,  tableName];
	
	if (columnName != nil) {
		sql = [sql stringByAppendingFormat:@" ORDER BY %@", columnName];
	}
	return [self executeSql:sql];
}

/**
 * delete a record from database by primary key
 * @param data model to delete
 * @return
 */
-(BOOL)del:(WKBaseData *) data
{
	if (data == nil || [data pkValue] == nil) {
		return FALSE;
	}
    
	NSString *sql = [[data class] getDeleteSql];
	NSMutableArray *values = [NSMutableArray arrayWithObject:[data pkValue]];

    return [self executeSqlNonQuery:sql withParameters:values];
}

/**
 * delete satified records from database
 * @param arrColumn condition column name
 * @param arrValue condition value
 * @return
 */
-(BOOL)deleteFrom:(NSString *) tableName where: (NSArray *)arrColumn value: (NSArray *)arrValue
{
	NSString *sql = @"DELETE FROM %@ WHERE %@";
	NSString *sqlWhere = @"";
    
	for (NSString *col in arrColumn) {
		sqlWhere = [sqlWhere stringByAppendingString:[NSString stringWithFormat:@"%@ = ? AND", col]];
	}
	sqlWhere = [sqlWhere substringToIndex:([sqlWhere length] - 3)];
	sql = [NSString stringWithFormat:sql, tableName, sqlWhere];
    
    return [self executeSqlNonQuery:sql withParameters:arrValue];
}

/**
 * delete all record from a table
 * @param tableName table to delete
 * @return boolean stating success or failure
 */
-(BOOL)deleteAll:(NSString *)tableName
{
    return YES;
}

#pragma mark -
@end