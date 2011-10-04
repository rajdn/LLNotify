/*
 Copyright (c) 2011 Liberati Luca http://www.liberatiluca.com
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 - The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 - The use of the Software in your (or your company) product, must include an attribution for my work in your (or your company) product (for example in the readme files, website and in the product itself).
 
 It's possible to have a non-attribution license, see: http://www.liberatiluca.com/components/licenses
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

#import "LLNotifyView.h"


@implementation LLNotifyView (Animation)


#pragma mark - Private methods

- (void)setupHideTimeout
{
    NSTimeInterval hideTimeout = [self hideTimeoutFromDelegate];
    
    if (hideTimeout > 0)
    {
        _hideTimer = [NSTimer scheduledTimerWithTimeInterval:hideTimeout
                                                      target:self
                                                    selector:@selector(hide)
                                                    userInfo:nil
                                                     repeats:NO];
    }
}


#pragma mark - Public methods

- (void)showAnimation
{
    CGRect startingViewFrame = self.frame;
    CGRect endingViewFrame = self.frame;
    
    LLNotifyAnimation showAnimation = [self showAnimationFromDelegate];
    switch (showAnimation)
    {
        case LLNotifyAnimationSlideUp:
            startingViewFrame = [self animationSlideUpStartingFrame];
            endingViewFrame = [self animationSlideUpShowFrame];
            break;
            
        case LLNotifyAnimationSlideDown:
            startingViewFrame = [self animationSlideDownStartingFrame];
            endingViewFrame = [self animationSlideDownShowFrame];
            break;
            
        case LLNotifyAnimationSlideLeft:
            startingViewFrame = [self animationSlideLeftStartingFrame];
            endingViewFrame = [self animationSlideLeftShowFrame];
            break;
            
        case LLNotifyAnimationSlideRight:
            startingViewFrame = [self animationSlideRightStartingFrame];
            endingViewFrame = [self animationSlideRightShowFrame];
            break;
            
        default:
            break;
    }
    
    self.frame = startingViewFrame;
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut
                     animations:^(void) {
                         
                         self.frame = endingViewFrame;
                         [_containerShadow setAlpha:1.0f];
                     }
                     completion:^(BOOL finished) {
                         
                         [self setupHideTimeout];
                         
                         _isAnimating = NO;
                     }
    ];
}

- (void)hideAnimation
{
    CGRect viewFrame = self.frame;
    
    LLNotifyAnimation hideAnimation = [self hideAnimationFromDelegate];
    switch (hideAnimation)
    {
        case LLNotifyAnimationSlideUp:
            viewFrame = [self animationSlideUpHideFrame];
            break;
            
        case LLNotifyAnimationSlideDown:
            viewFrame = [self animationSlideDownHideFrame];
            break;
            
        case LLNotifyAnimationSlideLeft:
            viewFrame = [self animationSlideLeftHideFrame];
            break;
            
        case LLNotifyAnimationSlideRight:
            viewFrame = [self animationSlideRightHideFrame];
            break;
            
        default:
            break;
    }
    
    _isAnimating = YES;
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut
                     animations:^(void) {
                         
                         self.frame = viewFrame;
                         [_containerShadow setAlpha:0.0f];
                     }
                     completion:^(BOOL finished){
                         
                         _isAnimating = NO;
                         
                         [self removeFromSuperview];
                         
                         [self.containerView removeFromSuperview];
                         _containerView = nil;
                         
                         if (_flags.delegateNotifyDidHide)
                         {
                             [self.delegate notifyViewDidHide:self];
                         }
                    }
    ];
}

@end
