//
//  NewStoryViewController.h
//  SocialStory
//
//  Created by James Cross on 06/12/2014.
//  Copyright (c) 2014 Colibri Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewStoryViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISlider *maxUsersSlider;
@property (weak, nonatomic) IBOutlet UILabel *maxUsersLabel;

@property (weak, nonatomic) IBOutlet UISlider *numRoundsSlider;
@property (weak, nonatomic) IBOutlet UILabel *numRoundsLabel;

@end
