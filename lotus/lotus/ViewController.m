//
//  ViewController.m
//  lotus
//
//  Created by Ying, Yuqian on 4/23/14.
//  Copyright (c) 2014 ___MSTR___. All rights reserved.
//

#import "ViewController.h"
#import "Deck.h"
#import "CardMatchingGame.h"

@interface ViewController ()
<<<<<<< HEAD
@property (weak, nonatomic) IBOutlet UILabel *FlipsLable;
=======
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastScore;
>>>>>>> FETCH_HEAD
@property (nonatomic) int flipCount;
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scorelable;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeID;

@end

@implementation ViewController

- (IBAction)reStart:(UIButton *)sender {
    [self setFlipCount:0];
    _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    [self updateUI];
    
}

- (CardMatchingGame *)game
{
    if (!_game) _game= [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    return _game;
}

- (Deck *)deck
{
    if (!_deck) _deck = [self createDeck];
    return _deck;
}

- (Deck *)createDeck //abstract
{
    //return [[PlayCardDeck alloc] init];
    return nil;
}

<<<<<<< HEAD

- (void)setFlipCount:(int)flipCount
{
=======
- (void)changeLastScore
{
self.lastScore.text = [NSString stringWithFormat:@"Last Score: %ld", (long)self.game.score];
}


- (void)setFlipCount:(int)flipCount
{
    [self performSelectorInBackground:@selector(changeLastScore) withObject:nil];
>>>>>>> FETCH_HEAD
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d",self.flipCount];
    NSLog(@"flipCount change to %d", self.flipCount);
}

- (IBAction)touchCardButton:(UIButton *)sender {
    /*
    if ([sender.currentTitle length]) {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    }
    else
    {
        Card *randCard = [self.deck drawRandomCard];
        if (randCard) {
            [sender setBackgroundImage:[UIImage imageNamed:@"CardFront"] forState:UIControlStateNormal];
            [sender setTitle:randCard.contents forState:UIControlStateNormal];
        }
      
    }
     */
    NSUInteger chooseButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chooseButtonIndex];
    [self updateUI];
    self.flipCount++;
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    }

}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents:@"";
}

<<<<<<< HEAD
-(NSString *)backgroundImageForCard:(Card *)card
=======
- (UIImage *)backgroundImageForCard:(Card *)card
>>>>>>> FETCH_HEAD
{
    return [UIImage imageNamed:card.isChosen ? @"CardFront" : @"cardback" ];
}

<<<<<<< HEAD
=======
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[self usePreferredFronts];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(preferredFrontsChanges:) name:UIContentSizeCategoryDidChangeNotification object:nil];
}

- (void)preferredFrontsChanges:(NSNotification  *)notification
{
    [self usePreferredFronts];
}

- (void)usePreferredFronts
{
    self.flipsLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.scoreLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}

>>>>>>> FETCH_HEAD

@end
