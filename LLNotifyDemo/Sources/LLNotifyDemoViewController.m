/* Copyright 2011 Liberati Luca. All rights reserved. */

#import "LLNotifyDemoViewController.h"

@implementation LLNotifyDemoViewController

@synthesize notifyManager, type, position, showAnimation, hideAnimation, targetView, typeButton, positionButton, showAnimationButton, hideAnimationButton, icon;

- (void)viewDidLoad
{
    self.notifyManager = [LLNotifyManager sharedManager];
    self.type = LLNotifyTypeInfo;
    self.icon = [UIImage imageNamed:@"icon_info"];
    self.position = LLNotifyPositionTop;
    self.showAnimation =LLNotifyAnimationSlideDown;
    self.hideAnimation = LLNotifyAnimationSlideUp;
}

- (void)viewDidUnload
{
    notifyManager = nil;
    
    [icon release];
    [targetView release];
    [typeButton release];
    [positionButton release];
    [showAnimationButton release];
    [hideAnimationButton release];
}

- (IBAction)addAndShow
{
    LLNotify *notification = [LLNotify notification];
    
    notification.type = self.type;
    notification.targetView = self.targetView;
    notification.icon = self.icon;
    notification.title = @"A notification";
    notification.message = @"This is a notification message!";
    notification.position = self.position;
    notification.showAnimation = self.showAnimation;
    notification.hideAnimation = self.hideAnimation;
    notification.hideTimeout = 3;
    
    [notifyManager addNotificationToQueue:notification];
    [notifyManager showNotifications];
}

- (IBAction)showSheet:(UIButton *)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] init];
    actionSheet.delegate = self;
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    
    NSString *title = nil;
    
    if ([sender isEqual:self.typeButton])
    {
        title = @"Notification type";
        
        [actionSheet addButtonWithTitle:@"Info"];
        [actionSheet addButtonWithTitle:@"Alert"];
        [actionSheet addButtonWithTitle:@"Error"];
        
        [actionSheet addButtonWithTitle:@"Cancel"];
        actionSheet.cancelButtonIndex = 3;
    }
    else if ([sender isEqual:self.positionButton])
    {
        title = @"Notification position";
        
        [actionSheet addButtonWithTitle:@"Top"];
        [actionSheet addButtonWithTitle:@"Bottom"];
        [actionSheet addButtonWithTitle:@"Left"];
        [actionSheet addButtonWithTitle:@"Right"];
        
        [actionSheet addButtonWithTitle:@"Cancel"];
        actionSheet.cancelButtonIndex = 4;
    }
    else if ([sender isEqual:self.showAnimationButton])
    {
        title = @"Notification show slide animation";
        
        [actionSheet addButtonWithTitle:@"Up"];
        [actionSheet addButtonWithTitle:@"Down"];
        [actionSheet addButtonWithTitle:@"Left"];
        [actionSheet addButtonWithTitle:@"Right"];

        [actionSheet addButtonWithTitle:@"Cancel"];
        actionSheet.cancelButtonIndex = 4;
    }
    else if ([sender isEqual:self.hideAnimationButton])
    {
        title = @"Notification hide slide animation";
        
        [actionSheet addButtonWithTitle:@"Up"];
        [actionSheet addButtonWithTitle:@"Down"];
        [actionSheet addButtonWithTitle:@"Left"];
        [actionSheet addButtonWithTitle:@"Right"];

        [actionSheet addButtonWithTitle:@"Cancel"];
        actionSheet.cancelButtonIndex = 4;
    }
    
    actionSheet.title = title;
    
    [actionSheet showInView:self.view];
    
    [actionSheet release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([actionSheet.title isEqualToString:@"Notification type"])
    {
        if (buttonIndex == 0)
        {
            self.type = LLNotifyTypeInfo;
            self.icon = [UIImage imageNamed:@"icon_info"];
            self.typeButton.titleLabel.text = @"Type: Info";
        }
        else if (buttonIndex == 1)
        {
            self.type = LLNotifyTypeAlert;
            self.icon = [UIImage imageNamed:@"icon_alert"];
            self.typeButton.titleLabel.text = @"Type: Alert";
        }
        else if (buttonIndex == 2)
        {
            self.type = LLNotifyTypeError;
            self.icon = [UIImage imageNamed:@"icon_error"];
            self.typeButton.titleLabel.text = @"Type: Error";
        }
    }
    else if ([actionSheet.title isEqualToString:@"Notification position"])
    {
        if (buttonIndex == 0)
        {
            self.position = LLNotifyPositionTop;
            
            self.positionButton.titleLabel.text = @"Position: Top";
        }
        else if (buttonIndex == 1)
        {
            self.position = LLNotifyPositionBottom;
            
            self.positionButton.titleLabel.text = @"Position: Bottom";
        }
        else if (buttonIndex == 2)
        {
            self.position = LLNotifyPositionLeft;
            
            self.positionButton.titleLabel.text = @"Position: Left";
        }
        else if (buttonIndex == 3)
        {
            self.position = LLNotifyPositionRight;
            
            self.positionButton.titleLabel.text = @"Position: Right";
        }
    }
    else if ([actionSheet.title isEqualToString:@"Notification show slide animation"])
    {
        if (buttonIndex == 0)
        {
            self.showAnimation = LLNotifyAnimationSlideUp;
            
            self.showAnimationButton.titleLabel.text = @"Show Anim: Slide Up";
        }
        else if (buttonIndex == 1)
        {
            self.showAnimation = LLNotifyAnimationSlideDown;
            
            self.showAnimationButton.titleLabel.text = @"Show Anim: Slide Down";
        }
        else if (buttonIndex == 2)
        {
            self.showAnimation = LLNotifyAnimationSlideLeft;
            
            self.showAnimationButton.titleLabel.text = @"Show Anim: Slide Left";
        }
        else if (buttonIndex == 3)
        {
            self.showAnimation = LLNotifyAnimationSlideRight;
            
            self.showAnimationButton.titleLabel.text = @"Show Anim: Slide Right";
        }
    }
    else if ([actionSheet.title isEqualToString:@"Notification hide slide animation"])
    {
        if (buttonIndex == 0)
        {
            self.hideAnimation = LLNotifyAnimationSlideUp;
            
            self.hideAnimationButton.titleLabel.text = @"Show Anim: Slide Up";
        }
        else if (buttonIndex == 1)
        {
            self.hideAnimation = LLNotifyAnimationSlideDown;
            
            self.hideAnimationButton.titleLabel.text = @"Show Anim: Slide Down";
        }
        else if (buttonIndex == 2)
        {
            self.hideAnimation = LLNotifyAnimationSlideLeft;
            
            self.hideAnimationButton.titleLabel.text = @"Show Anim: Slide Left";
        }
        else if (buttonIndex == 3)
        {
            self.hideAnimation = LLNotifyAnimationSlideRight;
            
            self.hideAnimationButton.titleLabel.text = @"Show Anim: Slide Right";
        }
    }
}

@end
