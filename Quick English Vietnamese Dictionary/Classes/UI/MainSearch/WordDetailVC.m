//
//  WordDetailVC.m
//  Quick English Vietnamese Dictionary
//
//  Created by Coder on 11/8/13.
//  Copyright (c) 2013 Academic Software. All rights reserved.
//

#import "WordDetailVC.h"
#import "WKDAOFactoryManager.h"
#import "WKDAOManager+DictionaryFav.h"
#import "TextAnalyzer.h"
#import "SettingData.h"
#import "DictionaryFavData.h"
#import "WKDAOManager+SettingInfo.h"
#import "WKDAOManager+DictionaryFav.h"

#define favoriteTag         1
#define normalTag           2

@interface WordDetailVC ()

@end

@implementation WordDetailVC

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
    //-get text data here
    self.navBar.topItem.title = self.wordReference.word_str;
    [self.navBar setBackgroundImage:[UIImage imageNamed:@"NavBg"] forBarMetrics:UIBarMetricsDefault];
    WKDAOManager *user_dao = [WKDAOFactoryManager getDaoManager:kUserDB];
    SettingData *settingData = [user_dao getSettingsInfo];
    mode = EVDict;
    if ([[settingData.dictionary_type lowercaseString] isEqualToString:@"ev"]) {
        mode = EVDict;
        NSArray *dataArray = [[TextAnalyzer sharedInstance] meaningsFromDictionaryRecords:[NSArray arrayWithObjects:self.wordReference, nil] ofType:1];
        NSString *fullDescription = @"";
        if (dataArray.count>0) {
            for (NSString *description in dataArray) {
                fullDescription = [fullDescription stringByAppendingString:description];
            }
        }
        self.wordDescriptionTV.text = fullDescription;
    } else if ([[settingData.dictionary_type lowercaseString] isEqualToString:@"ve"]) {
        mode = VEDict;
        NSArray *dataArray = [[TextAnalyzer sharedInstance] meaningsFromDictionaryRecords:[NSArray arrayWithObjects:self.wordReference, nil] ofType:2];
        NSString *fullDescription = @"";
        if (dataArray.count>0) {
            for (NSString *description in dataArray) {
                fullDescription = [fullDescription stringByAppendingString:description];
            }
        }
        self.wordDescriptionTV.text = fullDescription;
    }
    
    //-setup star status button
    if ([user_dao isFavorite:self.wordReference.word_str]) {
        [self.btnFavorite setImage:[UIImage imageNamed:@"star_active"] forState:UIControlStateNormal];
        self.btnFavorite.tag = favoriteTag;
    } else {
        [self.btnFavorite setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
        self.btnFavorite.tag = normalTag;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnBackTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnFavoriteTapped:(id)sender {
    DictionaryFavData *favData = [[DictionaryFavData alloc] init];
    favData.word_str = self.wordReference.word_str;
    favData.word_data_offset = self.wordReference.word_data_offset;
    favData.word_data_size = self.wordReference.word_data_size;
    favData.type = (mode==EVDict)?@"ev":@"ve";
    WKDAOManager *user_dao = [WKDAOFactoryManager getDaoManager:kUserDB];
    if (self.btnFavorite.tag==favoriteTag) {
        self.btnFavorite.tag=normalTag;
        [self.btnFavorite setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
        //-remove from favorite list
        [user_dao del:favData];
    } else {
        self.btnFavorite.tag=favoriteTag;
        [self.btnFavorite setImage:[UIImage imageNamed:@"star_active"] forState:UIControlStateNormal];
        //-add to favorite list
        [user_dao insert:favData];
    }
}

@end
