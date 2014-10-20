//
//  AuthViewController.m
//  SocialStory
//
//  Created by James Cross on 19/10/2014.
//  Copyright (c) 2014 Colibri Ltd. All rights reserved.
//

#import "AuthViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import <Firebase/Firebase.h>
#import "MainViewController.h"

@interface AuthViewController ()

@end

@implementation AuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FBLoginView *loginView = [[FBLoginView alloc] init];
    loginView.center = self.view.center;
    [self.view addSubview:loginView];
    
    self.ref = [[Firebase alloc] initWithUrl:@"https://colibristory.firebaseio.com"];
    
    // Open a session showing the user the login UI
    [FBSession openActiveSessionWithReadPermissions:@[@"public_profile"] allowLoginUI:YES
                                  completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
                                      
                                      if (error) {
                                          NSLog(@"Facebook login failed. Error: %@", error);
                                      } else if (state == FBSessionStateOpen) {
                                          NSString *accessToken = session.accessTokenData.accessToken;
                                          [self.ref authWithOAuthProvider:@"facebook" token:accessToken
                                                      withCompletionBlock:^(NSError *error, FAuthData *authData) {
                                                          
                                                          if (error) {
                                                              NSLog(@"Login failed. %@", error);
                                                          } else {
                                                              NSLog(@"Logged in! %@", authData);
                                                              if(!self.isLoggedIn) {
                                                                  MainViewController *mainViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
                                                                  
                                                                  [self addChildViewController:mainViewController];
                                                                  [self.view addSubview:mainViewController.view];
                                                                  [mainViewController didMoveToParentViewController:self];
                                                              }
                                                          }
                                                      }];
                                      }
                                  }];
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

@end
