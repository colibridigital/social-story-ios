//
//  NewStoryViewController.m
//  SocialStory
//
//  Created by James Cross on 06/12/2014.
//  Copyright (c) 2014 Colibri Ltd. All rights reserved.
//

#import "NewStoryViewController.h"

@interface NewStoryViewController ()

@end

@implementation NewStoryViewController

- (void) viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)maxUsersValueChanged:(id)sender {
    self.maxUsersLabel.text = [NSString stringWithFormat:@"%f", self.maxUsersSlider.value];
}

- (IBAction)numRoundsValueChanged:(id)sender {
    self.numRoundsLabel.text = [NSString stringWithFormat:@"%f", self.numRoundsSlider.value];
}


@end


