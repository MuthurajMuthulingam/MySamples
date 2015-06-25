//
//  ImageCollectionViewController.m
//  ImageFilteration
//
//  Created by Muthuraj M on 3/21/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "ImageCollectionViewController.h"
#import "ServerHandler.h"
#import "ImageDownloader.h"
#import "DataParser.h"
#import "ImageCache.h"
#import "ImageCollectionViewCell.h"
#import "ImageViewController.h"
#import "MBProgressHUD.h"


@interface ImageCollectionViewController ()<ImageDownloaderDeleagte,serverHandlerDelegate,DataParserDelegte,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) NSMutableArray *totalProcessedDataArray;
@property (nonatomic,strong) UIImage *selectedImage;
@property (nonatomic,strong) UIImage *blendedImage;

@property (nonatomic,strong) MBProgressHUD *loadingView;

@end

@implementation ImageCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.totalProcessedDataArray = [[NSMutableArray alloc] init];
    
    self.title = @"Image List";
    
    self.collectionView.backgroundColor = [UIColor blueColor];
    
    
    // Register cell classes
    [self.collectionView registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self showLoadingMessage:@"Loading..." addedToView:self.view];
    
    [self setupServerCallWithURLString:@"https://dl.dropboxusercontent.com/u/75148599/SampleImages/imageList.json"];
}

#pragma 
#pragma Setup Loading View

- (void)setupLoadingView:(UIView *)view
{
    if (self.loadingView)
    {
        self.loadingView = nil;
    }
    
    self.loadingView = [MBProgressHUD showHUDAddedTo:view animated:YES];
    self.loadingView.mode = MBProgressHUDModeIndeterminate;
}

- (void)showLoadingMessage:(NSString *)message addedToView:(UIView *)view
{
    [self setupLoadingView:view];
    
    self.loadingView.labelText = message;
    [self.loadingView show:YES];
}

- (void)hideLoadingMessageForView:(UIView *)view
{
    [MBProgressHUD hideHUDForView:view animated:YES];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.collectionView reloadData];
}

- (void)setupServerCallWithURLString:(NSString *)urlString
{
    ServerHandler *serverCall = [[ServerHandler alloc] initWithURL:[NSURL URLWithString:urlString]];
    serverCall.delegate = self;
    [serverCall start];
}

#pragma ServerCall delegate

- (void)finishedResponse:(id)rawData
{
    DataParser *parseData = [[DataParser alloc] initWithData:rawData];
    parseData.delegate = self;
    [parseData start];
}

#pragma Data Processor

- (void)parsedData:(NSArray *)dataArray
{
    NSLog(@"Image Data Array %@ and count %lu",dataArray,dataArray.count);

    dispatch_queue_t myQueue = dispatch_queue_create("myQueue", nil);
    dispatch_async(myQueue, ^{
        
        [self.totalProcessedDataArray removeAllObjects];
        [self.totalProcessedDataArray addObjectsFromArray:dataArray];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self hideLoadingMessageForView:self.view];
            
            [self.collectionView reloadData];
        });
        
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ImageViewController *vc = (ImageViewController *)[segue destinationViewController];
    vc.blendedImage = self.blendedImage;
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.totalProcessedDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    NSDictionary *dataDict = [self.totalProcessedDataArray objectAtIndex:indexPath.row];
    NSLog(@"Data Dict %@ and cell %@",dataDict,cell);
    
    [cell updateViewWithData:dataDict];
    
    return cell;
}


#pragma mark <UICollectionViewDelegate>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(150, 150);
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(50, 20, 50, 20);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dataDict = [self.totalProcessedDataArray objectAtIndex:indexPath.row];
    NSString *imageURL = [NSString stringWithFormat:@"https://dl.dropboxusercontent.com/u/75148599/SampleImages/%@",[dataDict objectForKey:@"image"]];
    
    UIImage *selectedImage = [[ImageCache getSharedInstance] getImageForkey:imageURL];
    NSLog(@"Image selected %@",selectedImage);
    
    self.selectedImage = selectedImage;
    
    [self openImagePicker];
}


#pragma open imagePicker 

- (void)openImagePicker
{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [imagePicker setDelegate: self];
        [imagePicker setAllowsEditing:NO];
        
        [self presentModalViewController:imagePicker animated:YES];
        
        NSLog(@"Has camera");
    }
    else
    {
        NSLog(@"Has no camera");
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"Picked image %@",info);

    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *pickedImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    UIImage *blendedImage = [self blendTwiImagesWithTopImage:self.selectedImage andBottomImage:pickedImage];
    
    self.blendedImage = blendedImage;
    
    NSLog(@"Blended Image %@",blendedImage);
    
    [self performSegueWithIdentifier:@"blendedImage" sender:self];
}


- (UIImage *)blendTwiImagesWithTopImage:(UIImage *)topImage andBottomImage:(UIImage *)bottomImage
{
    UIGraphicsBeginImageContext(CGSizeMake(320, 480));
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // create rect that fills screen
    CGRect bounds = CGRectMake( 0,0, 320, 480);
    
    // This is my bkgnd image
    CGContextDrawImage(context, bounds, bottomImage.CGImage);
    
    CGContextSetBlendMode(context, kCGBlendModeSourceIn);
    
    // This is my image to blend in
    CGContextDrawImage(context, bounds, topImage.CGImage);
    
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIImageWriteToSavedPhotosAlbum(outputImage, self, nil, nil);
    // clean up drawing environment
    //
    UIGraphicsEndImageContext();
    
    return outputImage;
}

@end
