//
//  WordDetailVC.h
//  Quick English Vietnamese Dictionary
//
//  Created by Coder on 11/8/13.
//  Copyright (c) 2013 Academic Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DictionaryData.h"

enum DictionaryMode {
    EVDict = 1,
    VEDict = 2
    };
@interface WordDetailVC : UIViewController {
    enum DictionaryMode mode;
}

@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;
@property (strong, nonatomic) IBOutlet UITextView *wordDescriptionTV;
@property (strong, nonatomic) IBOutlet UIButton *btnFavorite;
@property (strong, nonatomic) DictionaryData *wordReference;
- (IBAction)btnBackTapped:(id)sender;
- (IBAction)btnFavoriteTapped:(id)sender;
@end
