#MacGap

The MacGap project aims to provide HTML/JS/CSS developers an Xcode project for developing Native OSX Apps that run in OSX's WebView and take advantage of WebKit technologies. The project also exposes a basic JavaScript API for OS integration, such as display Growl notifications. The MacGap project is extremely lightweight and nimble, a blank application is about 0.3mb. 
 
##Pre-requisites

MacGap works on OSX 10.6 and 10.5.

Generate apps with the [macgap generator](http://github.com/maccman/macgap-rb), no compile necessary.

    gem install macgap    
    macgap --name MyApp ./public

##API

MacGap exposes an object called `macgap` inside JavaScript. You can use it to alter the Dock icon and display Growl notifications, amongst other things. The API is documented below:

App:

    // Quit application
    macgap.app.terminate();

    // Activate application (bring to front)
    macgap.app.activate();
    
    // Hide application
    macgap.app.hide();
    
    // Un-hide application
    macgap.app.unhide();

    // System bell
    macgap.app.beep();
    
    // Open URL in default browser
    macgap.app.open("http://google.com");
    
    // Launch application
    macgap.app.launch("TextEdit");
    
Window:

    // Open a new window
    macgap.window.open({url:"public/index2.html", width: 400, height: 300});

    // Resize window
    macgap.window.resize({width: 400, height: 200});

    // Move window (Bottom left is x:0 and y:0)
    macgap.window.move({x:0, y: 200});

File:

    // After a user has selected files from a either `<input type='file'>`, or with drag and drop,
    // their absolute paths can be obtained with
    macgap.file.files();

    //The following two methods will start reading the contents of a file. On successful completion the 'onload' event will be triggered. That event object will contain the data from the file (event.results).

    // Results in String (add  event listener to 'onload' to get results)
    macgap.file.readAsText('/path/to/file');

    // Results in Base64 String (add  event listener to 'onload' to get results)
    macgap.file.readAsDataURL('/path/to/file');

    //Available events: onerror, onload, onloadend, onloadstart
    //Example:

    var fileContent = function(evt){
        $("img").src = evt.result;
    };

    document.addEventListener('onload', fileContent, true);
    macgap.file.readAsDataURL('/path/to/imag.png');
    
Path:
   
    // Path to application
    macgap.path.application;
    
    // Path to application's resources
    macgap.path.resource;
    
Dock:

    // Set the Dock's badge
    macgap.dock.badge = "10";
    
Sound:

    // Play a sound
    macgap.sound.play("./my/sound.mp3")
    
    // Play a system sound
    macgap.sound.playSystem("funk");
    
Growl:

    // Send a Growl notification
    macgap.growl.notify({
      title: "Notify",
      content: "New Message!"
    });

Events:

    //Mac OS X on wake event.
    document.addEventListener('wake', function(){console.log('Wake!!')}, true);
      
    //Mac OS X on sleep event.
    document.addEventListener('sleep', function(){console.log('Sleep!!')}, true);
    
##Offline Patterns

Desktop apps load immediately and work offline, whilst web apps have the advantage of being easily updated and remotely managed. MacGap gives you the best of both worlds via HTML5's offline APIs. 

First you can define a refresh tag in `index.html`, which will immediately forward your WebView to a given address.

    <meta http-equiv="refresh" content="0;url=http://example.com">

Then use [HTML5 offline APIs](http://www.w3.org/TR/html5/offline.html) to cache your application locally. The first time your application launches, it'll download all the remote resources for use offline. Then during subsequent launches the locally cached resources will be used, and the application will fully function offline. If your remote application changes, then the cache manifest will be updated and application re-cached.

##Attributes

MacGap was forked/ported from Phonegap-mac. It's under the same license (MIT).

##Custom Build

To build, make sure you have installed the latest Mac OSX Core Library. Download at [http://developer.apple.com/](http://developer.apple.com/).

Just clone the repository and build in Xcode. The file `public/index.html` is loaded on startup.