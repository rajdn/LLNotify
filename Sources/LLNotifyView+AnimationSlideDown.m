/*
 Copyright (c) 2011 Liberati Luca http://www.liberatiluca.com
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 - The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 - The use of the Software in your (or your company) product, must include an attribution for my work in your (or your company) product (for example in the readme files, website and in the product itself).
 
 It's possible to have a non-attribution license, see: http://www.liberatiluca.com/components/licenses
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

#import "LLNotifyView.h"


@implementation LLNotifyView (AnimationSlideDown)

- (CGRect)animationSlideDownHideFrame
{
    CGRect viewFrame = self.frame;    
    viewFrame.origin.y += viewFrame.size.height;
    
    return viewFrame;
}

- (CGRect)animationSlideDownShowFrame
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
            viewFrame.origin.y = 0.0f;
            break;
            
        case LLNotifyPositionBottom:
            viewFrame.origin.y = 0.0f;
            break;
            
        case LLNotifyPositionLeft:
            viewFrame.origin.y = floorf((targetViewHeight / 2) - (viewHeight / 2));
            break;
            
        case LLNotifyPositionRight:
            viewFrame.origin.x = targetViewWidth - viewWidth;
            viewFrame.origin.y = floorf((targetViewHeight / 2) - (viewHeight / 2));
            break;
            
//        case LLNotifyPositionModal:
//        {
//            CGRect screenBounds = [[UIScreen mainScreen] applicationFrame];
//            viewFrame.origin.x = floorf((screenBounds.size.width / 2) - (viewWidth / 2));
//            viewFrame.origin.y = floorf((screenBounds.size.height / 2) - (viewHeight / 2));
//            break;
//        }
    }
    
    return viewFrame;
}

- (CGRect)animationSlideDownStartingFrame
{
    CGRect viewFrame = self.frame;
    
    viewFrame.origin.x = 0.0f;
    viewFrame.origin.y = -viewFrame.size.height;
    
    return viewFrame;
}

@end
