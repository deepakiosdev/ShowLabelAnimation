//
//  ViewController.m
//  ShowLabelAnimation
//
//  Created by Deepak on 29/03/14.
//  Copyright (c) 2014 Deepak. All rights reserved.
//

#import "ViewController.h"
#import "WYPopoverController.h"
#import "TagListViewController.h"

@interface ViewController () <WYPopoverControllerDelegate>

{
    NSString *login;
    NSString *password;
    WYPopoverController* tagListPopoverController;
}

@property (weak, nonatomic) IBOutlet UILabel *score;
@property (strong, nonatomic) NSTimer *timer;
- (IBAction)showPopover:(id)sender;
@end

@implementation ViewController




- (void)viewDidLoad {
    
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 0 && buttonIndex == 1) {
        NSLog(@"Button 2 was pressed ,Login:%@,PWD:%@", [alertView textFieldAtIndex:0].text,[alertView textFieldAtIndex:1].text);
        if ([[alertView textFieldAtIndex:0].text isEqualToString:login] && [[alertView textFieldAtIndex:1].text isEqualToString:password]) {
            NSLog(@"Correct login and password");
        }
    }
    
}

- (IBAction)scoreButtonPressed:(id)sender {
    
    login = @"login";
    password = @"password";
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Title" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Enter", nil];
    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    alert.tag = 0;
    [alert show];

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


- (IBAction)open:(id)sender
{
    [self showPopover:sender];
}

- (void)close:(id)sender
{
    [tagListPopoverController dismissPopoverAnimated:YES completion:^{
        [self popoverControllerDidDismissPopover:tagListPopoverController];
    }];
}

- (void)change:(id)sender
{
    // Change popover content size
    
    //[settingsPopoverController setPopoverContentSize:CGSizeMake(320, 480)];
    
    // Change complete theme
    
    //settingsPopoverController.theme = [WYPopoverTheme themeForIOS6];
    
    //
    
    [tagListPopoverController beginThemeUpdates];
    tagListPopoverController.theme.arrowHeight = 13;
    tagListPopoverController.theme.arrowBase = 25;
    [tagListPopoverController endThemeUpdates];
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"AnotherPopoverSegue"])
//    {
//        WYStoryboardPopoverSegue *popoverSegue = (WYStoryboardPopoverSegue *)segue;
//        anotherPopoverController = [popoverSegue popoverControllerWithSender:sender
//                                                    permittedArrowDirections:WYPopoverArrowDirectionDown
//                                                                    animated:YES
//                                                                     options:WYPopoverAnimationOptionFadeWithScale];
//        anotherPopoverController.delegate = self;
//    }
//}


- (BOOL)popoverControllerShouldDismissPopover:(WYPopoverController *)controller
{
    return YES;
}

- (void)popoverControllerDidDismissPopover:(WYPopoverController *)controller
{
    tagListPopoverController.delegate = nil;
    tagListPopoverController = nil;
}

- (IBAction)showPopover:(id)sender {
    if (tagListPopoverController == nil)
    {
        UIView *btn = (UIView *)sender;
        
        TagListViewController *tagListViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TagListViewController"];
        tagListViewController.preferredContentSize = CGSizeMake(280, 150);
        
        tagListViewController.title = @"Tag";
        
        //[tagListViewController.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"change" style:UIBarButtonItemStylePlain target:self action:@selector(change:)]];
        
        [tagListViewController.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(close:)]];
        
        tagListViewController.modalInPopover = NO;
        
        UINavigationController *contentViewController = [[UINavigationController alloc] initWithRootViewController:tagListViewController];
        
        tagListPopoverController = [[WYPopoverController alloc] initWithContentViewController:contentViewController];
        tagListPopoverController.delegate = self;
        tagListPopoverController.passthroughViews = @[btn];
        tagListPopoverController.popoverLayoutMargins = UIEdgeInsetsMake(10, 10, 10, 10);
        tagListPopoverController.wantsDefaultContentAppearance = NO;
        [tagListPopoverController presentPopoverAsDialogAnimated:YES
                                                         options:WYPopoverAnimationOptionFadeWithScale];
        /* if (sender == dialogButton)
         {
         [tagListViewController presentPopoverAsDialogAnimated:YES
         options:WYPopoverAnimationOptionFadeWithScale];
         }
         else
         {
         [tagListViewController presentPopoverFromRect:btn.bounds
         inView:btn
         permittedArrowDirections:WYPopoverArrowDirectionAny
         animated:YES
         options:WYPopoverAnimationOptionFadeWithScale];
         }*/
    }
    else
    {
        [self close:nil];
    }

}
@end
