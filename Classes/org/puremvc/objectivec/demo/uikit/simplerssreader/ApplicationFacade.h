//
//  ApplicationFacade.h
//  TIPlanet
//
/* 
 * 
 * @author        Adriweb - Original from Jens Krause [www.websector.de]    
 * @date          31/08/2011
 *   
 */


#import <Foundation/Foundation.h>
#import "Facade.h"

@interface ApplicationFacade : Facade 
{	

}

+(ApplicationFacade *)getInstance;

-(void)startup:(id)rootView;

@end
