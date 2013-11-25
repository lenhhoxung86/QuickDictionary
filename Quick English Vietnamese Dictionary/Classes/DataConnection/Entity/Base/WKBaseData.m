/***
 **  $Date: 2013-03-31 04:45:18 +0700 (Sun, 31 Mar 2013) $
 **  $Revision: 3516 $
 **  $Author: ChinhND $
 **  $HeadURL: https://chinhnd@scs01.wisekey.ch:8443/svn/wiseid/iphone/trunk/SRC/WISeID/Classes/Data/Entity/Base/WKBaseData.m $
 **  $Id: WKBaseData.m 3516 2013-03-30 21:45:18Z ChinhND $
***/

//
//  WKBaseData.m
//  WiseID
//
//  Created by Han Dang on 7/5/11.
//  Copyright 2011 Savvycom JSC. All rights reserved.
//

#import "WKBaseData.h"

//static SQLiteDatabase *database;

@implementation WKBaseData

#pragma mark Initializers

- (id)init {
    self = [super init];
    if (self) {
        if(relationShips) RELEASE_SAFELY(relationShips);
        relationShips = [[NSMutableDictionary alloc] init];
    }
    return self;
}

/**
 * Init a object model with result set selected from database
 */
- (id)initWithResultDictionary:(NSDictionary *)dictionary {
    self = [self init];
    if(self) {
        NSEnumerator *keyEnum = [dictionary keyEnumerator];
        id key;
        while ((key = [keyEnum nextObject])) {
            id value = [dictionary objectForKey:key];
            id propKey = [[[self class] columnNamesToPropertyName] objectForKey:key];
            
            if(propKey == nil) continue;
            
            [self setValue:value 
                    forKeyPath:propKey];
        }
    }
    return self;
}

/**
 * Mapping sql result to WKBaseData object
 * @return a object that is mapped data
 */
