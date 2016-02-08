//
//  PRAlertController.h
//  PRAlertControllerDemo
//
//  Created by Elethom Hunter on 29/10/2014.
//  Copyright (c) 2014 Project Rhinestone. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PRAlertActionStyle) {
    PRAlertActionStyleDefault = UIAlertActionStyleDefault,
    PRAlertActionStyleCancel = UIAlertActionStyleCancel,
    PRAlertActionStyleDestructive = UIAlertActionStyleDestructive,
};

typedef NS_ENUM(NSInteger, PRAlertControllerStyle) {
    PRAlertControllerStyleActionSheet = UIAlertControllerStyleActionSheet,
    PRAlertControllerStyleAlert = UIAlertControllerStyleAlert,
};

@class PRAlertAction;

typedef void (^PRAlertActionHandler)(PRAlertAction *action);

@interface PRAlertAction : NSObject <NSCopying>

+ (instancetype)actionWithTitle:(NSString *)title style:(PRAlertActionStyle)style handler:(PRAlertActionHandler)handler;

@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, assign) PRAlertActionStyle style;
@property (nonatomic, getter=isEnabled) BOOL enabled;

@end

@interface PRAlertController : NSObject

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(PRAlertControllerStyle)preferredStyle;

- (void)addAction:(PRAlertAction *)action;
@property (nonatomic, readonly, copy) NSArray *actions;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;

@property (nonatomic, readonly) PRAlertControllerStyle preferredStyle;

- (void)show;
- (void)dismiss;

@end
