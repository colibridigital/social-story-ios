//
//  VotingViewController.h
//  SocialStory
//
//  Created by Ingrid Funie on 04/10/2014.
//  Copyright (c) 2014 Colibri Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>

@interface VotingViewController : UIViewController 
@property (nonatomic) IBOutlet UIProgressView *votingProgress;
@property (weak, nonatomic) NSTimer *myTimer;
@property (weak, nonatomic) IBOutlet UILabel *storyTitle;

@property (weak, nonatomic) IBOutlet UIButton *firstWord;
@property (weak, nonatomic) IBOutlet UIButton *secondWord;
@property (weak, nonatomic) IBOutlet UIButton *thirdWord;
@property (weak, nonatomic) IBOutlet UIButton *forthWord;
@property (weak, nonatomic) IBOutlet UIButton *fifthWord;
@property (weak, nonatomic) IBOutlet UIButton *sixthWord;

@property (weak, nonatomic) IBOutlet UITextView *storyLine;

@property (nonatomic, strong) NSMutableArray* words;
@property (nonatomic, strong) Firebase* firebase;
@property (nonatomic, strong) Firebase* firebasePhase;

@property (nonatomic) NSString *phase;
@property (nonatomic) NSString *storyID;

- (IBAction)shareStory:(id)sender;

- (IBAction)vote1:(id)sender;
- (IBAction)vote2:(id)sender;
- (IBAction)vote3:(id)sender;
- (IBAction)vote4:(id)sender;
- (IBAction)vote5:(id)sender;
- (IBAction)vote6:(id)sender;

- (IBAction)goBackToMainView:(id)sender;

@end
