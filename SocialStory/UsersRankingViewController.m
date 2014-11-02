//
//  UIViewController+UsersRankingViewController.m
//  SocialStory
//
//  Created by Ingrid Funie on 02/11/2014.
//  Copyright (c) 2014 Colibri Ltd. All rights reserved.
//

#import "UsersRankingViewController.h"
#import "RankingsCell.h"

@interface UsersRankingViewController ()

@end

@implementation UsersRankingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    
       
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    return 10;

}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"showing cell");
    
    RankingsCell* cell = [tableView dequeueReusableCellWithIdentifier:@"RANKINGS" forIndexPath:indexPath];
    
       
    // Configure the cell...*/
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)goBackHome:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
