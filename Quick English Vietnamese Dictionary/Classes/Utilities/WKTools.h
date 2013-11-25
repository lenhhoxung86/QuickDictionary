/***
 **  $Date: 2013-03-26 16:32:59 +0700 (Tue, 26 Mar 2013) $
 **  $Revision: 3506 $
 **  $Author: ChinhND $"
 **  $HeadURL: https://chinhnd@scs01.wisekey.ch:8443/svn/wiseid/iphone/trunk/SRC/Libs/WISeKey/Tools/WKTools.h $
 **  $Id: WKTools.h 3506 2013-03-26 09:32:59Z ChinhND $
 ***/

//
//  WKTools.h
//  WISeID
//
//  Created by wisekey on 6/6/11.
//  Copyright 2011 WISeKey SA, All rights reserved.
//

#import <Foundation/Foundation.h>


#pragma mark Logs

/*
 * defines a custom log tool in order to provide detailed log content with callee class name & file line number
 */
#ifdef DEBUG

		#define DEBUGLog(...) extendedLog( [NSString stringWithFormat:@"%@ (Line %d): ", NSStringFromClass([self class]), __LINE__], __VA_ARGS__ )
		#define DEBUGLogBegin(x) extendedLog( [NSString stringWithFormat:@"%@ BEGIN - ", NSStringFromClass([self class])], @#x ) 
		#define DEBUGLogEnd(x) extendedLog( [NSString stringWithFormat:@"%@ END - ", NSStringFromClass([self class])], @#x )

#else

		#define DEBUGLog(...) 
		#define DEBUGLogBegin(x)  
		#define DEBUGLogEnd(x) 

#endif

/*
 * add extended information on a classical NSLog command
 */
void extendedLog(NSString* extendedInfo, NSString* format, ...);

#pragma mark -


#pragma mark Memory Handling

/*
 * define MACRO that ensure any pointer would get properly and safely released
 */
#define RELEASE_SAFELY(__POINTER){if(__POINTER){ [__POINTER release]; __POINTER = nil;}}
#define RELEASE_SAFELY_CF(X)  { CFRelease(X); X = NULL; }

// Shorthand for getting localized strings, used in formats below for readability
#define LocStr(key) [[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:nil]

// get UIColor from rgb value
#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#pragma mark -

@interface WKTools : NSObject

/*
 * Create NSInvocation instance based on provided arguments 
 */
+ (NSInvocation*)invocationWithTarget:(id)target
							 selector:(SEL)selector
                      retainArguments:(BOOL)retainArguments
                    argumentAddresses:(void*)firstArgumentAddress, ...;

#pragma mark URL related methods

/*
 * parse provided string parameter as an NSUrl to get host name value
 */
+ (NSString*) parseDomainFromURL:(NSString*) url;

/*
 * get URL NSString path representation
 */
+ (NSString *) pathForURL:(NSURL *)url;

#pragma mark -

@end


