# WeatherApp

<b>How to build</b>
<p>This search is available through CocoaPods. To install it, simply add the following line to your Podfile:</p>
<pre>
download or clone the repo.
$ sudo gem install cocoapods
$ pod install
</pre>

<h1></h1>

<b>Overview</b>
<pre>
Swift 4.1
Xcode 10.0
</pre>

<h1></h1>

<b>Libraries used</b>
<pre>
ReSwift
R.swift
Moya
SwiftyJSON
SwiftLint
Firebase/Core
Firebase/Database
UIColor_Hex_Swift
Changeable
Kingfisher
DeepLinkKit
PullToRefreshKit
</pre>

<b>Test used</b>
<pre>
Quick
Nimble
SwiftHamcrest
</pre>

<h1></h1>

<b>Instructions</b>

used forecast endpoint for search with (firebase)
used weather endpoint for search with (firebase)

apikey and api path is defiened in Config/DEBUG.plist

<b>Hierarchy</b>

<pre>
[WeatherTest]/[Resources]
[WeatherTest]/[Resources]/[Assets.scassets]
[WeatherTest]/[Resources]/[Fonts]
[WeatherTest]/[Route]
[WeatherTest]/[Redux]
[WeatherTest]/[Redux]/[Actor]
[WeatherTest]/[Redux]/[Action]
[WeatherTest]/[Redux]/[Reducer]
[WeatherTest]/[Redux]/[State]
[WeatherTest]/[Utils]
[WeatherTest]/[Service]
[WeatherTest]/[Config]
[WeatherTest]/[Config]/[DEBUG.plist]
[WeatherTest]/[Config]/[RELEASE.plist]
[WeatherTest]/[Config]/[STAGING.plist]
[WeatherTest]/[Controller]
[WeatherTest]/[Views]
[WeatherTest]/[Views]/[MainTab.storyboard]
[WeatherTest]/[Views]/[Today.storyboard]
[WeatherTest]/[Views]/[Forecast.storyboard]
</pre>

<img src="https://raw.githubusercontent.com/serdarbakirtas/WeatherApp/master/Screenshots/01.png" alt="HTML5 Icon" width="276" height="598"> <img src="https://raw.githubusercontent.com/serdarbakirtas/WeatherApp/master/Screenshots/02.png" alt="HTML5 Icon" width="276" height="598"> <img src="https://raw.githubusercontent.com/serdarbakirtas/WeatherApp/master/Screenshots/03.png" alt="HTML5 Icon" width="276" height="598">
