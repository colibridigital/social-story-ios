//
//  MainViewController.m
//  SocialStory
//
//  Created by Ingrid Funie on 06/10/2014.
//  Copyright (c) 2014 Colibri Ltd. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"
#import "SuggestingViewController.h"
#import "VotingViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"in here");
    
    //do this so it listen from any view and works accordingly
    
     self.firebase = [[Firebase alloc] initWithUrl:kFirechatNSPhase];
    
    [self.firebase observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        
        NSLog(@"snapshot value %@", snapshot.value);
        
        self.phase = snapshot.value;
        
        
        if ([self.phase isEqualToString:@"suggest"]) {
            SuggestingViewController *suggestingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SuggestingViewController"];
            
            [self presentViewController:suggestingViewController animated:YES completion:nil];
        } else if ([self.phase isEqualToString:@"vote"]) {
            VotingViewController *votingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"VotingViewController"];
            
            [self presentViewController:votingViewController animated:YES completion:nil];
            
        }
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
