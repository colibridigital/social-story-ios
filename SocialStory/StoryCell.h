//
//  StoryCell.h
//  SocialStory
//
//  Created by Ingrid Funie on 12/10/2014.
//  Copyright (c) 2014 Colibri Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *storyTitle;
@property (weak, nonatomic) IBOutlet UILabel *usersNumber;
- (IBAction)shareStory:(id)sender;

@end
