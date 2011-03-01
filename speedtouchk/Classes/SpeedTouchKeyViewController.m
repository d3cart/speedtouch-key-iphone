//
//  SpeedTouchKeyViewController.m
//  SpeedTouchKey
//
//  Created by Sveinbjorn Thordarson on 2/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SpeedTouchKeyViewController.h"
#import "stkeys.c"

@implementation SpeedTouchKeyViewController




 // The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil 
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
	{
		
		
	}
    return self;
}


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
	// When the user presses return, take focus away from the text field so that the keyboard is dismissed.
	if (theTextField == textField) {
		[self getKeysButtonPressed];
        // Invoke the method that changes the greeting.
	}
	return YES;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	
    // Dismiss the keyboard when the view outside the text field is touched.
    [textField resignFirstResponder];
    // Revert the text field to the previous value.
    //textField.text = self.string; 
    [super touchesBegan:touches withEvent:event];
}

-(IBAction)getKeysButtonPressed
{
	[textField resignFirstResponder];
	
	[[NSNotificationCenter defaultCenter] addObserver: self
											 selector: @selector(crackFinished:)
												 name: @"SpeedTouchKeyCrackFinished"
											   object: nil];	
	
	NSString *str = [textField text];
	
	if ([str length] < 5)
	{
		resultsTextView.text = @"SSID must be 5 or more characters.";
		return;
	}
	
	resultsTextView.text = @"Checking keys.\nThis may take a while.";
	activityIndicatorView.hidden = NO;
	[activityIndicatorView startAnimating];
	
	NSOperationQueue *queue = [NSOperationQueue new];

	NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self
																			selector:@selector(getKeys:)
																			  object:str];
	
	//[self performSelector: @selector(getKeys:) withObject: str afterDelay: 0.2];
	
	[queue addOperation:operation];
	[operation release];
}

-(void)crackFinished: (NSNotification *)notification
{
	NSLog(@"Crack finished");
	
	NSString *str = [notification object];
	NSLog(@"%@", str);
	
	dispatch_async(dispatch_get_main_queue(), ^(void)
				   {
					   resultsTextView.text = str;
					   activityIndicatorView.hidden = YES;
					   [activityIndicatorView stopAnimating];
				   });
	
	[[NSNotificationCenter defaultCenter] removeObserver: self name: @"SpeedTouchKeyCrackFinished" object:nil];
}

-(void)getKeys: (NSString *)str
{
	NSMutableArray *arr = getDefaultKey((char *)[str UTF8String]);
	NSString *result = @"";
	
	if ([arr count] < 1)
	{
		result = @"No keys found.";
	}
	else
	{
		NSString *allKeys = @"";
		
		for (NSString *key in arr)
		{
			allKeys = [allKeys stringByAppendingFormat: @"%@\n", key];
		}
		result = allKeys;
	}
	
	[[NSNotificationCenter defaultCenter] postNotificationName: @"SpeedTouchKeyCrackFinished" object: result];
	
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc 
{
    [super dealloc];
}

@end
