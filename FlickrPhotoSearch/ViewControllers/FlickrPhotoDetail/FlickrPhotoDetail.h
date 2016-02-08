//
//  FlickrPhotoDetail.h
//  FlickrPhotoSearch
//
//  Created by Mujtaba Alam on 2/6/16.
//  Copyright © 2016 Mujtaba Alam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoModel.h"

@interface FlickrPhotoDetail : UIViewController

@property (nonatomic, strong) PhotoModel *photoModel;
@property (nonatomic, strong) UIImage *photoImage;
@end
