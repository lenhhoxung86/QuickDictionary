//
//  AboutVC.h
//  Quick English Vietnamese Dictionary
//
//  Created by Coder on 11/22/13.
//  Copyright (c) 2013 Academic Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface AboutVC : UIViewController<MFMailComposeViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;
@property (strong, nonatomic) IBOutlet UITextView *appInfoTextView;
- (IBAction)btnDoneTapped:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *background;
- (IBAction)btnFeedbackTapped:(id)sender;

@end
