# Intrepid: Phase II

### ScrollerTabViewController
- superclass of `Health`, `Overview` & `Security` ViewControllers
- setup using two methods:
```objective-c
    [self addViews:viewsArray withVerticalOffset:offset];
    [self addTabs:namesArray];
```
where 
- **viewArray** is an array of `UIView`
- **offset** is an `NSInteger` that represents how many units from the top of the screen the views are added
- **namesArray** is an array of `NSString` that has names of the tabs and has to be same length as **viewArray**

___

[potential alternative to `CoreData`: SBJson](http://stackoverflow.com/a/5238998)
[persistent storage analysis for iOS](http://stackoverflow.com/a/5249674)
