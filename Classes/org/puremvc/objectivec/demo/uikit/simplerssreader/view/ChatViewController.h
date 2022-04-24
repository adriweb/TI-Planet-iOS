//
//  ChatViewController.h
//  TI-Planet iOS
//
//  Created by Adrien Bertrand on 01/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface ChatViewController : UIViewController <WKNavigationDelegate> {

    IBOutlet WKWebView  *ChatWebView;
    IBOutlet UIBarButtonItem *pageTitle;
}

@property(nonatomic,retain) IBOutlet UIBarButtonItem *pageTitle;

@end
