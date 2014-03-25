//
//  PhotoVC.h
//  FlickrBrowser
//
//  Created by comp41550 on 18/03/2014.
//  Copyright (c) 2014 comp41550. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface PhotoVC : UIViewController

@property (nonatomic, strong) NSURL *photoURL;
@property (nonatomic, strong) NSDictionary *photo;

@end
