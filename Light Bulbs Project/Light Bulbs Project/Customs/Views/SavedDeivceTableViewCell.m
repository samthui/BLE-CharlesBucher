//
//  SavedDeivceTableViewCell.m
//  Light Bulbs Project
//
//  Created by Ngoc Phuong Thanh Nguyen on 6/19/14.
//  Copyright (c) 2014 KeyStoneSolar. All rights reserved.
//

#import "SavedDeivceTableViewCell.h"

@implementation SavedDeivceTableViewCell

@synthesize delegate = _delegate;
@synthesize nameLabel;

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - IBActions
-(IBAction)onBtnClicked:(id)sender
{
    if (self.delegate && [_delegate respondsToSelector:@selector(onBtnClickedInCell:)]) {
        [_delegate onBtnClickedInCell:self];
    }
}

-(IBAction)offBtnClicked:(id)sender
{
    if (self.delegate && [_delegate respondsToSelector:@selector(offBtnClickedInCell:)]) {
        [_delegate offBtnClickedInCell:self];
    }
}

@end