+ (id)dataWithResultDictionary:(NSDictionary *)dictionary {
    id data = [[self alloc] initWithResultDictionary:dictionary];
    return [data autorelease];
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc
{
    RELEASE_SAFELY(relationShips);
    [super dealloc];
}

#pragma mark -
#pragma property setter and getters

//+ (SQLiteDatabase *)database {
//    return database;
//}
//
//+ (void)setDatabase:(SQLiteDatabase *)newDatabase {
//    if(newDatabase != database) {
//        [database autorelease];
//        database = [newDatabase retain];
//    }
//}

#pragma mark -
#pragma mark SQL TABLE-CLASS MAPPING FUNCTIONS 

/**
 * @return values of propety list get from columns
 */
- (NSArray *) propertyValues {
    NSMutableArray *values = [NSMutableArray array];
    NSDictionary *columnsMapping = [[self class] columnNamesToPropertyName];
    for(NSString *columnName in [[self class] columns]) {
        NSString *propertyName = [columnsMapping objectForKey:columnName];
        if(propertyName != nil) {
            id value = [self valueForKeyPath:propertyName];
            if(value != nil) {
                [values addObject: value];
            }else{
                [values addObject:[NSNull null]];
            }
        } else {
            [values addObject:[NSNull null]];
        }
    }
    return values;
}

/**
 * @return values of propety list get from columns except primary key
 */
- (NSArray *) propertyValuesWithoutPK {
    //id pkVal = [self pkValue];
    NSMutableArray *values = [NSMutableArray array];
    NSDictionary *columnsMapping = [[self class] columnNamesToPropertyName];
    for(NSString *columnName in [[self class] columns]) {
                
        NSString *propertyName = [columnsMapping objectForKey:columnName];
        if(propertyName != nil) {
            id value = [self valueForKeyPath:propertyName];
            /*if ([value isEqual:pkVal]) {
                continue;
            }
             */
            if ([columnName isEqualToString:[[self class] pkName]]) {
                continue;
            }
            
            if(value != nil) {
                [values addObject: value];
            }else{
                [values addObject:[NSNull null]];
            }
        } else {
            [values addObject:[NSNull null]];
        }
    }
    return values;
}

/**
 * @return propety primary key value of model
 */
- (NSObject *)pkValue
{       
    NSString *pkProp = [[[self class] columnNamesToPropertyName] objectForKey:[[self class] pkName]];
    return [self valueForKey:pkProp];
}

/**
 * @return table name of model
 */
+ (NSString *) tableName {
    return NSStringFromClass([self class]);
}

/**
 * @return a hash that map list of columns (table) to a list of properties (class)
 */
+ (NSDictionary *) columnNamesToPropertyName {
    NSArray *columns = [[self class] columns];
    return [NSDictionary dictionaryWithObjects:columns forKeys:columns];
}

/**
 * @return list of table column name
 */
+ (NSArray *)columns {
    return [NSArray array];
}

/**
 * @return name of primary key column
 */
+ (NSString *)pkName {
    return @"id";
}

#pragma mark -
#pragma mark SQL GENERATE FUNCTIONS

/**
 * Generate Insert SQL template
 * All fields configured in [columns] will be set by parameter in this statement
 * @return Insert SQL template for the model. 
 */
+ (NSString *)getInsertSql {
    NSString *sqlFormat = @"INSERT INTO \"%@\"  (%@) VALUES  (%@)";
    NSString *columns = @"";
    NSString *values = @"";
    for (NSString *col in [[self class] columns]) {
        columns = [columns stringByAppendingFormat:@"\"%@\",", col]; 
        values = [values stringByAppendingString:@"?,"];
    }
    columns = [columns substringToIndex:[columns length] - 1];
    values = [values substringToIndex:[values length] - 1];
    
    NSString *sql = @"";
    sql = [sql stringByAppendingFormat:sqlFormat, [[self class] tableName], columns, values];
    return sql;
}


/**
 * Generate Update SQL template
 * Except primary key, All fields configured in [columns] will be set by parameter in this statement
 * @return Update SQL template for the model. 
 */
+ (NSString *)getUpdateSql
{
    NSString *sqlFormat = @"UPDATE \"%@\" SET %@ WHERE \"%@\"=?";
    NSString *pkName = [[self class] pkName];
    
    NSString *setData = @"";
    for (NSString *col in [[self class] columns]) {
        if ([pkName isEqual:col]) {
            continue;
        }
        setData = [setData stringByAppendingFormat:@"\"%@\"=?,", col]; 
    }
    setData = [setData substringToIndex:[setData length] - 1];
    
    NSString *sql = @"";
    sql = [sql stringByAppendingFormat:sqlFormat, [[self class] tableName], setData, pkName];

    return sql;
}

/**
 * Generate Delete SQL template
 * Delete condition is primary key
 * @return Delete SQL template for the model. 
 */
+ (NSString *) getDeleteSql
{
    NSString *sqlFormat = @"DELETE FROM \"%@\" WHERE \"%@\"=?";
    NSString *pkName = [[self class] pkName];
    NSString *sql = @"";
    sql = [sql stringByAppendingFormat:sqlFormat, [[self class] tableName], pkName];

    return sql;
}

/**
 * Generate Delete SQL template without where statement
 * @return Delete SQL template for the model. 
 */
+ (NSString *) getDeleteAllSql
{
	NSString *sqlFormat = @"DELETE FROM \"%@\"";
    NSString *sql = [NSString stringWithFormat:sqlFormat, [[self class] tableName]];
    return sql;
}

/**
 * Generate Select SQL template
 * Select condition is primary key
 * @return Select SQL template for the model. 
 */
+ (NSString *) getSelectSql
{
    NSString *sqlFormat = @"SELECT %@ FROM \"%@\" WHERE \"%@\"=?";
    NSString *columns = @"";
    for (NSString *col in [[self class] columns]) {
        columns = [columns stringByAppendingFormat:@"\"%@\",", col]; 
    }
    columns = [columns substringToIndex:[columns length] - 1];
    
    NSString *sql = @"";
    sql = [sql stringByAppendingFormat:sqlFormat, columns, [[self class] tableName], [[self class] pkName]];

    return sql;
}

/*
 * Generate Select SQL template without where statement
 * @return Select SQL template for the model. 
 */
+ (NSString *) getSelectAllSql
{
    NSString *sqlFormat = @"SELECT %@ FROM \"%@\" ";
    NSString *columns = @"";
    for (NSString *col in [[self class] columns]) {
        columns = [columns stringByAppendingFormat:@"\"%@\",", col]; 
    }
    columns = [columns substringToIndex:[columns length] - 1];
    
    NSString *sql = @"";
    sql = [sql stringByAppendingFormat:sqlFormat, columns, [[self class] tableName]];
	
    return sql;
}

#pragma mark -
#pragma mark relational model methods

/**
 * override to add relationship process
 */
-(void)setValue:(id)value forKeyPath:(NSString *)key {
    NSArray *propTree = [key componentsSeparatedByString:@"."];
    if ([propTree count] >= 2 ) {
        NSString *childProp = [propTree objectAtIndex:0];
        id val1 = [self valueForKey:childProp];
        if (val1 != nil) {
            [val1 setValue:value forKeyPath:[key substringFromIndex:([childProp length] + 1)]];
        }
        [relationShips setObject:value forKey:key];
    } else {
        [super setValue:value forKeyPath:key];
    }
}

/**
 * gets the value for key in relational model
 */
- (id)valueForKeyPath:(NSString *)keyPath {
    id value = [super valueForKeyPath:keyPath];
    if (value == nil) {
        NSArray *propTree = [keyPath componentsSeparatedByString:@"."];
        if ([propTree count] >= 2 ) {
            value = [relationShips objectForKey:keyPath];
        }
    }
    return value;
}

/**
 * Get the object represent value of relationship column
 */
- (id)relationShipObjectForKeyPath:(NSString *)key {
    return [relationShips objectForKey:key];
}

/**
 * Compare with other instance
 */
- (BOOL) isEqualWithOtherInstance:(WKBaseData *)basedata {
    NSArray *values = [self propertyValuesWithoutPK];
    NSArray *instances = [basedata propertyValuesWithoutPK];
    if (values.count != instances.count) {
        return NO;
    }

    for (int i = 0; i < values.count; i++) {
        id val = [values objectAtIndex:i];
        if (![val isEqual:[instances objectAtIndex:i]]) {
            return NO;
        }
    }
    
    return YES;
}

#pragma mark -
@end