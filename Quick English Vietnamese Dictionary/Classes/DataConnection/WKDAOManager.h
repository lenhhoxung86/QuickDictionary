/***
 **  $Date: 2013-04-22 12:57:34 +0700 (Mon, 22 Apr 2013) $
 **  $Revision: 3577 $
 **  $Author: rmurukesan $
 **  $HeadURL: https://chinhnd@scs01.wisekey.ch:8443/svn/wiseid/iphone/trunk/SRC/WISeID/Classes/Data/DAO/WKDAOManager.h $
 **  $Id: WKDAOManager.h 3577 2013-04-22 05:57:34Z rmurukesan $
***/
//
//  WKDAOManager.h
//  WiseID
//
//  Created by Han Dang on 7/5/11.
//  Copyright 2011 Savvycom JSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WKBaseData.h"
#import "FMDatabaseQueue.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "DictionaryData.h"
#import "WKDatabaseSchema.h"

@interface WKDAOManager : NSObject  {
	BOOL noPasswordInUse;
	NSString *databaseFilePath;
	
	BOOL dbProcessStatus;
	
	@private
        FMDatabaseQueue *database;
}

//properties
@property (retain,getter=currentDatabaseFilePath) NSString *databaseFilePath;
@property (assign,getter = isdbprocessInprogress) BOOL dbProcessStatus;

#pragma mark constructors
/*
 * Creates a new dao manager instance pointing to the file in the path specified
 * @param path: path where the db to be pointed exists.
 * @return a new dao manager instance.
 */
- (id)initWithPath:(NSString*)path;

#pragma mark -
#pragma Database Interaction

-(BOOL)isFileExisting;

-(NSNumber*)getDatabaseFileSize;

#pragma mark -
#pragma database creation

//- (void)createNewDatabase;

#pragma mark -
#pragma mark open DB

- (BOOL)openDatabase;

- (BOOL)isDatabaseOpened;

#pragma mark -
#pragma mark close DB

- (void)cleanUp;

#pragma mark -
#pragma mark database transaction functions

/**
 * starts the transaction on the current database object
 */
-(void) beginTransaction;

/**
 * commits the changes done by the last transaction on the current database object
 */
-(void) commitTransaction;

/**
 * commits the changes done by the last transaction on the current database object
 */
-(void)rollbackTransaction;

#pragma mark -
#pragma mark DB basic functions

/**
 * returns a whole new uuid
 * @return UUID string
 */
//- (NSString*)getNewUUID;

/*
 * compact the db file
 */
-(BOOL)compactDatabase;

/**
 * Check if a table exists in db
 * @param tableName name of the table to check for
 * @return bool stating table's existence
 */
-(BOOL)hasTable:(NSString*)tableName;

/**
 *  Check if a table has a specific column
 *  @param columnName: name of column in the table
 */
-(BOOL)hasColumn:(NSString*)columnName inTable:(NSString*)tableName;

/**
 *  Add a column with data type to a given table
 */
-(void)addColumn:(NSString*)columnName withType:(NSString*)dataType intoTable:(NSString*)tableName;


/**
 * insert a record based on a model object into database
 * @param data model to insert
 * @return bool stating success or failure of insertion
 */
- (BOOL)insert:(WKBaseData *)data;

/**
 * update a record based on a model object into database by primary key
 * @param data model to update
 * @return bool stating success or failure of updation
 */
- (BOOL)update:(WKBaseData *) data;

/**
 * select a record from database by primary key get from model
 * @param data (IN-OUT) model to select, model to save result
 * @return TRUE if the data model that primary key match, otherwise FALSE
 */
-(BOOL)select:(WKBaseData *)data;

/**
 * Fetch all record from a table
 * @param tableName table to fetch
 * @return array of records
 */
-(NSArray *)selectAll:(NSString *) tableName;

/**
 * Fetch all record from a table in a ordered way
 * @param tableName table to fetch
 * @param columnName name of the column in specified table to sort with
 * @return array of sorted records
 */
- (NSArray *)selectAll:(NSString *)tableName orderBy:(NSString *)columnName;

/**
 * delete a record from database by primary key
 * @param data model to delete
 * @return boolean stating success of deletion
 */
-(BOOL)del:(WKBaseData *)data;

/**
 * delete satified records from database 
 * @param arrColumn condition column name
 * @param arrValue condition value
 * @return boolean stating success or failure
 */
-(BOOL)deleteFrom:(NSString *)tableName where:(NSArray *)arrColumns value:(NSArray *)arrValues;

/**
 * delete all record from a table
 * @param tableName table to delete
 * @return boolean stating success or failure
 */
-(BOOL)deleteAll:(NSString *)tableName;

#pragma mark -
#pragma mark handy methods for db interaction

/**
 * execute a sql statement
 * @param sql SQL statement
 * @param parameters parameter of statement
 * @return array of record in case of Select statement
 */
- (NSArray *)executeSql:(NSString *)sql withParameters:(NSArray *)parameters;

/**
 * execute a sql statement
 * @param sql SQL statement
 * @return array of record in case of Select statement
 */
- (NSArray *)executeSql:(NSString *)sql;

/**
 * execute a sql statement that doesn't returns a recordset
 * @param sql SQL statement
 * @param parameters parameter of statement
 * @return boolean to decide the status of execution
 */
- (BOOL)executeSqlNonQuery:(NSString *)sql withParameters:(NSArray *)parameters;

/**
 * Execute a sql statement that doesn't returns a recordset
 * @param sql SQL statement
 * @return boolean to decide the status of execution
 */
- (BOOL)executeSqlNonQuery:(NSString *)sql;

#pragma mark -
@end