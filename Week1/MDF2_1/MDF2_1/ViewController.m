//
//  ViewController.m
//  MDF2_1
//
//  Created by Nick Stelzer on 7/11/13.
//  Copyright (c) 2013 Nick Stelzer. All rights reserved.
//

#import "ViewController.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import "CustomCell.h"
#import "TweetDetailsView.h"
#import "UserDetailsView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
	
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self refreshTableView];
}


// Refresh TableView With User Timeline
-(void)refreshTableView
{
	// Alert View During Load/Refresh
    UIAlertView *loadingAlert = [[UIAlertView alloc] initWithTitle:@"Loading Twitter Feed" message:@"\n"  delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc]
                initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	activityIndicator.frame=CGRectMake(125, 60, 32, 32);
	[loadingAlert addSubview:activityIndicator];
    [activityIndicator startAnimating];
    [loadingAlert show];

	ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error){
    	if (granted) {
        	NSArray *twitterAccounts = [accountStore accountsWithAccountType:accountType];
            NSLog(@"Access granted");
            ACAccount *currentAccount = [twitterAccounts objectAtIndex:0];
            
            
            
            // Get User Timeline
            NSString *userTimelineURL = @"https://api.twitter.com/1.1/statuses/user_timeline.json";
        	SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:[NSURL URLWithString:userTimelineURL] parameters:nil];
            if (request) {
            	[request setAccount:currentAccount];
                [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error){
                	// Check for 200 response code so we know we are getting data
                    NSInteger responseCode = [urlResponse statusCode];
                    if (responseCode == 200) {
                    	userTimeline = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
                        if (userTimeline != nil) {
                        	[tableView reloadData];
                            [loadingAlert dismissWithClickedButtonIndex:0 animated:YES];                            NSLog(@"%@", [userTimeline description]);
                        	NSLog(@"name: %@", [[userTimeline objectAtIndex:0] objectForKey:@"text"]);
                        }
                    }
                }];
            }
        } else {
        	NSLog(@"User did not grant access");
        }
    }];
}

// Post Tweet 
-(IBAction)onClick:(id)sender
{
	UIButton *button = (UIButton*)sender;
    if (button.tag == 0) {
    	// Refresh Button
        [self refreshTableView];
    } else if (button.tag == 1) {
    	// Post Button
        SLComposeViewController *slComposeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    	if (slComposeViewController) {
    		[slComposeViewController setInitialText:@"Posted from my test app"];
        	[self presentViewController:slComposeViewController animated:true completion:nil];
    	}
    } else if (button.tag == 2) {
    	// User Details Button
		UserDetailsView *userDetailsView = [[UserDetailsView alloc] initWithNibName:@"UserDetailsView" bundle:nil];
    	[userDetailsView setUser:[[userTimeline objectAtIndex:0] objectForKey:@"user"]];
    [self presentViewController:userDetailsView animated:true completion:^(){}];    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Table View Configuration
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (userTimeline != nil){
		return [userTimeline count];
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView2 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
        cell = [views objectAtIndex:0];
    }
    
    if (userTimeline) {
    	NSDictionary *tweetDictionary = [userTimeline objectAtIndex:indexPath.row];
        
    	// User Profile Image
        NSString *imgURL = [[NSString alloc] initWithString:[[tweetDictionary objectForKey:@"user"] objectForKey:@"profile_image_url"]];
        UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgURL]]];
    	UIImageView *cellImageView = (UIImageView*)[cell viewWithTag:0];
    	[cellImageView setImage:image];
        
        // Tweet Text
        UILabel *tweetTextLabel = (UILabel*)[cell viewWithTag:1];
        tweetTextLabel.text = [tweetDictionary objectForKey:@"text"];
        
        // Tweet Time
        UILabel *tweetTimeLabel = (UILabel*)[cell viewWithTag:2];
        tweetTimeLabel.text = [tweetDictionary objectForKey:@"created_at"];
        
        
    }
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	TweetDetailsView *tweetDetailsView = [[TweetDetailsView alloc] initWithNibName:@"TweetDetailsView" bundle:nil];
    [tweetDetailsView setTweet:[userTimeline objectAtIndex:indexPath.row]];
    [self presentViewController:tweetDetailsView animated:true completion:^(){}];
}

@end
