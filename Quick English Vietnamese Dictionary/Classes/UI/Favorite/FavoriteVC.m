//
//  SecondViewController.m
//  Quick English Vietnamese Dictionary
//
//  Created by Coder on 11/5/13.
//  Copyright (c) 2013 Academic Software. All rights reserved.
//

#import "FavoriteVC.h"
#import "WordDetailVC.h"
#import "WKDAOFactoryManager.h"
#import "WKDAOManager+DictionaryFav.h"
#import "WKDAOManager+SettingInfo.h"
#import "SettingData.h"

@interface FavoriteVC ()

@end

@implementation FavoriteVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.mode = -1;
    self.navBar.topItem.title = @"Favorites";
    [self.navBar setBackgroundImage:[UIImage imageNamed:@"NavBg"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    WKDAOManager *dao = [WKDAOFactoryManager getDaoManager:kUserDB];
    
    SettingData *setting = [dao getSettingsInfo];
    if ([setting.dictionary_type isEqualToString:@"ev"]) {
        self.mode = EVDict;
    } else {
        self.mode = VEDict;
    }
    
    wordRefArray = [dao getAllFavoriteEntries];
    favoriteBlocks = [[NSMutableArray alloc] init];
    [self filterWithAlphabetChars:wordRefArray];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITAbleViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *favoriteWords = (NSArray*)[favoriteBlocks objectAtIndex:section];
    return [favoriteWords count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:12];
    }
    NSArray *favoriteWords = (NSArray*)[favoriteBlocks objectAtIndex:indexPath.section];
    cell.textLabel.text = [(DictionaryFavData*)[favoriteWords objectAtIndex:indexPath.row] word_str];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [favoriteBlocks count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSArray *favoriteWords = (NSArray*)[favoriteBlocks objectAtIndex:section];
    DictionaryFavData *firstElement = (DictionaryFavData*)[favoriteWords objectAtIndex:0];
    if (firstElement) {
        return [[firstElement.word_str substringToIndex:1] uppercaseString];
    } else {
        return @"";
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *favoriteWords = (NSArray*)[favoriteBlocks objectAtIndex:indexPath.section];
    wordRef = [favoriteWords objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"ShowWord" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    id destinationVC = segue.destinationViewController;
    if ([destinationVC isKindOfClass:[WordDetailVC class]]) {
        DictionaryData *dicDataRef = [[DictionaryData alloc] init];
        dicDataRef.word_str = wordRef.word_str;
        dicDataRef.word_data_offset = wordRef.word_data_offset;
        dicDataRef.word_data_size = wordRef.word_data_size;
        //-only show favorite words of current dictionary type
        [(WordDetailVC*)destinationVC setWordReference:dicDataRef];
    }
}

#pragma mark - private methods
/**
 *  This method will filter the input array with alphabetical characters from a to z
 */
- (void)filterWithAlphabetChars:(NSArray*)wordsRef {
    [favoriteBlocks removeAllObjects];
    NSString *filterDictKey = @"";
    if (self.mode==EVDict) {
        filterDictKey = @"ev";
    } else {
        filterDictKey = @"ve";
    }

    for (int start_index=97; start_index<=122; start_index++) {
        NSString *filterChar = [NSString stringWithFormat:@"%c",start_index];
        NSArray *ablock = [wordRefArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"word_str beginswith [cd] %@ and type contains [cd] %@",filterChar,filterDictKey]];
        if (ablock && (ablock.count>0)) {
            [favoriteBlocks addObject:ablock];
        }
    }
    [self.favTableView reloadData];
}

@end
