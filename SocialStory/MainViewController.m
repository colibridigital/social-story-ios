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
#import "AuthViewController.h"
#import "StoryCell.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"in here");
    
    //NSString* storyID = @"10"; //to get this
    
    NSString* firebaseStoriesURL = [NSString stringWithFormat:@"%@", kFirechatNSStories];
    
    self.firebase = [[Firebase alloc] initWithUrl:firebaseStoriesURL];
    
    // Initialize array that will store chat messages.
    self.stories = nil;
    self.stories = [[NSMutableArray alloc] init];
    
    self.storiesIDs = nil;
    self.storiesIDs = [[NSMutableArray alloc] init];
    
    NSLog(@"in the main view %@", firebaseStoriesURL);
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
        
        dispatch_sync(dispatch_get_main_queue(), ^(void) {
            
            NSLog(@"in the background thread");
            [self.firebase observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
                
                // NSData* data = [[NSData alloc]init];
                
                NSDictionary* data;
                
                if (![self.stories containsObject:snapshot.value]) {
                    
                    // data = (NSData*)snapshot.value;
                    
                    data = (NSDictionary*)snapshot.value;
                    
                    [self.stories addObject:data];
                    [self.storiesIDs addObject:snapshot.name];
                }
                
                //  NSLog(@"snapshot %@, data %@", snapshot.value, data);
                
                NSLog(@"stories number: %lu", (unsigned long)[self.stories count]);
                
                [self.topStoriesTableView reloadData];
            }];
        });
        
    });
}



-(void)viewDidAppear:(BOOL)animated {
    
    NSLog(@"in here");
    
    //NSString* storyID = @"10"; //to get this
    
    NSString* firebaseStoriesURL = [NSString stringWithFormat:@"%@", kFirechatNSStories];
    
    self.firebase = [[Firebase alloc] initWithUrl:firebaseStoriesURL];
    
    // Initialize array that will store chat messages.
    self.stories = nil;
    self.stories = [[NSMutableArray alloc] init];
    
    self.storiesIDs = nil;
    self.storiesIDs = [[NSMutableArray alloc] init];
    
    NSLog(@"in the main view %@", firebaseStoriesURL);
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
        
        dispatch_sync(dispatch_get_main_queue(), ^(void) {
            
            NSLog(@"in the background thread");
            [self.firebase observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
                
                // NSData* data = [[NSData alloc]init];
                
                NSDictionary* data;
                
                if (![self.stories containsObject:snapshot.value]) {
                    
                    // data = (NSData*)snapshot.value;
                    
                    data = (NSDictionary*)snapshot.value;
                    
                    [self.stories addObject:data];
                    [self.storiesIDs addObject:snapshot.name];
                }
                
                //  NSLog(@"snapshot %@, data %@", snapshot.value, data);
                
                NSLog(@"stories number: %lu", (unsigned long)[self.stories count]);
                
                [self.topStoriesTableView reloadData];
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
        return [self.stories count];
    } else {
        return 3;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"showing cell");
    
    StoryCell* cell = [tableView dequeueReusableCellWithIdentifier:@"STORY" forIndexPath:indexPath];
    
    if (tableView.tag == 0) {
        
        NSLog(@"in showing top stories cells");
        
        if([self.stories objectAtIndex:[indexPath row]] != nil) {
            
            NSLog(@"show object to use: %@", [self.stories objectAtIndex:[indexPath row]]);
            
            NSDictionary* json = [self.stories objectAtIndex:[indexPath row]];
            
            NSLog(@"show json %@", json);
            
            if (json != nil) {
                
                cell.storyTitle.text = [json objectForKey:@"title"];
                
                int usersNumber = [[json objectForKey:@"users"] count];
                
                cell.usersNumber.text = [NSString stringWithFormat:@"%d",usersNumber];
                
                cell.mainViewController = self;
            }
            
        }
        
    }
    
    NSLog(@"indexPath %li", (long)[indexPath row]);
    
    
    // Configure the cell...*/
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.storyID = [self.storiesIDs objectAtIndex:[indexPath row]];
    
    NSString* firebasePhaseURL = [NSString stringWithFormat:@"%@/%@/phase", kFirechatNSStories, self.storyID];
    
    self.firebasePhase = [[Firebase alloc] initWithUrl:firebasePhaseURL];
    
    if (tableView.tag == 0) {
        
        [self.firebasePhase observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
            
            NSLog(@"snapshot value %@", snapshot.value);
            
            self.phase = snapshot.value;
            
            if ([self.phase isEqualToString:@"SUGGEST"]) {
                SuggestingViewController *suggestingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SuggestingViewController"];
                
                suggestingViewController.storyID = self.storyID;
                
                [self presentViewController:suggestingViewController animated:YES completion:nil];
                
            } else if ([self.phase isEqualToString:@"VOTE"]) {
                VotingViewController *votingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"VotingViewController"];
                
                votingViewController.storyID = self.storyID;
                
                [self presentViewController:votingViewController animated:YES completion:nil];
            }
            
        }];
    }
    
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

- (IBAction)logoutFromFacebook:(id)sender {
    AuthViewController *authViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AuthViewController"];
    
    authViewController.isLoggedIn = true;
    [self addChildViewController:authViewController];
    [self.view addSubview:authViewController.view];
    [authViewController didMoveToParentViewController:self];
}
@end
