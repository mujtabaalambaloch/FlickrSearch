//
//  FlickrMainSearch.m
//  FlickrPhotoSearch
//
//  Created by Mujtaba Alam on 2/7/16.
//  Copyright © 2016 Mujtaba Alam. All rights reserved.
//

#import "FlickrMainSearch.h"
#import "FlickrPhotoTable.h"

@interface FlickrMainSearch ()

@property (weak, nonatomic) IBOutlet UITextField *searchTextfield;
@end

@implementation FlickrMainSearch

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.searchTextfield setBackgroundColor:[UIColor whiteColor]];
    [self.searchTextfield.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.searchTextfield.layer setBorderWidth:1.0];
    
    self.searchTextfield.layer.cornerRadius = 5.0f;
    
   // [self.searchTextfield becomeFirstResponder];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.searchTextfield resignFirstResponder];
    [self performSegueWithIdentifier:@"FlickrTableIdentifier" sender:nil];
    return NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField layoutIfNeeded];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"FlickrTableIdentifier"]) {
        FlickrPhotoTable *destController = (FlickrPhotoTable *)segue.destinationViewController;
        
        NSString *text = [self.searchTextfield.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        destController.searchString = text;
    }
}



@end
