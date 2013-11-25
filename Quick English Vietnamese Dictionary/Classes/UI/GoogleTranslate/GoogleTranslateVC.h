//
//  GoogleTranslateVCViewController.h
//  Quick English Vietnamese Dictionary
//
//  Created by Coder on 11/5/13.
//  Copyright (c) 2013 Academic Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoogleTranslateVC : UIViewController<UIWebViewDelegate> {
    BOOL fWebviewLoadedForTheFirstTime;
}

@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;
@property (strong, nonatomic) IBOutlet UIButton *refreshBtn;
@property (strong, nonatomic) IBOutlet UIWebView *gtWebView;
- (IBAction)btnRefreshTapped:(id)sender;
@end
