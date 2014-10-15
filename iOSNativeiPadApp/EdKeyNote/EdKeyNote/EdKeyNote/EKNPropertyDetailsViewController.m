//
//  EKNPropertyDetailsViewController.m
//  EdKeyNote
//
//  Created by canviz on 9/22/14.
//  Copyright (c) 2014 canviz. All rights reserved.
//

#import "EKNPropertyDetailsViewController.h"

@interface EKNPropertyDetailsViewController ()

@end

@implementation EKNPropertyDetailsViewController

-(void)initData
{
    //init extern data
    self.selectRightPropertyItemId = @"1";//for test
    self.loginName = @"Rob Barker";//for test
    //cloris will modify
    
    self.selectLetInspectionIndexPath = nil;
    self.selectRightPropertyTableIndexPath = nil;
    self.selectLetRoomIndexPath = nil;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initData];
    
    self.navigationController.navigationBar.hidden = YES;

    self.view.backgroundColor=[UIColor colorWithRed:242.00f/255.00f green:242.00f/255.00f blue:242.00f/255.00f alpha:1];
    
    UIView *statusbar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 20)];
    statusbar.backgroundColor = [UIColor colorWithRed:(0.00/255.00f) green:(130.00/255.00f) blue:(114.00/255.00f) alpha:1.0];
    [self.view addSubview:statusbar];
    
    UIImageView *header_img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 1024, 71)];
    header_img.image = [UIImage imageNamed:@"navigation_background"];
    [self.view addSubview:header_img];
    
    [self addLetView];
    UIImageView *seperatorline = [[UIImageView alloc] initWithFrame:CGRectMake(344, 91, 5, 677)];
    seperatorline.image = [UIImage imageNamed:@"sepratorline"];
    [self.view addSubview:seperatorline];
    
    [self addRightView];
    
    [self loadPropertyData];
}
#pragma mark - Left view
-(void)addLetView
{
    UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 91, 344, 677)];
    leftview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:leftview];
    [self addLeftPropertyDetailTable];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.tag=LeftBackButtonViewTag;
    [backBtn setFrame:CGRectMake(0, 350, 15, 71)];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"before"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    backBtn.hidden = YES;
    [self.view addSubview:backBtn];
    [self addLeftSlideView];
}
-(void)addLeftSlideView
{
    UIView *slideView = [[UIView alloc] initWithFrame:CGRectMake(24, 405, 320, 657)];
    slideView.tag = LefSliderViewTag;
    slideView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:slideView];
    
    [self addLeftSegementControl:slideView];
    [self addLeftInspectionsTable:slideView];
    [self addLeftRoomTable:slideView];
    [self addLeftFinalizeBtn:slideView];
}
-(void)addLeftSegementControl:(UIView *)slideView
{
    //1st sge
    UIImageView * bkimg =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 316, 54)];
    [bkimg setImage:[UIImage imageNamed:@"seg"]];
    [slideView addSubview:bkimg];
    
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    left.tag = LefPropertySegLeftBtnTag;
    [left setFrame:CGRectMake(24, 0, 105, 54)];
    [left addTarget:self action:@selector(leftSegButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [slideView addSubview:left];
    
    UIButton *mid = [UIButton buttonWithType:UIButtonTypeCustom];
    mid.tag = LefPropertySegMidBtnTag;
    [mid setFrame:CGRectMake(129, 0, 105, 54)];
    [mid addTarget:self action:@selector(midSegButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [slideView addSubview:mid];
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.tag = LefPropertySegRightBtnTag;
    [right setFrame:CGRectMake(234, 0, 106, 54)];
    [right addTarget:self action:@selector(rightSegButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [slideView addSubview:right];
    
    //2nd seg
    UIView *seg2View = [[UIView alloc] initWithFrame:CGRectMake(0, 310, 316, 54)];
    seg2View.tag = LeftRoomSegViewTag;
    
    UIImageView * bkimg1 =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 316, 54)];
    [bkimg1 setImage:[UIImage imageNamed:@"seg2"]];
    [seg2View addSubview:bkimg1];
    
    UIButton *left1 = [UIButton buttonWithType:UIButtonTypeCustom];
    left1.tag = LefRoomSegLeftBtnTag;
    [left1 setFrame:CGRectMake(0, 0, 105, 54)];
    [left1 addTarget:self action:@selector(leftSegButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [seg2View addSubview:left1];
    
    UIButton *mid1 = [UIButton buttonWithType:UIButtonTypeCustom];
    mid1.tag = LefRoomSegMidBtnTag;
    [mid1 setFrame:CGRectMake(0,0, 105, 54)];
    [mid1 addTarget:self action:@selector(midSegButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [seg2View addSubview:mid1];
    
    UIButton *right1 = [UIButton buttonWithType:UIButtonTypeCustom];
    right1.tag = LefRoomSegRightBtnTag;
    [right1 setFrame:CGRectMake(0, 0, 106, 54)];
    [right1 addTarget:self action:@selector(rightSegButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [seg2View addSubview:right1];
    seg2View.hidden= YES;
    [slideView addSubview:seg2View];
}
-(void)addLeftInspectionsTable:(UIView *)slideView
{
    UITableView *inspectionLeftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 55, 320, 235) style:UITableViewStyleGrouped];
    inspectionLeftTableView.tag = LeftInspectionLeftTableViewTag;
    inspectionLeftTableView.backgroundColor = [UIColor whiteColor];
    inspectionLeftTableView.delegate = self;
    inspectionLeftTableView.dataSource = self;
    [inspectionLeftTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    UIFont *font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    NSString *lbl1str = @"INSPECTIONS";
    UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 25)];
    lbl1.text = lbl1str;
    lbl1.textAlignment = NSTextAlignmentLeft;
    lbl1.font = font;
    lbl1.textColor = [UIColor colorWithRed:136.00f/255.00f green:136.00f/255.00f blue:136.00f/255.00f alpha:1];
    inspectionLeftTableView.tableHeaderView = lbl1;
    [inspectionLeftTableView registerNib:[UINib nibWithNibName:@"InspectionListCell" bundle:nil] forCellReuseIdentifier:@"InspectionListCell"];
    [slideView addSubview:inspectionLeftTableView];
    
    UITableView *inspectionMidTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 55, 320, 235) style:UITableViewStyleGrouped];
    inspectionMidTableView.tag = LeftInspectionMidTableViewTag;
    inspectionMidTableView.backgroundColor = [UIColor whiteColor];
    inspectionMidTableView.delegate = self;
    inspectionMidTableView.dataSource = self;
    [inspectionMidTableView setScrollEnabled:NO];
    
    NSString *lbl2str = @"CONTACT OFFICE";
    UILabel *lbl2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 25)];
    lbl2.text = lbl2str;
    lbl2.textAlignment = NSTextAlignmentLeft;
    lbl2.font = font;
    lbl2.textColor = [UIColor colorWithRed:136.00f/255.00f green:136.00f/255.00f blue:136.00f/255.00f alpha:1];
    inspectionMidTableView.tableHeaderView = lbl2;
    [inspectionMidTableView registerNib:[UINib nibWithNibName:@"ContactOwnerCell" bundle:nil] forCellReuseIdentifier:@"ContactOwnerCell"];
    [slideView addSubview:inspectionMidTableView];
    inspectionMidTableView.hidden = YES;
    
    UITableView *inspectionRightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 55, 320, 235) style:UITableViewStyleGrouped];
    inspectionRightTableView.tag = LeftInspectionRightTableViewTag;
    inspectionRightTableView.backgroundColor = [UIColor whiteColor];
    inspectionRightTableView.delegate = self;
    inspectionRightTableView.dataSource = self;
    [inspectionRightTableView setScrollEnabled:NO];
    
    NSString *lbl3str = @"CONTACT OWNER";
    UILabel *lbl3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 25)];
    lbl3.text = lbl3str;
    lbl3.textAlignment = NSTextAlignmentLeft;
    lbl3.font = font;
    lbl3.textColor = [UIColor colorWithRed:136.00f/255.00f green:136.00f/255.00f blue:136.00f/255.00f alpha:1];
    inspectionRightTableView.tableHeaderView = lbl3;
    [inspectionRightTableView registerNib:[UINib nibWithNibName:@"ContactOwnerCell" bundle:nil] forCellReuseIdentifier:@"ContactOwnerCell"];
    [slideView addSubview:inspectionRightTableView];
    inspectionRightTableView.hidden = YES;
}
-(void)addLeftRoomTable:(UIView *)slideView
{
    UITableView *roomTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 365, 320, 175) style:UITableViewStyleGrouped];
    roomTableView.tag = LeftRoomTableViewTag;
    roomTableView.backgroundColor = [UIColor whiteColor];
    roomTableView.delegate = self;
    roomTableView.dataSource = self;
    [roomTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    UIFont *font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    NSString *lbl1str = @"ROOMS";
    UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 25)];
    lbl1.text = lbl1str;
    lbl1.textAlignment = NSTextAlignmentLeft;
    lbl1.font = font;
    lbl1.textColor = [UIColor colorWithRed:136.00f/255.00f green:136.00f/255.00f blue:136.00f/255.00f alpha:1];
    roomTableView.tableHeaderView = lbl1;
    [roomTableView registerNib:[UINib nibWithNibName:@"RoomListCell" bundle:nil] forCellReuseIdentifier:@"RoomListCell"];
    [slideView addSubview:roomTableView];
}
-(void)addLeftFinalizeBtn:(UIView *)slideView
{
    UIButton *finalizeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    finalizeBtn.tag = LeftFinalizeBtnTag;
    [finalizeBtn setFrame:CGRectMake(0, 550, 316, 33)];
    [finalizeBtn setBackgroundImage:[UIImage imageNamed:@"finalize"] forState:UIControlStateNormal];
    [finalizeBtn addTarget:self action:@selector(finalizeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    finalizeBtn.hidden =  YES;
    [slideView addSubview:finalizeBtn];
    
}
-(void)addLeftPropertyDetailTable{
    
    UITableView *propertyDetailTableView = [[UITableView alloc] initWithFrame:CGRectMake(25, 100, 315, 300) style:UITableViewStyleGrouped];
    propertyDetailTableView.tag = LeftPropertyDetailTableViewTag;
    
    propertyDetailTableView.backgroundColor = [UIColor whiteColor];
    propertyDetailTableView.delegate = self;
    propertyDetailTableView.dataSource = self;
    [propertyDetailTableView setScrollEnabled:NO];
    UIFont *font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    NSString *lbl1str = @"PROPERTY DETAILS";
    UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 315, 25)];
    lbl1.text = lbl1str;
    lbl1.textAlignment = NSTextAlignmentLeft;
    lbl1.font = font;
    lbl1.textColor = [UIColor colorWithRed:136.00f/255.00f green:136.00f/255.00f blue:136.00f/255.00f alpha:1];
    propertyDetailTableView.tableHeaderView = lbl1;

    [self.view addSubview:propertyDetailTableView];
}

