//
//  ChatViewController.m
//  TI-Planet iOS
//
//  Created by Adrien Bertrand on 01/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ChatViewController.h"

@implementation ChatViewController

@synthesize pageTitle;

- (instancetype)init
{
    self = [super init];
    return self;
}

-(void)viewDidLoad {
    ChatWebView.delegate = self;
    [ChatWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://tiplanet.org/forum/chat/"]]];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    UIApplication* app = [UIApplication sharedApplication]; app.networkActivityIndicatorVisible = YES;
    pageTitle.title = @"Chargement...";
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *titleStr = [ChatWebView stringByEvaluatingJavaScriptFromString:@"document.title"];
    UIApplication* app = [UIApplication sharedApplication]; app.networkActivityIndicatorVisible = NO;
    pageTitle.title = titleStr;
    int theWidth = [UIScreen mainScreen].bounds.size.width;
    pageTitle.width = 0.81*theWidth;
}


@end
