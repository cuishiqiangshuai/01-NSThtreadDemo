//
//  ViewController.m
//  01-NSThtreadDemo
//
//  Created by qingyun on 16/6/12.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"
#define KURL @"http://www2.ppdesk.com/file/20100120/desk/2009/06/15/pincel3D_4_09_1024.jpg"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *tempImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)updateImage:(UIImage *)image{
    
    if ([[NSThread currentThread] isMainThread]) {
        NSLog(@"=====是主线程");
    }
    _tempImageView.image=image;

}

-(void)loadImageData{
    @autoreleasepool {
    //1.NSURL
    NSURL *url=[NSURL URLWithString:KURL];
    //2.下载
    NSData *data=[NSData dataWithContentsOfURL:url];
    //3.刷新UI
    UIImage *image=[UIImage imageWithData:data];
    
    if ([[NSThread currentThread] isMainThread]) {
        NSLog(@"=====是主线程");
    }
    //刷新UI必须通过主线程调用
    //dispatch_async(dispatch_get_main_queue(), ^{
      //  _tempImageView.image=image;
   // });
    [self performSelectorOnMainThread:@selector(updateImage:) withObject:image waitUntilDone:YES];
    }

}




- (IBAction)downLoadAction:(id)sender {
   //1启动一条线程,进行下载操作子线程
    if ([[NSThread currentThread] isMainThread]) {
        NSLog(@"=====是主线程");
    }
    
    [NSThread detachNewThreadSelector:@selector(loadImageData) toTarget:self withObject:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
