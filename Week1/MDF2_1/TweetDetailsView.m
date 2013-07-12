//
//  TweetDetailsView.m
//  MDF2_1
//
//  Created by Nick Stelzer on 7/12/13.
//  Copyright (c) 2013 Nick Stelzer. All rights reserved.
//

#import "TweetDetailsView.h"

@interface TweetDetailsView ()

@end

@implementation TweetDetailsView

@synthesize tweet;

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

- (void)viewWillAppear:(BOOL)animated
{
	// Profile Image
    NSString *imgURL = [[NSString alloc] initWithString:[[tweet objectForKey:@"user"] objectForKey:@"profile_image_url"]];
        UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgURL]]];
    [profileImageView setImage:image];
    
    // Real Name
    fullNameLabel.text = [[tweet objectForKey:@"user"] objectForKey:@"name"];
    
    // Screen Name
    screenNameLabel.text = [[tweet objectForKey:@"user"] objectForKey:@"screen_name"];
    
    // Tweet Text
    tweetLabel.text = [tweet objectForKey:@"text"];
	
    // Time
	createdAtLabel.text = [tweet objectForKey:@"created_at"];
}

-(IBAction)onClick:(id)sender
{
	[self dismissViewControllerAnimated:true completion:^(){}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