#pragma mark - Right View
-(void)addRightView
{
    [self addRightPropertyTable];
    [self addRightSlideView];
}
-(void)addRightPropertyTable{
    UITableView *rightPropertyTableView = [[UITableView alloc] initWithFrame:CGRectMake(380, 100, 620, 635) style:UITableViewStyleGrouped];
    rightPropertyTableView.tag = RightPropertyDetailTableViewTag;
    
    rightPropertyTableView.backgroundColor = [UIColor clearColor];
    [rightPropertyTableView setSeparatorColor:[UIColor colorWithRed:242.00f/255.00f green:242.00f/255.00f blue:242.00f/255.00f alpha:1]];
    rightPropertyTableView.delegate = self;
    rightPropertyTableView.dataSource = self;
    [rightPropertyTableView.layer setCornerRadius:10.0];
    [rightPropertyTableView.layer setMasksToBounds:YES];
    [rightPropertyTableView registerNib:[UINib nibWithNibName:@"PropertyListCell" bundle:nil] forCellReuseIdentifier:@"PropertyListCell"];
    [self.view addSubview:rightPropertyTableView];
}
-(void)addRightSlideView
{
    
    UIView *rightSlideView = [[UIView alloc] initWithFrame:CGRectMake(1024, 91, 669, 677)];
    rightSlideView.backgroundColor = [UIColor colorWithRed:242.00f/255.00f green:242.00f/255.00f blue:242.00f/255.00f alpha:1];
    rightSlideView.tag = RightSliderViewTag;
    [self.view addSubview:rightSlideView];
    
    UIFont *labelFont = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    UILabel *rightRoomDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 646, 46)];
    [rightRoomDateLabel setBackgroundColor:[UIColor colorWithRed:(123.00/255.00f) green:(123.00/255.00f) blue:(123.00/255.00f) alpha:1.00]];
    rightRoomDateLabel.tag = RightRoomImageDateLblTag;
    rightRoomDateLabel.textAlignment = NSTextAlignmentLeft;
    rightRoomDateLabel.font = labelFont;
    rightRoomDateLabel.textColor = [UIColor whiteColor];
    [rightSlideView addSubview:rightRoomDateLabel];
    
    
    UIImageView *rightLargePhotoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 46, 646, 465)];
    rightLargePhotoView.tag = RightRoomImageLargeImageTag;
    [rightSlideView addSubview:rightLargePhotoView];
    
    UIView *collectionBg = [[UIView alloc] initWithFrame:CGRectMake(0, 526, 646, 136)];
    collectionBg.backgroundColor = [UIColor colorWithRed:(225.00/255.00f) green:(225.00/255.00f) blue:(225.00/255.00f) alpha:1.00];
    [rightSlideView addSubview:collectionBg];
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    UICollectionView *rightCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(5, 536, 636, 116) collectionViewLayout:flowLayout];
    rightCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    rightCollectionView.delegate = self;
    rightCollectionView.dataSource = self;
    rightCollectionView.allowsMultipleSelection = YES;
    rightCollectionView.allowsSelection = YES;
    rightCollectionView.showsHorizontalScrollIndicator = NO;
    rightCollectionView.backgroundColor = [UIColor colorWithRed:(225.00/255.00f) green:(225.00/255.00f) blue:(225.00/255.00f) alpha:0.00];
    rightCollectionView.tag = RightRoomCollectionViewTag;
    rightCollectionView.delegate = self;
    rightCollectionView.dataSource =self;
    
    [rightCollectionView registerClass:[EKNCollectionViewCell class] forCellWithReuseIdentifier:@"EKNCollectionViewCell"];
    [rightSlideView addSubview:rightCollectionView];
}
-(void)setRightLargeImage:(UIImage *)image
{
    if(image!=nil)
    {
        [self.spinner stopAnimating];
    }
    UIImageView *largeIamgeView = (UIImageView *)[self.view viewWithTag:RightRoomImageLargeImageTag];
    [largeIamgeView setImage:image];
}
-(NSInteger)getRightCollectionViewItemsCount
{
    NSMutableArray *roomsArray = [self.roomsOfInspectionDic objectForKey:[self getSelectLeftInspectionItemId]];
    if(roomsArray!=nil)
    {
        NSDictionary * roomdic = [roomsArray objectAtIndex:self.selectLetRoomIndexPath.row];
        NSArray *imagesArray =[roomdic objectForKey:@"ImagesArray"];
        if(imagesArray!=nil)
        {
            return [imagesArray count];
        }
    }
    return 0;
}
#pragma mark - button action
-(void)backAction
{
    [UIView animateWithDuration:0.3 animations:^{
        [self.view viewWithTag:LefSliderViewTag].frame = CGRectMake(24, 405,  320, 657);
        [self.view viewWithTag:LeftRoomSegViewTag].hidden = YES;
        [self.view viewWithTag:LeftBackButtonViewTag].hidden = YES;
        self.selectRightCollectionIndexPath = nil;
        self.selectLetRoomIndexPath = nil;
    }
                     completion:^(BOOL finished){
                         if(finished)
                         {
                             [UIView animateWithDuration:0.3 animations:
                              ^{
                                  [self.view viewWithTag:RightSliderViewTag].frame=CGRectMake(1024, 91, 669, 677);
                              }
                                              completion:^(BOOL finished){
                                              }];
                         }
                     }];
    
}
-(void)leftSegButtonClicked:(id)sender
{
    if(((UIButton *)sender).tag == LefPropertySegLeftBtnTag)
    {
        UITableView * inspectionLeftTableView = (UITableView *)[self.view viewWithTag:LeftInspectionLeftTableViewTag];
        UITableView * inspectionMidTableView = (UITableView *)[self.view viewWithTag:LeftInspectionMidTableViewTag];
        UITableView * inspectionRightTableView = (UITableView *)[self.view viewWithTag:LeftInspectionRightTableViewTag];
        if(inspectionLeftTableView.hidden == YES)
        {
            inspectionLeftTableView.hidden =NO;
            inspectionMidTableView.hidden = YES;
            inspectionRightTableView.hidden = YES;
        }
    }
    else
    {
        //room
    }

}

