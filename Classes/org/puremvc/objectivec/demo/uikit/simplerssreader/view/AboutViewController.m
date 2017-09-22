//
//  AboutViewController.m
//  TI-Planet iOS
//
//  Created by Adrien Bertrand on 01/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AboutViewController.h"

@implementation AboutViewController
@synthesize whiteButton;
@synthesize resultLabel;


- (instancetype)init
{
    self = [super init];
    return self;
}

-(void)viewDidLoad {
    [whiteButton useWhiteStyle];
}

-(IBAction) sendEmail:(id)sender
{
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if ([mailClass canSendMail]) {
        
        //create an instance of MFMailComposeViewController
        MFMailComposeViewController *emailUI = [[MFMailComposeViewController alloc] init];
        
        
        //Set the standard interface fields with initial values
        
        //Set the subject
        [emailUI setSubject:@"TI-Planet Contact"];
        
        // Set up the recipients.
        NSArray *toRecipients = @[@"info@tiplanet.org"];
        
        [emailUI setToRecipients:toRecipients];        
        
        NSString *defaultMessage = [[NSString alloc] initWithFormat:@"\n\n\n\n\nAppareil : %@ (%@)",[UIDevice currentDevice].name, [UIDevice currentDevice].systemVersion];
        
        // Fill out the email body text.
        [emailUI setMessageBody:defaultMessage isHTML:NO];
        
        // Present the mail composition interface.
        [self presentViewController:emailUI animated:YES completion:NULL];
        emailUI.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        
        //assign the parent view controller as the mail compose view controller delegate
        emailUI.mailComposeDelegate = self;
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Erreur"
                                                      message:@"Impossible de démarrer le mailer intégré\n\n Contactez-nous via :\ninfo@tiplanet.org"
                                                     delegate:self
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
        [alert show];
        
    }
    
    
}

// The mail compose view controller delegate method
- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
    resultLabel.hidden = YES;
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MFMailComposeResultCancelled:
            resultLabel.text = @"Result: Annulé";
            break;
        case MFMailComposeResultSaved:
            resultLabel.text = @"Result: Sauvé";
            break;
        case MFMailComposeResultSent:
            resultLabel.text = @"Result: Envoyé";
            break;
        case MFMailComposeResultFailed:
            resultLabel.text = @"Result: Erreur";
            break;
        default:
            resultLabel.text = @"Result: Pas envoyé";
            break;
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}


@end
