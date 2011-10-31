//
//  StartupCommand.m
//  TIPlanet
//
/* 
 * 
 * @author        Adriweb - Original from Jens Krause [www.websector.de]    
 * @date          31/08/2011
 *   
 */


#import "StartupCommand.h"
#import "BlogProxy.h"
#import "RootViewMediator.h"
#import "PostViewMediator.h"
#import "RootViewController.h"

@implementation StartupCommand

-(void)execute:(id<INotification>)notification 
{
	//
	// register proxies
	BlogProxy *blogProxy = [BlogProxy proxy];
	[facade registerProxy: blogProxy];
	
	//
	// register mediators
	RootViewController *rootView = [notification body];
	[facade registerMediator: [RootViewMediator withViewComponent: rootView]];
	[facade registerMediator: [PostViewMediator withViewComponent: rootView.postViewController]];
	
	//
	// get first data
	[blogProxy getAllEntries];
}

@end
