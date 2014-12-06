# Intrepid: Phase II


### RequestBuilder
**static class thatbuilds request to retrieve JSON data from the server**
- should handle all network requests & parse JSON data
- should communicate with `TripManager` that converts JSON to CoreData

___

### ScrollerTabViewController
**UIViewController child class that allows scrolling, swiping or clicking tabs to switch between pages**
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
