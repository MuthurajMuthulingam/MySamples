//
//  ViewController.m
//  UploadDataTest
//
//  Created by Muthuraj M on 6/4/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *uploadImageBtn;

@end

@implementation ViewController

- (IBAction)uploadImageClicked:(id)sender
{
    [self performSelectorInBackground:@selector(uploadImage:) withObject:[UIImage imageNamed:@"userfile.jpeg"]];
    
}



-(void)uploadImage:(UIImage *)imageToBeUploaded
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://getpodapp.com/xbuddy/upload2.php"]];
    
    NSData *imageData = UIImageJPEGRepresentation(imageToBeUploaded, 1.0);
    
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"unique-consistent-string";
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    // add params (all params are strings)
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=%@\r\n\r\n", @"userfile"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@\r\n", @"Some Caption"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // add image data
    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=%@; filename=userfile.jpg\r\n", @"imageFormKey"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request fromData:body completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        if (data)
        {
            NSHTTPURLResponse *urlRes = (NSHTTPURLResponse *)response;
            
            if (!error && urlRes.statusCode == 200)
            {
                
                NSString *succesMessage = [NSString stringWithFormat:@"Succesfully uploaded %@ and Data in JSON format %@",data,[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error]];
                
                NSLog(@"Succesfully uploaded %@ and Data in JSON format %@",data,[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error]);
                
                [self performSelectorOnMainThread:@selector(showAlert:) withObject:succesMessage waitUntilDone:YES];
                
            }
            else
            {
                NSString *errorMesage = [NSString stringWithFormat:@"Failed  %@ and Response %d and Error %@",data,urlRes.statusCode,error];
                
                NSLog(@"Failed  %@ and Response %d and Error %@",data,urlRes.statusCode,error);
                
                [self performSelectorOnMainThread:@selector(showAlert:) withObject:errorMesage waitUntilDone:YES];
            }
          }
        
    }];
    
    [uploadTask resume];
}

- (void)showAlert:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"UploadImageTest" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
