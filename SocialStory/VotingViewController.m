//
//  VotingViewController.m
//  SocialStory
//
//  Created by Ingrid Funie on 04/10/2014.
//  Copyright (c) 2014 Colibri Ltd. All rights reserved.
//

#import "VotingViewController.h"
#import "SuggestingViewController.h"
#import "AppDelegate.h"

@interface VotingViewController ()

@end

@implementation VotingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.firebase = [[Firebase alloc] initWithUrl:kFirechatNSStory];
    
   // self.storyLine.text = @"Nothing here yet";
    
    
   // self.votingProgress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    
   
    
    
    [self.firebase observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        
        NSLog(@"snapshot value %@", snapshot.value);
        
        self.storyLine.text = snapshot.value;
        
    }];
    
    [self setWords];
    
    NSLog(@"words counter : %lu", [self.words count]);
        
       /* [self.chat addObject:snapshot.value];
        
        NSString *currentStory = @"";
        
        self.storyLine.text = currentStory;
        
        for (NSString* word in self.chat) {
        
            self.storyLine.text = [currentStory stringByAppendingString:word];
        }
        
        [self.storyLine reloadInputViews];
        
    }];
    
    [self.firebase observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        // Reload the table view so that the intial messages show up
        [self.storyLine reloadInputViews];
    }];*/

 
 //  [self.votingProgress setProgress:0.0 animated:NO];
    
  // [self startCount];
    
}



- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    
    NSLog(@"show main view");
    
    
    [self.sixthWord setTitle:@"End." forState:UIControlStateNormal];
    
    self.firebase = [[Firebase alloc] initWithUrl:kFirechatNSStory];
    
    [self.firebase observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        
        NSLog(@"snapshot value %@", snapshot.value);
        
        self.storyLine.text = snapshot.value;
        
    }];
    
    [self setWords];
    
   // self.firebase = [[Firebase alloc] initWithUrl:kFirechatNSVotes];
    
    //    [self.votingProgress setProgress:0.0 animated:NO];
    
      //  [self startCount];
}

-(void)setWords {
    self.firebase = [[Firebase alloc] initWithUrl:kFirechatNSWords];
    
    // Initialize array that will store chat messages.
    self.words = nil;
     self.words = [[NSMutableArray alloc] init];
    
    
    [self.firebase observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
    
        if (![self.words containsObject:snapshot.name]) {
            [self.words addObject:snapshot.name];
        }
        
        NSLog(@"snapshot %@", snapshot.name);
        
        NSLog(@"words number: %lu", (unsigned long)[self.words count]);
        
        if ([self.words count] > 0 && [self.words count] < 2) {
            [self.firstWord setTitle:[self.words objectAtIndex:0] forState:UIControlStateNormal];
        } else if ([self.words count] > 1 && [self.words count] < 3) {
            [self.firstWord setTitle:[self.words objectAtIndex:0] forState:UIControlStateNormal];
            
            [self.secondWord setTitle:[self.words objectAtIndex:1] forState:UIControlStateNormal];
        } else if ([self.words count] > 2 && [self.words count] < 4) {
            [self.firstWord setTitle:[self.words objectAtIndex:0] forState:UIControlStateNormal];
            
            [self.secondWord setTitle:[self.words objectAtIndex:1] forState:UIControlStateNormal];
            
            [self.thirdWord setTitle:[self.words objectAtIndex:2] forState:UIControlStateNormal];
        } else if ([self.words count] > 3 && [self.words count] < 5) {
            [self.firstWord setTitle:[self.words objectAtIndex:0] forState:UIControlStateNormal];
            
            [self.secondWord setTitle:[self.words objectAtIndex:1] forState:UIControlStateNormal];
            
            [self.thirdWord setTitle:[self.words objectAtIndex:2] forState:UIControlStateNormal];
            
            [self.forthWord setTitle:[self.words objectAtIndex:3] forState:UIControlStateNormal];

        } else if ([self.words count] > 4 && [self.words count] < 6) {
            [self.firstWord setTitle:[self.words objectAtIndex:0] forState:UIControlStateNormal];
            
            [self.secondWord setTitle:[self.words objectAtIndex:1] forState:UIControlStateNormal];
            
            [self.thirdWord setTitle:[self.words objectAtIndex:2] forState:UIControlStateNormal];
            
            [self.forthWord setTitle:[self.words objectAtIndex:3] forState:UIControlStateNormal];
            
            [self.fifthWord setTitle:[self.words objectAtIndex:4] forState:UIControlStateNormal];

        }
      
        
    }];

    
}

