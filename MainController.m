//
//  MainController.m
//  MachOView
//
//  Created by bomo on 2019/5/18.
//

#import "MainController.h"
#import "DragableView.h"
#import <Cocoa/Cocoa.h>

@interface MainController () <DragableViewDelegate>

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.view isKindOfClass:DragableView.class]) {
        DragableView *dragableView = (DragableView *)self.view;
        dragableView.delegate = self;
        dragableView.acceptPathExtension = @[];
    }
}

#pragma mark - DragableViewDelegate
- (void)dragableView:(DragableView *)view files:(NSArray<NSString *> *)files {
    NSString *file = files.firstObject;
    if (file) {
        // open document
        [NSApplication.sharedApplication.delegate application:NSApp openFile:file];
    }
}

@end
