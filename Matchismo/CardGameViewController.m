//
//  CardGameViewController.m
//  Matchismo
//
//  Created by William Bertrand on 2/22/13.
//  Copyright (c) 2013 William Bertrand. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "GameResult.h"
@interface CardGameViewController ()

//priavte instance fields
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *cardMatchControll;

@property (weak, nonatomic) IBOutlet UISegmentedControl *matchSwitch;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic)CardMatchingGame* game;
@property (strong, nonatomic) GameResult* gameResult;
@end

@implementation CardGameViewController


-(GameResult *)gameResult
{
    if(!_gameResult) _gameResult=[[GameResult alloc] init];
    return _gameResult;
}

-(CardMatchingGame *)game
{
    if(!_game) {
        _game=[[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                       usingDeck: [[PlayingCardDeck alloc] init]];
        [self segmentSwitch:self.cardMatchControll];
    }
    return _game;
}



-(IBAction)setCardButtons:(NSArray *)cardButtons
{
    
    _cardButtons=cardButtons;
    //common to have method like update UI to keep view and model in sync
    [self updateUI];
    
}
//make UI match model--> controller's fundamental job
-(void)updateUI
{
    UIImage *cardBackImage = [UIImage imageNamed:@"angryCat.jpg"];
    for(UIButton *cardButton in self.cardButtons){
        Card *card=[self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        if(!card.isFaceUp){
            [cardButton setImage:cardBackImage forState:UIControlStateNormal];
            [cardButton setImageEdgeInsets:(UIEdgeInsetsMake(4,4,4,4))];
        }
        else{
            [cardButton setImage:nil forState:UIControlStateNormal];
        }
        
        //card is in both selected and disabled state at the same time-> so
        //you must set it's title for both states, or else it will not work
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];

        cardButton.selected=card.isFaceUp;
        cardButton.enabled=!card.isUnplayable;
        cardButton.alpha=(card.isUnplayable ? 0.3:1.0); 
        
    }
    
    self.scoreLabel.text=[NSString stringWithFormat:@"Score: %d",self.game.score];
    self.resultLabel.text=self.game.resultString;
}

-(IBAction)flipCard:(UIButton*) sender
{
    
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
    self.flipsLabel.text=[NSString stringWithFormat:@"Flips: %d",self.flipCount];
    self.matchSwitch.enabled=NO;
    self.gameResult.score=self.game.score;
}
-(IBAction)newGame:(id)sender
{
    
    self.game=nil;
    self.flipCount=0;
    self.flipsLabel.text=@"Flips: 0";
    self.matchSwitch.enabled=YES;
    [self updateUI];
    
    
}
- (IBAction)segmentSwitch:(id)sender
{
    UISegmentedControl* controll= (UISegmentedControl*)sender;
    
    if(controll.selectedSegmentIndex==0){
        self.game.numberOfMatchingCards=2;
    }
    else if(controll.selectedSegmentIndex==1){
        self.game.numberOfMatchingCards=3;
    }
    else{
        self.game.numberOfMatchingCards=2;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self newGame:self];
}
@end













