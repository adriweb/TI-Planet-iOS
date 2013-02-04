//
//  TIPlanetAppDelegate.m
//  TIPlanet
//
/* 
 * 
 * @author        Adriweb - Original from Jens Krause [www.websector.de]    
 * @date          31/08/2011
 *   
 */


#import "TIPlanetAppDelegate.h"

#import "RootViewController.h"
#import "ApplicationFacade.h"
#import "Reachability.h"


@implementation TIPlanetAppDelegate

@synthesize window, nav, tabBarController;

- (void)dealloc 
{
	[nav release];
    [window release];
    [tabBarController release];
    [super dealloc];
}


- (void)applicationDidFinishLaunching:(UIApplication *)application 
{
	RootViewController *rootView = [RootViewController rootViewController];
	nav = [[UINavigationController alloc] initWithRootViewController: rootView];
    
	nav.tabBarController.title = @"NewsTitle";
    nav.tabBarController.tabBarItem.title = @"NewsTabTitle";
    
    NSMutableArray *viewArrays;
    
    viewArrays = [NSMutableArray arrayWithArray:tabBarController.viewControllers];
    [viewArrays replaceObjectAtIndex:0 withObject:nav];
           
    tabBarController.viewControllers = viewArrays;
    
    UIViewController *tab1 = [viewArrays objectAtIndex:0];
    tab1.tabBarItem.title = @"News";
    tab1.tabBarItem.image = [UIImage imageNamed:@"feed.png"];

    UIViewController *tab4 = [viewArrays objectAtIndex:3];
    tab4.tabBarItem.image = [UIImage imageNamed:@"info.png"];
    
    [window addSubview: tabBarController.view];

    [window makeKeyAndVisible];
    
    Reachability *r = [Reachability reachabilityWithHostName:@"www.google.com"];
	NetworkStatus internetStatus = [r currentReachabilityStatus];
	
	if ((internetStatus != ReachableViaWiFi) && (internetStatus != ReachableViaWWAN))
	{
		UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Pas de connexion Internet"
                                                          message:@"Une connexion internet via Wifi ou Réseau cellulaire (GPRS/EDGE/3G) est requise."
                                                         delegate:self
                                                cancelButtonTitle:@"Ok"
                                                otherButtonTitles:nil];
		[myAlert show];
		[myAlert release];
	}
    
    [[ApplicationFacade getInstance] startup: rootView];
}


@end
