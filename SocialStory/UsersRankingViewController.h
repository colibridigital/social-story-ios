//
//  UsersRankingViewController.h
//  SocialStory
//
//  Created by Ingrid Funie on 02/11/2014.
//  Copyright (c) 2014 Colibri Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UsersRankingViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
- (IBAction)goBackHome:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *userID;
@property (weak, nonatomic) IBOutlet UILabel *score;
@property (weak, nonatomic) IBOutlet UITableView *rankingsTableView;
@property (nonatomic) IBOutlet NSMutableArray *rankings;
@property (weak, nonatomic) IBOutlet UILabel *userRanking;

@end
