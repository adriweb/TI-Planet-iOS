//
//  EntryVO.h
//  TIPlanet
//
/* 
 * 
 * @author        Adriweb - Original from Jens Krause [www.websector.de]    
 * @date          31/08/2011
 *   
 */


#import <Foundation/Foundation.h>


@interface EntryVO : NSObject 
{
	NSString *blogTitle;
	NSMutableString *title, *txt, *dateString, *link, *author, *category;
}

@property(nonatomic, retain) NSMutableString *title, *txt, *dateString, *link, *author, *category;
@property(nonatomic, retain) NSString *blogTitle;

@end
