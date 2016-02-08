//
//  FlickrContants.h
//  FlickrPhotoSearch
//
//  Created by Mujtaba Alam on 2/6/16.
//  Copyright © 2016 Mujtaba Alam. All rights reserved.
//

#ifndef FlickrContants_h
#define FlickrContants_h


#endif 


static NSString *const FlickrAPIKey = @"";

static NSString *const SearchPhoto = @"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key={apiKey}&text={text}&per_page=10&format=json&page={page}&nojsoncallback=1";

static NSString *const PhotoImage = @"https://farm{farm}.staticflickr.com/{server}/{photoID}_{secret}_{size}.jpg";

static NSString *const sizeM = @"m";
static NSString *const sizeN = @"n";
static NSString *const sizeZ = @"z";
static NSString *const sizeB = @"b";
static NSString *const sizeK = @"k";
static NSString *const sizeH = @"h";
static NSString *const sizeO = @"o";
