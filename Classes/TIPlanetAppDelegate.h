//
//  TIPlanetAppDelegate.h
//  TIPlanet
//
/* 
 * 
 * @author        Adriweb - Original from Jens Krause [www.websector.de]    
 * @date          31/08/2011
 *   
 */


#import <UIKit/UIKit.h>

@interface TIPlanetAppDelegate : NSObject <UIApplicationDelegate> 
{
    UIWindow *window;
	UINavigationController *nav;
    IBOutlet UITabBarController *tabBarController;
	
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) UINavigationController *nav;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;



@end

