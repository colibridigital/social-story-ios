//
//  SuggestingViewController.m
//  SocialStory
//
//  Created by Ingrid Funie on 04/10/2014.
//  Copyright (c) 2014 Colibri Ltd. All rights reserved.
//

#import "SuggestingViewController.h"
#import "VotingViewController.h"
#import "AppDelegate.h"


@interface SuggestingViewController ()

@end

@implementation SuggestingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.suggestingProgress setProgress:0.0 animated:NO];
    
    [self startCount];
    
    NSString* firebasePhaseURL = [NSString stringWithFormat:@"%@/%@/phase", kFirechatNSStories, self.storyID];
    
    self.firebasePhase = [[Firebase alloc] initWithUrl:firebasePhaseURL];
    
    [self.firebasePhase observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        
        self.phase = snapshot.value;
        
        [self.myOtherTimer invalidate];
        self.myOtherTimer = nil;

        
        if ([self.phase isEqualToString:@"VOTE"]) {
            VotingViewController *votingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"VotingViewController"];
            
            votingViewController.storyID = self.storyID;
            
            [self presentViewController:votingViewController animated:YES completion:nil];
        }
        
        
    }];
    
   
    
    NSString* storyURL = [NSString stringWithFormat:@"%@/%@/story", kFirechatNSStories, self.storyID];
    
    self.firebase = [[Firebase alloc] initWithUrl:storyURL];
    
    [self.firebase observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        
        self.storyLine.text = snapshot.value;
        
    }];
    
    NSString* storyTitleURL = [NSString stringWithFormat:@"%@/%@/title", kFirechatNSStories, self.storyID];
    
    self.firebase = [[Firebase alloc] initWithUrl:storyTitleURL];
    
    [self.firebase observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        
        self.storyTitle.text = snapshot.value;
        
    }];


}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    
    NSLog(@"show suggestions view");
    
    [self.suggestingProgress setProgress:0.0 animated:NO];
    
    [self startCount];
   
    NSString* storyURL = [NSString stringWithFormat:@"%@/%@/story", kFirechatNSStories, self.storyID];
    
    self.firebase = [[Firebase alloc] initWithUrl:storyURL];
    
    NSLog(@"showing story...");
    
    [self.firebase observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        
        self.storyLine.text = snapshot.value;
        
    }];
    
    NSString* firebasePhaseURL = [NSString stringWithFormat:@"%@/%@/phase", kFirechatNSStories, self.storyID];
    
    self.firebasePhase = [[Firebase alloc] initWithUrl:firebasePhaseURL];

    
    [self.firebasePhase observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        
        NSLog(@"snapshot value %@", snapshot.value);
        
        self.phase = snapshot.value;
        
        if ([self.phase isEqualToString:@"VOTE"]) {
            VotingViewController *votingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"VotingViewController"];
            
            votingViewController.storyID = self.storyID;
            
            [self presentViewController:votingViewController animated:YES completion:nil];
        }
        
    }];
    
    NSString* storyTitleURL = [NSString stringWithFormat:@"%@/%@/title", kFirechatNSStories, self.storyID];
    
    self.firebase = [[Firebase alloc] initWithUrl:storyTitleURL];
    
    [self.firebase observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        
        self.storyTitle.text = snapshot.value;
        
    }];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startCount
{
    NSString* firebaseVoteTime = [NSString stringWithFormat:@"%@/%@/suggestTime", kFirechatNSStories, self.storyID];
    
    NSString* firebasePhaseStartedTime = [NSString stringWithFormat:@"%@/%@/phaseStarted", kFirechatNSStories, self.storyID];
    
    self.firebasePhase = [[Firebase alloc] initWithUrl:firebaseVoteTime];
    
    [self.firebasePhase observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        
        NSLog(@"voteTime value %@", snapshot.value);
        
        self.suggestTime = snapshot.value; //string
        
    }];
    
    self.firebasePhase = [[Firebase alloc] initWithUrl:firebasePhaseStartedTime];
    
    [self.firebasePhase observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        
        NSLog(@"phaseStarted value %@", snapshot.value);
        
        self.phaseStartedTime = snapshot.value; //string
        
    }];
    
    
    double time = [[NSDate date] timeIntervalSince1970]*1000;
    
    double phaseTime = [self.phaseStartedTime doubleValue];
    
    double remainingTime = (time - phaseTime);
    
    NSLog(@"time: %f, phaseTime: %f, remaining time : %f", time, phaseTime, remainingTime);
    
    double roundTime = ([self.suggestTime doubleValue] - remainingTime);
    
    NSLog(@"remaining time : %f, roundTime in double: %f, roundTime :%i", remainingTime, roundTime, (int)roundTime);
    
    self.myOtherTimer = [NSTimer scheduledTimerWithTimeInterval:(int)roundTime target:self selector:@selector(updateUI:) userInfo:nil repeats:YES];
}

- (void)updateUI:(NSTimer *)timer
{
    static int count =0; count++;
    
    if (count <=10)
    {
        NSLog(@"%i", count);
        
        [self.suggestingProgress setProgress:(float)count/10.0f animated:YES];
        
        //self.votingProgress.progress = (float)count/10.0f;
    } else
    {
        
        [self.myOtherTimer invalidate];
        self.myOtherTimer = nil;
        
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([self.suggestingWord isFirstResponder] && [touch view] != self.suggestingWord) {
        [self.suggestingWord resignFirstResponder];
    }
    
    [super touchesBegan:touches withEvent:event];
}

- (IBAction)suggestWord:(id)sender {
    
    NSString *word = self.suggestingWord.text;
    
    NSString* firebaseSuggestionsURL = [NSString stringWithFormat:@"%@/%@/suggestions", kFirechatNSStories, self.storyID];
    
    self.firebase = [[Firebase alloc] initWithUrl:firebaseSuggestionsURL];
    
    [[self.firebase childByAppendingPath:[NSString stringWithFormat:@"/%@", @"ingrid"]] setValue: word];
    
    NSLog(@"suggested %@", word);
    
   // [sender resignFirstResponder];
    
}

- (IBAction)goBackToMainView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)shareStory:(id)sender {
    NSString *textToShare = [NSString stringWithFormat:@"Looking forward to meet you at %@",self.storyTitle.text];
    
    NSArray *activityItems = [[NSArray alloc]  initWithObjects:textToShare, nil];
    
    UIActivity *activity = [[UIActivity alloc] init];
    NSArray *applicationActivities = [[NSArray alloc] initWithObjects:activity, nil];
    UIActivityViewController *activityVC =
    [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:applicationActivities];
    [self presentViewController:activityVC animated:YES completion:nil];
    
}
@end
