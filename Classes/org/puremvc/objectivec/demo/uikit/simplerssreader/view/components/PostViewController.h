//
//  PostViewController.h
//  TIPlanet
//
/* 
 * 
 * @author        Adriweb - Original from Jens Krause [www.websector.de]    
 * @date          31/08/2011
 *   
 */


#import <UIKit/UIKit.h>
#import "EntryVO.h"
#import <MessageUI/MessageUI.h>

@interface PostViewController : UIViewController <UIWebViewDelegate, UIActionSheetDelegate>
{
	IBOutlet UIWebView *webView;
    __unsafe_unretained NSString *articleURL;
    __unsafe_unretained NSString *articleTitle;
    NSString *storedStringForWebView;
}

+(PostViewController *)postViewController;

-(void)newBlogEntry:(EntryVO *) data;
-(void)hideGradientBackground:(UIView*)theView;

@property (nonatomic, assign) NSString *articleURL;
@property (nonatomic, assign) NSString *articleTitle;
@property (nonatomic, assign) NSString *storedStringForWebView;


@end
