//
//  Photo.h
//  FlickrBrowser
//
//  Created by Jaden on 22/03/2014.
//  Copyright (c) 2014 UCD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Photo : NSManagedObject

@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSString * owner;
@property (nonatomic, retain) NSString * subtitle;
@property (nonatomic, retain) NSData * thumbnail;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * unique;

@end
