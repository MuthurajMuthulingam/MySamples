//
//  StorageHandler.m
//  AttireOfTheDay
//
//  Created by Muthuraj M on 5/20/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "StorageHandler.h"

static StorageHandler *sharedInstance;

@interface StorageHandler ()



@end

@implementation StorageHandler


+ (StorageHandler *)getSharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (!sharedInstance)
        {
            sharedInstance = [[StorageHandler alloc] init];
        }
    });
    
    return sharedInstance;
}

- (void)initializeCompleteListStorage
{
    NSMutableArray *completeAttireList = [[NSMutableArray alloc] init];
    
    NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
    [pref setObject:completeAttireList forKey:@"completeAttireList"];
    [pref synchronize];
}

- (void)initializePreferncesListStorage
{
    NSMutableArray *myPreferncesAttireList = [[NSMutableArray alloc] init];
    
    NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
    [pref setObject:myPreferncesAttireList forKey:@"myPrefernceAttireList"];
    [pref synchronize];
}

- (NSMutableArray *)getComplteAttireListFromStorage
{
    NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
    NSArray *pairArray = [pref objectForKey:@"completeAttireList"];
    
    return pairArray.mutableCopy;
}

- (NSMutableArray *)getPreferredAttireListFromStorage
{
    NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
    NSArray *pairArray = [pref objectForKey:@"myPrefernceAttireList"];
    
    return pairArray.mutableCopy;
}

- (BOOL)deleteAttireFromCompletePairList:(NSDictionary *)attirePairDictToDelete
{
    NSMutableArray *completeAttireList = [self getComplteAttireListFromStorage];
    
    [completeAttireList removeObject:attirePairDictToDelete];
    
    return YES;
}

- (void)storeCompleteAttireListToStorage:(NSArray *)completeArray
{
    NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
    [pref setValue:completeArray forKey:@"completeAttireList"];
    
   // NSLog(@"complete List Available in storage %@",completeArray);
}

- (void)storePreferencesAttireListToStorage:(NSArray *)completeArray
{
    NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
    [pref setValue:completeArray forKey:@"myPrefernceAttireList"];
    
    //NSLog(@"preferneces List Available in storage %@",completeArray);
}


- (BOOL)storeAttirePair:(NSDictionary *)attirePairDict
{
    NSMutableArray *pairedArray = [self getComplteAttireListFromStorage];
    
    if (pairedArray.count == 0)
    {
        [self initializeCompleteListStorage];
        pairedArray = [self getComplteAttireListFromStorage];
    }
    [pairedArray addObject:attirePairDict];
    
    [self storeCompleteAttireListToStorage:pairedArray];
    
    return YES;
}

- (BOOL)storeAttirePairToMyPreferences:(NSDictionary *)attirePairDict
{
    NSMutableArray *pairedArray = [self getPreferredAttireListFromStorage];
    
    if (pairedArray.count == 0)
    {
        [self initializePreferncesListStorage];
        pairedArray = [self getPreferredAttireListFromStorage];
    }
    [pairedArray addObject:attirePairDict];
    
    [self storePreferencesAttireListToStorage:pairedArray];
    
    return YES;
}

- (void)clearStorage
{
    NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
    [pref setValue:nil forKey:@"completeAttireList"];
    [pref setValue:nil forKey:@"myPrefernceAttireList"];
    [pref synchronize];
}

- (BOOL)storeImageToDocumentDirectory:(UIImage *)image andImageName:(NSString *)imageName
{
    NSData *pngData = UIImagePNGRepresentation(image);
    NSString *filePath = [[StorageHandler getSharedInstance] documentsPathForFileName:imageName];
    return [pngData writeToFile:filePath atomically:YES]; //Write the file
}


- (UIImage *)retriveImageFromDocumentDirectory:(NSString *)imageName
{
    NSString *filePath = [[StorageHandler getSharedInstance] documentsPathForFileName:imageName];
    NSData *pngData = [NSData dataWithContentsOfFile:filePath];
    UIImage *image = [UIImage imageWithData:pngData];
    return image;
}

- (NSString *)documentsPathForFileName:(NSString *)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    
    return [documentsPath stringByAppendingPathComponent:name];
}

@end
