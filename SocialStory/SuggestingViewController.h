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

@property NSTimer *myOtherTimer;

@property (weak, nonatomic) IBOutlet UITextView *storyLine;

@property (weak, nonatomic) IBOutlet UITextField *suggestingWord;

- (IBAction)suggestWord:(id)sender;

@property (nonatomic, strong) Firebase* firebase;
@end
