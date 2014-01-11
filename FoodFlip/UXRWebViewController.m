//
//  UXRWebViewController.m
//  FMag
//
//  Created by Rex St. John on 12/26/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRWebViewController.h"

@interface UXRWebViewController ()
@property(nonatomic,strong) NSURL *urlToLoad;
@end

@implementation UXRWebViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    NSURLRequest *request = [NSURLRequest requestWithURL:self.urlToLoad];
    [self.webView loadRequest:request];
}

-(void)navigateToURL:(NSURL*)url{
    self.urlToLoad = url;
}

#pragma mark - UIWebViewDelegate


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
}

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    
    return YES;
}

@end