- (void)startCount
{
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateUI:) userInfo:nil repeats:YES];
}

- (void)updateUI:(NSTimer *)timer
{
    static int count =0; count++;
    
    if (count <=10)
    {
        NSLog(@"%i", count);
        
        [self.votingProgress setProgress:(float)count/10.0f animated:YES];
        
        //self.votingProgress.progress = (float)count/10.0f;
    } else
    {
        
        [self.myTimer invalidate];
        self.myTimer = nil;
        
       // SuggestingViewController *suggestingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SuggestingViewController"];
        
       /* [self presentViewController:suggestingViewController animated:YES completion:nil];
        
        [self addChildViewController:suggestingViewController];
        [self.view addSubview:suggestingViewController.view];
        [suggestingViewController didMoveToParentViewController:self];*/
        
        
        
        SuggestingViewController *suggestingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SuggestingViewController"];
        
        [self presentViewController:suggestingViewController animated:YES completion:nil];
        
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


- (IBAction)vote1:(id)sender {
    
    //add the user here
    self.firebase = [[Firebase alloc] initWithUrl:kFirechatNSVotes];
    
    [[self.firebase childByAppendingPath:@"/ingrid"] setValue: self.firstWord.titleLabel.text];
    
    NSLog(@"voted %@", self.firstWord.titleLabel.text);

    
    SuggestingViewController *suggestingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SuggestingViewController"];
    
    [self presentViewController:suggestingViewController animated:YES completion:nil];
}

- (IBAction)vote2:(id)sender {
    //add the user here
    self.firebase = [[Firebase alloc] initWithUrl:kFirechatNSVotes];
    
    [[self.firebase childByAppendingPath:@"/ingrid"] setValue: self.secondWord.titleLabel.text];
    
    NSLog(@"voted %@", self.secondWord.titleLabel.text);
    
    
    SuggestingViewController *suggestingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SuggestingViewController"];
    
    [self presentViewController:suggestingViewController animated:YES completion:nil];

}

- (IBAction)vote3:(id)sender {
    //add the user here
    self.firebase = [[Firebase alloc] initWithUrl:kFirechatNSVotes];
    
    [[self.firebase childByAppendingPath:@"/ingrid"] setValue: self.thirdWord.titleLabel.text];
    
    NSLog(@"voted %@", self.thirdWord.titleLabel.text);
    
    
    SuggestingViewController *suggestingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SuggestingViewController"];
    
    [self presentViewController:suggestingViewController animated:YES completion:nil];

}

- (IBAction)vote4:(id)sender {
    //add the user here
    self.firebase = [[Firebase alloc] initWithUrl:kFirechatNSVotes];
    
    [[self.firebase childByAppendingPath:@"/ingrid"] setValue: self.forthWord.titleLabel.text];
    
    NSLog(@"voted %@", self.forthWord.titleLabel.text);
    
    
    SuggestingViewController *suggestingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SuggestingViewController"];
    
    [self presentViewController:suggestingViewController animated:YES completion:nil];

}

- (IBAction)vote5:(id)sender {
    //add the user here
    self.firebase = [[Firebase alloc] initWithUrl:kFirechatNSVotes];
    
    [[self.firebase childByAppendingPath:@"/ingrid"] setValue: self.fifthWord.titleLabel.text];
    
    NSLog(@"voted %@", self.fifthWord.titleLabel.text);
    
    
    SuggestingViewController *suggestingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SuggestingViewController"];
    
    [self presentViewController:suggestingViewController animated:YES completion:nil];
}

- (IBAction)vote6:(id)sender {
    //add the user here
    self.firebase = [[Firebase alloc] initWithUrl:kFirechatNSVotes];
    
    [[self.firebase childByAppendingPath:@"/ingrid"] setValue: self.sixthWord.titleLabel.text];
    
    NSLog(@"voted %@", self.sixthWord.titleLabel.text);
    
    
    SuggestingViewController *suggestingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SuggestingViewController"];
    
    [self presentViewController:suggestingViewController animated:YES completion:nil];

}
@end
