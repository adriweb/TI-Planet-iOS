//
//  PostViewMediator.m
//  TIPlanet
//
/* 
 * 
 * @author        Adriweb - Original from Jens Krause [www.websector.de]    
 * @date          31/08/2011
 *   
 */


#import "PostViewMediator.h"
#import "PostViewController.h"
#import "Notifications.h"


@implementation PostViewMediator


#pragma -
#pragma mark mediator methods

+(NSString *)NAME 
{
    return @"PostViewMediator";
}

-(PostViewController *)viewComponent 
{
    return viewComponent;
}

-(void)initializeMediator 
{
    self.mediatorName = [PostViewMediator NAME];
    blogProxy = (BlogProxy *)[facade retrieveProxy:[BlogProxy NAME]];
}

-(void)onRegister 
{
}

#pragma -
#pragma mark notifications methods

-(NSArray *)listNotificationInterests 
{
    return @[BLOG_POST_DETAIL, 
                                        BLOG_POST_DETAIL_FAILED];
}

-(void)handleNotification:(id<INotification>)notification 
{
    NSString *notificationName = [notification name];
    
    if ([notificationName isEqual: BLOG_POST_DETAIL]) 
    {
        [viewComponent newBlogEntry:[notification body]];    
    }
    else if ([notificationName isEqual: BLOG_POST_DETAIL_FAILED]) 
    {
            
    }
    
}

@end
