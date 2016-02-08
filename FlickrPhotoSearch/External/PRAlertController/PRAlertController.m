//
//  PRAlertController.m
//  PRAlertControllerDemo
//
//  Created by Elethom Hunter on 29/10/2014.
//  Copyright (c) 2014 Project Rhinestone. All rights reserved.
//

#import "PRAlertController.h"
#import "PRAlertControllerUtils.h"
#import "PRAlertControllerManager.h"

@interface PRAlertAction ()

@property (nonatomic, readwrite, copy) NSString *title;
@property (nonatomic, readwrite, assign) PRAlertActionStyle style;
@property (nonatomic, copy) void (^handler)(PRAlertAction *action);
@property (nonatomic, assign) NSInteger buttonIndex;

- (UIAlertAction *)getActionEntity;

@end

@implementation PRAlertAction

- (UIAlertAction *)getActionEntity
{
    UIAlertAction *action = [UIAlertAction actionWithTitle:self.title
                                                     style:(UIAlertActionStyle)self.style
                                                   handler:^(UIAlertAction *action) {
                                                       if (self.handler) {
                                                           self.handler(self);
                                                       }
                                                   }];
    return action;
}

#pragma mark - Life cycle

+ (instancetype)actionWithTitle:(NSString *)title style:(PRAlertActionStyle)style handler:(PRAlertActionHandler)handler
{
    PRAlertAction *action = [[self alloc] init];
    action.title = title;
    action.style = style;
    action.handler = handler;
    return action;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone
{
    PRAlertAction *copy = [[[self class] alloc] init];
    if (copy) {
        copy.title = [self.title copyWithZone:zone];
        copy.style = self.style;
        copy.handler = [self.handler copyWithZone:zone];
    }
    return copy;
}

@end

@interface PRAlertController () <UIAlertViewDelegate, UIActionSheetDelegate>

@property (nonatomic, readwrite, copy) NSArray *actions;

@property (nonatomic, readwrite) PRAlertControllerStyle preferredStyle;

@property (nonatomic, strong) UIAlertController *alertControllerEntity;
@property (nonatomic, strong) UIAlertView *alertView;
@property (nonatomic, strong) UIActionSheet *actionSheet;

@property (nonatomic, strong) NSMutableArray *defaultActions;
@property (nonatomic, weak) PRAlertAction *cancelAction;
@property (nonatomic, weak) PRAlertAction *destructiveAction;

@end

@implementation PRAlertController

#pragma mark - Actions

- (void)show
{
    UIViewController *topViewController = [UIApplication sharedApplication].pr_topWindow.pr_topViewController;
    if (OS_VERSION_LESS_THAN(@"8")) {
        [[PRAlertControllerManager defaultManager] addController:self];
        switch (self.preferredStyle) {
            case PRAlertControllerStyleActionSheet:
                [self.actionSheet showInView:topViewController.view];
                break;
            case PRAlertControllerStyleAlert:
                [self.alertView show];
                break;
        }
    } else {
        self.alertControllerEntity.popoverPresentationController.sourceView = topViewController.view;
        self.alertControllerEntity.popoverPresentationController.permittedArrowDirections = 0;
        CGRect sourceRect = CGRectZero;
        sourceRect.origin = topViewController.view.center;
        self.alertControllerEntity.popoverPresentationController.sourceRect = sourceRect;
        [topViewController presentViewController:self.alertControllerEntity
                                        animated:YES
                                      completion:nil];
    }
}

- (void)dismiss
{
    if (OS_VERSION_LESS_THAN(@"8")) {
        [[PRAlertControllerManager defaultManager] removeController:self];
        switch (self.preferredStyle) {
            case PRAlertControllerStyleActionSheet:
            {
                UIActionSheet *actionSheet = self.actionSheet;
                [actionSheet dismissWithClickedButtonIndex:actionSheet.cancelButtonIndex animated:YES];
                break;
            }
            case PRAlertControllerStyleAlert:
            {
                UIAlertView *alertView = self.alertView;
                [alertView dismissWithClickedButtonIndex:alertView.cancelButtonIndex animated:YES];
                break;
            }
            default:
                break;
        }
    } else {
        [self.alertControllerEntity dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - Configuraiton

- (void)addAction:(PRAlertAction *)action
{
    if (!action) {
        return;
    }
    if (OS_VERSION_LESS_THAN(@"8")) {
        self.actions = [self.actions arrayByAddingObject:action];
        NSString *title = action.title;
        switch (self.preferredStyle) {
            case PRAlertControllerStyleActionSheet:
            {
                UIActionSheet *actionSheet = self.actionSheet;
                switch (action.style) {
                    case PRAlertActionStyleDefault:
                        action.buttonIndex = [actionSheet addButtonWithTitle:title];
                        [self.defaultActions addObject:action];
                        break;
                    case PRAlertActionStyleCancel:
                        actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:title];
                        self.cancelAction = action;
                        break;
                    case PRAlertActionStyleDestructive:
                        actionSheet.destructiveButtonIndex = [actionSheet addButtonWithTitle:title];
                        self.destructiveAction = action;
                        break;
                }
                break;
            }
            case PRAlertControllerStyleAlert:
            {
                UIAlertView *alertView = self.alertView;
                switch (action.style) {
                    case PRAlertActionStyleDefault:
                    case PRAlertActionStyleDestructive:
                        action.buttonIndex = [alertView addButtonWithTitle:title];
                        [self.defaultActions addObject:action];
                        break;
                    case PRAlertActionStyleCancel:
                        alertView.cancelButtonIndex = [alertView addButtonWithTitle:title];
                        self.cancelAction = action;
                        break;
                }
                break;
            }
        }
    } else {
        [self.alertControllerEntity addAction:action.getActionEntity];
    }
}

#pragma mark - Getters and setters

- (void)setTitle:(NSString *)title
{
    title.length > 0 ? nil : (title = nil);
    if (_title != title) {
        _title = title;
        if (OS_VERSION_LESS_THAN(@"8")) {
            self.alertView.title = title;
            self.actionSheet.title = title;
        } else {
            self.alertControllerEntity.title = title;
        }
    }
}

- (void)setMessage:(NSString *)message
{
    message.length > 0 ? nil : (message = nil);
    if (_message != message) {
        _message = message;
        if (OS_VERSION_LESS_THAN(@"8")) {
            self.alertView.message = message;
            message ? self.actionSheet.title = message : nil;
        } else {
            self.alertControllerEntity.message = message;
        }
    }
}

- (NSArray *)actions
{
    return _actions ?: (_actions = @[]);
}

- (NSMutableArray *)defaultActions
{
    return _defaultActions ?: (_defaultActions = [[NSMutableArray alloc] init]);
}

#pragma mark - Life cycle

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(PRAlertControllerStyle)preferredStyle
{
    title.length ? nil : (title = nil);
    message.length ? nil : (message = nil);
    PRAlertController *alertController = [[self alloc] init];
    alertController.title = title;
    alertController.message = message;
    alertController.preferredStyle = preferredStyle;
    if (OS_VERSION_LESS_THAN(@"8")) {
        switch (preferredStyle) {
            case PRAlertControllerStyleActionSheet:
            {
                alertController.actionSheet = [[UIActionSheet alloc] initWithTitle:title
                                                                          delegate:alertController
                                                                 cancelButtonTitle:nil
                                                            destructiveButtonTitle:nil
                                                                 otherButtonTitles:nil];
                break;
            }
            case PRAlertControllerStyleAlert:
            {
                alertController.alertView = [[UIAlertView alloc] initWithTitle:title
                                                                       message:message
                                                                      delegate:alertController
                                                             cancelButtonTitle:nil
                                                             otherButtonTitles:nil];
                break;
            }
        }
    } else {
        alertController.alertControllerEntity = [UIAlertController alertControllerWithTitle:title
                                                                                    message:message
                                                                             preferredStyle:(UIAlertControllerStyle)preferredStyle];
    }
    return alertController;
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView == self.alertView) {
        PRAlertAction *action;
        if (buttonIndex == alertView.cancelButtonIndex) {
            action = self.cancelAction;
        } else {
            for (PRAlertAction *anAction in self.defaultActions) {
                if (anAction.buttonIndex == buttonIndex) {
                    action = anAction;
                    break;
                }
            }
        }
        PRAlertActionHandler handler = action.handler;
        if (handler) {
            handler(action);
        }
        [[PRAlertControllerManager defaultManager] removeController:self];
    }
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (actionSheet == self.actionSheet) {
        PRAlertAction *action;
        if (buttonIndex == actionSheet.cancelButtonIndex) {
            action = self.cancelAction;
        } else if (buttonIndex == actionSheet.destructiveButtonIndex) {
            action = self.destructiveAction;
        } else {
            for (PRAlertAction *anAction in self.defaultActions) {
                if (anAction.buttonIndex == buttonIndex) {
                    action = anAction;
                    break;
                }
            }
        }
        PRAlertActionHandler handler = action.handler;
        if (handler) {
            handler(action);
        }
        [[PRAlertControllerManager defaultManager] removeController:self];
    }
}

@end
