/* Copyright 2011 Liberati Luca. All rights reserved. */

#import "LLNotifyManager.h"


@interface LLNotifyDemoViewController : UIViewController <UIActionSheetDelegate>

@property (nonatomic, assign) LLNotifyManager *notifyManager;
@property (nonatomic, assign) LLNotifyType type;
@property (nonatomic, copy) UIImage *icon;
@property (nonatomic, assign) LLNotifyPosition position;
@property (nonatomic, assign) LLNotifyAnimation showAnimation;
@property (nonatomic, assign) LLNotifyAnimation hideAnimation;
@property (nonatomic, retain) IBOutlet UIView *targetView;
@property (nonatomic, retain) IBOutlet UIButton *typeButton;
@property (nonatomic, retain) IBOutlet UIButton *positionButton;
@property (nonatomic, retain) IBOutlet UIButton *showAnimationButton;
@property (nonatomic, retain) IBOutlet UIButton *hideAnimationButton;

- (IBAction)addAndShow;
- (IBAction)showSheet:(id)sender;

@end
