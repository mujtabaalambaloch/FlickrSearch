//
//  FlickrPhotoCell.h
//  FlickrPhotoSearch
//
//  Created by Mujtaba Alam on 2/7/16.
//  Copyright © 2016 Mujtaba Alam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlickrPhotoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *photoLabel;
@property (weak, nonatomic) IBOutlet UIView *photoView;

@end
