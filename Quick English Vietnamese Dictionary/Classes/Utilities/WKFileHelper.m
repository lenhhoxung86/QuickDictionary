/***
 **  $Date: 2012-12-21 20:52:32 +0700 (Fri, 21 Dec 2012) $
 **  $Revision: 3328 $
 **  $Author: rmurukesan $
 **  $HeadURL: https://chinhnd@scs01.wisekey.ch:8443/svn/wiseid/iphone/trunk/SRC/WISeID/Classes/Common/Helpers/WKFileHelper.m $
 **  $Id: WKFileHelper.m 3328 2012-12-21 13:52:32Z rmurukesan $
***/
//
//  WKFileHelper.m
//  WiseID
//
//  Created by Tue Nguyen on 7/5/11.
//  Copyright 2011 Savvycom JSC. All rights reserved.
//

#import "WKFileHelper.h"
#import "WKTools.h"

@implementation WKFileHelper

#pragma mark general file operations

+ (BOOL)isfileExisting:(NSString*)filePath
{
	return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}

+(void) removeFilesInFolderPath :(NSString*) folderPath
{
    NSError *error = nil;
    for (NSString *file in [[NSFileManager defaultManager] contentsOfDirectoryAtPath:folderPath error:&error]) {
        [[NSFileManager defaultManager] removeItemAtPath:[folderPath stringByAppendingPathComponent:file] error:&error];
    }
}

+ (NSError*)removeFileAtPath:(NSString*)filePath
{
	NSError *err=nil;
	if([WKFileHelper isfileExisting:filePath])
	{
		[[NSFileManager defaultManager] removeItemAtPath:filePath error:&err];
	}
	return err;
}

+ (NSError*)duplicateFileFromPath:(NSString*)filePath toPath:(NSString*)targetPath
{
	NSError *err=nil;
	[[NSFileManager defaultManager] copyItemAtPath:filePath toPath:targetPath error:&err];
	return err;
}

+ (NSError*)moveFileAtPath:(NSString*)filePath toPath:(NSString*)targetPath
{
	NSError *err=nil;
	[[NSFileManager defaultManager] moveItemAtPath:filePath toPath:targetPath error:&err];
	return err;
}

+ (NSError*)moveFilesInFolder:(NSString*)folderSourcePath toFolder:(NSString*)folderTargetPath {
    NSError *err=nil;
    NSArray *fileNames = [self contentsOfDirectoryAtPath:folderSourcePath];
    for (int counter=0; counter<fileNames.count; counter++) {
        err = [self moveFileAtPath:[folderSourcePath stringByAppendingFormat:@"/%@",[fileNames objectAtIndex:counter]] toPath:[folderTargetPath stringByAppendingFormat:@"/%@",[fileNames objectAtIndex:counter]]];
    }
    return err;
}

+ (NSError*)copyFileAtPath:(NSString*)filePath toPath:(NSString*)targetPath {
    NSError *err=nil;
	[[NSFileManager defaultManager] copyItemAtPath:filePath toPath:targetPath error:&err];
	return err;
}

+ (NSError*)copyFilesInFolder:(NSString*)folderSourcePath toFolder:(NSString*)folderTargetPath {
    NSError *err=nil;
    NSArray *fileNames = [self contentsOfDirectoryAtPath:folderSourcePath];
    for (int counter=0; counter<fileNames.count; counter++) {
        err = [self copyFileAtPath:[folderSourcePath stringByAppendingFormat:@"/%@",[fileNames objectAtIndex:counter]] toPath:[folderTargetPath stringByAppendingFormat:@"/%@",[fileNames objectAtIndex:counter]]];
    }
    return err;
}

+ (NSError*)createFile:(NSString*)path withData:(NSData*)data overwrite:(BOOL)overwrite
{
	NSError *err=nil;
	if([WKFileHelper isfileExisting:path] && overwrite)
	{
		err=[WKFileHelper removeFileAtPath:path];
	}
	
	if(err==nil)
	{
		[data writeToFile:path atomically:YES];
	}
	return err;
}

