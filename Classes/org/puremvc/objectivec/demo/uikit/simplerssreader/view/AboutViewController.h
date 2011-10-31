//
//  AboutViewController.h
//  TI-Planet iOS
//
//  Created by Adrien Bertrand on 01/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GradientButton.h"
#import <MessageUI/MessageUI.h>


@interface AboutViewController : UIViewController <MFMailComposeViewControllerDelegate> {

    GradientButton    *whiteButton;
 
IBOutlet UILabel *resultLabel;


}
@property (nonatomic,retain) IBOutlet UILabel *resultLabel;

-(IBAction) sendEmail:(id)sender;

@property (nonatomic, retain) IBOutlet  GradientButton *whiteButton;


@end
