//
//  SavedDeviceTableViewCell
//  Light Bulbs Project
//
//  Created by Ngoc Phuong Thanh Nguyen on 6/19/14.
//  Copyright (c) 2014 KeyStoneSolar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SavedDeviceTableViewCell;
@protocol SavedDeviceTableViewCellDelegate<NSObject>
- (void) onBtnClickedInCell:(SavedDeviceTableViewCell*)cell;
- (void) offBtnClickedInCell:(SavedDeviceTableViewCell*)cell;
@end

@interface SavedDeviceTableViewCell : UITableViewCell

@property (nonatomic, retain)id<SavedDeviceTableViewCellDelegate> delegate;
@property(nonatomic, retain) IBOutlet UILabel* nameLabel;

-(IBAction)onBtnClicked:(id)sender;
-(IBAction)offBtnClicked:(id)sender;

@end
