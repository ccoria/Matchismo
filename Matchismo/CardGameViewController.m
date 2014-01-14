//
//  CardGameViewController.m
//  Matchismo
//
//  Created by ccoria on 22/04/13.
//  Copyright (c) 2013 ccoria. All rights reserved.
//

#import "CardGameViewController.h"
#import "TwoCardMatchingGame.h"
#import "ThreeCardMatchingGame.h"
#import <QuartzCore/QuartzCore.h>

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (nonatomic) int flipCount;
@property (nonatomic) int scoreCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UIButton *restartButton;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeSwitcher;
@property (nonatomic) BOOL isThreeCardGame;
@property (nonatomic) BOOL enableGameSwitcher;
@property (nonatomic) UIImage *beatlesLogo;
@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if (!_game){
        CardMatchingGame *cardGame = self.isThreeCardGame ?
        [ThreeCardMatchingGame alloc] : [TwoCardMatchingGame alloc];
        
        _game = [cardGame initWithCardCount:self.cardButtons.count
                                  usingDeck:[self createDeck]];
    }
    
    return _game;
}



- (Deck *)createDeck
{
    return nil; // implemented in PlayingCardViewController;
}


- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    
    UIImage *beatlesImage = [UIImage imageNamed:@"the_beatles_logo_black.jpg"];
    self.beatlesLogo = beatlesImage;
    [self updateUI];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        int currentIndex = [self.cardButtons indexOfObject:cardButton];
        Card *currentCard = [self.game cardAtIndex:currentIndex];
        
        NSString *cardContents = [currentCard contents];
        
        // The set image property was not respecting the states
        [cardButton setBackgroundImage:nil forState:UIControlStateNormal];
        if (!currentCard.isFaceUp) {
            [cardButton setBackgroundImage:self.beatlesLogo forState:UIControlStateNormal];
            cardButton.layer.cornerRadius = 8;
            cardButton.clipsToBounds = YES;
        }
        
        [cardButton setTitle:cardContents forState:UIControlStateSelected];
        [cardButton setTitle:cardContents forState:UIControlStateSelected|UIControlStateDisabled];
        
        cardButton.selected = currentCard.isFaceUp;
        cardButton.enabled = !currentCard.isUnplayable;
        
        cardButton.alpha = currentCard.isUnplayable ? 0.3 : 1.0;
        
        cardButton.layer.borderWidth=1.0f;
        [cardButton.layer setBorderColor:[[UIColor blackColor] CGColor]];
        
        [self setScoreCount:self.game.score];
        self.statusLabel.text = self.game.status;
    }
}

- (IBAction)flipCard:(UIButton *)sender
{
    //NSLog(@"Flipping UI");
    self.gameModeSwitcher.enabled = NO;
    int cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game flipCardAtIndex:cardIndex];
    
    [self updateUI];
    //NSLog(@"Changed: %d", sender.state);
    
    self.flipCount++;
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"%d Flips", self.flipCount];
}

-(void)restartGame
{
    self.gameModeSwitcher.enabled = YES;
    self.game = nil;
    self.flipCount = 0;
    
    [self updateUI];
    self.statusLabel.text = @"Flip cards to start!";

}

- (IBAction)restartGame:(UIButton *)sender
{
    [self restartGame];
}

- (IBAction)gameTypeChanged:(UISegmentedControl *)sender
{
    self.isThreeCardGame = sender.selectedSegmentIndex;
    [self restartGame];
    
    //NSLog(@"Changed: %d", sender.selectedSegmentIndex);
}

- (void)setScoreCount:(int)score
{
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", score];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
