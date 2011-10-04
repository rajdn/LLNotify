/*
 Copyright (c) 2011 Liberati Luca http://www.liberatiluca.com
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 - The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 - The use of the Software in your (or your company) product, must include an attribution for my work in your (or your company) product (for example in the readme files, website and in the product itself).
 
 It's possible to have a non-attribution license, see: http://www.liberatiluca.com/components/licenses
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

#import "LLNotify.h"


const struct LLNotifyConsts LLNotifyConsts =
{
    .iconMinSize = { 14.0f, 14.0f },
    .iconMaxSize = { 34.0f, 34.0f }
};


@implementation LLNotify

@synthesize type=_type;
@synthesize position=_position;
@synthesize showAnimation=_showAnimation;
@synthesize hideAnimation=_hideAnimation;
@synthesize icon=_icon;
@synthesize message=_message;
@synthesize title=_title;
@synthesize targetView=_targetView;
@synthesize hideTimeout=_hideTimeout;
@synthesize topMarginFromTargetView=_topMarginFromTargetView;
@synthesize highPriority=_highPriority;


#pragma mark - Class lifecycle

- (void)dealloc
{
    [_icon release];
    [_message release];
    [_title release];
    
    _targetView = nil;
    
    [super dealloc];
}

+ (LLNotify *)notification
{
    LLNotify *notify = [[self alloc] init];
    
    return [notify autorelease];
}

- (id)init
{
    if ( !(self = [super init]) ) return nil;
    
    _type = LLNotifyTypeInfo;
    _position = LLNotifyPositionTop;
    _showAnimation = LLNotifyAnimationSlideDown;
    _hideAnimation = LLNotifyAnimationSlideUp;
    _hideTimeout = 6;
    _topMarginFromTargetView = 0.0f;
    _highPriority = NO;
    
    return self;
}

#pragma mark - Private methods

- (CGFloat)clampValue:(CGFloat)value min:(CGFloat)min max:(CGFloat)max
{
    if (value < min) return min;
    if (value > max) return max;
    
    return value;
}


#pragma mark - Public methods

- (CGSize)sizeForIcon
{
    if (!self.icon) return CGSizeZero;
    
    CGSize iconSize = _icon.size;
    
    CGFloat minWidth = LLNotifyConsts.iconMinSize.width;
    CGFloat minHeight = LLNotifyConsts.iconMinSize.height;
    CGFloat maxWidth = LLNotifyConsts.iconMaxSize.width;
    CGFloat maxHeight = LLNotifyConsts.iconMaxSize.height;
    
    iconSize.width = [self clampValue:iconSize.width min:minWidth max:maxWidth];
    iconSize.height = [self clampValue:iconSize.height min:minHeight max:maxHeight];
    
    return iconSize;
}

@end
