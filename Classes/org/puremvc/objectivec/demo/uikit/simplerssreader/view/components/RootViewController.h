//
//  RootViewController.h
//  TIPlanet
//
/* 
 * 
 * @author        Adriweb - Original from Jens Krause [www.websector.de]    
 * @date          31/08/2011
 *   
 */


#import <UIKit/UIKit.h>
#import "PostViewController.h"
#import "EntryVO.h"
#import "PullRefreshTableViewController.h"

@protocol RootViewControllerDelegate

-(void)getBlogEntries;
-(void)getBlogEntry:(NSUInteger)blogId;

@end


@interface RootViewController : PullRefreshTableViewController
{	
	PostViewController *postViewController;
	NSMutableArray *blogEntries;
	id<RootViewControllerDelegate> delegate;
	UIActivityIndicatorView *feedLoader;
    UIImageView *imageView;
}

@property(nonatomic, retain) PostViewController *postViewController;
@property(nonatomic, retain) id<RootViewControllerDelegate> delegate;
@property(nonatomic, retain) UIImageView *imageView;


+(RootViewController *)rootViewController;

-(void)killSplashScreen;
-(void)showBlogEntry;
-(void)getBlogEntries;
-(void)showBlogEntries:(NSMutableArray *)data;
-(void)showLoader;
-(void)hideLoader;


@end

