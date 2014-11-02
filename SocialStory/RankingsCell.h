//
//  RankingsCell.h
//  SocialStory
//
//  Created by Ingrid Funie on 02/11/2014.
//  Copyright (c) 2014 Colibri Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RankingsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *userName;

@property (weak, nonatomic) IBOutlet UILabel *userPosition;

@property (weak, nonatomic) IBOutlet UILabel *userScore;

@end

