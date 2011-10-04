/*
 Copyright (c) 2011 Liberati Luca http://www.liberatiluca.com
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 - The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 - The use of the Software in your (or your company) product, must include an attribution for my work in your (or your company) product (for example in the readme files, website and in the product itself).
 
 It's possible to have a non-attribution license, see: http://www.liberatiluca.com/components/licenses
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

#import "LLNotifyEnums.h"


@protocol LLNotifyViewDelegate;


/** LLNotifyView is a configurable view that contains a notification message, with a title and an icon */
@interface LLNotifyView : UIView
{
    id _containerView;
    id _containerShadow;
    BOOL _isAnimating;
    NSTimer *_hideTimer;
    
    struct
	{
        unsigned int delegateNotifyWillShow: 1;
        unsigned int delegateNotifyDidShow: 1;
        unsigned int delegateNotifyWillHide: 1;
        unsigned int delegateNotifyDidHide: 1;
        unsigned int delegateIcon: 1;
        unsigned int delegateMessage: 1;
        unsigned int delegateTitle: 1;
        unsigned int delegateType: 1;
        unsigned int delegatePosition: 1;
        unsigned int delegateShowAnimation: 1;
        unsigned int delegateHideAnimation: 1;
        unsigned int delegateTargetView: 1;
		unsigned int delegateIconSize: 1;
        unsigned int delegateHideTimeout: 1;
        unsigned int delegateTopMargin: 1;
	} _flags;
}

/** The delegate will be used to retrieve the model data.
 
 Don't set this property manually, it will be set by the manager!
 */
@property (nonatomic, assign) id <LLNotifyViewDelegate> delegate;

/** The image view for the icon */
@property (nonatomic, retain, readonly) UIImageView *iconView;

/** The label that contains the message */
@property (nonatomic, retain, readonly) UILabel *messageView;

/** The label that contains the title */
@property (nonatomic, retain, readonly) UILabel *titleView;

/** The background primary color.
 
 This is used to draw the background gradient and it's the default behavior.
 If you prefer a single color background, just set backgroundPrimaryColor.
 */
@property (nonatomic, retain) UIColor *backgroundPrimaryColor;

/** The background secondary color.
 
 This is used to draw the background gradient and it's the default behavior.
 If you prefer a single color background, just set backgroundPrimaryColor.
 */
@property (nonatomic, retain) UIColor *backgroundSecondaryColor;

/** If you want inverted colors in the gradient, set to YES, default is NO */
@property (nonatomic, assign) BOOL invertedBackgroundColors;

/** The container that will contain the view.
 
 It will be an UIView or UIWindow (if it's a modal notification).
 */
@property (nonatomic, retain, readonly) id containerView;

/** The container shadow */
@property (nonatomic, retain, readonly) id containerShadow;

/** Can be used to check if the view is animating */
@property (nonatomic, assign, readonly) BOOL isAnimating;

/** If is set to YES, the view is forced to redraw itself and update icon and texts views */
@property (nonatomic, assign) BOOL shouldUpdate;

/** Show the message view. It will be dismissed on user tap, on timer timeout or programmatically */
- (void)show;

/** Used to dismiss the message view programmatically */
- (void)hide;

@end


#pragma mark - Categories

@interface LLNotifyView (DelegateMethods)

- (LLNotifyType)typeFromDelegate;
- (LLNotifyPosition)positionFromDelegate;
- (LLNotifyAnimation)showAnimationFromDelegate;
- (LLNotifyAnimation)hideAnimationFromDelegate;
- (UIView *)targetViewFromDelegate;
- (UIImage *)iconFromDelegate;
- (NSString *)messageFromDelegate;
- (NSString *)titleFromDelegate;
- (CGSize)iconSizeFromDelegate;
- (NSTimeInterval)hideTimeoutFromDelegate;
- (CGFloat)topMarginFromDelegate;

@end


@interface LLNotifyView (Update)

- (void)update;
- (void)updateFrames;
- (void)updateViews;

@end


@interface LLNotifyView (Container)

- (void)initContainerView;

- (UIImage *)topShadowImage;
- (UIImage *)bottomShadowImage;
- (UIImage *)leftShadowImage;
- (UIImage *)rightShadowImage;

- (CGRect)topShadowFrame;
- (CGRect)bottomShadowFrame;
- (CGRect)leftShadowFrame;
- (CGRect)rightShadowFrame;

@end


@interface LLNotifyView (Animation)

- (void)showAnimation;
- (void)hideAnimation;

@end


@interface LLNotifyView (AnimationSlideDown)

- (CGRect)animationSlideDownHideFrame;
- (CGRect)animationSlideDownShowFrame;
- (CGRect)animationSlideDownStartingFrame;

@end


@interface LLNotifyView (AnimationSlideUp)

- (CGRect)animationSlideUpHideFrame;
- (CGRect)animationSlideUpShowFrame;
- (CGRect)animationSlideUpStartingFrame;

@end


@interface LLNotifyView (AnimationSlideLeft)

- (CGRect)animationSlideLeftHideFrame;
- (CGRect)animationSlideLeftShowFrame;
- (CGRect)animationSlideLeftStartingFrame;

@end


@interface LLNotifyView (AnimationSlideRight)

- (CGRect)animationSlideRightHideFrame;
- (CGRect)animationSlideRightShowFrame;
- (CGRect)animationSlideRightStartingFrame;

@end


#pragma mark - Protocols

/** LLNotifyViewDelegate protocol is used to retrieve information about the notification from the delegate (LLNotifyManager) */
@protocol LLNotifyViewDelegate <NSObject>

- (void)notifyViewDidHide:(LLNotifyView *)notifyView;

- (UIImage *)iconForNotifyView:(LLNotifyView *)notifyView;
- (NSString *)messageForNotifyView:(LLNotifyView *)notifyView;
- (NSString *)titleForNotifyView:(LLNotifyView *)notifyView;

- (CGSize)iconSizeForNotifyView:(LLNotifyView *)notifyView;

- (LLNotifyType)typeForNotifyView:(LLNotifyView *)notifyView;
- (LLNotifyPosition)positionForNotifyView:(LLNotifyView *)notifyView;
- (LLNotifyAnimation)showAnimationForNotifyView:(LLNotifyView *)notifyView;
- (LLNotifyAnimation)hideAnimationForNotifyView:(LLNotifyView *)notifyView;

- (UIView *)targetViewForNotifyView:(LLNotifyView *)notifyView;

- (NSTimeInterval)hideTimeoutForNotifyView:(LLNotifyView *)notifyView;
- (CGFloat)topMarginForNotifyView:(LLNotifyView *)notifyView;

@optional
- (void)notifyViewWillShow:(LLNotifyView *)notifyView;
- (void)notifyViewDidShow:(LLNotifyView *)notifyView;
- (void)notifyViewWillHide:(LLNotifyView *)notifyView;

@end
