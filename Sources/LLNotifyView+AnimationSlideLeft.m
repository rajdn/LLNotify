/*
 Copyright (c) 2011 Liberati Luca http://www.liberatiluca.com
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 - The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 - The use of the Software in your (or your company) product, must include an attribution for my work in your (or your company) product (for example in the readme files, website and in the product itself).
 
 It's possible to have a non-attribution license, see: http://www.liberatiluca.com/components/licenses
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

#import "LLNotifyView.h"


@implementation LLNotifyView (AnimationSlideLeft)

- (CGRect)animationSlideLeftHideFrame
{
    UIView *targetView = [self targetViewFromDelegate];
    CGFloat targetViewWidth = CGRectGetWidth(targetView.frame);
    
    CGRect viewFrame = self.frame;
    
    viewFrame.origin.x = -targetViewWidth;
    
    return viewFrame;
}

- (CGRect)animationSlideLeftShowFrame
{
    LLNotifyPosition position = [self positionFromDelegate];
    UIView *targetView = [self targetViewFromDelegate];
    
    CGRect viewFrame = self.frame;
    
    CGFloat targetViewWidth = CGRectGetWidth(targetView.frame);
    CGFloat targetViewHeight = CGRectGetHeight(targetView.frame);
    CGFloat viewWidth = CGRectGetWidth(viewFrame);
    CGFloat viewHeight = CGRectGetHeight(viewFrame);
    
    switch (position)
    {
        case LLNotifyPositionTop:
            viewFrame.origin.x = 0.0f;
            viewFrame.origin.y = 0.0f;
            break;
            
        case LLNotifyPositionBottom:
            viewFrame.origin.x = 0.0f;
            viewFrame.origin.y = targetViewHeight - viewHeight;
            break;
            
        case LLNotifyPositionLeft:
            viewFrame.origin.x = 0.0f;
            break;
            
        case LLNotifyPositionRight:
            viewFrame.origin.x = targetViewWidth - viewWidth;
            break;
            
//        case LLNotifyPositionModal:
//            //TODO: to be implemented...
//            break;
    }

    return viewFrame;
}

- (CGRect)animationSlideLeftStartingFrame
{
    LLNotifyPosition position = [self positionFromDelegate];
    
    CGRect viewFrame = self.frame;
    
    CGFloat containerViewWidth = CGRectGetWidth([self.containerView frame]);
    CGFloat containerViewHeight = CGRectGetHeight([self.containerView frame]);
    CGFloat viewHeight = CGRectGetHeight(viewFrame);
    
    viewFrame.origin.x = containerViewWidth;
    
    switch (position)
    {
        case LLNotifyPositionTop:
            viewFrame.origin.y = 0.0f;
            break;
            
        case LLNotifyPositionBottom:
            viewFrame.origin.y = containerViewHeight - viewHeight;
            break;
            
        case LLNotifyPositionLeft:
        case LLNotifyPositionRight:
            viewFrame.origin.y = floorf((containerViewHeight / 2) - (viewHeight / 2));
            break;
            
//        case LLNotifyPositionModal:
//            //TODO: to be implemented...
//            break;
            
        default:
            break;
    }
    
    return viewFrame;
}

@end
