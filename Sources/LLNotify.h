/*
 Copyright (c) 2011 Liberati Luca http://www.liberatiluca.com
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 - The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 - The use of the Software in your (or your company) product, must include an attribution for my work in your (or your company) product (for example in the readme files, website and in the product itself).
 
 It's possible to have a non-attribution license, see: http://www.liberatiluca.com/components/licenses
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

#import "LLNotifyEnums.h"


// class constants
extern const struct LLNotifyConsts
{
    CGSize iconMinSize;
    CGSize iconMaxSize;
} LLNotifyConsts;


/** The model for the notification to be displayed */
@interface LLNotify : NSObject

@property (nonatomic, assign) LLNotifyType type;
@property (nonatomic, assign) LLNotifyPosition position;
@property (nonatomic, assign) LLNotifyAnimation showAnimation;
@property (nonatomic, assign) LLNotifyAnimation hideAnimation;

/** The icon associated with the notification.
 
 If this property is not set, default icons will be used.
 */
@property (nonatomic, copy) UIImage *icon;

/** The message to be displayed */
@property (nonatomic, copy) NSString *message;

/** The title of the message */
@property (nonatomic, copy) NSString *title;

/** The view from where to display the notification */
@property (nonatomic, assign) UIView *targetView;

/** After how many seconds you want to dismiss the notification */
@property (nonatomic, assign) NSTimeInterval hideTimeout;

/** Used if you want to adjust the top margin of the view (for example below a navigation bar) */
@property (nonatomic, assign) CGFloat topMarginFromTargetView;

/** Default is NO. If set to YES, it will be displayed immediately */
@property (nonatomic,assign) BOOL highPriority;

/** Convenience method that returns an autoreleased object */
+ (LLNotify *)notification;

/** Returns the calculated size for the icon */
- (CGSize)sizeForIcon;

@end
