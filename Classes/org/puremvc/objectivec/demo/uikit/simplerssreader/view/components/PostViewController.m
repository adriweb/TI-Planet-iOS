//
//  PostViewController.m
//  TIPlanet
//
/* 
 * 
 * @author        Adriweb - Original from Jens Krause [www.websector.de]    
 * @date          31/08/2011
 *   
 */


#import "PostViewController.h"
#import "FormatterUtil.h"


@implementation PostViewController

@synthesize articleURL, articleTitle;


#pragma mark -
#pragma mark init && dealloc

+(PostViewController *)postViewController
{
    return [[PostViewController alloc] initWithNibName:@"PostViewController" bundle:nil];
}


- (void) hideGradientBackground:(UIView*)theView
{
    for (UIView* subview in theView.subviews)
    {
        if ([subview isKindOfClass:[UIImageView class]])
            subview.hidden = YES;
        
        [self hideGradientBackground:subview];
    }
    
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    // initial loading
    [webView loadHTMLString:@"Chargement..." baseURL: NULL];
    
    ((UIScrollView *)webView.subviews[0]).scrollsToTop = YES;
    // scrolls to top when touching the status bar
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                                   target:self
                                                                                   action:@selector(actionStuff)];
    self.navigationItem.rightBarButtonItem = anotherButton;
}

- (void)didFinishNavigation:(WKWebView *)webView
{
    // inited after first display
    if ([webView.URL.absoluteString isEqualToString:@"about:blank"]) {
        [webView loadHTMLString:storedStringForWebView baseURL:[NSURL URLWithString:@"https://tiplanet.org/"]];
    }
}

- (void) actionStuff {
    UIActionSheet *actionsheet = [[UIActionSheet alloc] 
                                  initWithTitle:@"Article TI-Planet"
                                  delegate:self 
                                  cancelButtonTitle:@"Annuler" 
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"Voir dans Safari", @"Partager...", nil
                                  ];
    [actionsheet showFromTabBar:self.tabBarController.tabBar];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:articleURL] options:@{} completionHandler:nil];
    } else if (buttonIndex == 1) {
        NSMutableArray *sharingItems = [NSMutableArray new];
        [sharingItems addObject:articleTitle];
        [sharingItems addObject:articleURL];
        
        UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:sharingItems applicationActivities:nil];

        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            activityController.popoverPresentationController.barButtonItem = self.navigationItem.rightBarButtonItem;
        }
        
        [self presentViewController:activityController animated:YES completion:nil];
    }
}

#pragma -
#pragma mark methods which are called by its mediator


-(void)newBlogEntry:(EntryVO *) data
{
    EntryVO *entryVO = (EntryVO *) data;
    
    self.title = entryVO.blogTitle;
    
    articleURL = entryVO.link;
    articleTitle = entryVO.title;
    
       
    NSLog(@"webview = %p : %@", webView, webView);
    
    storedStringForWebView = [NSString stringWithFormat: @"<div><span class=\"header\">Par <b>%@</b>, %@</span><h1>%@</h1></div><p>%@</p>",
                                  entryVO.author,
                                  [FormatterUtil formatFeedDateString: entryVO.dateString newFormat: @"'le 'dd'/'MM'/'yyyy' à 'HH:mm"],
                                  entryVO.title,
                                  [entryVO.txt stringByReplacingOccurrencesOfString:@"src=\"/forum/images/spinload.gif\" data-original=\""
                                                                         withString:@"src=\""]
                              ];
    
    [webView loadHTMLString:storedStringForWebView
                    baseURL:[NSURL URLWithString:@"https://tiplanet.org/"]
     ];

}

@end
