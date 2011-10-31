//
//  RootViewController.m
//  TIPlanet
//
/* 
 * 
 * @author        Adriweb - Original from Jens Krause [www.websector.de]    
 * @date          31/08/2011
 *   
 */


#import "RootViewController.h"
#import "EntryVO.h"
#import "BlogEntryCell.h"
#import "FormatterUtil.h"
#import "ApplicationFacade.h"
#import <QuartzCore/QuartzCore.h>

@implementation RootViewController

@synthesize postViewController;
@synthesize delegate, imageView;


#pragma -
#pragma mark init && dealloc

+(RootViewController *)rootViewController
{
	return 	[[[RootViewController alloc] init] autorelease];
}


-(id)init
{
	if (self = [super init]) 
	{	
		blogEntries = [[NSMutableArray alloc] init];
		postViewController = [PostViewController postViewController];
	}
	return self;
}

- (void)dealloc 
{
	[blogEntries release];
	[feedLoader release];	
	
	[postViewController release];
	[delegate release];
	
    [super dealloc];
}


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
	self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;

	UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] init];
	backBarButton.title = NSLocalizedString(@"LABEL_BACK", @"LABEL_BACK STRING not found");
	self.navigationItem.backBarButtonItem = backBarButton;
	[backBarButton release];
	
	[super loadView];
}

- (void)killSplashScreen {
    [UIView animateWithDuration:0.5 animations:^{imageView.alpha = 0.0;} completion:NULL];
    [imageView release];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
    
    CGRect myImageRect = [[UIScreen mainScreen] applicationFrame];
    myImageRect.origin.y -= 18;
    imageView = [[UIImageView alloc] initWithFrame:myImageRect];
    [imageView setImage:[UIImage imageNamed:@"Default.png"]];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) [imageView setImage:[UIImage imageNamed:@"Default-Portrait~ipad.png"]];
    imageView.opaque = YES; // explicitly opaque for performance
    [self.view addSubview:imageView]; 
    
    [self performSelector:@selector(killSplashScreen) withObject:nil afterDelay:0];

	[self setTitle: NSLocalizedString(@"TITLE_ROOT", @"TITLE_ROOT not found")];
	
	[self showLoader];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


-(void)showLoader
{
    UIApplication* app = [UIApplication sharedApplication]; app.networkActivityIndicatorVisible = YES;
	feedLoader = [[UIActivityIndicatorView alloc] initWithFrame: CGRectMake([[UIScreen mainScreen] bounds].size.width/2-10, 145, 20, 20)];
	[feedLoader startAnimating];	
	[feedLoader setActivityIndicatorViewStyle: UIActivityIndicatorViewStyleGray];
	[self.view addSubview: feedLoader];
}


-(void)hideLoader
{
	UIApplication* app = [UIApplication sharedApplication]; app.networkActivityIndicatorVisible = NO;
    [feedLoader stopAnimating];
	[feedLoader removeFromSuperview];
	[feedLoader release];	
	feedLoader = nil;	
}


#pragma mark -
#pragma mark table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    return [blogEntries count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
   NSUInteger row = [indexPath row];
	
    static NSString *CellId = @"BlogEntryCellIdentifier";
    
    BlogEntryCell *cell = (BlogEntryCell *) [tableView dequeueReusableCellWithIdentifier: CellId];
    
    if (cell == nil) 
	{
        NSArray *nib;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            nib = [[NSBundle mainBundle] loadNibNamed:@"BlogEntryCell-iPad" 
                                                         owner:self 
                                                       options:nil];
        } else {
            nib = [[NSBundle mainBundle] loadNibNamed:@"BlogEntryCell" 
                                                         owner:self 
                                                       options:nil];
        }
		
		for (id object in nib)
		{
			if ( [object isKindOfClass:[UITableViewCell class]])
			{
				cell = object;
				cell.selectionStyle = UITableViewCellSelectionStyleBlue;
				break;
			}
		}
	    }
    
	if ( [blogEntries count] > 0 )
	{
		EntryVO *entryVO = [blogEntries objectAtIndex: row];
		// headline
		cell.headline.text = [NSString stringWithFormat: @"%@ - Par %@  -  %@",
                                                        entryVO.category,
														entryVO.author,
														[FormatterUtil formatFeedDateString: entryVO.dateString 
																				newFormat: @"'Le 'dd'/'MM'/'yyyy' à 'HH:mm"] 
														] ;
		cell.label.text = entryVO.title;
	}
	else
	{
		cell.textLabel.text = NSLocalizedString(@"LABEL_LOADING", @"LABEL_LOADING not found");
	}

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{    
    NSUInteger row = [indexPath row];
	
	[self.delegate getBlogEntry:row];
}

#pragma -
#pragma Reload stuff

-(void) refresh
{
    NSLog(@"got to refresh.... not done yet");
    [self getBlogEntries]; //  <-- not working (crash)
    //[self stopLoading]; // to put somewhere else when ^ is working
}

#pragma -
#pragma mark methods which are called by its mediator

-(void)showBlogEntry
{	   
    [self.navigationController pushViewController:postViewController
                               animated:YES];
}

-(void)getBlogEntries
{
    [self showLoader];
	[delegate getBlogEntries];
}

-(void)showBlogEntries:(NSMutableArray *)data
{
    [blogEntries release];
	blogEntries = [data retain];	
    
	[self hideLoader];
	[self.tableView reloadData];
}


@end
