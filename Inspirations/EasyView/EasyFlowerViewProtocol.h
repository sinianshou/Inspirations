//
//  EasyFlowerViewProtocol.h
//  Inspirations
//
//  Created by Easer on 2018/2/16.
//  Copyright © 2018年 Easer. All rights reserved.
//

#ifndef EasyFlowerViewProtocol_h
#define EasyFlowerViewProtocol_h

@class EasyFlowerView;
@class EasyFlowerViewCell;

@protocol EasyFlowerViewDataSource <NSObject>
@required
- (NSInteger)numberOfRowsInEasyFlowerView:(EasyFlowerView *)easyFlowerView;
- (EasyFlowerViewCell *)easyFlowerView:(EasyFlowerView *)easyFlowerView cellForRow:(NSInteger)row;
@optional
//- (NSInteger)numberOfSectionsInEasyFlowerView:(EasyFlowerView *)easyFlowerView;              // Default is 1 if not implemented
//- (NSString *)easyFlowerView:(EasyFlowerView *)easyFlowerView titleForHeaderInSection:(NSInteger)section;
//- (NSString *)easyFlowerView:(EasyFlowerView *)easyFlowerView titleForFooterInSection:(NSInteger)section;
//- (BOOL)easyFlowerView:(EasyFlowerView *)easyFlowerView canEditRowAtIndexPath:(NSIndexPath *)indexPath;
//- (BOOL)easyFlowerView:(EasyFlowerView *)easyFlowerView canMoveRowAtIndexPath:(NSIndexPath *)indexPath;
//- (NSArray<NSString *> *)sectionIndexTitlesForEasyFlowerView:(EasyFlowerView *)easyFlowerView;
//- (NSInteger)easyFlowerView:(EasyFlowerView *)easyFlowerView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;  // tell table which section corresponds to section title/index (e.g. "B",1))
//- (void)easyFlowerView:(EasyFlowerView *)easyFlowerView commitEditingStyle:(EasyFlowerViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)easyFlowerView:(EasyFlowerView *)easyFlowerView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;
@end

@protocol EasyFlowerViewDelegate <NSObject>
@optional
@end


#endif /* EasyFlowerViewProtocol_h */
