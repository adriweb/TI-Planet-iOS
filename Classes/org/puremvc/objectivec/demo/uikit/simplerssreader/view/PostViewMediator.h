//
//  PostViewMediator.h
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

@interface PostViewMediator : Mediator 
{
	BlogProxy *blogProxy;
}

@end
