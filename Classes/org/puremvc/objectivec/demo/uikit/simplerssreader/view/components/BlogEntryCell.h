//
//  BlogEntryCell.h
//  TIPlanet
//
/* 
 * 
 * @author        Adriweb - Original from Jens Krause [www.websector.de]    
 * @date          31/08/2011
 *   
 */


#import <UIKit/UIKit.h>


@interface BlogEntryCell : UITableViewCell 
{
	IBOutlet UILabel	*headline;
	IBOutlet UILabel	*label;	
}


@property (nonatomic, retain) UILabel *headline;
@property (nonatomic, retain) UILabel *label;

@end
