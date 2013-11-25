//
//  SecondViewController.h
//  Quick English Vietnamese Dictionary
//
//  Created by Coder on 11/5/13.
//  Copyright (c) 2013 Academic Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DictionaryFavData.h"
#import "DictionaryData.h"
#import "WordDetailVC.h"

@interface FavoriteVC : UIViewController<UITableViewDataSource,UITableViewDelegate> {
    NSMutableArray *favoriteBlocks;
    NSArray *wordRefArray;
    DictionaryFavData *wordRef;
}
@property (strong, nonatomic) IBOutlet UITableView *favTableView;
@property (nonatomic, assign) enum DictionaryMode mode;
@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;
@end
