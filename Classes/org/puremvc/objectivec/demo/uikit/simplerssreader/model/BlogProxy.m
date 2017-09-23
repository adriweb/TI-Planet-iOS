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


#define BLOG_FEED    @"https://tiplanet.org/forum/feed.php?mode=news"

@implementation BlogProxy


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
    [NSURLCache sharedURLCache].memoryCapacity = 0;
    [NSURLCache sharedURLCache].diskCapacity = 0;
    
    
    // 
    // Spawn a thread to fetch all needed data without freezing the UI
    // while loading and parsing XML data
    [NSThread detachNewThreadSelector:@selector( startParsing ) 
                             toTarget:self 
                            withObject:nil];    
}


-(void)startParsing
{    
    @autoreleasepool {
        
        BlogService *service = [[BlogService alloc] init];
        
        BOOL success;
        success = [service getBlogData: [NSURL URLWithString: BLOG_FEED]];
        
        if ( success )
        {
            data = service.blogEntries;
            [self sendNotification: BLOG_POSTS_RESULT body: data];
        }
        else
        {
            [self sendNotification: BLOG_POSTS_FAILED];
        }
    }

}

-(void)entryById:(NSUInteger) entryId
{
    if ( [data count] > entryId )
    {
        EntryVO *entry = data[entryId];
        [self sendNotification: BLOG_POST_DETAIL body: entry];
    }
    else
    {
        [self sendNotification: BLOG_POST_DETAIL_FAILED];    
    }
}

@end
