#Callback-Mac

The callback-mac project aims to provide HTML/JS/CSS developers an Xcode project for developing Native OSX Apps that run in OSX's WebView and take advantage of WebKit technologies. The project also exposes a basic JavaScript API for OS integration, such as display Growl notifications. The callback-mac project is extremely lightweight and nimble, a blank application is about 0.3mb. 
 
##Pre-requisites

Make sure you have installed the latest Mac OSX Core Library. Download at [http://developer.apple.com/](http://developer.apple.com/)

##Usage

Just clone the repository and build in Xcode. The root file `index.html` is loaded on startup.

##API

callback-mac exposes an object called `callback` inside JavaScript. You can use it to alter the Dock icon and display Growl notifications, amongst other things. The API is documented below:

    // Quit application
    callback.app.terminate();

    // Activate application (bring to front)
    callback.app.activate();
    
    // Hide application
    callback.app.hide();
    
    // Un-hide application
    callback.app.unhide();
    
    // System bell
    callback.app.beep();

    // Path to application
    callback.path.application;
    
    // Path to application's resources
    callback.path.resource;

    // Set the Dock's badge
    callback.dock.badge = "10";

    // Play a sound
    callback.sound.play("./my/sound.mp3")
    
    // Play a system sound
    callback.sound.playSystem("funk");

    // Send a Growl notification
    callback.growl.notify({
      title: "Notify",
      content: "New Message!"
    });
    
##Offline Patterns

Desktop apps load immediately and work offline, whilst web apps have the advantage of being easily updated and remotely managed. Using HTML5's offline APIs, callback-mac gives you the best of both worlds. 

First you can define a refresh tag in `index.html`, which will immediately forward your WebView to a given address.

    <meta http-equiv="refresh" content="0;url=http://example.com">

Then use [HTML5 offline APIs](http://www.w3.org/TR/html5/offline.html) to cache your application locally. The first time your application launches, it'll download all the remote resources for use offline. Then subsequent launches the locally cached resources will be used, and the application will fully function offline. If your remote application changes, then the cache manifest will be updated and application re-cached.