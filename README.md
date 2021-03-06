# Project 3 - *Yelp*

**Yelp** is a Yelp search app using the [Yelp API](http://www.yelp.com/developers/documentation/v2/search_api).

Time spent: **8** hours spent in total

## User Stories

The following **required** functionality is completed:

- [√] Table rows for search results should be dynamic height according to the content height.
- [√] Custom cells should have the proper Auto Layout constraints.
- [√] Search bar should be in the navigation bar (doesn't have to expand to show location like the real Yelp app does).

The following **optional** features are implemented:

- [√] Search results page
- [√] Infinite scroll for restaurant results.
- [√] Implement map view of restaurant results.
- [√] Implement the restaurant detail page.

The following **additional** features are implemented:

- [√] App will remember last search result and launches with that result even after you close it.
- [√] Added loading wheel
- [√] Added scroll view in detail page of map view, and correct autolayout constraints
- [√] Added app icon



Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Implementing custom annotations
2. Autolayout when you have both landscape and portrait

## Video Walkthrough 

Here's a walkthrough of implemented user stories in portrait:

<img src='https://cloud.githubusercontent.com/assets/14018274/23108082/999338c2-f6d5-11e6-87da-9fc83dd8c07c.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

Here's a walkthrough of implemented user stories in landscape:

<img src='https://cloud.githubusercontent.com/assets/14018274/23108076/8a4d3e80-f6d5-11e6-855a-55ebb874e16e.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.

## License

Copyright [2017] [Aarnav Ram]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

### Basic Yelp client

This is a headless example of how to implement an OAuth 1.0a Yelp API client. The Yelp API provides an application token that allows applications to make unauthenticated requests to their search API.

### Next steps

- Check out `BusinessesViewController.swift` to see how to use the `Business` model.

### Sample request

**Basic search with query**

```
Business.searchWithTerm("Thai", completion: { (businesses: [Business]!, error: NSError!) -> Void in
    self.businesses = businesses
    
    for business in businesses {
        print(business.name!)
        print(business.address!)
    }
})
```

**Advanced search with categories, sort, and deal filters**

```
Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in

    for business in businesses {
        print(business.name!)
        print(business.address!)
    }
}
```
