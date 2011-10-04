/*
 Copyright (c) 2011 Liberati Luca http://www.liberatiluca.com
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 - The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 - The use of the Software in your (or your company) product, must include an attribution for my work in your (or your company) product (for example in the readme files, website and in the product itself).
 
 It's possible to have a non-attribution license, see: http://www.liberatiluca.com/components/licenses
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

#import "LLNotifyView.h"


@implementation LLNotifyView (DelegateMethods)

- (LLNotifyType)typeFromDelegate
{
    LLNotifyType type = LLNotifyTypeInfo;
    
    if (_flags.delegateType)
    {
        type = [self.delegate typeForNotifyView:self];
    }
    
    return type;
}

- (LLNotifyPosition)positionFromDelegate
{
    LLNotifyPosition position = LLNotifyPositionTop;
    
    if (_flags.delegateType)
    {
        position = [self.delegate positionForNotifyView:self];
    }
    
    return position;
}

- (LLNotifyAnimation)showAnimationFromDelegate
{
    LLNotifyAnimation showAnimation = LLNotifyAnimationSlideDown;
    
    if (_flags.delegateShowAnimation)
    {
        showAnimation = [self.delegate showAnimationForNotifyView:self];
    }
    
    return showAnimation;
}

- (LLNotifyAnimation)hideAnimationFromDelegate
{
    LLNotifyAnimation hideAnimation = LLNotifyAnimationSlideUp;
    
    if (_flags.delegateHideAnimation)
    {
        hideAnimation = [self.delegate hideAnimationForNotifyView:self];
    }
    
    return hideAnimation;
}

- (UIImage *)iconFromDelegate
{
    UIImage *icon = nil;
    
    if (_flags.delegateIcon)
    {
        icon = [self.delegate iconForNotifyView:self];
    }
    
    return icon;
}

- (NSString *)messageFromDelegate
{
    NSString *message = nil;
    
    if (_flags.delegateMessage)
    {
        message = [self.delegate messageForNotifyView:self];
    }
    
    return message;
}

- (NSString *)titleFromDelegate
{
    NSString *title = nil;
    
    if (_flags.delegateIcon)
    {
        title = [self.delegate titleForNotifyView:self];
    }
    
    return title;
}

- (UIView *)targetViewFromDelegate
{
    UIView *targetView = nil;
    
    if (_flags.delegateTargetView)
    {
        targetView = [self.delegate targetViewForNotifyView:self];
    }
    
    return targetView;
}

- (CGSize)iconSizeFromDelegate
{
    CGSize iconSize = CGSizeZero;
    
    if (_flags.delegateIconSize)
    {
        iconSize = [self.delegate iconSizeForNotifyView:self];
    }
    
    return iconSize;
}

- (NSTimeInterval)hideTimeoutFromDelegate
{
    NSTimeInterval hideTimeout = 6;
    if (_flags.delegateHideTimeout)
    {
        hideTimeout = [self.delegate hideTimeoutForNotifyView:self];
    }
    
    return hideTimeout;
}

- (CGFloat)topMarginFromDelegate
{
    CGFloat topMargin = 0.0f;
    
    if (_flags.delegateTopMargin)
    {
        topMargin = [self.delegate topMarginForNotifyView:self];
    }
    
    return topMargin;
}

@end
