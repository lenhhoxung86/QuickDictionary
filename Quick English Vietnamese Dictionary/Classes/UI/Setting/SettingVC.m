//
//  SettingVC.m
//  Quick English Vietnamese Dictionary
//
//  Created by Coder on 11/5/13.
//  Copyright (c) 2013 Academic Software. All rights reserved.
//

#import "SettingVC.h"

#define kNumberOfSections           4

#define kDictionariesConst          @"Dictionaries"
#define kLanguagesConst             @"Languages"
#define kVoicesConst                @"Voices"
#define kAppInfor                   @"App Information"

#define kEnglishVietnameseDict      @"English Vietnamese Dictionary"
#define kVietnameseEnglishDict      @"Vietnamese English Dictionary"

@interface SettingVC ()

@end

@implementation SettingVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navBar.topItem.title = @"Setting";
    [self.navBar setBackgroundImage:[UIImage imageNamed:@"NavBg"] forBarMetrics:UIBarMetricsDefault];
    WKDAOManager *dao = [WKDAOFactoryManager getDaoManager:kUserDB];
    setting = [dao getSettingsInfo];
    if (setting.reversed1==nil) {
        setting.reversed1=@"-";
    }
    if (setting.reversed2==nil) {
        setting.reversed2=@"-";
    }
//    selectedIndexPath = nil;
    tbViewData = [NSMutableArray array];
    //-dictionary type
    NSDictionary *en_vn_dict = [NSDictionary dictionaryWithObjectsAndKeys:@"England",@"first_icon_key"
                                ,@"vn",@"second_icon_key"
                                ,kEnglishVietnameseDict,@"dictionary_key"
                                ,nil];
    NSDictionary *vn_en_dict = [NSDictionary dictionaryWithObjectsAndKeys:@"vn",@"first_icon_key"
                                ,@"England",@"second_icon_key"
                                ,kVietnameseEnglishDict,@"dictionary_key"
                                ,nil];
    NSArray *dicts = [NSArray arrayWithObjects:en_vn_dict,vn_en_dict, nil];
    [tbViewData addObject:dicts];
    
    //-languages
    NSDictionary *enDict = [NSDictionary dictionaryWithObjectsAndKeys:@"England",@"icon_key"
                            ,@"English",@"name"
                            ,nil];
    NSDictionary *vnDict = [NSDictionary dictionaryWithObjectsAndKeys:@"vn",@"icon_key"
                            ,@"Tiếng Việt",@"name"
                            ,nil];
    NSArray *languages = [NSArray arrayWithObjects:enDict,vnDict, nil];
    [tbViewData addObject:languages];
    
    //-voices
    NSDictionary *manDict = [NSDictionary dictionaryWithObjectsAndKeys:@"Jake",@"icon_key"
                             ,@"Jake",@"name"
                             , nil];
    NSDictionary *womanDict = [NSDictionary dictionaryWithObjectsAndKeys:@"Katherine",@"icon_key"
                             ,@"Katherine",@"name"
                             , nil];
    NSArray *voices = [NSArray arrayWithObjects:manDict,womanDict, nil];
    [tbViewData addObject:voices];
    
    //-app info
    NSDictionary *aboutDict = [NSDictionary dictionaryWithObjectsAndKeys:@"Info",@"icon_key"
                               ,@"About",@"name"
                               , nil];
    NSDictionary *purchaseDict = [NSDictionary dictionaryWithObjectsAndKeys:@"payment-icon",@"icon_key"
                               ,@"Remove Ad",@"name"
                               , nil];
    NSArray *appInfo = [NSArray arrayWithObjects:aboutDict,purchaseDict, nil];
    [tbViewData addObject:appInfo];
}

