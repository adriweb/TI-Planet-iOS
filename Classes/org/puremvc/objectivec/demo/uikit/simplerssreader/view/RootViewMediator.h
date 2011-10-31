//
//  MainMediator.h
//  TIPlanet
//
/* 
 * 
 * @author        Adriweb - Original from Jens Krause [www.websector.de]    
 * @date          31/08/2011
 *   
 */


#import <Foundation/Foundation.h>
#import "Mediator.h"
#import "BlogProxy.h"
#import "RootViewController.h"


@interface RootViewMediator : Mediator <RootViewControllerDelegate>
{
	BlogProxy *blogProxy;
}

@end
