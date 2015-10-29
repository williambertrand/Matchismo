//
//  GameResultsViewController.m
//  Matchismo
//
//  Created by William Bertrand on 4/2/13.
//  Copyright (c) 2013 William Bertrand. All rights reserved.
//

#import "GameResultsViewController.h"
#import "GameResult.h"
@interface GameResultsViewController ()
@property (weak, nonatomic) IBOutlet UITextView *display;

@end

@implementation GameResultsViewController



-(void)setup{
    //initialization that cannot wait untill viewDidLoad
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateUI];
}

-(void)updateUI
{
    NSString *displayText=@"";
    for(GameResult* result in [GameResult allGameResults])
    {
        displayText=[displayText stringByAppendingFormat:@"Score: %d (%@ %0g)\n",result.score,result.end,round(result.duration)];
    }
    self.display.text=displayText;
    
}
-(void)awakeFromNib{
    
    [self setup];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [self setup];
    return self;
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

@end
