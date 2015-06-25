//
//  StorageHandler.h
//  AttireOfTheDay
//
//  Created by Muthuraj M on 5/20/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface StorageHandler : NSObject

+ (StorageHandler *)getSharedInstance;

- (BOOL)storeAttirePair:(NSDictionary *)attirePairDict;
- (BOOL)storeAttirePairToMyPreferences:(NSDictionary *)addtireParDict;

- (BOOL)deleteAttireFromCompletePairList:(NSDictionary *)attirePairDictToDelete;

- (NSMutableArray *)getComplteAttireListFromStorage;
- (NSMutableArray *)getPreferredAttireListFromStorage;

- (BOOL)storeImageToDocumentDirectory:(UIImage *)image andImageName:(NSString *)imageName;
- (UIImage *)retriveImageFromDocumentDirectory:(NSString *)imageName;
- (void)clearStorage;

@end
