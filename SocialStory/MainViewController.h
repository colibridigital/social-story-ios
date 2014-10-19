//
//  MainViewController.h
//  SocialStory
//
//  Created by Ingrid Funie on 06/10/2014.
//  Copyright (c) 2014 Colibri Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>

@interface MainViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) Firebase* firebase;
@property (nonatomic) NSString *phase;
@property (weak, nonatomic) IBOutlet UITableView *topStoriesTableView;
@property (weak, nonatomic) IBOutlet UITableView *myStoriesTableView;
@property (nonatomic) IBOutlet NSMutableArray *stories;

@end
