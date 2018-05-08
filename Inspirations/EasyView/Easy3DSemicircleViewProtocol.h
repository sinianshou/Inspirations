//
//  Easy3DSemicircleViewProtocol.h
//  Inspirations
//
//  Created by Easer on 2018/2/16.
//  Copyright © 2018年 Easer. All rights reserved.
//

#ifndef Easy3DSemicircleViewProtocol_h
#define Easy3DSemicircleViewProtocol_h

@class Easy3DSemicircleView;
@class Easy3DSemicircleViewCell;

@protocol Easy3DSemicircleViewDataSource <NSObject>
@required
- (NSInteger)numberOfRowsInEasy3DSemicircleView:(Easy3DSemicircleView *)easy3DSemicircleView;
- (Easy3DSemicircleViewCell *)easy3DSemicircleView:(Easy3DSemicircleView *)easy3DSemicircleView cellForRow:(NSInteger)row;
@optional
//- (NSInteger)numberOfSectionsInEasy3DSemicircleView:(Easy3DSemicircleView *)easy3DSemicircleView;              // Default is 1 if not implemented
//- (NSString *)easy3DSemicircleView:(Easy3DSemicircleView *)easy3DSemicircleView titleForHeaderInSection:(NSInteger)section;
//- (NSString *)easy3DSemicircleView:(Easy3DSemicircleView *)easy3DSemicircleView titleForFooterInSection:(NSInteger)section;
//- (BOOL)easy3DSemicircleView:(Easy3DSemicircleView *)easy3DSemicircleView canEditRowAtIndexPath:(NSIndexPath *)indexPath;
//- (BOOL)easy3DSemicircleView:(Easy3DSemicircleView *)easy3DSemicircleView canMoveRowAtIndexPath:(NSIndexPath *)indexPath;
//- (NSArray<NSString *> *)sectionIndexTitlesForEasy3DSemicircleView:(Easy3DSemicircleView *)easy3DSemicircleView;
//- (NSInteger)easy3DSemicircleView:(Easy3DSemicircleView *)easy3DSemicircleView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;  // tell table which section corresponds to section title/index (e.g. "B",1))
//- (void)easy3DSemicircleView:(Easy3DSemicircleView *)easy3DSemicircleView commitEditingStyle:(Easy3DSemicircleViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)easy3DSemicircleView:(Easy3DSemicircleView *)easy3DSemicircleView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;
@end

@protocol Easy3DSemicircleViewDelegate <NSObject>
@optional
@end

#endif /* Easy3DSemicircleViewProtocol_h */
