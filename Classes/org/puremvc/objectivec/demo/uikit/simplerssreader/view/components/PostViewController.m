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
    ((UIScrollView *)webView.subviews[0]).scrollsToTop = YES;
    // scrolls to top when touching the status bar
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(actionStuff)];        
    self.navigationItem.rightBarButtonItem = anotherButton;
}

- (void) actionStuff {
    UIActionSheet *actionsheet = [[UIActionSheet alloc] 
                                  initWithTitle:@"Article TI-Planet"
                                  delegate:self 
                                  cancelButtonTitle:@"Annuler" 
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"Voir dans Safari", @"Envoyer par E-mail", @"Partager sur Facebook", nil
                                  ];
    [actionsheet showFromTabBar:self.tabBarController.tabBar];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:articleURL]];
    } else if (buttonIndex == 1) {
            [actionSheet dismissWithClickedButtonIndex:3 animated:YES];
            Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
            if ([mailClass canSendMail]) {
                
                //create an instance of MFMailComposeViewController
                MFMailComposeViewController *emailUI = [[MFMailComposeViewController alloc] init];
                
                
                //Set the standard interface fields with initial values
                
                //Set the subject
                [emailUI setSubject:@"Un article intéressant sur TI-Planet..."];
                
                NSString *defaultMessage = [[NSString alloc] initWithFormat:@"Salut, j'ai lu un article intéressant sur <a href=\"https://tiplanet.org\">TI-Planet.org</a> : <br /><br />\"%@:\"<br /><a href=\"%@\">%@</a>",articleTitle,articleURL,articleURL];
                
                // Fill out the email body text.
                [emailUI setMessageBody:defaultMessage isHTML:YES];
                
                // Present the mail composition interface.
                [self presentViewController:emailUI animated:YES completion:NULL];
                emailUI.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
                
                //assign the parent view controller as the mail compose view controller delegate
                emailUI.mailComposeDelegate = self;
            }
            else
            {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Erreur"
                                                              message:@"Impossible de démarrer le mailer intégré."
                                                             delegate:self
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
                [alert show];
                
            }
    } else if (buttonIndex == 2) {
        NSString *tmpStr = [NSString stringWithFormat:@"https://facebook.com/sharer.php?u=%@&t=%@",articleURL,articleTitle];
        NSString *escaped = [tmpStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:escaped]];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (BOOL)webView:(UIWebView *)webView 
        shouldStartLoadWithRequest:(NSURLRequest *)request 
        navigationType:(UIWebViewNavigationType)navigationType 
{
    if (navigationType == UIWebViewNavigationTypeLinkClicked) 
    {
        // open browser
        [[UIApplication sharedApplication] openURL:request.URL];
        return NO;
    }
    return YES;
}

#pragma -
#pragma mark methods which are called by its mediator


-(void)newBlogEntry:(EntryVO *) data
{
    EntryVO *entryVO = (EntryVO *) data;
    
    self.title = entryVO.blogTitle;
    
    articleURL = entryVO.link;
    articleTitle = entryVO.title;
    
    int theWidth = [UIScreen mainScreen].bounds.size.width-10;
    
    NSString *style = [NSString stringWithFormat:@"<style type='text/css'><!--* { font-family: Arial; color: #333; font-size: 1em;}  h1 { font-size: 1.4em; text-shadow: 0px 0px 0px #eee, 1px 1px 0px #707070;} span.header { color: #666; font-size: .8em; } a { color:#3388BB; text-decoration:underline }  img { max-width:%ipx; height:auto;} --></style>",theWidth];
    
    [webView loadHTMLString: [NSString stringWithFormat: @"<div>%@ <span class=\"header\">Par <b>%@</b>, %@</span><h1>%@</h1></div><p>%@</p>",
                              style,
                              entryVO.author,
                              [FormatterUtil formatFeedDateString: entryVO.dateString
                                                        newFormat: @"'le 'dd'/'MM'/'yyyy' à 'HH:mm"],
                              entryVO.title,
                              
                              [entryVO.txt
                                 stringByReplacingOccurrencesOfString:@"src=\"/forum/images/spinload.gif\" data-original=\""
                                                           withString:@"src=\""]
                              ]
                baseURL:[NSURL URLWithString:@"https://tiplanet.org/"]
     ];

}

@end
