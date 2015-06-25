//
//  AsynchronousImageDownloader.h
//  KE
//
//  Created by Muthuraj M on 11/5/14.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AsynchronousImageDownloader : NSObject

+ (AsynchronousImageDownloader *)sharedInstance;

- (void)loadImageFromURL:(NSString *)urlString completionBlock:(void (^)(BOOL succeeded, UIImage *image,NSString *urlString))completionBlock;

@end
