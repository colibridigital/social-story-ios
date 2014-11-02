//
//  AppDelegate.h
//  SocialStory
//
//  Created by Ingrid Funie on 04/10/2014.
//  Copyright (c) 2014 Colibri Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

//#define kFirechatNSSugestions @"https://colibristory.firebaseio.com/social-story/suggestions"
//#define kFirechatNSVotes @"https://colibristory.firebaseio.com/social-story/votes"
//#define kFirechatNSWords @"https://colibristory.firebaseio.com/social-story/words"
#define kFirechatNSStories @"https://colibristory.firebaseio.com/social-story/live-stories"
#define kFirechatNSRanking @"https://colibristory.firebaseio.com/social-story/ranking/topTenUsers"
//#define kFirechatNSPhase @"https://colibristory.firebaseio.com/social-story/1/attributes/phase"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

