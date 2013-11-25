/***
 **  $Date: 2013-03-26 16:32:59 +0700 (Tue, 26 Mar 2013) $
 **  $Revision: 3506 $
 **  $Author: ChinhND $
 **  $HeadURL: https://chinhnd@scs01.wisekey.ch:8443/svn/wiseid/iphone/trunk/SRC/Libs/WISeKey/Tools/WKTools.m $
 **  $Id: WKTools.m 3506 2013-03-26 09:32:59Z ChinhND $
***/
//
//  WKTools.m
//  WISeID
//
//  Created by wisekey on 6/6/11.
//  Copyright 2011 WISeKey SA, All rights reserved.
//

#import "WKTools.h"
//#import "WISeIDAppDelegate.h"
#import "WKFileHelper.h"

@implementation WKTools

#pragma mark Logs

/*
 * add extended information on a classical NSLog command
 */
void extendedLog(NSString* extendedInfo, NSString* format, ...)
{
	va_list argumentList;
	va_start(argumentList, format);
	
	NSLogv([extendedInfo stringByAppendingString:format], argumentList);
	
	va_end(argumentList);
}

#pragma mark -
#pragma mark Common Utils Methods

/*
 * Create NSInvocation instance based on provided arguments 
 */
+ (NSInvocation*)invocationWithTarget:(id)target
							 selector:(SEL)selector
                      retainArguments:(BOOL)retainArguments
                    argumentAddresses:(void*)firstArgumentAddress, ...
{
	//- compute target method signature
	NSMethodSignature *sig = [target methodSignatureForSelector:selector];
	NSInvocation* _invocation = [NSInvocation invocationWithMethodSignature:sig];
	//- apply provided flags
	[_invocation setTarget:target];
	[_invocation setSelector:selector];
	if(retainArguments && firstArgumentAddress != nil){
		[_invocation retainArguments];
	}
	
	//- The first argument isn't part of the varargs list,
	if (firstArgumentAddress) 
	{ 
		//- so we'll handle it separately.
		id eachObject = firstArgumentAddress;
		//- get target method signature count
		int argCount = [sig numberOfArguments];
		int i = 2; //- start seek index at 2 to handle hidden objects _self & _cmd 
		va_list argumentList;
		//- Start scanning for arguments after firstArgumentAddress.
		va_start(argumentList, firstArgumentAddress); 
		//- As many times as we can get an argument of type "id" .. based on argCount as default behavior doesn't seems to work properly
		while (i < argCount) 
		{
			//- add object reference to invocation object
			[_invocation setArgument:eachObject atIndex:i]; 
			eachObject = va_arg(argumentList, id);
			i++;
		}
		//- properly close argumnetList pointer
		va_end(argumentList);
	}
	return _invocation;
}

#pragma mark -

#pragma mark URL related methods 

/*
 * parse provided string parameter as an NSUrl to get host name value
 */
+ (NSString*) parseDomainFromURL:(NSString*) url
{
	NSString* domain = nil;
	
	if( [url length] > 0 )
	{
		//- Use NSURL's -host method to get the scheme and path/query stripped correctly.
		NSURL* parsed = [NSURL URLWithString: url];
		NSString* host = [parsed host];
		
		if( host )
		{
			//- Use NSString's -componentsSeparatedByString: method to get an array of the domain name's "components".
			NSArray* components = [host componentsSeparatedByString:@"."];
			
			int count = [components count];
			
			switch (count) {
				case 1:
				case 2:
					domain = host;
					break;
				default:
					domain = [NSString stringWithFormat:@"%@.%@", [components objectAtIndex:count-2], [components objectAtIndex:count-1] ];
					break;
			}
		}
	}
	
	//- return computed domain value
	return domain;
}

/*
 * get URL NSString path representation
 */
+ (NSString *)pathForURL:(NSURL *)url 
{
    return (url) 
	? ( [url isFileURL] ? [url path]:[url absoluteString] )
    : nil;
}

#pragma mark -
@end