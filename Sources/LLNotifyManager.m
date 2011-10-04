/*
 Copyright (c) 2011 Liberati Luca http://www.liberatiluca.com
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 - The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 - The use of the Software in your (or your company) product, must include an attribution for my work in your (or your company) product (for example in the readme files, website and in the product itself).
 
 It's possible to have a non-attribution license, see: http://www.liberatiluca.com/components/licenses
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

#import "LLNotifyManager.h"


// shared instance
static LLNotifyManager *sharedManager = nil;


@interface LLNotifyManager ()
@property (nonatomic, retain) NSMutableArray *internalQueue;
@property (nonatomic, assign) LLNotify *currentNotification;
@property (nonatomic, assign) BOOL running;

- (void)showNext;
@end


@implementation LLNotifyManager

//private
@synthesize internalQueue=_internalQueue;
@synthesize currentNotification=_currentNotification;
@synthesize running=_running;
// public
@synthesize notificationsQueue=_notificationsQueue;
@synthesize notifyView=_notifyView;


#pragma mark - Class lifecycle

- (void)dealloc
{
    [_internalQueue release];
    [_currentNotification release];
    
    [_notificationsQueue release];
    [_notifyView release];
    
    [super dealloc];
}

+ (id)alloc
{
    @synchronized([LLNotifyManager class])
	{
        NSAssert(sharedManager == nil, @"Attempted to allocate a second instance of a singleton.");
        
        sharedManager = [super alloc];
        return sharedManager;
	}
    
	return nil;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized([LLNotifyManager class])
    {
        NSAssert(sharedManager == nil, @"Attempted to allocate a second instance of a singleton.");
        
        sharedManager = [super allocWithZone:zone];
        return sharedManager;
    }
    
    return nil;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

+ (void)initialize
{
    if (self == [LLNotifyManager class])
    {
        sharedManager = [[self alloc] init];
    }
}

- (id)retain
{
    return self;
}

- (unsigned)retainCount
{
    return UINT_MAX;
} 

- (oneway void)release {}

- (id)autorelease
{
    return self;
}

+ (id)sharedManager
{
    return sharedManager;
}

- (id)init
{
    if ( !(self = [super init]) ) return nil;
    
    _internalQueue = [[NSMutableArray alloc] init];
    _running = NO;
    
    return self;
}


#pragma mark - Getters / Setters

- (NSArray *)notificationsQueue
{
    return [NSArray arrayWithArray:_internalQueue];
}


#pragma mark - Public methods

- (void)addNotificationToQueue:(LLNotify *)notify
{
    if (notify == nil) return;
    if ([notify isKindOfClass:[LLNotify class]] == NO) return;
    if ([_internalQueue containsObject:notify] == YES) return;
    
    if (notify.highPriority)
    {
        [_internalQueue insertObject:notify atIndex:0];
        [self.notifyView hide];
    }
    else
    {
        [_internalQueue addObject:notify];
    }
}

- (void)showNotifications
{
    if (self.running) return;
    if (_internalQueue.count == 0) return;
    
    self.running = YES;
    
    [self showNext];
}


#pragma mark - Private methods

- (void)showNext
{
    self.currentNotification = [_internalQueue objectAtIndex:0];
    
    _notifyView = nil;
    _notifyView = [[LLNotifyView alloc] initWithFrame:CGRectZero];
    _notifyView.delegate = self;
    
    [self.notifyView show];
}


#pragma mark - LLNotifyViewDelegate callbacks

- (void)notifyViewDidHide:(LLNotifyView *)notifyView
{
    if ([_internalQueue containsObject:self.currentNotification])
    {
        [_internalQueue removeObject:self.currentNotification];
    }
    
    self.currentNotification = nil;
    
    if (_internalQueue.count > 0)
    {
        [self showNext];
    }
    else
    {
        self.running = NO;
    }
}

- (UIImage *)iconForNotifyView:(LLNotifyView *)notifyView
{
    return self.currentNotification.icon;
}

- (NSString *)messageForNotifyView:(LLNotifyView *)notifyView
{
    return self.currentNotification.message;
}

- (NSString *)titleForNotifyView:(LLNotifyView *)notifyView
{
    return self.currentNotification.title;
}

- (LLNotifyType)typeForNotifyView:(LLNotifyView *)notifyView
{
    return self.currentNotification.type;
}

- (LLNotifyPosition)positionForNotifyView:(LLNotifyView *)notifyView
{
    return self.currentNotification.position;
}

- (LLNotifyAnimation)showAnimationForNotifyView:(LLNotifyView *)notifyView
{
    return self.currentNotification.showAnimation;
}

- (LLNotifyAnimation)hideAnimationForNotifyView:(LLNotifyView *)notifyView
{
    return self.currentNotification.hideAnimation;
}

- (UIView *)targetViewForNotifyView:(LLNotifyView *)notifyView
{
    return self.currentNotification.targetView;
}

- (CGSize)iconSizeForNotifyView:(LLNotifyView *)notifyView
{
    return [self.currentNotification sizeForIcon];
}

- (NSTimeInterval)hideTimeoutForNotifyView:(LLNotifyView *)notifyView
{
    return self.currentNotification.hideTimeout;
}

- (CGFloat)topMarginForNotifyView:(LLNotifyView *)notifyView
{
    return self.currentNotification.topMarginFromTargetView;
}

@end
