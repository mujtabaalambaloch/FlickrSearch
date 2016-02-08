//
//  PRAlertControllerManager.m
//  PRAlertControllerDemo
//
//  Created by Elethom Hunter on 30/10/2014.
//  Copyright (c) 2014 Project Rhinestone. All rights reserved.
//

#import "PRAlertControllerManager.h"

@interface PRAlertControllerManager ()

@property (nonatomic, strong) NSMutableSet *controllers;

@end

@implementation PRAlertControllerManager

- (void)addController:(PRAlertController *)alertController
{
    [self.controllers addObject:alertController];
}

- (void)removeController:(PRAlertController *)alertController
{
    [self.controllers removeObject:alertController];
}

#pragma mark - Getters and setters

- (NSMutableSet *)controllers
{
    return _controllers ?: (_controllers = [[NSMutableSet alloc] init]);
}

#pragma mark - Life cycle

+ (instancetype)defaultManager
{
    static id defaultManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultManager = [[self alloc] init];
    });
    return defaultManager;
}

@end
