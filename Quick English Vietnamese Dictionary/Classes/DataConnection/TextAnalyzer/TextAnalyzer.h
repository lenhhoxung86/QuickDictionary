//
//  TextAnalyzer.h
//  Quick English Vietnamese Dictionary
//
//  Created by Coder on 11/20/13.
//  Copyright (c) 2013 Academic Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DictionaryData.h"

@interface TextAnalyzer : NSObject {
    
}
@property (nonatomic, retain) NSString *filePath;
+ (TextAnalyzer*)sharedInstance;
- (NSArray*)meaningsFromDictionaryRecords:(NSArray*)records ofType:(NSInteger)type;

@end
