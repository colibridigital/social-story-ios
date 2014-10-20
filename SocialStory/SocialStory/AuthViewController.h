//
//  AuthViewController.h
//  SocialStory
//
//  Created by James Cross on 19/10/2014.
//  Copyright (c) 2014 Colibri Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>

@interface AuthViewController : UIViewController
@property (nonatomic, strong) Firebase *ref;
@property (nonatomic) BOOL isLoggedIn;

@end
