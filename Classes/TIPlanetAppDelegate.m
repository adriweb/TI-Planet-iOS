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


- (void)applicationDidFinishLaunching:(UIApplication *)application
{
    RootViewController *rootView = [RootViewController rootViewController];
    nav = [[UINavigationController alloc] initWithRootViewController: rootView];
    
    nav.tabBarController.title = @"NewsTitle";
    nav.tabBarController.tabBarItem.title = @"NewsTabTitle";
    
    NSMutableArray *viewArrays;
    
    viewArrays = [NSMutableArray arrayWithArray:tabBarController.viewControllers];
    viewArrays[0] = nav;
    
    tabBarController.viewControllers = viewArrays;
    
    UIViewController *tab1 = viewArrays[0];
    tab1.tabBarItem.title = @"News";
    tab1.tabBarItem.image = [UIImage imageNamed:@"feed.png"];

    UIViewController *tab2 = viewArrays[1];
    tab2.tabBarItem.image = [UIImage imageNamed:@"info.png"];
    
    [window addSubview:tabBarController.view];
    window.rootViewController = tabBarController;
    [window makeKeyAndVisible];
    
    Reachability *r = [Reachability reachabilityWithHostName:@"www.google.com"];
    NetworkStatus internetStatus = [r currentReachabilityStatus];
    
    if ((internetStatus != ReachableViaWiFi) && (internetStatus != ReachableViaWWAN))
    {
        UIAlertController * myAlert = [UIAlertController
                        alertControllerWithTitle:@"Pas de connexion Internet"
                                         message:@"Une connexion internet via Wifi ou Réseau cellulaire est requise."
                                  preferredStyle:UIAlertControllerStyleAlert];
        [rootView presentViewController:myAlert animated:YES completion:nil];
    }
    
    [[ApplicationFacade getInstance] startup: rootView];
}


@end
