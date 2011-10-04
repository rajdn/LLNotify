/*
 Copyright (c) 2011 Liberati Luca http://www.liberatiluca.com
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 - The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 - The use of the Software in your (or your company) product, must include an attribution for my work in your (or your company) product (for example in the readme files, website and in the product itself).
 
 It's possible to have a non-attribution license, see: http://www.liberatiluca.com/components/licenses
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

#import "LLNotifyView.h"
#import "LLNotify.h"


/** This class manages the queue of the notifications that needs to be displayed to the user */
@interface LLNotifyManager : NSObject <LLNotifyViewDelegate>

/** The notification queue.
 
 An array that contains the notifications that needs to be displayed.
 When a notification is displayed and then dismissed it will be removed from the queue.
 */
@property (nonatomic, assign, readonly) NSArray *notificationsQueue;

/** The notification view that contains the icon, title and message */
@property (nonatomic, retain, readonly) LLNotifyView *notifyView;

/** Shared instance of the manager */
+ (LLNotifyManager *)sharedManager;

/** Adds a notification to the queue
 
 @param notify The LLNotify object to be added to the queue
 */
- (void)addNotificationToQueue:(LLNotify *)notify;

/** Shows the notifications in the queue */
- (void)showNotifications;

@end
