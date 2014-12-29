//
//  ViewController.m
//  ViewTrain
//
//  Created by Ying, Yuqian on 10/21/14.
//  Copyright (c) 2014 Ying, Yuqian. All rights reserved.
//

#import "ViewController.h"
#import "TextStatsViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *body;
@property (weak, nonatomic) IBOutlet UILabel *headLine;
@property (weak, nonatomic) IBOutlet UIButton *outlineButton;

@end

@implementation ViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Analyze Text"]) {
        if ([segue.destinationViewController isKindOfClass:[TextStatsViewController class] ]) {
            TextStatsViewController *tsvc = (TextStatsViewController *)segue.destinationViewController;
            tsvc.textToAnalyze = self.body.textStorage;
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:self.outlineButton.currentTitle];
    [title setAttributes:@{ NSStrokeColorAttributeName : [UIColor blackColor],
                            NSStrokeWidthAttributeName : @-3} range:NSMakeRange(0, [title length])];
    [self.outlineButton setAttributedTitle:title forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(preferredFrontsChanges:) name:UIContentSizeCategoryDidChangeNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIContentSizeCategoryDidChangeNotification object:nil];
    
}

- (void)preferredFrontsChanges:(NSNotification  *)notification
{
    [self usePreferredFronts];
}

- (void)usePreferredFronts
{
    self.body.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.headLine.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}

- (IBAction)changeBodySelectionColorToMatchBackgroudOfButton:(UIButton *)sender {
    [self.body.textStorage addAttribute:NSForegroundColorAttributeName value:sender.backgroundColor range:self.body.selectedRange];

}

- (IBAction)outLineSelectedWords:(id)sender {
    [self.body.textStorage addAttributes:@{ NSStrokeColorAttributeName : [UIColor blackColor],
        NSStrokeWidthAttributeName : @-3}
                                   range:self.body.selectedRange];
}

- (IBAction)unOutLineSelectedWords:(UIButton *)sender {
    [self.body.textStorage addAttributes:@{ NSStrokeColorAttributeName : [UIColor blackColor],
                                            NSStrokeWidthAttributeName : @0}
                                   range:self.body.selectedRange];
}




@end
