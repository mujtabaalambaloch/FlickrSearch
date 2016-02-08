//
//  APIEngine.m
//  FlickrPhotoSearch
//
//  Created by Mujtaba Alam on 2/6/16.
//  Copyright © 2016 Mujtaba Alam. All rights reserved.
//

#import "APIEngine.h"

@implementation APIEngine

- (void)getAPIRequestURL:(NSString *)urlString
              parameters:(NSDictionary *)parameters completion:(TaskCompletionHandler)completion {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            //NSLog(@"Error: %@", error);
            completion(FALSE, nil, error);
        } else {
            //NSLog(@"%@ %@", response, responseObject);
            completion(TRUE, responseObject, nil);
        }
    }];
    [dataTask resume];
}



@end
