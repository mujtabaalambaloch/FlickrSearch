//
//  APIEngine.h
//  FlickrPhotoSearch
//
//  Created by Mujtaba Alam on 2/6/16.
//  Copyright © 2016 Mujtaba Alam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface APIEngine : NSObject

typedef void (^TaskCompletionHandler)(BOOL success, NSDictionary *response, NSError *error);

- (void)getAPIRequestURL:(NSString *)urlString
              parameters:(NSDictionary *)parameters completion:(TaskCompletionHandler)completion;

@end
