//
//  ViewController.m
//  ShowLabelAnimation
//
//  Created by Deepak on 29/03/14.
//  Copyright (c) 2014 Deepak. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *score;
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation ViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
     self.score.text = [NSString stringWithFormat:@"%d", 500];
}

- (void) viewDidAppear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)scoreButtonPressed:(id)sender {
    self.timer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target:self   selector:@selector(updateScore) userInfo:nil repeats:YES];
}

-(void)updateScore {
    static int i = 0;
    CATransition *animation = [CATransition animation];
    animation.duration = 1.0;
    animation.type = kCATransitionFade;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.score.layer addAnimation:animation forKey:@"changeTextTransition"];
    
    // Change the text
    self.score.text = [NSString stringWithFormat:@"%d", [self.score.text intValue] - 1];
    i++;
    if (i == 10 && [self.timer isValid]) {
        [self.timer invalidate];
        i = 0;
    }
}

@end
