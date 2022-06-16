#import "CellularX.h"

@interface CXSettingController: PSListController
-(void) RunCMD:(NSString *)RunCMD WaitUntilExit:(BOOL)WaitUntilExit;
@end

@implementation CXSettingController
-(void) RunCMD:(NSString *)RunCMD WaitUntilExit:(BOOL)WaitUntilExit {
 NSString *SSHGetFlex = [NSString stringWithFormat:@"%@",RunCMD];

 NSTask *task = [[NSTask alloc] init];
 NSMutableArray *args = [NSMutableArray array];
 [args addObject:@"-c"];
 [args addObject:SSHGetFlex];
 [task setLaunchPath:@"/bin/sh"];
 [task setArguments:args];
 [task launch];
 if (WaitUntilExit)
  [task waitUntilExit];
}
- (NSArray *)specifiers
{
    if(_specifiers == nil) {

        NSMutableArray *specifiers = [NSMutableArray array];
        
        [specifiers addObject:[PSSpecifier emptyGroupSpecifier]];
        PSSpecifier *logo3G = [PSSpecifier preferenceSpecifierNamed:@"3G" target:self set:@selector(setValue:forSpecifier:) get:@selector(getValueForSpecifier:) detail:NSClassFromString(@"PSListItemsController") cell:[PSTableCell cellTypeFromString:@"PSLinkListCell"] edit:nil];
        [logo3G setIdentifier:@"3G"];

        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"14.0")) {
            logo3G.values = @[@0,@1,@2,@5,@6,@7,@8]; // @3,@4, broken here
                       logo3G.titleDictionary = [NSDictionary dictionaryWithObjects:@[
                           @"Default", //0
                           @"4G",      //1
                           @"LTE",     //2
                           /*
                           @"LTE-A",   //3
                           @"LTE+",    //4
                           */
                           @"5GE",     //5
                           @"5G",      //6
                           @"5G+",     //7
                           @"5G UWB",  //8
                       ] forKeys:logo3G.values];
                   }
else if (SYSTEM_VERSION_LESS_THAN(@"12.2"))
                {
                    logo3G.values = @[@0,@1,@2,@5];// @3,@4, broken here
                                logo3G.titleDictionary = [NSDictionary dictionaryWithObjects:@[
                                    @"Default", //0
                                    @"4G",      //1
                                    @"LTE",     //2
                                    /*
                                    @"LTE-A",   //3
                                    @"LTE+",    //4
                                    */
                                    @"5GE",     //5
                                ] forKeys:logo3G.values];
        }
        else {
            logo3G.values = @[@0,@1,@2];
            logo3G.titleDictionary = [NSDictionary dictionaryWithObjects:@[
                @"Default", //0
                @"4G",      //1
                @"LTE"      //2
            ] forKeys:logo3G.values];
        }
        [logo3G setProperty:@"kListValue" forKey:@"key"];
        [specifiers addObject:logo3G];

        [specifiers addObject:[PSSpecifier emptyGroupSpecifier]];
        PSSpecifier *logo4G = [PSSpecifier preferenceSpecifierNamed:@"4G/LTE" target:self set:@selector(setValue:forSpecifier:) get:@selector(getValueForSpecifier:) detail:NSClassFromString(@"PSListItemsController") cell:[PSTableCell cellTypeFromString:@"PSLinkListCell"] edit:nil];
        [logo4G setIdentifier:@"4G"];

        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"14.0")) {
            logo4G.values = @[@0,@1,@2,@5,@6,@7,@8]; // @3,@4, broken here
                        logo4G.titleDictionary = [NSDictionary dictionaryWithObjects:@[
                            @"Default", //0
                            @"4G",      //1
                            @"LTE",     //2
                            /*
                            @"LTE-A",   //3
                            @"LTE+",    //4
                            */
                            @"5GE",     //5
                            @"5G",      //6
                            @"5G+",     //7
                            @"5G UWB",  //8
            ] forKeys:logo4G.values];
        }
 else if (SYSTEM_VERSION_LESS_THAN(@"12.2"))
                {
                    logo4G.values = @[@0,@1,@2,@5]; // @3,@4, broken here
                                logo4G.titleDictionary = [NSDictionary dictionaryWithObjects:@[
                                    @"Default",//0
                                    @"4G",     //1
                                    @"LTE",    //2
                                    /*
                                    @"LTE-A",  //3
                                    @"LTE+",   //4
                                    */
                                    @"5GE",    //5
            ] forKeys:logo4G.values];
        }
        else {
            logo4G.values = @[@0,@1,@2,@3];
            logo4G.titleDictionary = [NSDictionary dictionaryWithObjects:@[
                              @"Default", //0
                              @"5G",      //1
                              @"5G+",     //2
                              @"5G UWB",  //3
            ] forKeys:logo4G.values];
        }
        [logo4G setProperty:@"kListValue" forKey:@"key"];
        [specifiers addObject:logo4G];

        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"14.0")) {
            [specifiers addObject:[PSSpecifier emptyGroupSpecifier]];
            PSSpecifier *logo5G = [PSSpecifier preferenceSpecifierNamed:@"5G" target:self set:@selector(setValue:forSpecifier:) get:@selector(getValueForSpecifier:) detail:NSClassFromString(@"PSListItemsController") cell:[PSTableCell cellTypeFromString:@"PSLinkListCell"] edit:nil];
            [logo5G setIdentifier:@"5G"];

            logo5G.values = @[@0,@1,@2,@3];
            logo5G.titleDictionary = [NSDictionary dictionaryWithObjects:@[
                @"Default", //0
                @"5G",      //1
                @"5G+",     //2
                @"5G UWB",  //3
            ] forKeys:logo5G.values];
            [logo5G setProperty:@"kListValue" forKey:@"key"];
            [specifiers addObject:logo5G];
        }
        PSSpecifier* footSpecifier = [PSSpecifier emptyGroupSpecifier];
                [footSpecifier setProperty:@"© 2020-2022 TuranUl" forKey:@"footerText"];
                [specifiers addObject:footSpecifier];
        PSSpecifier *respringButton = [PSSpecifier preferenceSpecifierNamed:@"Apply Changes (Respring)" target:self set:nil get:nil detail:nil cell:[PSTableCell cellTypeFromString:@"PSButtonCell"] edit:nil];
        respringButton->action = @selector(respring);
        [specifiers addObject:respringButton];

        _specifiers = [[NSMutableArray alloc] initWithArray:specifiers];
    }

    return _specifiers;
}

- (void)loadView {
    [super loadView];
    
    NSMutableDictionary* settings = [[NSMutableDictionary alloc] initWithContentsOfFile:SettingsPath];
    if(![[NSFileManager defaultManager] fileExistsAtPath:SettingsPath])
    {
        settings = [[NSMutableDictionary alloc] initWithObjectsAndKeys: @0, @"3G",
                                                                        @0, @"4G",
                                                                        @0, @"5G",
                                                                        nil];
        [settings writeToFile:SettingsPath atomically:YES];
    }
}

//=============================================================================
- (id)getValueForSpecifier:(PSSpecifier *)specifier {
    return getUserDefaultForKey(specifier.identifier);
}

- (void)setValue:(id)value forSpecifier:(PSSpecifier *)specifier {
    setUserDefaultForKey(specifier.identifier, value);
}

-(void)respring
{
    sleep(1);
    [self RunCMD:@"su root;killall -9 backboardd" WaitUntilExit:YES];
}
//=============================================================================
@end
