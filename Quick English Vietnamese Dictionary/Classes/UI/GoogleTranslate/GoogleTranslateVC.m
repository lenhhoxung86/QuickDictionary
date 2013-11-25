//
//  GoogleTranslateVCViewController.m
//  Quick English Vietnamese Dictionary
//
//  Created by Coder on 11/5/13.
//  Copyright (c) 2013 Academic Software. All rights reserved.
//

#import "GoogleTranslateVC.h"
#import "MBProgressHUD.h"
#import "SVProgressHUD.h"
#import "ASIHTTPRequest.h"

@interface GoogleTranslateVC ()

@end

@implementation GoogleTranslateVC

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
    self.navBar.topItem.title = @"Google Translate";
    [self.navBar setBackgroundImage:[UIImage imageNamed:@"NavBg"] forBarMetrics:UIBarMetricsDefault];
    fWebviewLoadedForTheFirstTime = NO;
	[self.gtWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://translate.google.com.vn"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebviewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (!fWebviewLoadedForTheFirstTime) {
        [SVProgressHUD showWithStatus:@"Loading..." maskType:SVProgressHUDMaskTypeClear];
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {

}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if (!fWebviewLoadedForTheFirstTime) {
        [SVProgressHUD dismiss];
        fWebviewLoadedForTheFirstTime = YES;
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if (!fWebviewLoadedForTheFirstTime) {
        fWebviewLoadedForTheFirstTime = YES;
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"Error: %@",error.description]];
    }
}

- (IBAction)btnRefreshTapped:(id)sender {
    [self.gtWebView reload];
}
@end
