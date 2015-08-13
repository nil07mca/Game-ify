//
//  BrowserViewController.m
//  Game-ify
//
//  Created by sadmin on 8/13/15.
//  Copyright (c) 2015 Niladri. All rights reserved.
//

#import "BrowserViewController.h"

@interface BrowserViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *busyIndicator;

@end

@implementation BrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.articleURL]];
    [self.webView setUserInteractionEnabled:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - UIAction
- (IBAction)articleClosed:(id)sender {
    [self.webView stopLoading];
    [self.busyIndicator stopAnimating];
    [self dismissViewControllerAnimated:YES completion:^{
        ;
    }];
}


#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.webView setUserInteractionEnabled:YES];
    [self.busyIndicator stopAnimating];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    [self.busyIndicator startAnimating];
    return YES;
}

@end
