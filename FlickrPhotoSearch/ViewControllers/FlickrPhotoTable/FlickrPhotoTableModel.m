//
//  FlickrPhotoTableModel.m
//  FlickrPhotoSearch
//
//  Created by Mujtaba Alam on 2/7/16.
//  Copyright © 2016 Mujtaba Alam. All rights reserved.
//

#import "FlickrPhotoTableModel.h"
#import "APIEngine.h"
#import "FlickrContants.h"
#import "FlickrSearchModel.h"
#import "MBProgressHUD.h"


@implementation FlickrPhotoTableModel

@synthesize photosArray;

- (void)setupArray {
    self.photosArray = [[NSMutableArray alloc] init];
}

#pragma mark - TableView Methods

- (NSInteger)numberOfItems {
    return self.photosArray.count;
}

- (NSString *)photoTitleAtIndexPath:(NSIndexPath *)indexPath {
    return [self photoModelAtIndexPath:indexPath].title;
}

- (NSURL *)photoURLAtIndexPath:(NSIndexPath *)indexPath {
    PhotoModel *photoModel = (PhotoModel *)self.photosArray[indexPath.row];
    return [photoModel photoURLBySize:sizeH];
}

- (NSString *)photoURLStringAtIndexPath:(NSIndexPath *)indexPath {
    PhotoModel *photoModel = (PhotoModel *)self.photosArray[indexPath.row];
    return [photoModel photoURLStringBySize:sizeH];
}

- (PhotoModel *)photoModelAtIndexPath:(NSIndexPath *)indexPath {
    return (PhotoModel *)self.photosArray[indexPath.row];
}

#pragma mark - Web Serivce Call
- (void)getPhotosByText:(NSString *)text page:(NSInteger)page
               complete:(CompletionHandler)completion {
    
    [self showLoadingIndicator];

    text = [text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    APIEngine *apiEngine = [[APIEngine alloc] init];
    
    NSString *request = [SearchPhoto stringByReplacingOccurrencesOfString:@"{apiKey}" withString:FlickrAPIKey];
    
    request = [request stringByReplacingOccurrencesOfString:@"{text}"
                                                 withString:text];
    
    NSString *pages = [[NSNumber numberWithInteger:page] stringValue];
    
    request = [request stringByReplacingOccurrencesOfString:@"{page}"
                                                 withString:pages];
    
    [apiEngine getAPIRequestURL:request parameters:nil completion:^(BOOL success, NSDictionary *response, NSError *error) {
        
        [self hideLoadingIndicator];
        
        if (success) {
            
            PhotosModel *photosModel = [[PhotosModel alloc] initWithDictionary:response[@"photos"] error:nil];
            
            for (NSInteger i = 0; i < [photosModel.photo count]; i++) {
                [self.photosArray addObject:photosModel.photo[i]];
            }
            
            completion(TRUE, nil);
            
        } else {
            completion(FALSE, error);
        }
    }];
}


- (void)showLoadingIndicator {
    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
}

- (void)hideLoadingIndicator {
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
}

- (UIImage *)validationImage:(NSIndexPath *)indexPath {
    
    SDImageCache *cachedImage = [SDImageCache sharedImageCache];
    NSString *photoURLString = [self photoURLStringAtIndexPath:indexPath];
    UIImage *image = [cachedImage imageFromDiskCacheForKey:photoURLString];
    
    if (image == nil) {
        return nil;
    } else {
        return image;
    }
}


@end
