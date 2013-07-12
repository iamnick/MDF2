//
//  ViewController.h
//  MDF2_1
//
//  Created by Nick Stelzer on 7/11/13.
//  Copyright (c) 2013 Nick Stelzer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
	NSArray *userTimeline;
    IBOutlet UITableView *tableView;
}

-(void)refreshTableView;
-(IBAction)onClick:(id)sender;

@end
