#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Preferences/PSSpecifier.h>
#import <Preferences/PSListController.h>
#import <objc/runtime.h>
#import <spawn.h>
#import "../tweak.h"

#define UserDefaultsChangedNotification "xyz.turannul.CellularX"
#define SettingsPath @"/var/mobile/Library/Preferences/xyz.turannul.CellularX.plist"

@interface PSSpecifier (CellularX)
@property (nonatomic, retain) NSArray *values;
- (void)setIdentifier:(NSString *)identifier;
@end

@interface PSListController (CellularX)
- (void)loadView;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@end


@interface PSTableCell (CellularX)
@property(readonly, assign, nonatomic) UILabel* textLabel;
@end

//====================================================================================================================

id getUserDefaultForKey(NSString *key) {
    NSDictionary *defaults = [NSDictionary dictionaryWithContentsOfFile:SettingsPath];
    return [defaults objectForKey:key];
}

void setUserDefaultForKey(NSString *key, id value) {
    NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
    [defaults addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:SettingsPath]];
    [defaults setObject:value forKey:key];
    [defaults writeToFile:SettingsPath atomically:YES];
}