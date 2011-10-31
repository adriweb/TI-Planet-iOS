//
//  BlogProxy.h
//  TIPlanet
//
/* 
 * 
 * @author        Adriweb - Original from Jens Krause [www.websector.de]    
 * @date          31/08/2011
 *   
 */


#import <Foundation/Foundation.h>
#import "Proxy.h"
#import "EntryVO.h"


@protocol IBlogService
-(BOOL)getBlogData:(NSURL *) url;
@end


@interface BlogProxy : Proxy 
{

}

-(void)getAllEntries;
-(void)startParsing;
-(void)entryById:(NSUInteger) entryId;

@end
