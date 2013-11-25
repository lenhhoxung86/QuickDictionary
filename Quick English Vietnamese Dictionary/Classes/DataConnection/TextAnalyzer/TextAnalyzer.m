//
//  TextAnalyzer.m
//  Quick English Vietnamese Dictionary
//
//  Created by Coder on 11/20/13.
//  Copyright (c) 2013 Academic Software. All rights reserved.
//

#import "TextAnalyzer.h"
#import "WKDAOFactoryManager.h"
#import "WFConstants.h"
#import "WKFileHelper.h"

static TextAnalyzer *sharedInstance = nil;

@implementation TextAnalyzer

#pragma mark - share instance frameworks
+ (TextAnalyzer*)sharedInstance {
    @synchronized(self) {
        if(sharedInstance == nil) {
            sharedInstance = [[super allocWithZone:NULL] init];
        }
    }
    return sharedInstance;
}

/*
 * method to ensure that another instance is not allocated if someone tries to allocate
 * and initialize an instance of your class directly instead of using the class factory method.
 * Instead, it just returns the shared object.
 */
+ (id)allocWithZone:(NSZone *)zone
{
    return [[self sharedInstance] retain];
}

/*
 * Implements the base protocol methods to do the appropriate things to ensure singleton status.
 * Applies to memory-managed code, not to garbage-collected code
 */
- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

/*
 * Implements the base protocol methods to do the appropriate things to ensure singleton status.
 * Applies to memory-managed code, not to garbage-collected code
 */
- (id)retain
{
    return self;
}

/*
 * Implements the base protocol methods to do the appropriate things to ensure singleton status.
 * Applies to memory-managed code, not to garbage-collected code
 */
- (NSUInteger)retainCount
{
    return NSUIntegerMax;  //denotes an object that cannot be released
}

/*
 * Implements the base protocol methods to do the appropriate things to ensure singleton status.
 * Applies to memory-managed code, not to garbage-collected code
 */
- (oneway void)release
{
    // never release
}

/*
 * Implements the base protocol methods to do the appropriate things to ensure singleton status.
 * Applies to memory-managed code, not to garbage-collected code
 */
- (id)autorelease
{
    return self;
}

#pragma mark - instance methods
- (NSArray*)meaningsFromDictionaryRecords:(NSArray*)records ofType:(NSInteger)type {
    NSMutableArray *retVal = [[[NSMutableArray alloc] init] autorelease];
    //- we need to know what kind of dictionary here
    //- temporarily set 1
    for (DictionaryData *record in records) {
        NSString *content = [self getMeaningFromRecord:record ofType:type];
        if (content) {
            [retVal addObject:content];
        }
    }
    return retVal;
}

/**
 * Get the meaning of search keyword
 * @param type: 1 as EV dictionary, 2 as VE dictionary
 */
- (NSString*)getMeaningFromRecord:(DictionaryData*)record ofType:(NSInteger)type {
    NSString *retVal = nil;
    NSString *fileName = nil;
    if (type==1) {
        fileName = kDictEVData;
    } else if (type==2) {
        fileName = kDictVEData;
    }
    NSString *filePath = [[WKFileHelper applicationDataDirectory] stringByAppendingPathComponent:fileName];
    NSInteger offset = record.word_data_offset;
    NSInteger wordSize = record.word_data_size;
    
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:filePath];
    [handle seekToFileOffset:offset];
    NSData *textData = [handle readDataOfLength:wordSize];
    if ([textData length]>0) {
        retVal = [[NSString alloc] initWithData:textData encoding:NSUTF8StringEncoding];
    }
    return retVal;
}

@end
