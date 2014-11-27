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
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastScore;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;


@end

@implementation ViewController

- (IBAction)reStart:(UIButton *)sender {
    [self setFlipCount:0];
    _game = nil;
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

- (void)ChangeLastScore
{
self.lastScore.text = [NSString stringWithFormat:@"Last Score: %d", self.game.score];
}


- (void)setFlipCount:(int)flipCount
{
    [self performSelectorInBackground:@selector(ChangeLastScore) withObject:nil];
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d",self.flipCount];
    NSLog(@"flipCount change to %d", self.flipCount);
}

- (IBAction)touchCardButton:(UIButton *)sender {
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
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    }

}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents:@"";
}

- (NSString *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"CardFront" : @"cardback" ];
}

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


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIContentSizeCategoryDidChangeNotification object:nil];
    
}
@end
