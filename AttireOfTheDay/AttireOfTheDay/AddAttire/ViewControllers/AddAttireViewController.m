//
//  AddAttireViewController.m
//  AttireOfTheDay
//
//  Created by Muthuraj M on 5/18/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "AddAttireViewController.h"
#import "AddAttireView.h"
#import "StorageHandler.h"

@interface AddAttireViewController ()<attireViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) AddAttireView *addAttireView;

@property (nonatomic,strong) NSString *currentViewPositionToUpdate;

@property (nonatomic,strong) NSMutableDictionary *singleAttirePairImageURL;

@end

@implementation AddAttireViewController

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        
    }
    
    return self;
}

-(void)createViews
{
    self.addAttireView = [[AddAttireView alloc] init];
    self.addAttireView.backgroundColor = [UIColor whiteColor];
    self.addAttireView.attireViewDelegate = self;
    self.view = self.addAttireView;
    
    self.singleAttirePairImageURL = [[NSMutableDictionary alloc] init];
    
    [self.addAttireView showAttireSelectionView:YES];
}

#pragma AttireView delegate

- (void)addAttireView:(AddAttireView *)addAttireView andSingleattireView:(SingleAttireViewForAdding *)singleAttireView openCameraToLoadImage:(NSString *)viewPosition
{
    self.currentViewPositionToUpdate = viewPosition;
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)addAttireView:(AddAttireView *)addAttireView andSingleattireView:(SingleAttireViewForAdding *)singleAttireView openImageGalaryToLoadImage:(NSString *)viewPosition
{
    self.currentViewPositionToUpdate = viewPosition;
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)addAttireView:(AddAttireView *)addAttireView andSingleattireView:(SingleAttireViewForAdding *)singleAttireView addBtnClicked:(NSString *)viewPosition
{
   BOOL succes = [[StorageHandler getSharedInstance] storeAttirePair:self.singleAttirePairImageURL];
    
    if (succes)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self showMessageInAlert:AlertTitle andMessage:@"Failed"];
    }
    
    
}

// This method is called when an image has been chosen from the library or taken from the camera.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //You can retrieve the actual UIImage
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    //Or you can get the image url from AssetsLibrary
    NSURL *path = [info valueForKey:UIImagePickerControllerReferenceURL];
    
    NSString *imageName = [[[path absoluteString] componentsSeparatedByString:@"?"] objectAtIndex:1];
    
   // NSString *imageName = [path lastPathComponent];
    
    [[StorageHandler getSharedInstance] storeImageToDocumentDirectory:image andImageName:imageName];
    
    [self.addAttireView updateImageToAddAtireView:self.addAttireView toView:self.currentViewPositionToUpdate andImage:image];
    
    [picker dismissViewControllerAnimated:YES completion:^{
    
        [self.singleAttirePairImageURL setValue:imageName forKey:self.currentViewPositionToUpdate];
        
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.title = @"Add Attire";
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
