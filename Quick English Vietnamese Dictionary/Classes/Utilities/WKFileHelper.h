/***
 **  $Date: 2012-12-21 20:52:32 +0700 (Fri, 21 Dec 2012) $
 **  $Revision: 3328 $
 **  $Author: rmurukesan $
 **  $HeadURL: https://chinhnd@scs01.wisekey.ch:8443/svn/wiseid/iphone/trunk/SRC/WISeID/Classes/Common/Helpers/WKFileHelper.h $
 **  $Id: WKFileHelper.h 3328 2012-12-21 13:52:32Z rmurukesan $
***/
//
//  WKFileHelper.h
//  WiseID
//
//  Created by Tue Nguyen on 7/5/11.
//  Copyright 2011 Savvycom JSC. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface WKFileHelper : NSObject
{
	
}

#pragma mark general file operations

+ (BOOL)isfileExisting:(NSString*)filePath;

+ (NSError*)removeFileAtPath:(NSString*)filePath;

+ (NSError*)duplicateFileFromPath:(NSString*)filePath toPath:(NSString*)targetPath;

+ (NSError*)moveFileAtPath:(NSString*)filePath toPath:(NSString*)targetPath;

+ (NSError*)moveFilesInFolder:(NSString*)folderSourcePath toFolder:(NSString*)folderTargetPath;

+ (NSError*)copyFileAtPath:(NSString*)filePath toPath:(NSString*)targetPath;

+ (NSError*)copyFilesInFolder:(NSString*)folderSourcePath toFolder:(NSString*)folderTargetPath;

+ (NSError*)createFile:(NSString*)path withData:(NSData*)data overwrite:(BOOL)overwrite;

+(NSError*)createFolderAtPath:(NSString*)folderpath;

+(NSNumber*) sizeForFileInBytes:(NSString*)filePath;

+(NSNumber*) convertBytesToMegaBytes:(NSNumber*)bytes;

+(NSArray*)contentsOfDirectoryAtPath:(NSString*)folderpath;

+(int) countNumberOfFilesInDir:(NSString*)folderpath;

+(void) removeFilesInFolderPath :(NSString*) folderPath;


#pragma mark -
#pragma mark Application data directory

+ (NSString *)applicationDataDirectory;

+ (NSString*)pathForApplicationDataFile:(NSString*)filename;

+ (NSArray*)contentsOfApplicationDataDirectory;

#pragma mark -
#pragma mark Application bundle

+ (NSArray*)contentsOfApplicationBundle;

+ (NSError*)duplicateFiletoAppDataFromBundle:(NSString*)filename overwrite:(BOOL)overwrite;

#pragma mark -
#pragma mark Application documents

+ (NSArray*)contentsOfApplicationDocuments;

+ (NSString*)applicationDocumentsDirectory;

+ (NSString*)pathForApplicationDataDirectory:(NSString*)filename;

#pragma mark - Caching files

+ (NSString*)pathForCachingFile;

+ (void) deleteCachingFileOnSchedule;

#pragma mark - non-backup flle database:

+ (void) excludePathFromICloud:(NSString*) path;

#pragma mark -
@end