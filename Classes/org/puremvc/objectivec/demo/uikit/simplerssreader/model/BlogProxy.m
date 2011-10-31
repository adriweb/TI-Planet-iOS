//
//  BlogProxy.m
//  TIPlanet
//
/* 
 * 
 * @author        Adriweb - Original from Jens Krause [www.websector.de]    
 * @date          31/08/2011
 *   
 */


#import "BlogProxy.h"
#import "Notifications.h"
#import "BlogService.h"


//#define BLOG_FEED	@"http://www.websector.de/blog/feed/"
#define BLOG_FEED	@"http://tiplanet.org/forum/feed.php?mode=news"

@implementation BlogProxy

#pragma mark init && dealloc

-(void)dealloc
{
	[super dealloc];
}

#pragma mark proxy standard methods

-(void)initializeProxy 
{
	[super initializeProxy];
	self.proxyName = [BlogProxy NAME];
}

+(NSString *)NAME 
{
	return @"BlogProxy";
}



-(NSMutableArray *)data 
{
	return data;
}


#pragma mark remote proxy methods

-(void)getAllEntries
{	
	//
	// clear data
	[data release];
	
	
	NSLog(@"getAllEntries");
	
	[[NSURLCache sharedURLCache] setMemoryCapacity:0];
	[[NSURLCache sharedURLCache] setDiskCapacity:0];
	
	
	// 
	// Spawn a thread to fetch all needed data without freezing the UI
	// while loading and parsing XML data
    [NSThread detachNewThreadSelector:@selector( startParsing ) 
							 toTarget:self 
							withObject:nil];	
	 
}


-(void)startParsing
{	
    
    NSLog(@"startParsing");
    
    
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	BlogService *service = [[BlogService alloc] init];
	
	BOOL success;
	success = [service getBlogData: [NSURL URLWithString: BLOG_FEED]];
    
    NSLog(@"hello after getblogdata");

	if ( success )
	{
		data = service.blogEntries;
		[self sendNotification: BLOG_POSTS_RESULT body: data];		
	}
	else
	{
		[self sendNotification: BLOG_POSTS_FAILED];
	}
	
	[service release];
	[pool drain];
	[pool release];
	
}

-(void)entryById:(NSUInteger) entryId
{
	if ( [data count] > entryId )
	{
		EntryVO *entry = [data objectAtIndex: entryId];
		[self sendNotification: BLOG_POST_DETAIL body: entry];		
	}
	else
	{
		[self sendNotification: BLOG_POST_DETAIL_FAILED];	
	}

}


@end
