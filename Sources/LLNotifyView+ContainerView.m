/*
 Copyright (c) 2011 Liberati Luca http://www.liberatiluca.com
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 - The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 - The use of the Software in your (or your company) product, must include an attribution for my work in your (or your company) product (for example in the readme files, website and in the product itself).
 
 It's possible to have a non-attribution license, see: http://www.liberatiluca.com/components/licenses
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

#import "LLNotifyView.h"


@implementation LLNotifyView (Container)

#pragma mark - Private methods

- (CGRect)containerFramePositionModal
{
    CGRect containerFrame = [[UIScreen mainScreen] applicationFrame];
    
    return containerFrame;
}

- (CGRect)containerFramePositionTop
{
    UIView *targetView = [self targetViewFromDelegate];
    
    CGRect containerFrame = targetView.bounds;
    
    BOOL targetIsWindow = [targetView isMemberOfClass:[UIWindow class]];
    
    if (targetIsWindow)
    {
        CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
        
        if (statusBarFrame.size.height > 0)
        {
            containerFrame.origin.y += statusBarFrame.size.height;
        }
    }
    
    containerFrame.origin.y += [self topMarginFromDelegate];
    containerFrame.size.height = self.frame.size.height + 5.0f; // 5.0 is padding
    
    return containerFrame;
}

- (CGRect)containerFramePositionBottom
{
    UIView *targetView = [self targetViewFromDelegate];
    
    CGRect containerFrame = targetView.bounds;
    
    containerFrame.origin.y = targetView.bounds.size.height - self.frame.size.height;
    containerFrame.size.height = self.frame.size.height;
    
    return containerFrame;
}

- (CGRect)containerFramePositionLeft
{
    UIView *targetView = [self targetViewFromDelegate];
    
    CGRect containerFrame = targetView.bounds;
    
    containerFrame.origin.y = floorf((targetView.bounds.size.height / 2) - (self.frame.size.height / 2));
    containerFrame.size.height = self.frame.size.height;
    
    return containerFrame;
}

- (CGRect)containerFramePositionRight
{
    UIView *targetView = [self targetViewFromDelegate];
    
    CGRect containerFrame = targetView.bounds;
    
    containerFrame.origin.x = targetView.bounds.size.width - self.frame.size.width;
    containerFrame.origin.y = floorf((targetView.bounds.size.height / 2) - (self.frame.size.height / 2));
    containerFrame.size.height = self.frame.size.height;
    
    return containerFrame;
}


#pragma mark - Public methods

- (void)initContainerView
{
    CGRect containerFrame = CGRectZero;
    
    UIView *targetView = [self targetViewFromDelegate];
    BOOL isModal = NO;
    
    LLNotifyPosition position= [self positionFromDelegate];
    switch (position)
    {
//        case LLNotifyPositionModal:
//        {
//            isModal = YES;
//            containerFrame = [self containerFramePositionModal];
//            break;
//        }
        
        case LLNotifyPositionTop:
            containerFrame = [self containerFramePositionTop];
            
            _containerShadow = [[UIImageView alloc] initWithImage:[self topShadowImage]];
            [_containerShadow setFrame:[self topShadowFrame]];
            break;
            
        case LLNotifyPositionBottom:
            containerFrame = [self containerFramePositionBottom];
            
            _containerShadow = [[UIImageView alloc] initWithImage:[self bottomShadowImage]];
            [_containerShadow setFrame:[self bottomShadowFrame]];
            break;
            
        case LLNotifyPositionLeft:
            containerFrame = [self containerFramePositionLeft];
            
            _containerShadow = [[UIImageView alloc] initWithImage:[self leftShadowImage]];
            [_containerShadow setFrame:[self leftShadowFrame]];
            break;
            
        case LLNotifyPositionRight:
            containerFrame = [self containerFramePositionRight];
            
            _containerShadow = [[UIImageView alloc] initWithImage:[self rightShadowImage]];
            [_containerShadow setFrame:[self rightShadowFrame]];
            break;
    }
    
    [_containerShadow setContentMode:UIViewContentModeScaleToFill];
    [_containerShadow setAlpha:0.0f];
    
    if (isModal)
    {
        _containerView = [[UIWindow alloc] initWithFrame:containerFrame];
        
        [self.containerView setWindowLevel:UIWindowLevelAlert];
        [self.containerView makeKeyAndVisible];
        
        [self.containerView addSubview:self];
    }
    else
    {
        _containerView = [[UIView alloc] initWithFrame:containerFrame];
        
        [_containerView addSubview:self];
        [_containerView insertSubview:_containerShadow aboveSubview:self];
        
        [targetView addSubview:_containerView];
    }
    
    [self.containerView setBackgroundColor:[UIColor clearColor]];
    [self.containerView setClipsToBounds:YES];
}

- (UIImage *)topShadowImage
{
    return [UIImage imageNamed:@"notify_view_top_shadow"];
}

- (UIImage *)bottomShadowImage
{
    return [UIImage imageNamed:@"notify_view_bottom_shadow"];
}

- (UIImage *)leftShadowImage
{
    return [UIImage imageNamed:@"notify_view_left_shadow"];
}

- (UIImage *)rightShadowImage
{
    return [UIImage imageNamed:@"notify_view_right_shadow"];
}

- (CGRect)topShadowFrame
{
    UIImage *topShadow = [self topShadowImage];
    
    CGRect shadowViewFrame = {
        shadowViewFrame.origin.x = 0.0f,
        shadowViewFrame.origin.y = 0.0f,
        shadowViewFrame.size.width = self.bounds.size.width,
        shadowViewFrame.size.height = topShadow.size.height
    };
    
    return shadowViewFrame;
}

- (CGRect)bottomShadowFrame
{
    UIImage *bottomShadow = [self bottomShadowImage];
    
    CGRect shadowViewFrame = {
        shadowViewFrame.origin.x = 0.0f,
        shadowViewFrame.origin.y = self.bounds.size.height - bottomShadow.size.height,
        shadowViewFrame.size.width = self.bounds.size.width,
        shadowViewFrame.size.height = bottomShadow.size.height
    };
    
    return shadowViewFrame;
}

- (CGRect)leftShadowFrame
{
    UIImage *leftShadow = [self leftShadowImage];
    
    CGRect shadowViewFrame = {
        shadowViewFrame.origin.x = 0.0f,
        shadowViewFrame.origin.y = 0.0f,
        shadowViewFrame.size.width = leftShadow.size.width,
        shadowViewFrame.size.height = self.bounds.size.height
    };
    
    return shadowViewFrame;
}

- (CGRect)rightShadowFrame
{
    UIImage *rightShadow = [self rightShadowImage];
    
    CGRect shadowViewFrame = {
        shadowViewFrame.origin.x = self.bounds.size.width - rightShadow.size.width,
        shadowViewFrame.origin.y = 0.0f,
        shadowViewFrame.size.width = rightShadow.size.width,
        shadowViewFrame.size.height = self.bounds.size.height
    };
    
    return shadowViewFrame;
}

@end
