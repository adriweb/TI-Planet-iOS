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
    // NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    dateFormatter.locale = [NSLocale systemLocale];

    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
    
    NSDate *formattedDate = [dateFormatter dateFromString: feedDateString];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    
    NSString *formattedDateString;
    if (newFormat != nil)
    {
        outputFormatter.dateFormat = newFormat;
        formattedDateString = [outputFormatter stringFromDate:formattedDate];
    }
    else
    {
        formattedDateString = @"";
    }
        
    dateFormatter = nil;
    outputFormatter = nil;
    
    return formattedDateString;
}

@end
