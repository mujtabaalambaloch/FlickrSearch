//
//  PhotosModel.h
//  FlickrPhotoSearch
//
//  Created by Mujtaba Alam on 2/6/16.
//  Copyright © 2016 Mujtaba Alam. All rights reserved.
//

#import "JSONModel.h"
#import "PhotoModel.h"

@protocol PhotosModel
@end

@interface PhotosModel : JSONModel

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pages;
@property (nonatomic, assign) NSInteger perpage;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, strong) NSArray <PhotoModel, ConvertOnDemand, Optional> *photo;

@end
