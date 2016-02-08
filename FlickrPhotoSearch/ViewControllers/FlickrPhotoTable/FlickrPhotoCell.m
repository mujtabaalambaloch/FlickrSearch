//
//  FlickrPhotoCell.m
//  FlickrPhotoSearch
//
//  Created by Mujtaba Alam on 2/7/16.
//  Copyright © 2016 Mujtaba Alam. All rights reserved.
//

#import "FlickrPhotoCell.h"

@implementation FlickrPhotoCell

@synthesize photoImageView;
@synthesize photoLabel;
@synthesize photoView;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.photoView.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.photoView.layer.shadowOffset = CGSizeMake(5.0f,5.0f);
    self.photoView.layer.shadowOpacity = .2f;
    self.photoView.layer.shadowRadius = 5.0f;
    self.photoView.layer.cornerRadius = 5.0f;
}

@end
