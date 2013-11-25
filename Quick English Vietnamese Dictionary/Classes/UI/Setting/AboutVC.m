//
//  AboutVC.m
//  Quick English Vietnamese Dictionary
//
//  Created by Coder on 11/22/13.
//  Copyright (c) 2013 Academic Software. All rights reserved.
//

#import "AboutVC.h"
#import "UIDeviceHardware.h"
@implementation AboutVC
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
    self.navBar.topItem.title = @"About";
    [self.navBar setBackgroundImage:[UIImage imageNamed:@"NavBg"] forBarMetrics:UIBarMetricsDefault];
    self.appInfoTextView.textAlignment = NSTextAlignmentCenter;
    self.appInfoTextView.text = @"Quick Dictionary\nVersion 1.0\nAuthor: tiendh\nEmail: tiendh11986@gmail.com";
    self.background.image = [UIImage imageNamed:@"iphone5bg"];
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
- (IBAction)btnDoneTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)btnFeedbackTapped:(id)sender {
    [self sendMail];
}

- (void)sendMail
{
    MFMailComposeViewController *mailComposerVC = [[MFMailComposeViewController alloc] init];
    if ([MFMailComposeViewController canSendMail]) {
        mailComposerVC.mailComposeDelegate = self;
        [mailComposerVC setSubject: @"Quick Dictionary Feedback"];
        
        // Get Bundle Info
        NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
        NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
        
        // Get the users Device Model, Version Number
        UIDevice *dev = [UIDevice currentDevice];
        NSString *deviceSystemVersion = dev.systemVersion;
        
        //NSString *deviceModel = [dev.model stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        UIDeviceHardware *deviceHardware = [[UIDeviceHardware alloc] init];
        NSString *deviceModel = [deviceHardware platformString];
        
        NSString *bodyEmail = [NSString stringWithFormat:@"App name: %@ \nApp version: %@ \nDevice: %@ \nOS version: %@", appName, appVersion, deviceModel, deviceSystemVersion];
        
        [mailComposerVC setMessageBody:bodyEmail isHTML:NO];
        [mailComposerVC setToRecipients: [NSArray arrayWithObject: @"tiendh11986@gmail.com" ]];//
        [self presentViewController:mailComposerVC animated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You have not configured your email account" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    
	[self dismissViewControllerAnimated:YES completion:nil];
    
    if (result == MFMailComposeResultSent) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Your email sent successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    } else if(result == MFMailComposeResultFailed) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send email" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}

@end
