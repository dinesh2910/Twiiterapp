//
//  ViewController.m
//  Twiiterapp
//
//  Created by dinesh danda on 6/22/16.
//  Copyright © 2016 dinesh danda. All rights reserved.
//

#import "ViewController.h"
#import "Social/Social.h"

@interface ViewController ()
-(void) showAlertMessage: (NSString *) myMessge;
-(void) configureTweetTextView;
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTweetTextView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) showAlertMessage: (NSString *) myMessge{
    UIAlertController *alertController;
    alertController = [UIAlertController alertControllerWithTitle:@"TwitterShare" message:myMessge preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
   }

- (IBAction)shareTextView:(id)sender {
    if ([self.tweetTextView isFirstResponder]){
        [self.tweetTextView resignFirstResponder];
    }
    
        UIAlertController *actionController = [UIAlertController alertControllerWithTitle:@"" message:@"Tweet yout tweet" preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:actionController animated:"Yes" completion:nil];
    
    UIAlertAction *cancellAction = [UIAlertAction actionWithTitle:@"Canccel" style:UIAlertActionStyleDefault handler:nil];
    
    [actionController addAction:cancellAction];
    UIAlertAction *postAction = [UIAlertAction actionWithTitle:@"Post" style:UIAlertActionStyleDefault handler:nil];
    
    [actionController addAction:postAction];
    
    
    
    
    
    
    UIAlertAction *tweetAction = [UIAlertAction actionWithTitle:@"Tweet" style:UIAlertActionStyleDefault handler:^ (UIAlertAction *action){
        if([SLComposeViewController  isAvailableForServiceType:SLServiceTypeTwitter]){
            
            SLComposeViewController * twitterVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            if([self.tweetTextView.text length]<140){
                [twitterVC setInitialText:self.tweetTextView.text];
                
                
            }
            else{
                NSString *shortText = [self.tweetTextView.text substringFromIndex:140];
                [twitterVC setInitialText:shortText];
                
            }
            
            [self presentViewController:twitterVC animated:YES completion:nil];
            
            // tweet the tweet
        }
        else{
            //rasie some kind of objection
            [self showAlertMessage:@"You are not signed into twitter"];
        }
    }];
    
    [actionController addAction:tweetAction];
    
    
        
        
        
   
}
-(void) configureTweetTextView{
    self.tweetTextView.layer.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0].CGColor;
    self.tweetTextView.layer.cornerRadius = 10.0;
    self.tweetTextView.layer.borderWidth = 2.0;
    self.tweetTextView.layer.borderColor = [UIColor colorWithWhite:1.0 alpha:0.9].CGColor;
}

@end
