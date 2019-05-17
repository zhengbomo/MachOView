//
//  DragableView.h
//  MachOView
//
//  Created by bomo on 2019/5/18.
//

#import <Cocoa/Cocoa.h>

@class DragableView;

@protocol DragableViewDelegate <NSObject>

@optional
- (void)dragableView:(DragableView *)view files:(NSArray<NSString *> *)files;
- (void)dragableView:(DragableView *)view folder:(NSString *)folder;

@end

@interface DragableView : NSView

@property (nonatomic, weak) id<DragableViewDelegate> delegate;

// empty for all
@property (nonatomic, copy) NSArray<NSString *> *acceptPathExtension;
@property (nonatomic, assign) BOOL acceptFolder;

@end
