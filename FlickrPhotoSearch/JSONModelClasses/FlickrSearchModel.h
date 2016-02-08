//
//  FlickrSearchModel.h
//  FlickrPhotoSearch
//
//  Created by Mujtaba Alam on 2/6/16.
//  Copyright © 2016 Mujtaba Alam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"
#import "PhotosModel.h"

@interface FlickrSearchModel : JSONModel

@property (nonatomic, strong) PhotosModel <ConvertOnDemand, Optional> * photos;
@property (nonatomic, strong) NSString <Optional> *stat;

@end