-(void)midSegButtonClicked:(id)sender
{
    if(((UIButton *)sender).tag == LefPropertySegMidBtnTag)
    {
        UITableView * inspectionLeftTableView = (UITableView *)[self.view viewWithTag:LeftInspectionLeftTableViewTag];
        UITableView * inspectionMidTableView = (UITableView *)[self.view viewWithTag:LeftInspectionMidTableViewTag];
        UITableView * inspectionRightTableView = (UITableView *)[self.view viewWithTag:LeftInspectionRightTableViewTag];
        if(inspectionMidTableView.hidden == YES)
        {
            inspectionLeftTableView.hidden =YES;
            inspectionMidTableView.hidden = NO;
            inspectionRightTableView.hidden = YES;
        }
    }
    else
    {
        //room
    }

}

-(void)rightSegButtonClicked:(id)sender
{
    if(((UIButton *)sender).tag == LefPropertySegRightBtnTag)
    {
        UITableView * inspectionLeftTableView = (UITableView *)[self.view viewWithTag:LeftInspectionLeftTableViewTag];
        UITableView * inspectionMidTableView = (UITableView *)[self.view viewWithTag:LeftInspectionMidTableViewTag];
        UITableView * inspectionRightTableView = (UITableView *)[self.view viewWithTag:LeftInspectionRightTableViewTag];
        if(inspectionRightTableView.hidden == YES)
        {
            inspectionLeftTableView.hidden =YES;
            inspectionMidTableView.hidden = YES;
            inspectionRightTableView.hidden = NO;
        }
    }
    else
    {
        //room
    }
}
-(void)finalizeButtonClicked:(id)sender
{
    //here finalize
    //cloris need add finalize action;
}
-(void)rightPropertyTableSelectIndexChange:(NSIndexPath*)indexpath
{
    if(self.selectRightPropertyTableIndexPath != indexpath)
    {
        self.selectRightPropertyTableIndexPath = indexpath;
        self.selectRightPropertyItemId = nil;
        
        self.selectLetInspectionIndexPath = nil;
        self.selectLetRoomIndexPath = nil;
        
        
        //set currentsetId
        ListItem *inspectionitem = nil;
        if(self.selectRightPropertyTableIndexPath.section == 0)
        {
            inspectionitem = [self.rightPropertyListDic objectForKey:@"top"];
        }
        else
        {
            NSMutableArray *bottomarray = [self.rightPropertyListDic objectForKey:@"bottom"];
            if(bottomarray!=nil)
            {
                inspectionitem = [bottomarray objectAtIndex:self.selectRightPropertyTableIndexPath.row];
            }
        }
        if(inspectionitem!=nil)
        {
            NSDictionary *pro = (NSDictionary *)[inspectionitem getData:@"sl_propertyID"];
            self.selectRightPropertyItemId =[NSString stringWithFormat:@"%@",[pro objectForKey:@"ID"]];
            
            NSDictionary *insdic = (NSDictionary *)[inspectionitem getData:@"sl_inspector"];
            NSMutableDictionary *propertydic=[self.propertyDic objectForKey:self.selectRightPropertyItemId];
            if([self.propertyDic objectForKey:self.selectRightPropertyItemId] == nil)
            {
                propertydic = [[NSMutableDictionary alloc] init];
            }
            [propertydic setObject:[insdic objectForKey:@"sl_accountname"] forKey:@"contactowner"];
            [propertydic setObject:[pro objectForKey:@"sl_emailaddress"] forKey:@"contactemail"];
        }
        
        //reload left property detail table;
        [(UITableView *)[self.view viewWithTag:LeftPropertyDetailTableViewTag] reloadData];
        
        [self GetInspectionListAccordingPropertyId:self.selectRightPropertyItemId];
        //reload left property insection left table;
        [(UITableView *)[self.view viewWithTag:LeftInspectionLeftTableViewTag] reloadData];
        [(UITableView *)[self.view viewWithTag:LeftInspectionMidTableViewTag] reloadData];
        [(UITableView *)[self.view viewWithTag:LeftInspectionRightTableViewTag] reloadData];
    }
}
#pragma mark - load property data using REST
-(void)loadPropertyData{
    
    self.spinner = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(135,140,50,50)];
    self.spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.view addSubview:self.spinner];
    self.spinner.hidesWhenStopped = YES;
    
    [self.spinner startAnimating];
    
    ListClient* client = [self getClient];
    
    NSURLSessionTask* task = [client getListItemsByFilter:@"Inspections" filter:@"$select=ID,sl_datetime,sl_finalized,sl_inspector/ID,sl_inspector/Title,sl_inspector/sl_accountname,sl_propertyID/ID,sl_propertyID/Title,sl_propertyID/sl_owner,sl_propertyID/sl_address1,sl_propertyID/sl_emailaddress&$expand=sl_inspector,sl_propertyID&$orderby=sl_datetime%20desc" callback:^(NSMutableArray *listItems, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSMutableArray *upcomingList = [[NSMutableArray alloc] init];
            ListItem* currentInspectionData = [[ListItem alloc] init];
            BOOL bfound=false;
            self.inspectionsListArray =listItems;
            for(ListItem* tempitem in listItems)
            {
                /*NSDictionary * pdic = (NSDictionary *)[tempitem getData:@"sl_propertyID"];
                EKNPropertyData* pdata = nil;
                EKNInspectorData *indata = nil;
                if(pdic!=nil)
                {
                    pdata = [[EKNPropertyData alloc] init];
                    [pdata initParameter:(NSString *)[pdic objectForKey:@"ID"]
                                   Title:(NSString *)[pdic objectForKey:@"Title"]
                                   Owner:(NSString *)[pdic objectForKey:@"sl_owner"]
                                 Adress1:(NSString *)[pdic objectForKey:@"sl_address1"]
                                 Adress2:(NSString *)[pdic objectForKey:@"sl_address2"]
                                    City:(NSString *)[pdic objectForKey:@"sl_city"]
                                   State:(NSString *)[pdic objectForKey:@"sl_state"]
                              PostalCode:(NSString *)[pdic objectForKey:@"sl_postalCode"]];
                }
                NSDictionary * indic = (NSDictionary *)[tempitem getData:@"sl_inspector"];
                if(indic!=nil)
                {
                    indata = [[EKNInspectorData alloc] init];
                    [indata initParameter:(NSString *)[indic objectForKey:@"ID"]
                           InspectorTitle:(NSString *)[indic objectForKey:@"Title"]
                     InspectorAccountName:(NSString *)[indic objectForKey:@"sl_accountname"]
                     InspectorEmailAdress:(NSString *)[indic objectForKey:@"sl_emailaddress"]];
                }
                EKNInspectionData * inspectionItem = [[EKNInspectionData alloc] init];
                [inspectionItem initParameter:(NSString *)[tempitem getData:@"ID"]
                              InspectionTitle:(NSString *)[tempitem getData:@"Title"]
                           InspectionDateTime:(NSString *)[tempitem getData:@"sl_datetime"]
                                InspectorData:indata
                                 PropertyData:pdata];*/
                bfound = false;
                NSDictionary * pdic = (NSDictionary *)[tempitem getData:@"sl_propertyID"];
                if(pdic!=nil)
                {
                    if([[pdic objectForKey:@"ID"] intValue] == [self.selectRightPropertyItemId intValue])
                    {
                        bfound = true;
                        currentInspectionData = tempitem;
                    }
                }
                if(!bfound)
                {
                    NSString *tempdatetime =(NSString *)[tempitem getData:@"sl_datetime"];
                    if(tempdatetime!=nil)
                    {
                        NSDate *inspectiondatetime = [EKNEKNGlobalInfo converDateFromString:tempdatetime];
                        if([inspectiondatetime compare:[NSDate date]] == NSOrderedDescending)
                        {
                            [upcomingList addObject:tempitem];
                        }
                    }
                }
            }
            //get the right pannel data
            self.rightPropertyListDic = [[NSMutableDictionary alloc] init];
            [self.rightPropertyListDic setObject:currentInspectionData forKey:@"top"];
            [self.rightPropertyListDic setObject:upcomingList forKey:@"bottom"];
            
            //get property resource list:
            [self getPropertyResourceListArray:client];
        });
    }];
    
    [task resume];
}

