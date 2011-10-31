//
//  ApplicationFacade.m
//  TIPlanet
//
/* 
 * 
 * @author        Adriweb - Original from Jens Krause [www.websector.de]    
 * @date          31/08/2011
 *   
 */


#import "ApplicationFacade.h"
#import "Notifications.h"
#import "StartupCommand.h"
#import "Reachability.h"


@implementation ApplicationFacade

-(void)startup:(id)rootView 
{
	[self sendNotification:APP_STARTUP body:rootView];
}

+(ApplicationFacade *)getInstance 
{
	return (ApplicationFacade *)[super getInstance];
}

-(void)initializeController 
{
	[super initializeController];
	
	[self registerCommand:APP_STARTUP commandClassRef:[StartupCommand class]];
}


@end