- (void)viewWillDisappear:(BOOL)animated {
//    WKDAOManager *dao = [WKDAOFactoryManager getDaoManager:kUserDB];
//    [dao update:setting];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource and UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [tbViewData count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sectionData = (NSArray*)[tbViewData objectAtIndex:section];
    return [sectionData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *DictionaryCellIdentifier = @"DictionaryCell";
    static NSString *GeneralCellIdentifier = @"GeneralCell";
    UITableViewCell *dictCell = [tableView dequeueReusableCellWithIdentifier:DictionaryCellIdentifier];
    UITableViewCell *generalCell = [tableView dequeueReusableCellWithIdentifier:GeneralCellIdentifier];
    
    UIImageView *sourceDict = (UIImageView*)[[dictCell contentView] viewWithTag:1];
    UIImageView *targetDict = (UIImageView*)[[dictCell contentView] viewWithTag:2];
    UILabel *dictTitle = (UILabel*)[[dictCell contentView] viewWithTag:3];
    
    UIImageView *cellImage = (UIImageView*)[[generalCell contentView] viewWithTag:1];
    UILabel *generalTitle = (UILabel*)[[generalCell contentView] viewWithTag:2];
    
    NSArray *sectionData = (NSArray*)[tbViewData objectAtIndex:indexPath.section];
    NSDictionary *rowDict = (NSDictionary*)[sectionData objectAtIndex:indexPath.row];
    if (indexPath.section==0) {
        [sourceDict setImage:[UIImage imageNamed:[rowDict objectForKey:@"first_icon_key"]]];
        [targetDict setImage:[UIImage imageNamed:[rowDict objectForKey:@"second_icon_key"]]];
        dictTitle.text = [rowDict objectForKey:@"dictionary_key"];
        if (([setting.dictionary_type isEqualToString:@"ev"] && (indexPath.row==0)) || ([setting.dictionary_type isEqualToString:@"ve"] && (indexPath.row==1))) {
            dictCell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            dictCell.accessoryType = UITableViewCellAccessoryNone;
        }
        return dictCell;
    } else {
        [cellImage setImage:[UIImage imageNamed:[rowDict objectForKey:@"icon_key"]]];
        [generalTitle setText:[rowDict objectForKey:@"name"]];
        if (indexPath.section==1) {
            if (([[setting.language lowercaseString] isEqualToString:[[rowDict objectForKey:@"name"] lowercaseString]])) {
                generalCell.accessoryType = UITableViewCellAccessoryCheckmark;
            } else {
                generalCell.accessoryType = UITableViewCellAccessoryNone;
            }
        } else if (indexPath.section==2) {
            if (([[setting.voice lowercaseString] isEqualToString:[[rowDict objectForKey:@"name"] lowercaseString]])) {
                generalCell.accessoryType = UITableViewCellAccessoryCheckmark;
            } else {
                generalCell.accessoryType = UITableViewCellAccessoryNone;
            }
        } else {
            generalCell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        return generalCell;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return kDictionariesConst;
    } else if (section==1) {
        return kLanguagesConst;
    } else if (section==2) {
        return kVoicesConst;
    } else {
        return kAppInfor;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section!=3) {
        NSArray *sectionData = (NSArray*)[tbViewData objectAtIndex:indexPath.section];
        NSDictionary *rowDict = (NSDictionary*)[sectionData objectAtIndex:indexPath.row];
        UITableViewCell *selectedCell = (UITableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
        selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
        if (indexPath.section==0) {
            if (indexPath.row==0) {
                setting.dictionary_type=@"ev";
            } else {
                setting.dictionary_type=@"ve";
            }
        } else if(indexPath.section==1) {
            setting.language = [rowDict objectForKey:@"name"];
        } else if (indexPath.section==2) {
            setting.voice = [rowDict objectForKey:@"name"];
        }
        if (indexPath.row==0) {
            NSIndexPath *unselectedIndexPath = [NSIndexPath indexPathForRow:1 inSection:indexPath.section];
            UITableViewCell *unselectedCell = (UITableViewCell*)[tableView cellForRowAtIndexPath:unselectedIndexPath];
            unselectedCell.accessoryType = UITableViewCellAccessoryNone;
        } else {
            NSIndexPath *unselectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
            UITableViewCell *unselectedCell = (UITableViewCell*)[tableView cellForRowAtIndexPath:unselectedIndexPath];
            unselectedCell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        WKDAOManager *dao = [WKDAOFactoryManager getDaoManager:kUserDB];
        [dao update:setting];
    } else {
        //-do stuff for in-app purchase and about information
//        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if (indexPath.row==0) {
            [self performSegueWithIdentifier:@"ShowAbout" sender:self];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
