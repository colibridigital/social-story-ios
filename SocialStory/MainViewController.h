//
//  MainViewController.h
//  SocialStory
//
//  Created by Ingrid Funie on 06/10/2014.
//  Copyright (c) 2014 Colibri Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>

@interface MainViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UITabBarDelegate>

@property (nonatomic, strong) Firebase* firebase;

@property (nonatomic, strong) Firebase* firebasePhase;

@property (nonatomic) NSString *phase;
@property (weak, nonatomic) IBOutlet UITableView *topStoriesTableView;
@property (weak, nonatomic) IBOutlet UITableView *myStoriesTableView;
@property (nonatomic) IBOutlet NSMutableArray *stories;
@property (nonatomic) IBOutlet NSMutableArray *storiesIDs;
@property (nonatomic) NSString* storyID;
@property (weak, nonatomic) IBOutlet UITabBar *menuTabBar;



@end
