//
//  UXRWebViewController.h
//  FMag
//
//  Created by Rex St. John on 12/26/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UXRWebViewController : GAITrackedViewController <UIWebViewDelegate>
@property(nonatomic,strong) IBOutlet UIWebView *webView;

-(void)navigateToURL:(NSURL*)url;

@end
