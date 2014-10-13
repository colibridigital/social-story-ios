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
#import "StoryCell.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"in here");
    
    
    
    
    //do this so it listen from any view and works accordingly
    
   /* NSString* storyID = @"10"; //to get this
    
    NSString* storyURL = [NSString stringWithFormat:@"%@/%@/attributes/phase", kFirechatNSStories, storyID];
    
    NSLog(@"storyURL: %@", storyURL);
    
    self.firebase = [[Firebase alloc] initWithUrl:storyURL];
    
    [self.firebase observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        
        NSLog(@"snapshot name %@, value %@", snapshot.name, snapshot.value);
        
        self.phase = snapshot.value;
        
        
        if ([self.phase isEqualToString:@"SUGGEST"]) {
            SuggestingViewController *suggestingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SuggestingViewController"];
            
            [self presentViewController:suggestingViewController animated:YES completion:nil];
        } else if ([self.phase isEqualToString:@"VOTE"]) {
            VotingViewController *votingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"VotingViewController"];
            
            [self presentViewController:votingViewController animated:YES completion:nil];
            
        }
        
    }];*/
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 3;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"showing cell");
    
    
    StoryCell* cell = [tableView dequeueReusableCellWithIdentifier:@"STORY" forIndexPath:indexPath];

   
    // Configure the cell...
    return cell;
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
