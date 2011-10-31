//
//  EntryVO.m
//  TIPlanet
//
/* 
 * 
 * @author        Adriweb - Original from Jens Krause [www.websector.de]    
 * @date          31/08/2011
 *   
 */


#import "EntryVO.h"


@implementation EntryVO

@synthesize dateString;
@synthesize title;
@synthesize txt;
@synthesize blogTitle;
@synthesize author;
@synthesize link;
@synthesize category;

-(void) dealloc
{
	[dateString release];
	[title release];
	[txt release];
	[blogTitle release];
    [author release];
    [link release];
    [category release];
	
	[super dealloc];
}

@end
