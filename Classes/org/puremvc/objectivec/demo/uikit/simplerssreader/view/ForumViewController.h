//
//  ForumViewController.h
//  TI-Planet iOS
//
//  Created by Adrien Bertrand on 01/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface ForumViewController : UIViewController <WKNavigationDelegate> {

    IBOutlet WKWebView  *forumWebView;
}


@end
