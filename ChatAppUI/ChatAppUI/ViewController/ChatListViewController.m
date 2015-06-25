//
//  ChatListViewController.m
//  ChatAppUI
//
//  Created by Muthuraj M on 6/13/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "ChatListViewController.h"
#import "ServerHandler.h"
#import "DataParser.h"
#import "ChatListViewCell.h"

@interface ChatListViewController ()<ServerHandlerDelegate,DataParserDelagate>

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSArray *dataArray;

@end

@implementation ChatListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    self.dataArray = [NSArray array];
    
    self.topView.layer.cornerRadius = 20.0;
    self.topView.clipsToBounds = YES;
    
    [self.tableView registerClass:[ChatListViewCell class] forCellReuseIdentifier:@"cellIdentifier"];
    
    self.navigationController.title = @"Chat Conversation";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self performSelectorInBackground:@selector(makeServerCall:) withObject:[NSURL URLWithString:@"https://sapi.getspini.com:8443/SpinGrailsApp/mobile/dev/messages/conversation"]];
    
}

- (void)makeServerCall:(NSURL *)serverURL {
    ServerHandler *serverHandler = [[ServerHandler alloc] initWithURL:serverURL]; //?offset=1&max=1
    serverHandler.delegate = self;
    [serverHandler start];
}

- (void)showAlertViewWithmessage:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Chat App " message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)reloadChatListData:(NSArray *)dataArray {
    self.dataArray = dataArray;
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
}

#pragma Server Handler Delegate

- (void)serverHandler:(ServerHandler *)serverHandler finishedResponse:(NSData *)rawData {
    if (rawData) {
        
        DataParser *dataParser = [[DataParser alloc] initWithData:rawData];
        dataParser.delegate = self;
        [dataParser start];
        
    } else {
        
        [self performSelectorOnMainThread:@selector(showAlertViewWithmessage:) withObject:@"No Data Available." waitUntilDone:YES];
        //[self showAlertViewWithmessage:@"No Data Available."];
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    float startXPos = 10;
    float startYPos = 20;
    float fullWidth = self.view.frame.size.width - (startXPos*2);
    float fullHeight = self.view.frame.size.height - (startYPos);
    
    self.topView.frame = CGRectMake(startXPos, startYPos, fullWidth, 80);
    self.tableView.frame = CGRectMake(startXPos, self.topView.frame.size.height + self.topView.frame.origin.y, fullWidth, fullHeight - (self.topView.frame.size.height));
}

#pragma  Data Parser Delegate

- (void)dataParser:(DataParser *)dataParser finishedResponse:(NSArray *)jsonDataArray {
    NSLog(@"Data Array %@",jsonDataArray);
    
    [self performSelectorOnMainThread:@selector(reloadChatListData:) withObject:jsonDataArray waitUntilDone:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"CellIdentifier";
    ChatListViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[ChatListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [cell updateViewsWithData:[self.dataArray objectAtIndex:indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}



@end
