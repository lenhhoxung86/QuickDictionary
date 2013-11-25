//
//  FirstViewController.h
//  Quick English Vietnamese Dictionary
//
//  Created by Coder on 11/5/13.
//  Copyright (c) 2013 Academic Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DictionaryData.h"
#import "WKDAOManager+Dictionary.h"

@interface MainSearchVC : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate> {
    NSMutableArray *searchResults;
    NSInteger selectedIndex;
}

@property (strong, nonatomic) IBOutlet UILabel *dictionaryTypeLb;
@property (strong, nonatomic) WKDAOManager *dao;
@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;
@end
