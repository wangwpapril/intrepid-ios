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
- **namesArray** is an array of `NSString`s that has names of the tabs and has to be same length as **viewArray**
