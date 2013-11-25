//
//  SettingVC.h
//  Quick English Vietnamese Dictionary
//
//  Created by Coder on 11/5/13.
//  Copyright (c) 2013 Academic Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKDAOManager+SettingInfo.h"
#import "SettingData.h"
#import "WKDAOFactoryManager.h"

@interface SettingVC : UIViewController<UITableViewDataSource,UITableViewDelegate> {
    NSMutableArray *tbViewData;
//    NSIndexPath *selectedIndexPath;
    SettingData *setting;
}
@property (strong, nonatomic) IBOutlet UITableView *settingTbView;
@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;

@end
