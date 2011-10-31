//
//  ForumViewController.m
//  TI-Planet iOS
//
//  Created by Adrien Bertrand on 01/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ForumViewController.h"

@implementation ForumViewController

- (id)init
{
    self = [super init];
    return self;
}

-(void)viewDidLoad {
    forumWebView.delegate = self;
    [forumWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.tiplanet.org/forum/"]]];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    UIApplication* app = [UIApplication sharedApplication]; app.networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    UIApplication* app = [UIApplication sharedApplication]; app.networkActivityIndicatorVisible = NO;
}

- (void) dealloc {
    [super dealloc];
}
   
@end
