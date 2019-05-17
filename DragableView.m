//
//  DragableView.m
//  MachOView
//
//  Created by bomo on 2019/5/18.
//

#import "DragableView.h"

@interface DragableView ()


@end

@implementation DragableView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self registerForDraggedTypes:@[NSPasteboardTypeFileURL]];
}

- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender {
    NSArray *paths = [sender.draggingPasteboard propertyListForType:NSFilenamesPboardType];
    if (self.acceptFolder && paths.count == 1) {
        BOOL isDirectory;
        if ([NSFileManager.defaultManager fileExistsAtPath:paths[0] isDirectory:&isDirectory]);
        if (isDirectory) {
            return NSDragOperationCopy;
        }
    }
    
    if (self.acceptPathExtension.count > 0) {
        NSString *path = paths.firstObject;
        if ([self.acceptPathExtension containsObject:path.pathExtension]) {
            return NSDragOperationCopy;
        } else {
            return NSDragOperationNone;
        }
    } else {
        return NSDragOperationCopy;
    }
}

- (BOOL)prepareForDragOperation:(id<NSDraggingInfo>)sender {
    NSArray *paths = [sender.draggingPasteboard propertyListForType:NSFilenamesPboardType];
    if (self.acceptFolder && paths.count == 1) {
        BOOL isDirectory;
        if ([NSFileManager.defaultManager fileExistsAtPath:paths[0] isDirectory:&isDirectory]);
        if (isDirectory) {
            if ([self.delegate respondsToSelector:@selector(dragableView:folder:)]) {
                [self.delegate dragableView:self folder:paths[0]];
            }
            return YES;
        }
    }
    
    
    NSMutableArray *acceptPaths = [NSMutableArray array];
    if (self.acceptPathExtension.count > 0) {
        for (NSString *path in paths) {
            if ([self.acceptPathExtension containsObject:path.pathExtension]) {
                [acceptPaths addObject:path];
            }
        }
    } else {
        [acceptPaths addObjectsFromArray:paths];
    }
    
    if (acceptPaths.count > 0) {
        if ([self.delegate respondsToSelector:@selector(dragableView:files:)]) {
            [self.delegate dragableView:self files:acceptPaths];
        }
        return YES;
    }
    
    return NO;
}

@end