+(NSError*)createFolderAtPath:(NSString*)folderpath
{
	NSError *err=nil;
	[[NSFileManager defaultManager] createDirectoryAtPath:folderpath withIntermediateDirectories:YES attributes:nil error:&err];
	return err;
}

+(NSArray*)contentsOfDirectoryAtPath:(NSString*)folderpath
{
	NSArray *files=nil;
	NSError *error=nil;
	
	files=[[NSFileManager defaultManager] contentsOfDirectoryAtPath:folderpath error:&error];

	if(error!=nil)
		return nil;
	return files;
}

+(int) countNumberOfFilesInDir:(NSString*)folderpath
{
    NSFileManager * filemgr = [NSFileManager defaultManager];
    NSArray *filelist= [filemgr contentsOfDirectoryAtPath:folderpath error:nil];
    int count = [filelist count];
    return count;
}



/*
 *Get size for the given file
 */
+(NSNumber*) sizeForFileInBytes:(NSString*)filePath
{
	NSError *error = nil;
	
	if(![WKFileHelper isfileExisting:filePath])
		return [NSNumber numberWithInt:0];
	
	NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:&error];
	
	NSNumber *size=0;
	if (!error)
	{
		size = [attributes objectForKey:NSFileSize];		
	}
	return size;
}

/*
 *Convert Bytes to MegaBytes
 */
+(NSNumber*) convertBytesToMegaBytes:(NSNumber*)bytes
{
	NSNumber* result =[NSNumber numberWithDouble:([bytes longLongValue] / 1048576.0)];
	return result;
}

#pragma mark -
#pragma mark Application data directory
+ (NSString *)applicationDataDirectory
{
//	NSArray *applicationDataDirectories = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
//    //NSArray *applicationDataDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    
//   
//	NSString *applicationDataDirectory = [applicationDataDirectories objectAtIndex:0];
//	applicationDataDirectory = [applicationDataDirectory stringByAppendingPathComponent:@"WISFansData"];
//	//Create the directory if it not exist
//	if(![[NSFileManager defaultManager] fileExistsAtPath:applicationDataDirectory])
//	{
//		[[NSFileManager defaultManager] createDirectoryAtPath:applicationDataDirectory withIntermediateDirectories:YES attributes:nil error:nil];
//	}
    
    NSString *applicationDataDirectory = [[NSBundle mainBundle] bundlePath];
	
	return applicationDataDirectory;

    /*
    NSArray *documentDataDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //DEBUGLog(@"path = %@",[documentDataDirectories objectAtIndex:0]);
	return [documentDataDirectories objectAtIndex:0];
     */
}

+ (NSString*)pathForApplicationDataFile:(NSString*)filename
{
	NSString *applicationDataDirectory=[WKFileHelper applicationDataDirectory];
	return [applicationDataDirectory stringByAppendingPathComponent:filename];
}

+ (NSArray*)contentsOfApplicationDataDirectory
{
	return [WKFileHelper contentsOfDirectoryAtPath:[WKFileHelper applicationDataDirectory]];
}
#pragma mark -
#pragma mark Application bundle

+ (NSArray*)contentsOfApplicationBundle
{
	NSString* path = [[NSBundle mainBundle] bundlePath];
	//DEBUGLog(@"Application Bundle Path %@",path);
	NSArray *directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:NULL];
	
	return directoryContent;
}

+ (NSError*)duplicateFiletoAppDataFromBundle:(NSString*)filename overwrite:(BOOL)overwrite
{
	NSString *ext=[filename pathExtension];
	NSString *name=[filename stringByDeletingPathExtension];
	NSString *bundlepath=[[NSBundle mainBundle] pathForResource:name ofType:ext];
	
	if(bundlepath==nil)
	{
		return [NSError errorWithDomain:@"FileSystem" code:10000 userInfo:nil];
	}
	
	NSString *dataPath=[WKFileHelper pathForApplicationDataFile:filename];
	NSError *err=nil;
	if(overwrite && [WKFileHelper isfileExisting:dataPath])
	{
		err=[self removeFileAtPath:dataPath];
		if(!err)
		{
			DEBUGLog(@"Error while removing file %@",[err localizedDescription]);
		}
	}
	err=[WKFileHelper duplicateFileFromPath:bundlepath toPath:dataPath];
	return err;
}

