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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
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
                    	NSArray *twitterFeed = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
                        NSLog(@"%@", [twitterFeed description]);
                    }
                }];
            }
        } else {
        	NSLog(@"User did not grant access");
        }
    }];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)onPost:(id)sender
{
	SLComposeViewController *slComposeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    if (slComposeViewController) {
    	[slComposeViewController setInitialText:@"Posted from my test app"];
        [self presentViewController:slComposeViewController animated:true completion:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
