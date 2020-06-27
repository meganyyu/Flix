# Project 2 - Flix

Flix is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: **19** hours spent in total

## User Stories

The following **required** functionality is complete:

- [x] User sees an app icon on the home screen and a styled launch screen.
- [x] User can view a list of movies currently playing in theaters from The Movie Database.
- [x] Poster images are loaded using the UIImageView category in the AFNetworking library.
- [x] User sees a loading state while waiting for the movies API.
- [x] User can pull to refresh the movie list.
- [x] User sees an error message when there's a networking error.
- [x] User can tap a tab bar button to view a grid layout of Movie Posters using a CollectionView.

The following **optional** features are implemented:

- [x] User can tap a poster in the collection view to see a detail screen of that movie
- [x] User can search for a movie.
- [x] All images fade in as they are loading.
- [x] User can view the large movie poster by tapping on a cell.
- [x] For the large poster, load the low resolution image first and then switch to the high resolution image when complete.
- [x] While poster is being fetched or if poster fails to load, user sees a placeholder image
- [x] Customize the selection effect of the cell.
- [x] Customize the navigation bar.
- [x] Customize the UI.

The following **additional** features are implemented:

- [ ] Show recommended movies in details screen based on what movie is selected
- [x] Show ratings in details screen
- [ ] Add functionality to see reviews
- [x] Customize details page with play button for trailer
- [x] Change images to rounded corners with shadows

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Understanding how to do work in main thread vs. background thread (async operations)
2.

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='http://g.recordit.co/arWbOPrKwQ.gif' title='TableView & CollectionView' width='' alt='TableView & CollectionView' /> &nbsp; <img src='http://g.recordit.co/70gnFeApNs.gif' title='Detail View' width='' alt='Detail View' /> &nbsp; <img src='http://g.recordit.co/70gnFeApNs.gif' title='Views' width='' alt='Views' />

GIF created with [Recordit](https://recordit.co/).

## Notes

Describe any challenges encountered while building the app.
- Current roadblock: I was not able to get UIActivityIndicatorView to appear - I'm not sure if it's that it doesn't load at all, or if it just doesn't appear for long enough compared to the process of fetching movie data. As an alternative, I was able to get MBProgressHUD to appear as a loading screen, but only by manually setting a delay. This is only really a temporary fix, so I plan to come back to this feature at a later time.

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library
- [MBProgressHUD](https://github.com/matej/MBProgressHUD) - an iOS activity indicator view

## License

    Copyright 2020 Megan Yu

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
