//
//  StoryCell.m
//  SocialStory
//
//  Created by Ingrid Funie on 12/10/2014.
//  Copyright (c) 2014 Colibri Ltd. All rights reserved.
//

#import "StoryCell.h"

@implementation StoryCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)init {
    
    self = [super init];
    
    return self;
    
}

- (IBAction)shareStory:(id)sender {
}
@end
