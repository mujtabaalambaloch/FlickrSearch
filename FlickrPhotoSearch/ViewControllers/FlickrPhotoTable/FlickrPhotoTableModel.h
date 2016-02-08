//
//  FlickrPhotoTableModel.h
//  FlickrPhotoSearch
//
//  Created by Mujtaba Alam on 2/7/16.
//  Copyright © 2016 Mujtaba Alam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotosModel.h"
#import "PhotoModel.h"
#import "UIImageView+WebCache.h"

@interface FlickrPhotoTableModel : UITableViewController

@property (nonatomic, strong) NSMutableArray *photosArray;

typedef void (^CompletionHandler)(BOOL success, NSError *error);

- (void)setupArray;

#pragma mark - CollectionView Methods

- (NSInteger)numberOfItems;
- (NSString *)photoTitleAtIndexPath:(NSIndexPath *)indexPath;
- (NSURL *)photoURLAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)photoURLStringAtIndexPath:(NSIndexPath *)indexPath;
- (PhotoModel *)photoModelAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark - Web Serivce Call

- (void)getPhotosByText:(NSString *)text page:(NSInteger)page
               complete:(CompletionHandler)completion;


- (UIImage *)validationImage:(NSIndexPath *)indexPath;

@end
