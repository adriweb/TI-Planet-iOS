//
//  BlogService.h
//  TIPlanet
//
/* 
 * 
 * @author        Adriweb - Original from Jens Krause [www.websector.de]    
 * @date          31/08/2011
 *   
 */


#import <Foundation/Foundation.h>
#import "EntryVO.h"
#import "BlogProxy.h"


@interface BlogService : NSObject <IBlogService, NSXMLParserDelegate>
{
	NSString *keyInProgress;
	NSMutableString *blogTitle, *textInProgress;
    NSString *theCategory;
	
	EntryVO *currentEntry;
	NSMutableArray *blogEntries;
}

@property( copy ) NSMutableArray *blogEntries;

-(BOOL) getBlogData:(NSURL *) url;

@end
