/*
 Copyright (c) 2011 Liberati Luca http://www.liberatiluca.com
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 - The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 - The use of the Software in your (or your company) product, must include an attribution for my work in your (or your company) product (for example in the readme files, website and in the product itself).
 
 It's possible to have a non-attribution license, see: http://www.liberatiluca.com/components/licenses
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

#import "LLNotifyView.h"


#define kViewMargin 8.0f


@implementation LLNotifyView (Update)

- (void)update
{
    if (!self.shouldUpdate) return;
    
    self.frame = [[self targetViewFromDelegate] bounds];
    
    [self updateViews];
    [self updateFrames];
    
    self.shouldUpdate = NO;
}

- (void)updateFrames
{
    CGSize iconSize = [self iconSizeFromDelegate];
    
    CGFloat viewWidth = CGRectGetWidth(self.bounds);
    
    
    // title
    CGRect titleViewFrame = {
        kViewMargin + iconSize.width + kViewMargin,
        kViewMargin,
        viewWidth - kViewMargin - iconSize.width - (kViewMargin * 2),
        0.0f
    };
    
    self.titleView.frame = titleViewFrame;
    
    [self.titleView sizeToFit];
    
    
    // message
    CGFloat titleMinX = CGRectGetMinX(self.titleView.frame);
    CGFloat titleMinY = CGRectGetMinY(self.titleView.frame);
    CGFloat titleHeight = CGRectGetHeight(self.titleView.frame);
    
    CGRect messageViewFrame = {
        titleMinX,
        titleMinY + titleHeight + kViewMargin,
        viewWidth - kViewMargin - iconSize.width - (kViewMargin * 2),
        0.0f
    };
    
    self.messageView.frame = messageViewFrame;
    
    [self.messageView sizeToFit];
    
    
    //view
    CGRect viewFrame = self.frame;
    
    viewFrame.size.height =
        self.titleView.frame.size.height +
        self.messageView.frame.size.height +
        (kViewMargin * 3);
    
    self.frame = viewFrame;
    
    
    // icon
    CGRect iconViewFrame = {
        kViewMargin,
        floor((self.bounds.size.height / 2) - (iconSize.height / 2)),
        iconSize.width,
        iconSize.height
    };
    
    self.iconView.frame = iconViewFrame;
}

- (void)updateViews
{
    UIImage *iconImage = [self iconFromDelegate];
    LLNotifyType type = [self typeFromDelegate];
    
    switch (type)
    {
        case LLNotifyTypeInfo:
            self.backgroundPrimaryColor = [UIColor colorWithRed:0.15f green:0.16f blue:0.2f alpha:0.94f];
            self.backgroundSecondaryColor = nil;
            
            self.titleView.shadowColor = [UIColor blackColor];
            self.titleView.textColor = [UIColor whiteColor];
            
            self.messageView.shadowColor = [UIColor blackColor];
            self.messageView.textColor = [UIColor whiteColor];
            
            break;
            
        case LLNotifyTypeAlert:
            self.backgroundPrimaryColor = [UIColor colorWithRed:0.98f green:0.86f blue:0.31f alpha:0.94f];
            self.backgroundSecondaryColor = [UIColor colorWithRed:0.92f green:0.86f blue:0.57f alpha:0.94f];
            self.invertedBackgroundColors = YES;
            
            self.titleView.shadowColor = [UIColor blackColor];
            self.titleView.textColor = [UIColor whiteColor];
            
            self.messageView.shadowColor = [UIColor blackColor];
            self.messageView.textColor = [UIColor whiteColor];
            
            break;
            
        case LLNotifyTypeError:
            self.backgroundPrimaryColor = [UIColor colorWithRed:0.68f green:0.22f blue:0.24f alpha:0.94f];
            self.backgroundSecondaryColor = [UIColor colorWithRed:0.85f green:0.22f blue:0.21f alpha:0.94f];
            self.invertedBackgroundColors = YES;
            
            self.titleView.shadowColor = [UIColor blackColor];
            self.titleView.textColor = [UIColor whiteColor];
            
            self.messageView.shadowColor = [UIColor blackColor];
            self.messageView.textColor = [UIColor whiteColor];
            
            break;
    }
    
    self.iconView.image = iconImage;
    self.titleView.text = [self titleFromDelegate];
    self.messageView.text = [self messageFromDelegate];
}

@end
