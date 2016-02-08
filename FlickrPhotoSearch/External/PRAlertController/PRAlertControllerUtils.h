//
//  UIApplication+PRTopWindow.h
//  PRAlertControllerDemo
//
//  Created by Elethom Hunter on 30/10/2014.
//  Copyright (c) 2014 Project Rhinestone. All rights reserved.
//

#import <UIKit/UIKit.h>

#define OS_VERSION_LESS_THAN(version) ([[[UIDevice currentDevice] systemVersion] compare:version options:NSNumericSearch] == NSOrderedAscending)

@interface UIApplication (PRTopWindow)

- (UIWindow *)pr_topWindow;

@end

@interface UIWindow (PRTopViewController)

- (UIViewController *)pr_topViewController;

@end
