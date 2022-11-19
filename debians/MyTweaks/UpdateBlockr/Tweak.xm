#include <Preferences/PSSpecifier.h>
#include <Preferences/PSListController.h>

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface PSGGeneralController : PSListController
@end

@interface PSUIGeneralController : PSListController
@end

%group iOS13
	%hook PSGGeneralController
	-(void)viewWillAppear:(BOOL)arg1 
{
		%orig;
		[self removeSpecifierID:@"SOFTWARE_UPDATE_LINK" animated:NO];
}

	%end
%end

%group iOS12
	%hook PSUIGeneralController
	-(void)viewDidAppear:(BOOL)arg1 
{
		%orig;
		[self removeSpecifierID:@"SOFTWARE_UPDATE_LINK" animated:NO];
}

	%end
%end

%ctor 
{
	if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"13.0")) {
		%init(iOS13);
	} else {
		%init(iOS12);
	}
}
