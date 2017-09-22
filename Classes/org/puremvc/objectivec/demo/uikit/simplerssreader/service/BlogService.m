//
//  BlogService.m
//  TIPlanet
//
/* 
 * 
 * @author        Adriweb - Original from Jens Krause [www.websector.de]    
 * @date          31/08/2011
 *   
 */

//
//    BlogService based on an example "Parsing XML in Cocoa" by Aaron Hillegass (http://weblog.bignerdranch.com/?p=48)
//    and Apples example "SeismicXML" at iPhoneDevCenter (https://developer.apple.com/iphone/library/samplecode/SeismicXML/index.html)
//

#import "BlogService.h"

static NSUInteger parsedItemCounter;
static NSSet *interestingKeys;


@implementation BlogService

@synthesize blogEntries;


+ (void)initialize
{
    if ( !interestingKeys ) 
    {
        interestingKeys = [[NSSet alloc] initWithObjects:    @"title",
                           @"content",
                           @"updated",
                           @"name",
                           @"id",
                           @"category",
                           nil];
    }
}


-(BOOL)getBlogData:(NSURL *) url
{
    blogEntries = [[NSMutableArray alloc] init];
    
    NSXMLParser *feedParser = [[NSXMLParser alloc] initWithContentsOfURL: url];
    
    feedParser.delegate = self;
    [feedParser setShouldProcessNamespaces: NO];
    [feedParser setShouldReportNamespacePrefixes: NO];
    [feedParser setShouldResolveExternalEntities: NO];
    
    //
    // start parsing
    BOOL success;    
    success = [feedParser parse];
    
    return success;
}

#pragma mark NSXMLParser delegate methods

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    parsedItemCounter = 0;
}


#define MAX_ENTRIES 20

- (void)parser:(NSXMLParser *)parser 
didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName 
    attributes:(NSDictionary *)attributeDict 
{
    if ( parsedItemCounter > MAX_ENTRIES ) 
    {
        [parser abortParsing];
    }
    
    if ( [elementName isEqual:@"entry"]) 
    {
        parsedItemCounter++;
        currentEntry = [[EntryVO alloc] init];    
        return;
    }
    
    
    if ( [interestingKeys containsObject:elementName] ) 
    {
        if ([elementName isEqualToString:@"category"]) {

            NSString *tmpString = attributeDict[@"label"];
            tmpString = [tmpString stringByReplacingOccurrencesOfString:@" (TI-73/76/80/81/82/83/84/85/86)"
                                                             withString:@""];
            tmpString = [tmpString stringByReplacingOccurrencesOfString:@" (TI-89/92, TI-Voyage 200)"
                                                             withString:@""];
            
            //NSLog(@"tmpString = %@",tmpString);
            theCategory = tmpString;
        }
        
        keyInProgress = [elementName copy];
        textInProgress = [[NSMutableString alloc] init];
    }
    
}


- (void)parser:(NSXMLParser *)parser 
foundCharacters:(NSString *)value 
{
    [textInProgress appendString: value];    
}


- (void)parser:(NSXMLParser *)parser 
 didEndElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName 
{
    
    // store title of the entire blog - not of the post entry
    // Note: We have to different @"title", because within XML data twice.
    if ( [elementName isEqual:@"title"] && blogTitle == nil )
    {
        //[blogTitle release];
        blogTitle = textInProgress;
        return;
    }
    
    
    if ( [elementName isEqual:@"entry"] ) 
    {
        //
        // store entry
        currentEntry.blogTitle = [blogTitle copy];
        [blogEntries addObject: currentEntry];
        
        currentEntry = nil;
        
        return;
        
    }
    
    
    if ( [elementName isEqual:keyInProgress])
    {
        if ( [elementName isEqual:@"content"] ) 
        {
            currentEntry.txt = textInProgress;        
        }
        else if ( [elementName isEqual:@"updated"] ) 
        {
            currentEntry.dateString = textInProgress;
        }
        else if ( [elementName isEqual:@"title"] ) 
        {
            currentEntry.title = textInProgress;
        }
        else if ( [elementName isEqual:@"name"] ) 
        {
            currentEntry.author = textInProgress;
        }
        else if ( [elementName isEqual:@"id"] ) 
        {
            currentEntry.link = textInProgress;
        }
        else if ( [elementName isEqual:@"category"] ) 
        {
            currentEntry.category = [NSMutableString stringWithString:theCategory];
        }
        
        textInProgress = nil;
        keyInProgress = nil;
    }
    
    
    else 
    {
        //NSLog(@"uneeded XML element to store: %@", elementName);
    }
    
    
    
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser 
{
    NSLog(@"blogEntries array has %lu entries", (unsigned long)blogEntries.count);
}



@end
