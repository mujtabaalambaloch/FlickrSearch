//
//  PhotoModel.m
//  FlickrPhotoSearch
//
//  Created by Mujtaba Alam on 2/6/16.
//  Copyright © 2016 Mujtaba Alam. All rights reserved.
//

#import "PhotoModel.h"
#import "FlickrContants.h"

@implementation PhotoModel

+ (BOOL)propertyIsOptional:(NSString*)propertyName {
    return YES;
}


- (NSURL *)photoURLBySize:(NSString *)photoSize {
    return [NSURL URLWithString:[self photoURLStringBySize:photoSize]];
}

- (NSString *)photoURLStringBySize:(NSString *)photoSize {
    
    NSString *photoURL = [PhotoImage stringByReplacingOccurrencesOfString:@"{farm}" withString:self.farm];
    photoURL = [photoURL stringByReplacingOccurrencesOfString:@"{server}"
                                                   withString:self.server];
    photoURL = [photoURL stringByReplacingOccurrencesOfString:@"{photoID}"
                                                   withString:self.id];
    photoURL = [photoURL stringByReplacingOccurrencesOfString:@"{secret}"
                                                   withString:self.secret];
    photoURL = [photoURL stringByReplacingOccurrencesOfString:@"{size}"
                                                   withString:photoSize];
    
    return photoURL;
}


@end
