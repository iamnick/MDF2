//
//  UserDetailsView.h
//  MDF2_1
//
//  Created by Nick Stelzer on 7/12/13.
//  Copyright (c) 2013 Nick Stelzer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserDetailsView : UIViewController
{
	IBOutlet UIImageView *profileImageView;
    IBOutlet UILabel *fullNameLabel;
    IBOutlet UILabel *screenNameLabel;
    IBOutlet UILabel *tweetsLabel;
    IBOutlet UILabel *followersLabel;
    IBOutlet UILabel *friendsLabel;
}
@property (strong, nonatomic) NSDictionary *user;
-(IBAction)onClick:(id)sender;
@end
