//
//  FirstViewController.m
//  Quick English Vietnamese Dictionary
//
//  Created by Coder on 11/5/13.
//  Copyright (c) 2013 Academic Software. All rights reserved.
//

#import "MainSearchVC.h"
#import "WordDetailVC.h"
#import "WKDAOFactoryManager.h"
#import "WKDAOManager+SettingInfo.h"
#import "SettingData.h"
#import "DictionaryData.h"

@interface MainSearchVC ()

@end

@implementation MainSearchVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    selectedIndex = -1;
    searchResults = [[NSMutableArray alloc] init];
    self.navBar.topItem.title = @"Search word";
    [self.navBar setBackgroundImage:[UIImage imageNamed:@"NavBg"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidAppear:(BOOL)animated {
    WKDAOManager *setting_dao = [WKDAOFactoryManager getDaoManager:kUserDB];
    NSString *dictType = [(SettingData*)[setting_dao getSettingsInfo] dictionary_type];
    if ([dictType isEqualToString:@"ev"]) {
        self.dao = [WKDAOFactoryManager getDaoManager:kDictE_VTypeDB];
    } else if ([dictType isEqualToString:@"ve"]) {
        self.dao = [WKDAOFactoryManager getDaoManager:kDictV_ETypeDB];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    id destinationVC = segue.destinationViewController;
    if ([destinationVC isKindOfClass:[WordDetailVC class]]) {
        DictionaryData *refData = [searchResults objectAtIndex:selectedIndex];
        [(WordDetailVC*)destinationVC setWordReference:refData];
    }
}

#pragma mark - private methods
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    DEBUGLog(@"search text: %@",searchText);
    [searchResults removeAllObjects];
    NSArray *records = [self.dao searchWordsByKeyword:searchText];
    [searchResults addObjectsFromArray:records];
    [self.searchDisplayController.searchResultsTableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [searchResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"SearchCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:12];
    }
    DictionaryData *data = [searchResults objectAtIndex:indexPath.row];
    cell.textLabel.text = data.word_str;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //-handle action here
    selectedIndex = indexPath.row;
    [self performSegueWithIdentifier:@"ShowWord" sender:self];
}

#pragma mark - UISearchDisplayController
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return YES;
}

@end
