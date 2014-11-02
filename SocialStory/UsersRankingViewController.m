//
//  UIViewController+UsersRankingViewController.m
//  SocialStory
//
//  Created by Ingrid Funie on 02/11/2014.
//  Copyright (c) 2014 Colibri Ltd. All rights reserved.
//

#import "UsersRankingViewController.h"
#import "RankingsCell.h"
#import "AppDelegate.h"


@interface UsersRankingViewController ()

@end

@implementation UsersRankingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString* firebaseRankingsURL = [NSString stringWithFormat:@"%@/", kFirechatNSRanking];
    
    NSLog(@"firebase URL %@", firebaseRankingsURL);
    
    self.firebase = [[Firebase alloc] initWithUrl:firebaseRankingsURL];
    
    // Initialize array that will store chat messages.
    self.rankings = nil;
    self.rankings = [[NSMutableArray alloc] init];
    
    NSLog(@"in the rankings view %@", firebaseRankingsURL);
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
        
        dispatch_sync(dispatch_get_main_queue(), ^(void) {
            
            NSLog(@"in the background thread");
            [self.firebase observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
                
                // NSData* data = [[NSData alloc]init];
                
                NSDictionary* data;
                
                if (![self.rankings containsObject:snapshot.value]) {
                    
                    // data = (NSData*)snapshot.value;
                    
                    data = (NSDictionary*)snapshot.value;
                    
                    [self.rankings addObject:data];
                    
                }
                
                NSLog(@"snapshot %@, data %@", snapshot.value, data);
                
                NSLog(@"rankings number: %lu", (unsigned long)[self.rankings count]);
                
                [self.rankingsTableView reloadData];
            }];
        });
        
    });
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    
    NSString* firebaseRankingsURL = [NSString stringWithFormat:@"%@", kFirechatNSRanking];
    
    NSLog(@"firebase URL %@", firebaseRankingsURL);
    
    self.firebase = [[Firebase alloc] initWithUrl:firebaseRankingsURL];
    
    // Initialize array that will store chat messages.
    self.rankings = nil;
    self.rankings = [[NSMutableArray alloc] init];
    
    NSLog(@"in the rankings view %@", firebaseRankingsURL);
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
        
        dispatch_sync(dispatch_get_main_queue(), ^(void) {
            
            NSLog(@"in the background thread");
            [self.firebase observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
                
                // NSData* data = [[NSData alloc]init];
                
                NSDictionary* data;
                
                if (![self.rankings containsObject:snapshot.value]) {
                    
                    // data = (NSData*)snapshot.value;
                    
                    data = (NSDictionary*)snapshot.value;
                    
                    [self.rankings addObject:data];
                }
                
                NSLog(@"snapshot %@, data %@", snapshot.value, data);
                
                NSLog(@"rankings number: %lu", (unsigned long)[self.rankings count]);
                
                [self.rankingsTableView reloadData];
            }];
        });
        
    });
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    if (tableView.tag == 0) {
        return [self.rankings count];
    } else {
        return 10;
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"showing cell");
    
    RankingsCell* cell = [tableView dequeueReusableCellWithIdentifier:@"RANKINGS" forIndexPath:indexPath];
    
    if (tableView.tag == 0) {
        
        if([self.rankings objectAtIndex:[indexPath row]] != nil) {
            
            NSLog(@"show object to use: %@", [self.rankings objectAtIndex:[indexPath row]]);
            
            NSDictionary* json = [self.rankings objectAtIndex:[indexPath row]];
            
            NSLog(@"show json %@", json);
            
            if (json != nil) {
                
                cell.userName.text = [json objectForKey:@"username"];
                
                cell.userScore.text = [NSString stringWithFormat:@"%@", [json objectForKey:@"score"] ];
                
                cell.userPosition.text =  [NSString stringWithFormat:@"%ld", (long)[indexPath row] ];
            }
            
        }
    }
    
    
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
