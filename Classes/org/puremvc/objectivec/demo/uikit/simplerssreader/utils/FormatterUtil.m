//
//  FormatterUtil.m
//  TIPlanet
//
/* 
 * 
 * @author        Adriweb - Original from Jens Krause [www.websector.de]    
 * @date          31/08/2011
 *   
 */


#import "FormatterUtil.h"


@implementation FormatterUtil



+(NSString *) formatFeedDateString:(NSString *) feedDateString newFormat:(NSString *) newFormat
{
	
	//create formatter and format
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

	// we have to force the locale to avoid unexpected issues formatting data, e.g. on an German iPhone ;)
	NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
	[dateFormatter setLocale:[NSLocale systemLocale]];

	
	//[dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss Z"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'+02:00'"];
    // from php :  Y-m-d\TH:i:s  (exemple : 2011-08-04T02:59:07+02:00 )
    
	NSDate *formattedDate = [dateFormatter dateFromString: feedDateString];
	
	NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
	
	if (newFormat != nil )
	{
		[outputFormatter setDateFormat: newFormat];
	}
	else
	{
		[outputFormatter setDateFormat:@"dd MMM yyyy"];
	}
	
	NSString *formattedDateString = [outputFormatter stringFromDate:formattedDate];
	
	[dateFormatter release];
	dateFormatter = nil;

	[usLocale release];
	usLocale = nil;
	
	[outputFormatter release];
	outputFormatter = nil;
	
	return formattedDateString;


}
@end
