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
    
     NSString* storyID = @"10"; //to get this
    
    NSString* firebasePhaseURL = [NSString stringWithFormat:@"%@/%@/attributes/phase", kFirechatNSStories, storyID];
    
    self.firebasePhase = [[Firebase alloc] initWithUrl:firebasePhaseURL];
    
    [self.firebasePhase observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        
        self.phase = snapshot.value;
        
        [self.myOtherTimer invalidate];
        self.myOtherTimer = nil;

        
        if ([self.phase isEqualToString:@"VOTE"]) {
            VotingViewController *votingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"VotingViewController"];
            
            [self presentViewController:votingViewController animated:YES completion:nil];
        }
        
        
    }];
    
   
    
    NSString* storyURL = [NSString stringWithFormat:@"%@/%@/attributes/story", kFirechatNSStories, storyID];
    
    self.firebase = [[Firebase alloc] initWithUrl:storyURL];
    
    [self.firebase observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        
        self.storyLine.text = snapshot.value;
        
    }];

}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    
    NSLog(@"show suggestions view");
    
    [self.suggestingProgress setProgress:0.0 animated:NO];
    
    [self startCount];
    
    NSString* storyID = @"10"; //to get this
    
    NSString* storyURL = [NSString stringWithFormat:@"%@/%@/attributes/story", kFirechatNSStories, storyID];
    
    self.firebase = [[Firebase alloc] initWithUrl:storyURL];
    
    NSLog(@"showing story...");
    
    [self.firebase observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        
        self.storyLine.text = snapshot.value;
        
    }];
    
    NSString* firebasePhaseURL = [NSString stringWithFormat:@"%@/%@/attributes/phase", kFirechatNSStories, storyID];
    
    self.firebasePhase = [[Firebase alloc] initWithUrl:firebasePhaseURL];

    
    [self.firebasePhase observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        
        NSLog(@"snapshot value %@", snapshot.value);
        
        self.phase = snapshot.value;
        
        if ([self.phase isEqualToString:@"VOTE"]) {
            VotingViewController *votingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"VotingViewController"];
            
            [self presentViewController:votingViewController animated:YES completion:nil];
        }
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startCount
{
    self.myOtherTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(updateUI:) userInfo:nil repeats:YES];
}

- (void)updateUI:(NSTimer *)timer
{
    static int count =0; count++;
    
    if (count <=30)
    {
        NSLog(@"%i", count);
        
        [self.suggestingProgress setProgress:(float)count/30.0f animated:YES];
        
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
    
    //add the user here
    
    NSString* storyID = @"10"; //to get this
    
    NSString* firebaseSuggestionsURL = [NSString stringWithFormat:@"%@/%@/suggestions", kFirechatNSStories, storyID];
    
    self.firebase = [[Firebase alloc] initWithUrl:firebaseSuggestionsURL];
    
    [[self.firebase childByAppendingPath:[NSString stringWithFormat:@"/%@", @"ingrid"]] setValue: word];
    
    NSLog(@"suggested %@", word);
    
   // [sender resignFirstResponder];
    
}
@end
