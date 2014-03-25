//
//  PhotoVC.m
//  FlickrBrowser
//
//  Created by comp41550 on 18/03/2014.
//  Copyright (c) 2014 comp41550. All rights reserved.
//

#import "PhotoVC.h"
#import "FlickrFetcher.h"
#import "AppDelegate.h"
#import "Photo+Flickr.h"
#import "FavoritesTVC.h"

@interface PhotoVC ()
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) NSManagedObjectContext *context;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addToFavoriteBarButton;
@end

@implementation PhotoVC

- (NSManagedObjectContext *)context
{
    if (!_context) {
        _context = ((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;
    }
    return _context;
}

- (void)setPhotoURL:(NSURL *)photoURL
{
    _photoURL = photoURL;
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
    UIBarButtonItem *button = self.navigationItem.rightBarButtonItem;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];
    
    [FlickrFetcher startFlickrFetch:_photoURL completion:^(NSData *data) {
        if (data)
        {
            UIImage *image = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageView.image = image;
                [spinner stopAnimating];
                self.navigationItem.rightBarButtonItem = button;
            });
        }
    }];
}

- (void)viewDidLoad
{
    // check whether this photo exists in core data
    NSString *imageURL = [self.photoURL absoluteString];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
    request.predicate = [NSPredicate predicateWithFormat:@"imageURL = %@", imageURL];
    
    NSError *error;
    NSArray *matches = [self.context executeFetchRequest:request error:&error];

    // update the button
    if ( matches.count > 0 ) {
        [self.addToFavoriteBarButton setEnabled:NO];
    }
}

- (IBAction)addToFavorite:(UIBarButtonItem *)sender
{
    // add to core data
    [Photo photoWithDict:self.photo inManagedObjectContext:self.context];
    [((AppDelegate *)[UIApplication sharedApplication].delegate) saveContext];
    // remove the button
    //[self.navigationItem.rightBarButtonItem setEnabled:FALSE];
    [self.addToFavoriteBarButton setEnabled:NO];
}

@end
