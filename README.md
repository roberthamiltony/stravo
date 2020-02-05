# stravo
The intention for the app is to display Strava activity data. Hopefully in future, this will include weather information as well.

# running
To build the project, you will need Xcode 11.3 as the app is targeting iOS 13.2.

Firstly, run `carthage update` to build the .framework files. After this is complete, add the new .framework files to the "Frameworks, Libraries and Embedded Content" tab on the Target's "General" tab in Xcode.

To run the project, you will need a Strava ID and OAuth secret - follow the steps (here)[https://developers.strava.com/docs/getting-started/] to setup the account. You'll need to create (if you haven't already) a Strava Account and a Strava App, both of which are free. Once you have these, add the ID and secret to `release.xcconfig`.

# dependencies
## OAuthSwift
OAuthSwift is used to handle authentication with the Strava API.
https://github.com/OAuthSwift/OAuthSwift
## PanModal
PanModal is used to provide the UI for the bottom sheet view used for the Activity Detailer.
https://github.com/slackhq/PanModal
## SnapKit
SnapKit is used to define the UI and is preferred over Storyboards.
https://github.com/SnapKit/SnapKit