-(void)getPropertyResourceListArray:(ListClient*)client
{
    NSURLSessionTask* getpropertyResourcetask = [client getListItemsByFilter:@"Property Photos" filter:@"$select=sl_propertyIDId,Id" callback:^(NSMutableArray * listItems, NSError *error)
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            //self.propertyResourceListArray =listItems;
                            [self getPropertyResourceFile:client PropertyResourceItems:listItems];
                        });
                    }];
    
    [getpropertyResourcetask resume];
}

-(void)getPropertyResourceFile:(ListClient*)client  PropertyResourceItems:(NSMutableArray* )listItems
{
    NSMutableString* loopindex = [[NSMutableString alloc] initWithString:@"0"];
    NSMutableArray *loopitems =listItems;
    self.propertyDic = [[NSMutableDictionary alloc] init];
    
    for (ListItem* tempitem in loopitems)
    {
        NSString *propertyId =[NSString stringWithFormat:@"%@",[tempitem getData:@"sl_propertyIDId"]];
    
        NSURLSessionTask* getFileResourcetask = [client getListItemFileByFilter:@"Property Photos"
                                                        FileId:(NSString *)[tempitem getData:@"ID"]
                                                        filter:@"$select=ServerRelativeUrl"
                                                        callback:^(NSMutableArray *listItems, NSError *error)
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            int preindex = [loopindex intValue];
                            preindex++;
                                                         
                            if([listItems count]>0)
                            {
                                NSMutableDictionary *propertyData =[[NSMutableDictionary alloc] init];
                                [propertyData setObject:[[listItems objectAtIndex:0] getData:@"ServerRelativeUrl"] forKey:@"ServerRelativeUrl"];
                                                             
                                [self.propertyDic setObject:propertyData forKey:propertyId];
                            }
                                                         
                            NSLog(@"propertyId %@",propertyId);
                            if(preindex == [loopitems count])
                            {
                                    //get Incidents list
                                    [self getIncidentsListArray:client];
                                                        
                            }
                            [loopindex setString:[NSString stringWithFormat:@"%d",preindex]];
                            NSLog(@"loopindex %@",loopindex);
                        });
                                                     
                    }];
        
        [getFileResourcetask resume];
    }
}

-(void)getIncidentsListArray:(ListClient*)client
{
    self.incidentOfInspectionDic = [[NSMutableDictionary alloc] init];
    self.incidentOfRoomsDic = [[NSMutableDictionary alloc] init];
    NSURLSessionTask* getincidentstask = [client getListItemsByFilter:@"Incidents" filter:@"$select=sl_inspectionIDId,sl_roomIDId,Id"  callback:^(NSMutableArray *        listItems, NSError *error)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                for (ListItem* tempitem in listItems) {
                    NSString *key =[NSString stringWithFormat:@"%@",[tempitem getData:@"sl_inspectionIDId"]];
                        
                    if(![self.incidentOfInspectionDic objectForKey:key])
                    {
                        NSMutableDictionary *temp = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"red",@"icon", nil];
                        [self.incidentOfInspectionDic setObject:temp forKey:key];

                    }
                    NSString *roomId =[NSString stringWithFormat:@"%@",[tempitem getData:@"sl_roomIDId"]];
                    if (![self.incidentOfRoomsDic objectForKey:roomId]) {
                        [self.incidentOfRoomsDic setObject:@"1" forKey:roomId];
                    }
                }
                [self InitAllViewDateAfterFirstRest];
                //get All property images
                [self getAllPropertyImageFiles:client];
                [self.spinner stopAnimating];
            });
        }];
    [getincidentstask resume];
}
-(void)InitAllViewDateAfterFirstRest
{
    //get current property inspection list
    [self GetInspectionListAccordingPropertyId:self.selectRightPropertyItemId];
    //right property table view need reload data
    UITableView *rightPropertyTableView = (UITableView *)[self.view viewWithTag:RightPropertyDetailTableViewTag];
    [rightPropertyTableView reloadData];
    NSIndexPath *temp = [NSIndexPath indexPathForRow:0 inSection:0];
    [rightPropertyTableView selectRowAtIndexPath:temp animated:NO scrollPosition:UITableViewScrollPositionNone];
    [self rightPropertyTableSelectIndexChange:temp];
}

-(void)GetInspectionListAccordingPropertyId:(NSString*)pid
{
    if([self.propertyDic objectForKey:pid] ==nil)
    {
        NSMutableDictionary *propertyTempDic = [[NSMutableDictionary alloc] init];
        [self.propertyDic setObject:propertyTempDic forKey:pid];
    }
    
    if(![[self.propertyDic objectForKey:pid] objectForKey:@"inspectionslist"])
    {
        NSMutableArray *inspectionslistTemp = [[NSMutableArray alloc] init];
        
        for (ListItem* tempitem in self.inspectionsListArray) {
            NSString *inspectionId = [NSString stringWithFormat:@"%@",[tempitem getData:@"ID"]];
            
            NSDictionary * pdic = (NSDictionary *)[tempitem getData:@"sl_propertyID"];
            NSDictionary *insdic =(NSDictionary *)[tempitem getData:@"sl_inspector"];
            
            if(pdic!=nil)
            {
                if([[pdic objectForKey:@"ID"] intValue] == [pid intValue])
                {
                    
                    NSMutableDictionary * inspectionItem= [[NSMutableDictionary alloc] init];
                    
                    [inspectionItem setObject:inspectionId forKey:@"ID"];
                    [inspectionItem setObject:[insdic objectForKey:@"Title"] forKey:@"sl_accountname"];
                    

                    if ([[insdic objectForKey:@"Title"] isEqualToString:self.loginName ]) {
                        NSString *final = (NSString *)[tempitem getData:@"sl_finalized"];
                        
                        if (final == (NSString *)[NSNull null]) {
                            [inspectionItem setObject:@"YES" forKey:@"bowner"];
                        }
                    }
                    NSDate *inspectiondatetime = [EKNEKNGlobalInfo converDateFromString:(NSString *)[tempitem getData:@"sl_datetime"]];
                    [inspectionItem setObject:[EKNEKNGlobalInfo converStringFromDate:inspectiondatetime] forKey:@"sl_datetime"];
                    
                    if([inspectiondatetime compare:[NSDate date]] == NSOrderedDescending)
                    {
                    //upcoming
                        [inspectionItem setObject:@"black" forKey:@"icon"];
                    }
                    else
                    {
                        if([[self.incidentOfInspectionDic objectForKey:inspectionId] objectForKey:@"icon"]!=nil)
                        {
                             [inspectionItem setObject:@"red" forKey:@"icon"];
                        }
                        else
                        {
                            [inspectionItem setObject:@"green" forKey:@"icon"];
                        }
                       
                    }
                    
                    [inspectionslistTemp addObject:inspectionItem];
                }
            }
        }
        [[self.propertyDic objectForKey:pid] setObject:inspectionslistTemp forKey:@"inspectionslist"];
    }
}

