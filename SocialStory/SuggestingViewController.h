//
//  SuggestingViewController.h
//  SocialStory
//
//  Created by Ingrid Funie on 04/10/2014.
//  Copyright (c) 2014 Colibri Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>

@interface SuggestingViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIProgressView *suggestingProgress;

@property (weak, nonatomic) IBOutlet UILabel *storyTitle;
@property (weak, nonatomic) NSTimer *myOtherTimer;

@property (weak, nonatomic) IBOutlet UITextView *storyLine;

@property (weak, nonatomic) IBOutlet UITextField *suggestingWord;

- (IBAction)suggestWord:(id)sender;

@property (nonatomic, strong) Firebase* firebase;

@property (nonatomic, strong) Firebase* firebasePhase;
- (IBAction)goBackToMainView:(id)sender;
- (IBAction)shareStory:(id)sender;

@property (nonatomic) NSString *phase;
@property (nonatomic) NSString *storyID;
@property (nonatomic) NSString *suggestTime;
@property (nonatomic) NSString *phaseStartedTime;
@end
