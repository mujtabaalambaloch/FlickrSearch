//
//  PRAlertControllerManager.h
//  PRAlertControllerDemo
//
//  Created by Elethom Hunter on 30/10/2014.
//  Copyright (c) 2014 Project Rhinestone. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PRAlertController;

@interface PRAlertControllerManager : NSObject

+ (instancetype)defaultManager;

- (void)addController:(PRAlertController *)alertController;
- (void)removeController:(PRAlertController *)alertController;

@end
