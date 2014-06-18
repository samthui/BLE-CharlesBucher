//
//  SavedDeivceTableViewCell.h
//  Light Bulbs Project
//
//  Created by Ngoc Phuong Thanh Nguyen on 6/19/14.
//  Copyright (c) 2014 KeyStoneSolar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SavedDeivceTableViewCell;
@protocol SavedDeivceTableViewCellDelegate<NSObject>
- (void) onBtnClickedInCell:(SavedDeivceTableViewCell*)cell;
- (void) offBtnClickedInCell:(SavedDeivceTableViewCell*)cell;
@end

@interface SavedDeivceTableViewCell : UITableViewCell

@property (nonatomic, retain)id<SavedDeivceTableViewCellDelegate> delegate;
@property(nonatomic, retain) IBOutlet UILabel* nameLabel;

-(IBAction)onBtnClicked:(id)sender;
-(IBAction)offBtnClicked:(id)sender;

@end
