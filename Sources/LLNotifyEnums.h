/*
 Copyright (c) 2011 Liberati Luca http://www.liberatiluca.com
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 - The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 - The use of the Software in your (or your company) product, must include an attribution for my work in your (or your company) product (for example in the readme files, website and in the product itself).
 
 It's possible to have a non-attribution license, see: http://www.liberatiluca.com/components/licenses
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

/** A notification has three pre-configured types, each one with a different color scheme and icon:
 
 - Info will have a black background with white text
 - Alert will have a dark yellow background with black text
 - Error will have a dark red background with white text
 */
typedef enum
{
    LLNotifyTypeInfo,
    LLNotifyTypeAlert,
    LLNotifyTypeError
} LLNotifyType;


/** Where a notification will be displayed */
typedef enum
{
    LLNotifyPositionTop,
    LLNotifyPositionBottom,
    LLNotifyPositionLeft,
    LLNotifyPositionRight
//    LLNotifyPositionModal
} LLNotifyPosition;


/** The available animations to show and hide a notification */
typedef enum
{
    LLNotifyAnimationNone,
    LLNotifyAnimationSlideUp,
    LLNotifyAnimationSlideDown,
    LLNotifyAnimationSlideLeft,
    LLNotifyAnimationSlideRight
//    LLNotifyAnimationFadeIn,
//    LLNotifyAnimationFadeOut
} LLNotifyAnimation;
