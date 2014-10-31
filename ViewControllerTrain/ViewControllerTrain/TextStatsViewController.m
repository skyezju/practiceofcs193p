//
//  TestStatsViewController.m
//  ViewControllerTrain
//
//  Created by Ying, Yuqian on 10/23/14.
//  Copyright (c) 2014 Ying, Yuqian. All rights reserved.
//

#import "TextStatsViewController.h"

@interface TextStatsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *colorfulCharactersLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlinedCharactersLable;

@end

@implementation TextStatsViewController
/*
- (void) viewDidLoad
{
    [super viewDidLoad];
    self.textToAnalyze = [[NSAttributedString alloc] initWithString:@"test" attributes:@{ NSForegroundColorAttributeName : [UIColor greenColor], NSStrokeColorAttributeName: @-3 }];
}
*/

- (void)updateUI
{
  self.colorfulCharactersLabel.text = [NSString stringWithFormat:@"%d colourful characters", [[self charactersWithAttribute:NSForegroundColorAttributeName] length]];
    self.outlinedCharactersLable.text = [NSString stringWithFormat:@"%d outlined characters", [[self charactersWithAttribute:NSStrokeColorAttributeName] length]];
    
}

- (void)setTextToAnlyze:(NSAttributedString *)textToAnlyze
{
    _textToAnalyze = textToAnlyze;
    if(self.view.window)[self updateUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (NSAttributedString *)charactersWithAttribute:(NSString *)attributeName
{
    NSMutableAttributedString *characters = [[NSMutableAttributedString alloc] init];
    
    int index = 0;
    
    while (index < [self.textToAnalyze length]) {
        NSRange range;
        id value = [self.textToAnalyze attribute:attributeName atIndex:index effectiveRange:&range];
        if (value) {
            [characters appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
            index = range.location + range.length;
        }else{
            index++;
        }
    }
    
    return characters;
}

@end
