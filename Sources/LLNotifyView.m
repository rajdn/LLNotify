/*
 Copyright (c) 2011 Liberati Luca http://www.liberatiluca.com
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 - The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 - The use of the Software in your (or your company) product, must include an attribution for my work in your (or your company) product (for example in the readme files, website and in the product itself).
 
 It's possible to have a non-attribution license, see: http://www.liberatiluca.com/components/licenses
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

#import "LLNotifyView.h"


@implementation LLNotifyView

@synthesize delegate=_delegate;
@synthesize iconView=_iconView;
@synthesize messageView=_messageView;
@synthesize titleView=_titleView;
@synthesize backgroundPrimaryColor=_backgroundPrimaryColor;
@synthesize backgroundSecondaryColor=_backgroundSecondaryColor;
@synthesize invertedBackgroundColors=_invertedBackgroundColors;
@synthesize containerView=_containerView;
@synthesize containerShadow=_containerShadow;
@synthesize isAnimating=_isAnimating;
@synthesize shouldUpdate=_shouldUpdate;


#pragma mark - Class lifecycle

- (void)dealloc
{
    _delegate = nil;
    
    [_iconView release];
    [_messageView release];
    [_titleView release];
    [_backgroundPrimaryColor release];
    [_backgroundSecondaryColor release];
    [_containerView release];
    [_hideTimer release];
    
    [super dealloc];
}

- (void)commonInit
{
    // view
    self.opaque = NO;
    
    //TODO: move to drawrect
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOffset = CGSizeMake(0.0, 1.0f);
    self.layer.shadowOpacity = 0.75f;
    self.layer.shadowRadius = 2.0f;
    self.layer.shouldRasterize = YES;
    
    
    _isAnimating = NO;
    _shouldUpdate = YES;
    
    // set a default icon
    _iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_info"]];
    _iconView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_iconView];
    
    _messageView = [[UILabel alloc] init];
    _messageView.adjustsFontSizeToFitWidth = NO;
    _messageView.backgroundColor = [UIColor clearColor];
    _messageView.font = DEFAULT_FONT(DEFAULT_FONTSIZE - 2.0f);
    _messageView.lineBreakMode = UILineBreakModeWordWrap;
    _messageView.numberOfLines = 0;
    _messageView.shadowOffset = CGSizeMake(0.0f, 1.0f);
    [self addSubview:_messageView];
    
    _titleView = [[UILabel alloc] init];
    _titleView.adjustsFontSizeToFitWidth = NO;
    _titleView.backgroundColor = [UIColor clearColor];
    _titleView.font = DEFAULT_BOLDFONT(DEFAULT_FONTSIZE - 1.0f);
    _titleView.lineBreakMode = UILineBreakModeWordWrap;
    _titleView.numberOfLines = 0;
    _titleView.shadowOffset = CGSizeMake(0.0f, 1.0f);
    [self addSubview:_titleView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
    [tapGesture addTarget:self action:@selector(hide)];
    [self addGestureRecognizer:tapGesture];
    [tapGesture release];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ( !(self = [super initWithCoder:aDecoder]) ) return nil;
    
    [self commonInit];
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if ( !(self = [super initWithFrame:frame]) ) return nil;
    
    [self commonInit];
    
    return self;
}

- (CGGradientRef)makeGradient
{
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    
    // gradient colors
    CGColorRef firstColor = (self.invertedBackgroundColors ?
                             (self.backgroundSecondaryColor != nil ? [self.backgroundSecondaryColor CGColor] : NULL) :
                             (self.backgroundPrimaryColor != nil ? [self.backgroundPrimaryColor CGColor] : NULL));
    
    CGColorRef secondColor = (self.invertedBackgroundColors ?
                              (self.backgroundPrimaryColor != nil ? [self.backgroundPrimaryColor CGColor] : NULL) :
                              (self.backgroundSecondaryColor != nil ? [self.backgroundSecondaryColor CGColor] : NULL));
    
    const CGFloat *firstColorComponents = CGColorGetComponents(firstColor);
    const CGFloat *secondColorComponents = CGColorGetComponents(secondColor);
    
    CGFloat colors[] =
    {
        firstColorComponents[0], firstColorComponents[1], firstColorComponents[2], firstColorComponents[3],
        secondColorComponents[0], secondColorComponents[1], secondColorComponents[2], secondColorComponents[3]
    };
    
    CGGradientRef gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors) / (sizeof(colors[0]) * 4));
    
    CGColorSpaceRelease(rgb);
    
    return (CGGradientRef) [(id)gradient autorelease];
}

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
    
    [[UIColor clearColor] setFill];
    [path fill];
    
    CGFloat maxX = CGRectGetMaxX(rect);
    CGFloat maxY = CGRectGetMaxY(rect);
    
    CGGradientRef gradient = NULL;
    if (self.backgroundPrimaryColor && self.backgroundSecondaryColor)
    {
        gradient = [self makeGradient];
    }
    
    if (gradient != NULL)
    {
        CGPoint startPoint = { rect.origin.x, 0.0f };
        CGPoint endPoint = { rect.origin.x, rect.size.height };
        
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        CGContextDrawLinearGradient(ctx, gradient, startPoint, endPoint, 0);
    }
    else
    {
        [self.backgroundPrimaryColor setFill];
        [path fill];
    }
    
    // top line
    [path moveToPoint:CGPointMake(0.0f, 0.0f)];
    [path addLineToPoint:CGPointMake(maxX, 0.0f)];
    
    [[UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.5f] setStroke];
    [path setLineWidth:2.0f];
    [path stroke];
    
    
    // bottom line
    [path moveToPoint:CGPointMake(0.0f, maxY)];
    [path addLineToPoint:CGPointMake(maxX, maxY)];
    
    [[UIColor colorWithWhite:0 alpha:1.0f] setStroke];
    [path setLineWidth:2.0f];
    [path stroke];
}


#pragma mark - Getters / Setters

- (void)setDelegate:(id <LLNotifyViewDelegate>)delegate
{
    if (!delegate) return;
    
    if (![delegate conformsToProtocol:@protocol(LLNotifyViewDelegate)])
    {
        [NSException raise:NSInvalidArgumentException format:@"The delegate object must conform to LLNotifyViewDelegate protocol"];
    }
    
    _delegate = delegate;
    
    _flags.delegateNotifyWillShow = [delegate respondsToSelector:@selector(notifyViewWillShow:)];
    _flags.delegateNotifyDidShow = [delegate respondsToSelector:@selector(notifyViewDidShow:)];
    _flags.delegateNotifyWillHide = [delegate respondsToSelector:@selector(notifyViewWillHide:)];
    _flags.delegateNotifyDidHide = [delegate respondsToSelector:@selector(notifyViewDidHide:)];
    _flags.delegateIcon = [delegate respondsToSelector:@selector(iconForNotifyView:)];
    _flags.delegateMessage = [delegate respondsToSelector:@selector(messageForNotifyView:)];
    _flags.delegateTitle = [delegate respondsToSelector:@selector(titleForNotifyView:)];
    _flags.delegateType = [delegate respondsToSelector:@selector(typeForNotifyView:)];
    _flags.delegatePosition = [delegate respondsToSelector:@selector(positionForNotifyView:)];
    _flags.delegateShowAnimation = [delegate respondsToSelector:@selector(showAnimationForNotifyView:)];
    _flags.delegateHideAnimation = [delegate respondsToSelector:@selector(hideAnimationForNotifyView:)];
    _flags.delegateTargetView = [delegate respondsToSelector:@selector(targetViewForNotifyView:)];
    _flags.delegateIconSize = [delegate respondsToSelector:@selector(iconSizeForNotifyView:)];
    _flags.delegateHideTimeout = [delegate respondsToSelector:@selector(hideTimeoutForNotifyView:)];
    _flags.delegateTopMargin = [delegate respondsToSelector:@selector(topMarginForNotifyView:)];
}

- (void)setShouldUpdate:(BOOL)shouldUpdate
{
    _shouldUpdate = shouldUpdate;
    
    [self setNeedsDisplay];
    [self update];
}


#pragma mark - Public methods

- (void)show
{
    [self update];
    [self initContainerView];
    
    _isAnimating = YES;
    
    [self showAnimation];
}

- (void)hide
{
    if (_flags.delegateNotifyWillHide)
    {
        [self.delegate notifyViewWillHide:self];
    }
    
    [_hideTimer invalidate];
    
    _isAnimating = YES;
    
    [self hideAnimation];
}


@end