#pragma mark -
#pragma mark Application documents

+ (NSArray*)contentsOfApplicationDocuments
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSArray* directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:NULL];
	
	return directoryContent;
}

+ (NSString*)applicationDocumentsDirectory
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return documentsDirectory;
}

+ (NSString*)pathForApplicationDataDirectory:(NSString*)filename
{
	NSString *applicationDocumentsDirectory=[WKFileHelper applicationDataDirectory];
	NSString *dataPath = [applicationDocumentsDirectory stringByAppendingPathComponent:filename];
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:dataPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return dataPath;
}

#pragma mark - Caching files 
+ (NSString*)pathForCachingFile
{
    return [WKFileHelper pathForApplicationDataDirectory:@"CachingFile"];
}

+ (void) deleteCachingFileOnSchedule
{
    // delete which older that 30days
    NSString *cachingPath = [WKFileHelper pathForCachingFile];
    
    // check folder size - delete file older than 15 days if size > 100MB
    CGFloat cacheSize = [WKFileHelper folderSize:cachingPath];
    cacheSize = cacheSize/(1024*1024);
    DEBUGLog(@"cacheSize = %f",cacheSize);
    if (cacheSize > 100) {
        [self deleteOlderFileInFolder:cachingPath withNumberOfDay:15];
        return;
    }
    
    // delete file older than 30days
    [self deleteOlderFileInFolder:cachingPath withNumberOfDay:30];
}

+ (unsigned long long int) folderSize:(NSString *)folderPath
{
    NSArray *filesArray = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:folderPath error:nil];
    NSEnumerator *filesEnumerator = [filesArray objectEnumerator];
    NSString *fileName;
    unsigned long long int fileSize = 0;
    
    while (fileName = [filesEnumerator nextObject]) {
        NSDictionary *fileDictionary = [[NSFileManager defaultManager] attributesOfItemAtPath:[folderPath stringByAppendingPathComponent:fileName] error:nil];
        fileSize += [fileDictionary fileSize];
    }
    
    return fileSize;
}

+ (void) deleteOlderFileInFolder:(NSString *)pathFolder withNumberOfDay:(int)day
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    BOOL isDir;
    NSDate *curDate = [NSDate date];
    
    NSArray *files = [fileManager contentsOfDirectoryAtPath:pathFolder error:NULL];
    for (NSString *pathFile in files) {
        pathFile = [NSString stringWithFormat:@"%@/%@",pathFolder,pathFile];
        if ([fileManager fileExistsAtPath:pathFile isDirectory:&isDir] && !isDir) {
            NSDictionary *attr = [fileManager attributesOfItemAtPath:pathFile error:NULL];
            NSDate *modDate = [attr objectForKey:NSFileModificationDate];
            modDate = [modDate dateByAddingTimeInterval:day*24*3600];
            if ([modDate compare:curDate] == NSOrderedAscending) {
                // delete that file
                [WKFileHelper removeFileAtPath:pathFile];
            }
        }
    }
    
    [fileManager release];
}

#pragma mark - non-backup flle database:

+ (void) excludePathFromICloud:(NSString*) path
{
    NSURL* url = [NSURL fileURLWithPath:path];
    
    if (SYSTEM_VERSION_LESS_THAN(@"5.1")) {
        [self addSkipBackupAttributeToItemAtURL501:url];
    }  else {
        [self addSkipBackupAttributeToItemAtURL:url];
    }
}

// iOS 5.1 and later:
+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        //NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}

//5.0.1:
+ (BOOL)addSkipBackupAttributeToItemAtURL501:(NSURL *)URL
{
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    const char* filePath = [[URL path] fileSystemRepresentation];
    
    const char* attrName = "com.apple.MobileBackup";
    u_int8_t attrValue = 1;
    
    int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
    return result == 0;
}

#pragma mark -

@end