-(void)getAllPropertyImageFiles:(ListClient*)client
{
    NSArray *prokeys = [self.propertyDic allKeys];
    for (NSString *key in prokeys) {
        [self getFile:key];
    }
}

-(void)getFile:(NSString *)key
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString *siteUrl = [standardUserDefaults objectForKey:@"demoSiteCollectionUrl"];
    
    NSMutableDictionary *prodict = [self.propertyDic objectForKey:key];
    NSString *path =[prodict objectForKey:@"ServerRelativeUrl"];
    NSString *requestUrl = [NSString stringWithFormat:@"%@/_api/web/GetFileByServerRelativeUrl('%@%@",siteUrl,path,@"')/$value"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestUrl]];
    NSString *authorizationHeaderValue = [NSString stringWithFormat:@"Bearer %@", self.token];
    [request addValue:authorizationHeaderValue forHTTPHeaderField:@"Authorization"];
    [request setHTTPMethod:@"GET"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data,
                                                                                          NSURLResponse *response,
                                                                                          NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"cloris get image erro %@",error);
            if (error == nil) {
                NSLog(@"data length %lu",[data length]);
                UIImage *image =[[UIImage alloc] initWithData:data];
                [[self.propertyDic objectForKey:key] setObject:image
                                                        forKey:@"image"];
                [self updatePropertyTableCellImage:key image:image];
            }
            else
            {
                //retry one
                if([[self.propertyDic objectForKey:key] objectForKey:@"trytimes"]!=nil)
                {
                    NSInteger times =[[[self.propertyDic objectForKey:key] objectForKey:@"trytimes"] integerValue];
                    if(times>=3)
                    {
                        
                    }
                    else
                    {
                        times=times+1;
                        [[self.propertyDic objectForKey:key] setObject:[NSString stringWithFormat:@"%ld",(long)times] forKey:@"trytimes"];
                        [self getFile:key];
                    }
                }
                else
                {
                    [[self.propertyDic objectForKey:key] setObject:@"1" forKey:@"trytimes"];
                    [self getFile:key];
                }
            }
        });
    }];
    [task resume];
}

