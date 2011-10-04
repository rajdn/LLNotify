//
//  main.m
//  LLNotifyDemo
//
//  Created by Luca Liberati on 22/07/11.
//  Copyright 2011 Liberati Luca. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LLNotifyDemoAppDelegate.h"

int main(int argc, char *argv[])
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, NSStringFromClass([LLNotifyDemoAppDelegate class]));
    [pool release];
    return retVal;
}
