//
//  FlickrPhotoTable.m
//  FlickrPhotoSearch
//
//  Created by Mujtaba Alam on 2/7/16.
//  Copyright © 2016 Mujtaba Alam. All rights reserved.
//

#import "FlickrPhotoTable.h"
#import "FlickrPhotoCell.h"
#import "FlickrPhotoDetail.h"
#import "PRAlertController.h"

@interface FlickrPhotoTable ()
@property (weak, nonatomic) IBOutlet UITextField *searchTextfield;
@property (nonatomic, assign) NSInteger page;
@end

@implementation FlickrPhotoTable

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES animated:YES];
    [self setupArray];
    self.page = 1;
    
    self.searchTextfield.text = self.searchString;
    
    [self callWebService];
}

#pragma mark - Custom Methods

- (void)callWebService {

    [self getPhotosByText:self.searchTextfield.text page:self.page complete:^(BOOL success, NSError *error) {
        [self.tableView reloadData];
    }];
    
}

#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self numberOfItems];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FlickrPhotoCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    [cell.photoImageView sd_setImageWithURL:[self photoURLAtIndexPath:indexPath]];
    cell.photoLabel.text = [self photoTitleAtIndexPath:indexPath];
    
    return cell;
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"FlickrPhotoIdentifier" sender:indexPath];
}

#pragma mark - Scroll View Delegate

- (void)scrollViewDidEndDragging:(UIScrollView *)aScrollView
                  willDecelerate:(BOOL)decelerate {
    CGPoint offset = aScrollView.contentOffset;
    CGRect bounds = aScrollView.bounds;
    CGSize size = aScrollView.contentSize;
    UIEdgeInsets inset = aScrollView.contentInset;
    float y = offset.y + bounds.size.height - inset.bottom;
    float h = size.height;
    
    float reload_distance = 50;
    if(y > h + reload_distance) {
        self.page += 1;
        [self callWebService];
    }
}

#pragma mark - Text Field Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.searchTextfield resignFirstResponder];
    
    self.page = 1;
    [self setupArray];
    [self callWebService];
    return NO;
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexPath = (NSIndexPath *)sender;
    
    UIImage *photoImage = [self validationImage:indexPath];
    
    if (photoImage != nil) {
        
        if ([segue.identifier isEqualToString:@"FlickrPhotoIdentifier"]) {
            FlickrPhotoDetail *photoDetails = (FlickrPhotoDetail *)segue.destinationViewController;
            photoDetails.photoModel = [self photoModelAtIndexPath:indexPath];
            photoDetails.photoImage = photoImage;
        }
        
    } else {
        
        PRAlertController *alertController = [PRAlertController
                                          alertControllerWithTitle:@"Empty Image"
                                          message:@"Please let the image download."
                                          preferredStyle:PRAlertControllerStyleAlert];
        
        
        PRAlertAction *cancelAction = [PRAlertAction actionWithTitle:@"ok"
                                                               style:PRAlertActionStyleCancel
                                                             handler:^(PRAlertAction *action) {
                                                                 
                                                             }];
        
        [alertController addAction:cancelAction];
        [alertController show];
    }
}

@end