-(void)updatePropertyTableCellImage:(NSString *)proid image:(UIImage *)image
{
    BOOL found =  false;
    ListItem *inspectionitem = nil;
    inspectionitem = [self.rightPropertyListDic objectForKey:@"top"];
    NSIndexPath *updateIndexPath = nil;
    if(inspectionitem!=nil)
    {
        NSDictionary *pro = (NSDictionary *)[inspectionitem getData:@"sl_propertyID"];
        if(pro!=nil)
        {
            NSString *propertyId =[NSString stringWithFormat:@"%@",[pro objectForKey:@"ID"]];
            if([propertyId isEqualToString:proid])
            {
                updateIndexPath =[NSIndexPath indexPathForRow:0 inSection:0];
                [self didUpdateRightPropertyTableCell:updateIndexPath image:image];
                found = true;
            }
        }
    }
    if(!found)
    {
        NSMutableArray *bottomarray = [self.rightPropertyListDic objectForKey:@"bottom"];
        if(bottomarray!=nil)
        {
            for(NSInteger i = 0; i< [bottomarray count]; i++)
            {
                ListItem *tp = [bottomarray objectAtIndex:i];
                
                NSDictionary *pro = (NSDictionary *)[tp getData:@"sl_propertyID"];
                if(pro!=nil)
                {
                    NSString *propertyId =[NSString stringWithFormat:@"%@",[pro objectForKey:@"ID"]];
                    if([propertyId isEqualToString:proid])
                    {
                         updateIndexPath =[NSIndexPath indexPathForRow:i inSection:1];
                        [self didUpdateRightPropertyTableCell:updateIndexPath image:image];
                        found = true;
                        break;
                    }
                }
            }
        }
    }
    if(found && self.selectRightPropertyTableIndexPath == updateIndexPath)
    {
        UITableView * propertyDetailTableView =(UITableView *)[self.view viewWithTag:LeftPropertyDetailTableViewTag];
        [propertyDetailTableView beginUpdates];
        NSIndexPath *upi = [NSIndexPath indexPathForRow:2 inSection:0];
        
        [propertyDetailTableView reloadRowsAtIndexPaths:@[upi] withRowAnimation:UITableViewRowAnimationNone];
        if(self.selectRightPropertyTableIndexPath == updateIndexPath)
        {
             [(UITableView *)[self.view viewWithTag:RightPropertyDetailTableViewTag] selectRowAtIndexPath:updateIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
        [propertyDetailTableView endUpdates];
        
        
        //PropertyDetailsImage *up = (PropertyDetailsImage *)[self.propertyDetailTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
       // [up.imageView setImage:image];
    }
}

-(void)didUpdateRightPropertyTableCell:(NSIndexPath *)indexpath image:(UIImage*)image
{
    UITableView *rightPropertyTableView = (UITableView *)[self.view viewWithTag:RightPropertyDetailTableViewTag];
    [rightPropertyTableView beginUpdates];
    [rightPropertyTableView reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
    [rightPropertyTableView endUpdates];
    
   // PropertyListCell *up = (PropertyListCell *)[self.rightTableView cellForRowAtIndexPath:indexpath];
    //[up.imageView setImage:image];
}

#pragma mark - load Room data using REST
-(void)GetRoomInspectionPhotosList{
    [self.spinner setFrame:CGRectMake(135,460,50,50)];
    [self.spinner startAnimating];
    ((UIButton *)[self.view viewWithTag:LeftBackButtonViewTag]).enabled = NO;
    
    ListClient* client = [self getClient];
    self.roomsOfInspectionDic = [[NSMutableDictionary alloc] init];
    NSURLSessionTask* task = [client getListItemsByFilter:@"Room Inspection Photos" filter:@"$select=Id,sl_inspectionIDId,sl_roomID/Title,sl_roomID/Id&$expand=sl_roomID"
                                                     callback:^(NSMutableArray *listItems, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                for (ListItem *temp in listItems) {
                    NSString *insId =[NSString stringWithFormat:@"%@",[temp getData:@"sl_inspectionIDId"]];

                    
                    NSMutableArray *roomsArray= [self.roomsOfInspectionDic objectForKey:insId];
                    if(roomsArray ==nil)
                    {
                        roomsArray = [[NSMutableArray alloc] init];
                        [self.roomsOfInspectionDic setObject:roomsArray forKey:insId];
                    }
                    
                    NSDictionary *romtemp = (NSDictionary *)[temp getData:@"sl_roomID"];
                    if(romtemp!=nil)
                    {
                        NSString *roomId =[NSString stringWithFormat:@"%@",[romtemp objectForKey:@"Id"]];
                        //check roomid whehter exist
                        NSMutableDictionary *roomDic=nil;
                        for (NSMutableDictionary *tempDic in roomsArray) {
                            if ([[tempDic objectForKey:@"Id"] isEqualToString:roomId]) {
                                roomDic = tempDic;
                                break;
                            }
                        }
                        if(roomDic == nil)
                        {
                            roomDic = [[NSMutableDictionary alloc] init];
                            [roomDic setObject:roomId forKey:@"Id"];
                            [roomDic setObject:[romtemp objectForKey:@"Title"] forKey:@"Title"];
                            [roomsArray addObject:roomDic];
                            
                        }
                        
                        NSMutableArray *imagesArray = [roomDic objectForKeyedSubscript:@"ImagesArray"];
                        if(imagesArray ==nil)
                        {
                            imagesArray = [[NSMutableArray alloc] init];
                            [roomDic setObject:imagesArray forKey:@"ImagesArray"];
                        }
                        
                        NSString *fileId = [NSString stringWithFormat:@"%@",[temp getData:@"Id"]];
                        if(fileId!=nil)
                        {
                            NSMutableDictionary *imagesDic = [[NSMutableDictionary alloc] init];
                            [imagesDic setObject:fileId forKey:@"Id"];
                            [imagesArray addObject:imagesDic];
                        }
                    }
                }
                [(UITableView *)[self.view viewWithTag:LeftRoomTableViewTag] reloadData];
                
                [self.spinner stopAnimating];
                
                [self didSelectRoomTableItem:[NSIndexPath indexPathForRow:0 inSection:0] refresh:YES];
                ((UIButton *)[self.view viewWithTag:LeftBackButtonViewTag]).enabled = YES;
            });
            
        }];
        
        [task resume];
}
-(void)didSelectRoomTableItem:(NSIndexPath *)indexpath refresh:(BOOL)refresh
{
    NSLog(@"[self getSelectLeftInspectionItemId] %@",[self getSelectLeftInspectionItemId]);
    NSLog(@"[[self.roomsOfInspectionDic objectForKey:[self getSelectLeftInspectionItemId]] count] %ld",[[self.roomsOfInspectionDic objectForKey:[self getSelectLeftInspectionItemId]] count]);
    NSLog(@"indexpath.row %ld",indexpath.row);
    
    if([[self.roomsOfInspectionDic objectForKey:[self getSelectLeftInspectionItemId]] count]>=indexpath.row+1)
    {

        self.selectLetRoomIndexPath = indexpath;
        if(refresh)
        {
            [(UITableView *)[self.view viewWithTag:LeftRoomTableViewTag] selectRowAtIndexPath:self.selectLetRoomIndexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
        }

        //
        //here we will reload right collection view;
        UICollectionView * collectionView = (UICollectionView *)[self.view viewWithTag:RightRoomCollectionViewTag];
        [collectionView reloadData];
        
        self.selectRightCollectionIndexPath =nil;
        [self setRightLargeImage:nil];
        if ([self getRightCollectionViewItemsCount]>0) {
            //load spiner for remote get image file;
            [self.spinner setFrame:CGRectMake(500,384,50,50)];
            [self.spinner startAnimating];
            self.selectRightCollectionIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [collectionView selectItemAtIndexPath:self.selectRightCollectionIndexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
        }
        
    }
    else
    {
        [self setRightLargeImage:nil];
        UICollectionView * collectionView = (UICollectionView *)[self.view viewWithTag:RightRoomCollectionViewTag];
        [collectionView reloadData];
    }
    
}
-(void)getRoomImageFileREST:(NSString *)path
                 propertyId:(NSInteger)proId
               inspectionId:(NSInteger)insid
                  roomIndex:(NSInteger)roomIndex
                 imageIndex:(NSInteger)imageIndex
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString *siteUrl = [standardUserDefaults objectForKey:@"demoSiteCollectionUrl"];
    NSString *requestUrl = [NSString stringWithFormat:@"%@/_api/web/GetFileByServerRelativeUrl('%@%@",siteUrl,path,@"')/$value"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestUrl]];
    NSString *authorizationHeaderValue = [NSString stringWithFormat:@"Bearer %@", self.token];
    [request addValue:authorizationHeaderValue forHTTPHeaderField:@"Authorization"];
    [request setHTTPMethod:@"GET"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data,
                                                                                          NSURLResponse *response,
                                                                                          NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"cloris get room image erro %@",error);
            if (error == nil) {
                NSLog(@"data length %lu",[data length]);
                UIImage *image =[[UIImage alloc] initWithData:data];
                NSMutableArray *imageArray = [[[self.roomsOfInspectionDic objectForKey:[NSString stringWithFormat:@"%ld",insid]] objectAtIndex:roomIndex] objectForKey:@"ImagesArray"];
                
                if([imageArray count]>= imageIndex+1)
                {
                    NSMutableDictionary *imagDic = [imageArray objectAtIndex:imageIndex];
                    [imagDic setObject:image forKey:@"image"];

                    if (proId == [self.selectRightPropertyItemId intValue]
                        && insid == [[self getSelectLeftInspectionItemId] intValue]
                        && roomIndex == self.selectLetRoomIndexPath.row) {
                        NSLog(@"proId %ld, insid = %ld, roomIndex =%ld",proId,insid,roomIndex);
                        //update collection cell
                         UICollectionView *clviw =(UICollectionView *)[self.view viewWithTag:RightRoomCollectionViewTag];
                         EKNCollectionViewCell *cell = (EKNCollectionViewCell *)[clviw cellForItemAtIndexPath:[NSIndexPath indexPathForRow:imageIndex inSection:0]];
                        if (cell.selected) {
                            [self setRightLargeImage:image];
                            //cell.selectImageViw.hidden = NO;
                        }
                        [clviw reloadItemsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:imageIndex inSection:0], nil]];
                        
                    }
                }

            }
            else
            {
                //retry one
                NSMutableDictionary *imagDic = [[[self.roomsOfInspectionDic objectForKey:[NSString stringWithFormat:@"%ld",insid]] objectAtIndex:roomIndex] objectAtIndex:imageIndex];
                
                if([imagDic objectForKey:@"trytimes"]!=nil)
                {
                    NSInteger times =[[imagDic objectForKey:@"trytimes"] integerValue];
                    if(times>=3)
                    {
                        UICollectionView *clviw =(UICollectionView *)[self.view viewWithTag:RightRoomCollectionViewTag];
                        EKNCollectionViewCell *cell = (EKNCollectionViewCell *)[clviw cellForItemAtIndexPath:[NSIndexPath indexPathForRow:imageIndex inSection:0]];
                        if (cell.selected) {
                            [self.spinner stopAnimating];
                        }
                    }
                    else
                    {
                        times=times+1;
                        [imagDic setObject:[NSString stringWithFormat:@"%ld",(long)times] forKey:@"trytimes"];
                        [self getRoomImageFileREST:path propertyId:proId inspectionId:insid roomIndex:roomIndex imageIndex:imageIndex];
                    }
                }
                else
                {
                    [imagDic setObject:@"1" forKey:@"trytimes"];
                    [self getRoomImageFileREST:path propertyId:proId inspectionId:insid roomIndex:roomIndex imageIndex:imageIndex];
                }
            }
        });
    }];
    [task resume];
}
#pragma mark - other
-(ListClient*)getClient{
    OAuthentication* authentication = [OAuthentication alloc];
    [authentication setToken:self.token];
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    return [[ListClient alloc] initWithUrl:[standardUserDefaults objectForKey:@"demoSiteCollectionUrl"]
                               credentials: authentication];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - TableView delegte
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(tableView.tag == RightPropertyDetailTableViewTag)
    {
        return 2;
    }
    else
    {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView.tag == RightPropertyDetailTableViewTag)
    {
        if(section == 0)
        {
            NSMutableArray *toparray =[self.rightPropertyListDic objectForKey:@"top"];
            if(toparray!=nil)
            {
                return 1;
            }
            else
            {
                return 0;
            }
        }
        else
        {
            
            NSMutableArray *bottomarray =[self.rightPropertyListDic objectForKey:@"bottom"];
            if(bottomarray!=nil)
            {
                return [bottomarray count];
            }
            else
            {
                return 0;
            }
        }
    }
    else if(tableView.tag == LeftPropertyDetailTableViewTag)
    {
        if(self.selectRightPropertyTableIndexPath!=nil)
        {
            return 3;
        }
        else
        {
            return 0;
        }
        
    }
    else if(tableView.tag == LeftInspectionLeftTableViewTag)
    {
        if(self.selectRightPropertyTableIndexPath!=nil)
        {
            NSDictionary *tempdic  = [self.propertyDic objectForKey:self.selectRightPropertyItemId];
            if(tempdic!=nil)
            {
                NSArray * list = [tempdic objectForKey:@"inspectionslist"];
                if(list!=nil)
                {
                    return [list count];
                }
            }
        }
        return 0;
    }
    else if(tableView.tag == LeftInspectionMidTableViewTag||
            tableView.tag == LeftInspectionRightTableViewTag)
    {
        if(self.selectRightPropertyTableIndexPath!=nil)
        {
            return 1;
        }
        else
        {
            return 0;
        }
    }
    else if(tableView.tag == LeftRoomTableViewTag)
    {
        if(self.selectLetInspectionIndexPath!=nil)
        {
            NSArray *roomArray = [self.roomsOfInspectionDic objectForKey:[self getSelectLeftInspectionItemId]];
            if(roomArray!=nil)
            {
                return [roomArray count];
            }
        }
        return 0;
    }
    else
    {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView.tag == RightPropertyDetailTableViewTag)
    {
        return 109;
    }
    else if(tableView.tag == LeftPropertyDetailTableViewTag)
    {
        if(indexPath.row == 2)
        {
            return 225;
        }
        else
        {
            return 25;
        }
    }
    else if(tableView.tag == LeftInspectionLeftTableViewTag||
            tableView.tag == LeftRoomTableViewTag)
    {
        return 30;
    }
    else if(tableView.tag == LeftInspectionMidTableViewTag||
            tableView.tag == LeftInspectionRightTableViewTag)
    {
        return 50;
    }
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(tableView.tag == RightPropertyDetailTableViewTag)
    {
        return 30;
        
    }
    return 0;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(tableView.tag == RightPropertyDetailTableViewTag)
    {
        if (section == 0)
        {
            UIFont *font = [UIFont fontWithName:@"Helvetica" size:12];
            NSString *lbl1str = @"CURRENT INSPECTION";
           // NSDictionary *attributes = @{NSFontAttributeName:font};
            //CGSize lbsize = [lbl1str sizeWithAttributes:attributes];
            UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 620, 30)];
            lbl1.text = lbl1str;
            lbl1.textAlignment = NSTextAlignmentLeft;
            lbl1.font = font;
            lbl1.textColor = [UIColor colorWithRed:136.00f/255.00f green:136.00f/255.00f blue:136.00f/255.00f alpha:1];
            return lbl1;
        }
        else
        {
            UIFont *font = [UIFont fontWithName:@"Helvetica" size:12];
            NSString *lbl1str = @"UPCOMING INSPECTION";
            //NSDictionary *attributes = @{NSFontAttributeName:font};
            //CGSize lbsize = [lbl1str sizeWithAttributes:attributes];
            UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 620, 30)];
            lbl1.text = lbl1str;
            lbl1.textAlignment = NSTextAlignmentLeft;
            lbl1.font = font;
            lbl1.textColor = [UIColor colorWithRed:136.00f/255.00f green:136.00f/255.00f blue:136.00f/255.00f alpha:1];
            
            return lbl1;
        }
    }
    else
    {
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView.tag == RightPropertyDetailTableViewTag)
    {
        NSString *identifier = @"PropertyListCell";
        PropertyListCell *cell  = cell = [tableView dequeueReusableCellWithIdentifier:identifier  forIndexPath:indexPath];
        [cell setSelectionStyle:UITableViewCellSelectionStyleDefault];
        [self setRightTableCell:cell cellForRowAtIndexPath:indexPath];
        return cell;
    }
    else if(tableView.tag == LeftInspectionMidTableViewTag ||
            tableView.tag == LeftInspectionRightTableViewTag )
    {
        NSString *identifier = @"ContactOwnerCell";
        ContactOwnerCell *cell  = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        NSDictionary * tempdic = [self.propertyDic objectForKey:self.selectRightPropertyItemId];
        if(tempdic!=nil)
        {
            if(tableView.tag == LeftInspectionMidTableViewTag)
            {
                NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
                
                [cell setCellValue: [standardUserDefaults objectForKey:@"dispatcherEmail"]];
            }
            else
            {
                [cell setCellValue:[tempdic objectForKey:@"contactemail"]];
            }
        }
        
        return cell;
    }
    else if(tableView.tag == LeftInspectionLeftTableViewTag)
    {
        NSString *identifier = @"InspectionListCell";
        InspectionListCell *cell  = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        [cell setSelectionStyle:UITableViewCellSelectionStyleDefault];
        [self setLeftInspectionTableCell:cell cellForRowAtIndexPath:indexPath];
        return cell;
    }
    else if(tableView.tag == LeftRoomTableViewTag)
    {
        NSString *identifier = @"RoomListCell";
        RoomListCell *cell  = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        [self setLeftRoomTableCell:cell cellForRowAtIndexPath:indexPath];
        return cell;
    }
    else if(tableView.tag == LeftPropertyDetailTableViewTag)
    {
        if(self.selectRightPropertyTableIndexPath!=nil && self.rightPropertyListDic!=nil)
        {
            ListItem *inspectionitem = nil;
            if(self.selectRightPropertyTableIndexPath.section == 0)
            {
                inspectionitem = [self.rightPropertyListDic objectForKey:@"top"];
            }
            else
            {
                NSMutableArray *bottomarray = [self.rightPropertyListDic objectForKey:@"bottom"];
                if(bottomarray!=nil)
                {
                    inspectionitem = [bottomarray objectAtIndex:self.selectRightPropertyTableIndexPath.row];
                }
            }
            if(inspectionitem!=nil)
            {
                NSDictionary *pro = (NSDictionary *)[inspectionitem getData:@"sl_propertyID"];
                if(pro!=nil)
                {
                    if(indexPath.row==2)
                    {
                        NSString *identifier = @"PropertyDetailsImage";
                        PropertyDetailsImage *cell  = [tableView dequeueReusableCellWithIdentifier:identifier];
                        if (cell == nil) {
                            [tableView registerNib:[UINib nibWithNibName:@"PropertyDetailsImage" bundle:nil] forCellReuseIdentifier:identifier];
                            cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
                        }
                        
                        NSString *address = [pro objectForKey:@"sl_address1"];
                        //NSString *propertyId =[NSString stringWithFormat:@"%@",[pro objectForKey:@"ID"]];
                        NSMutableDictionary *prodict = [self.propertyDic objectForKey:self.selectRightPropertyItemId];
                        UIImage *image =(UIImage *)[prodict objectForKey:@"image"];
                        [cell setCellValue:image title:address];
                        
                        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                        return cell;
                    }
                    else
                    {
                        NSString *identifier = @"PropertyDetailsCell";
                        PropertyDetailsCell *cell  = [tableView dequeueReusableCellWithIdentifier:identifier];
                        if (cell == nil) {
                            [tableView registerNib:[UINib nibWithNibName:@"PropertyDetailsCell" bundle:nil] forCellReuseIdentifier:identifier];
                            cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
                        }
                        if (indexPath.row == 0) {
                            NSString *title = [pro objectForKey:@"Title"];
                            [cell setCellValue:[UIImage imageNamed:@"home"] title:title];
                        }
                        else
                        {
                            NSString *title = [pro objectForKey:@"sl_owner"];
                            [cell setCellValue:[UIImage imageNamed:@"man"] title:title];
                        }
                        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                        return cell;
                    }
                    
                }
            }
        }
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == RightPropertyDetailTableViewTag)
    {
        [self rightPropertyTableSelectIndexChange:indexPath];
    }
    else if(tableView.tag == LeftInspectionLeftTableViewTag)
    {
        if(self.selectLetInspectionIndexPath !=indexPath)
        {
            self.selectLetInspectionIndexPath = indexPath;
            self.selectLetRoomIndexPath = nil;
            
            InspectionListCell *cell = (InspectionListCell *)[tableView cellForRowAtIndexPath:indexPath];
            NSString *stringTemp = [NSString stringWithFormat:@"        %@  |  %@",cell.dateTime.text,cell.owner.text];
            [(UILabel *)[self.view viewWithTag:RightRoomImageDateLblTag] setText:stringTemp];
            if(cell.plusImage.image!=nil)
            {
                [self.view viewWithTag:LeftFinalizeBtnTag].hidden = NO;
            }
            else
            {
                [self.view viewWithTag:LeftFinalizeBtnTag].hidden = YES;
            }
            
        }
        if([self.view viewWithTag:LeftBackButtonViewTag].hidden)
        {
            
            [UIView animateWithDuration:0.3 animations:
             ^{
                 [self.view viewWithTag:LefSliderViewTag].frame = CGRectMake(24, 100,  320, 657);
                 [self.view viewWithTag:LeftRoomSegViewTag].hidden = NO;
                 if(self.roomsOfInspectionDic==nil)
                 {
                     //get room data using service
                     [self GetRoomInspectionPhotosList];
                 }
                 else
                 {
                     [(UITableView *)[self.view viewWithTag:LeftRoomTableViewTag] reloadData];
                     [self didSelectRoomTableItem:[NSIndexPath indexPathForRow:0 inSection:0] refresh:YES];
                 }
                 
             }
                             completion:^(BOOL finished){
                                 if (finished) {
                                     [UIView animateWithDuration:0.3 animations:
                                      ^{
                                          [self.view viewWithTag:RightSliderViewTag].frame=CGRectMake(355, 91, 669, 677);
                                          [self.view viewWithTag:LeftBackButtonViewTag].hidden = NO;
                                      }
                                                      completion:^(BOOL finished){
                                                      }];
                                 }
                             }];
        }
        else
        {
            [(UITableView *)[self.view viewWithTag:LeftRoomTableViewTag] reloadData];
            [self didSelectRoomTableItem:[NSIndexPath indexPathForRow:0 inSection:0] refresh:YES];
        }
    }
    else if(tableView.tag == LeftRoomTableViewTag)
    {
        [self didSelectRoomTableItem:indexPath refresh:NO];
    }
    else
    {
        
    }
}
#pragma mark - Property Table cell init value
-(NSString *)getSelectLeftInspectionItemId
{
    if(self.selectRightPropertyTableIndexPath!=nil)
    {
        NSDictionary *tempdic  = [self.propertyDic objectForKey:self.selectRightPropertyItemId];
        if(tempdic!=nil)
        {
            NSArray * inspectionlist = [tempdic objectForKey:@"inspectionslist"];
            if(inspectionlist!=nil)
            {
                if(self.selectLetInspectionIndexPath!=nil)
                {
                    NSDictionary *inspecdic =[inspectionlist objectAtIndex:self.selectLetInspectionIndexPath.row];
                    NSString *insId = [inspecdic objectForKey:@"ID"];
                    return insId;
                }
            }
        }
    }
    return nil;
}
-(void)setLeftInspectionTableCell:(InspectionListCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *prodic = [self.propertyDic objectForKey:self.selectRightPropertyItemId];
    
    if(prodic!=nil)
    {
        NSMutableArray *inspectionList = [prodic objectForKey:@"inspectionslist"];
        NSDictionary *inspecdic =[inspectionList objectAtIndex:indexPath.row];
        if(inspecdic!=nil)
        {
            [cell setCellValue:[inspecdic objectForKey:@"sl_datetime"]
                         owner:[inspecdic objectForKey:@"sl_accountname"]
                         incident:[inspecdic objectForKey:@"icon"]
                          plus:[[inspecdic objectForKey:@"bowner"] isEqualToString:@"YES"]];
        }
    }
}
-(void)setLeftRoomTableCell:(RoomListCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableArray *roomsArray = [self.roomsOfInspectionDic objectForKey:[self getSelectLeftInspectionItemId]];
    if(roomsArray!=nil)
    {
        NSDictionary *roomDic = [roomsArray objectAtIndex:indexPath.row];
        NSString *roomIconName = @"greenRoom";
        if(![self.roomsOfInspectionDic objectForKey:[self getSelectLeftInspectionItemId]])
        {
            roomIconName = @"redRoom";
        }
        [cell setCellValue:roomIconName title:[roomDic objectForKey:@"Title"]];
    }
}
-(void)setRightTableCell:(PropertyListCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListItem *inspectionitem = nil;
    if(indexPath.section == 0)
    {
        inspectionitem = [self.rightPropertyListDic objectForKey:@"top"];
    }
    else
    {
        NSMutableArray *bottomarray = [self.rightPropertyListDic objectForKey:@"bottom"];
        inspectionitem = [bottomarray objectAtIndex:indexPath.row];
    }
    
    NSDictionary *pro = (NSDictionary *)[inspectionitem getData:@"sl_propertyID"];
    if(pro!=nil)
    {
        NSString *address = [pro objectForKey:@"sl_address1"];
        NSString *propertyId =[NSString stringWithFormat:@"%@",[pro objectForKey:@"ID"]];
        if(propertyId!=nil)
        {
            NSMutableDictionary *prodict = [self.propertyDic objectForKey:propertyId];
            UIImage *image =(UIImage *)[prodict objectForKey:@"image"];
            [cell setCellValue:image address:address];
        }
    }
}

