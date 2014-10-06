//
//  AppDelegate.h
//  SocialStory
//
//  Created by Ingrid Funie on 04/10/2014.
//  Copyright (c) 2014 Colibri Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kFirechatNSSugestions @"https://colibristory.firebaseio.com/social-story/1/suggestions"
#define kFirechatNSVotes @"https://colibristory.firebaseio.com/social-story/1/votes"
#define kFirechatNSWords @"https://colibristory.firebaseio.com/social-story/1/words"
#define kFirechatNSStory @"https://colibristory.firebaseio.com/social-story/1/story"
#define kFirechatNSPhase @"https://colibristory.firebaseio.com/social-story/1/attributes/phase"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

