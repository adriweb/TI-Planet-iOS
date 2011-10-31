//
//  ChatViewController.h
//  TI-Planet iOS
//
//  Created by Adrien Bertrand on 01/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatViewController : UIViewController <UIWebViewDelegate> {

    IBOutlet UIWebView  *ChatWebView;
    IBOutlet UIBarButtonItem *pageTitle;
}

@property(nonatomic,retain) IBOutlet UIBarButtonItem *pageTitle;

@end