#pragma mark - Room Detail Right Collection view
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(collectionView.tag == RightRoomCollectionViewTag)//right image collection view
    {
        return [self getRightCollectionViewItemsCount];
    }
    return 0;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView.tag == RightRoomCollectionViewTag)
    {
        self.selectRightCollectionIndexPath = indexPath;
        EKNCollectionViewCell *cell = (EKNCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
       // cell.selectImageViw.hidden = NO;
        if (cell.imagecell!=nil) {
            [self setRightLargeImage:cell.imagecell.image];
        }
        else
        {
            [self setRightLargeImage:nil];
        }
    }
}
/*- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    if(collectionView.tag == RightRoomCollectionViewTag)
    {
        EKNCollectionViewCell *cell = (EKNCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        cell.selectImageViw.hidden = YES;
    }
}*/
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
     if(collectionView.tag == RightRoomCollectionViewTag)
    {
        NSString *identifier = @"EKNCollectionViewCell";

        EKNCollectionViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        [self setRightCollectionCellValue:cell indexpath:indexPath];
        NSLog(@"collection view %p",cell);
        return cell;
    }
    return nil;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    /*CGFloat width = image.size.width;
    CGFloat heigth = image.size.height;
    if(heigth > 116)
    {
        width = width / (heigth / 116);
        heigth = 116;
    }
    return CGSizeMake(width, heigth);*/
    
    return CGSizeMake(150, 116);
}
#pragma mark - Room Collection cell init value
-(void)setRightCollectionCellValue:(EKNCollectionViewCell *)cell indexpath:(NSIndexPath *)indexpath
{
    NSInteger proId = [self.selectRightPropertyItemId intValue];
    NSInteger insId = [[self getSelectLeftInspectionItemId] intValue];
    
    NSArray *roomsArray = [self.roomsOfInspectionDic objectForKey:[NSString stringWithFormat:@"%ld",insId]];
    NSInteger roomIdex =self.selectLetRoomIndexPath.row;
    
    if([roomsArray count]>=roomIdex+1)
    {
        NSDictionary *roomdic = [roomsArray objectAtIndex:roomIdex];
        NSArray *imagesArray = [roomdic objectForKey:@"ImagesArray"];
        if([imagesArray count]>=indexpath.row+1)
        {
            NSDictionary *imagedic = [imagesArray objectAtIndex:indexpath.row];
            UIImage *roomImage = [imagedic objectForKey:@"image"];
            if(roomImage!=nil)
            {
                
                [cell.imagecell setImage:roomImage];
                [self.spinner stopAnimating];
            }
            else
            {
                [cell.imagecell setImage:nil];
                
                if([imagedic objectForKey:@"ServerRelativeUrl"] == nil)
                {
                    NSString *fileId = [imagedic objectForKey:@"Id"];
                    //task read file infor
                    ListClient *client = [self getClient];
                    NSURLSessionTask* getFileResourcetask = [client getListItemFileByFilter:@"Room Inspection Photos"
                                                                                     FileId:fileId
                                                                                     filter:@"$select=ServerRelativeUrl"
                                                                                   callback:^(NSMutableArray *listItems, NSError *error)
                                                             {
                                                                 dispatch_async(dispatch_get_main_queue(), ^{
                                                                     
                                                                     if([listItems count]>0)
                                                                     {
                                                                         NSString *path =(NSString *)[[listItems objectAtIndex:0] getData:@"ServerRelativeUrl"];
                                                                         [imagedic setValue:path forKey:@"ServerRelativeUrl"];
                                                                         [self getRoomImageFileREST:path
                                                                                         propertyId:proId
                                                                                       inspectionId:insId
                                                                                       roomIndex:roomIdex
                                                                                       imageIndex:indexpath.row];
                                                                     }
                                                                 });
                                                             }];
                    
                    [getFileResourcetask resume];
                }
            }

            
        }
    }
    
}
@end
