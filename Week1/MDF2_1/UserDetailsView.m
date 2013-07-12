//
//  UserDetailsView.m
//  MDF2_1
//
//  Created by Nick Stelzer on 7/12/13.
//  Copyright (c) 2013 Nick Stelzer. All rights reserved.
//

#import "UserDetailsView.h"

@interface UserDetailsView ()

@end

@implementation UserDetailsView

@synthesize user;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
	// Profile Image
    NSString *imgURL = [[NSString alloc] initWithString:[user objectForKey:@"profile_image_url"]];
        UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgURL]]];
    [profileImageView setImage:image];
    
    // Real Name
    fullNameLabel.text = [user objectForKey:@"name"];
    
    // Screen Name
    screenNameLabel.text = [user objectForKey:@"screen_name"];
    
    // Total Tweets
    tweetsLabel.text = [[NSString alloc] initWithFormat:@"Total Tweets: %@", [user objectForKey:@"statuses_count"]];
    
    // Friends
    friendsLabel.text = [[NSString alloc] initWithFormat:@"Friends: %@", [user objectForKey:@"friends_count"]];
    
    // Followers
    followersLabel.text = [[NSString alloc] initWithFormat:@"Followers: %@", [user objectForKey:@"followers_count"]];
    
	NSLog(@"%@", [user objectForKey:@"friends_count"]);
}

-(IBAction)onClick:(id)sender
{
	[self dismissViewControllerAnimated:true completion:^(){}];
}
@end
