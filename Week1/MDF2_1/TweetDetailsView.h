//
//  TweetDetailsView.h
//  MDF2_1
//
//  Created by Nick Stelzer on 7/12/13.
//  Copyright (c) 2013 Nick Stelzer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetDetailsView : UIViewController
{
	IBOutlet UIImageView *profileImageView;
    IBOutlet UILabel *fullNameLabel;
    IBOutlet UILabel *screenNameLabel;
    IBOutlet UILabel *tweetLabel;
    IBOutlet UILabel *createdAtLabel;
}
@property (strong, nonatomic) NSDictionary *tweet;
-(IBAction)onClick:(id)sender;
@end
