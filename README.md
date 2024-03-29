# Auth Virtual Tourist

## Introduction
This app allows you to easily authenticate from the server using Face ID or fingerprint and drop pins on anywhere on the map and let's you see photos from the Flickr API, and saves all your pins that you have placed on the map as will as thier corresponding photos.
 
## Requirements
* For installing:
    * iOS 12.1+
* For editing the code:
    * Xcode 10.1+
    * Swift 4.2+
    * MacOS system

## Installation
Go to the following repository: [Virtual-Tourist](https://github.com/omarfoz/authvt)
Then clone or download the project. If you chose to download the project extract the Zip file and open the virtual tourist.xcworkspace file inside the virtual tourist folder with xCode.


### You can build the application on your device by 
1.  Navigate to the project directory on terminal
2.  type `pod install`
3.	Open `virtual tourist.xcworkspace`
4.	Plugging in your Device to your Mac
5.	Press on the project name then sign with your apple ID
6.	Run the App 

## Content
The project follows the Model View Controller (MVC) design for separating the code and for nicer and readable code.
The classes are separated as follows

### Controller
   * `AuthViewController`: Here will you authenticate the user, first from Face ID or fingerprint after that will authenticate from the server to get the token.

   * `MapViewController`: Here is the landing page and where you can place you pin anywhere on the map where you want to see photos from that place.

   * `PhotoAlbumViewController`: When pressing on one of the pins you will be directed to this view with 9 photos from that place, with a button for pulling another 9 photos.  


### Cocoapods
   pods are libraries in swift and I used some of them in this project. Such as
   
   * `IBMMobileFirstPlatformFoundation` Mobile Foundation provides a rich set of back end capabilities for building, managing and updating your next gen cognitive, engaging, secure and personalized mobile and web applications.

   * `KingFisher` This library provides an asynchronous image downloader with cache support. This provides a place holder until the image downloads and caches the images for faster load time.
   
   
## Features

1.	**Implementing persistent data**

   I used "CoreData" to save the pins and the photos to be accessible at all times. Such as:

2.	**Implementing authentication from the server**

     I used authentication by Face ID or fingerprint to easily login.
