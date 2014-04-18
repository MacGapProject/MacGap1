#MacGap

The MacGap project aims to provide HTML/JS/CSS developers an Xcode project for developing Native OSX Apps that run in OSX's WebView and take advantage of WebKit technologies. The project also exposes a basic JavaScript API for OS integration, such as display Growl notifications. The MacGap project is extremely lightweight and nimble, a blank application is about 0.3mb.

##Pre-requisites

MacGap works on OSX 10.6 and 10.5.

Generate apps with the [macgap generator](http://github.com/maccman/macgap-rb), no compile necessary.

    gem install macgap

    macgap new myapp
    macgap build myapp

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

    // Bounce Dock icon of applications
    macgap.app.bounce();

    // Open URL in default browser
    macgap.app.open("http://google.com");

    // Launch application
    macgap.app.launch("TextEdit");

	// Set a custom user agent string
	macgap.app.setCustomUserAgent('new user agent string');
	
	// Get the system idle time. This example outputs the idle time to the console once per second.
	window.setInterval(function(){
		console.log( macgap.app.systemIdleTime() );
    }, 1000);

	
Clipboard:

    // copy text to clipboard
    macgap.clipboard.copy('this text will be copied to the clipboard');

    // returns the contents of the clipboard
    var clipboardContents = macgap.clipboard.paste();

Window:

    // Open a new window
    macgap.window.open({url:"public/index2.html", width: 400, height: 300});

    // Resize window
    macgap.window.resize({width: 400, height: 200});

	// Get the window coordinates
	macgap.window.getX();
	macgap.window.getY();

    // Move window (Bottom left is x:0 and y:0)
    macgap.window.move({x:0, y: 200});

    // Toggle fullscreen mode
    macgap.window.toggleFullscreen();

    // Maximize the window
    macgap.window.maximize();

    // Minimize the window
    macgap.window.minimize();

    // Return true if the window is currently maximized and false if it is not
    var isWindowMaximized = macgap.window.isMaximized();

Path:

    // Path to application
    macgap.path.application;

    // Path to application's resources
    macgap.path.resource;
    
    // Path to the current user's documents directory.
    macgap.path.documents;

    // Path to the application's home directory. This is the application’s sandbox directory or the current user’s home directory (if the application is not in a sandbox).
    macgap.path.home;
    
    // Path to the App's temp directory.
    macgap.path.temp;

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

Notice:

    // Send a Native User notification
    macgap.notice.notify({
      title: "Notify",
      content: "New Message!"
    });
    
Fonts:

    // Return an array of installed font names
    macgap.fonts.availableFonts();
    
    // Return an array of installed font families
    macgap.fonts.availableFontFamilies();

	// Return the fonts in the given font family.
    macgap.fonts.availableMembersOfFontFamily('Helvetica');

Events:

    // Mac OS X on wake event.
    document.addEventListener('wake', function(){console.log('Wake!!')}, true);

    // Mac OS X on sleep event.
    document.addEventListener('sleep', function(){console.log('Sleep!!')}, true);
    
    // Mac OS X app was activated.
    document.addEventListener('appActivated', function(e {
        console.log(e.data);
        var appName = e.data.localizedName;
        var bundleURL = e.data.bundleURL;
    }, true);
    
Menus:

    // Add a menu item.
    macgap.menu.getItem("File").submenu().addItem("Foo", "cmd+opt+g", function() { alert("Foo!"); })
    
    // Menu item keyboard commands can include any of the following modifiers: caps, shift, cmd, ctrl, opt, alt

    // Add a menu item separator.
	macgap.menu.getItem("File").submenu().addSeparator();

    // Remove a menu item or an entire menu.
    macgap.menu.getItem("File").remove(); // Remove the file menu
    macgap.menu.getItem("File").submenu().getItem("Foo").remove(); // Remove the file menu's "foo" item

	// Remove a menu item.
	macgap.menu.getItem("File").submenu().getItem("Close").remove();
	
	// Change the callback for a menu item.
	macgap.menu.getItem("File").submenu().getItem("Foo").setCallback(function(){alert('Foo new');});

	// Change the key command for a menu item.
	macgap.menu.getItem("File").submenu().getItem("Foo").setKey('cmd-opt-ctrl-g');

	// Change the title of a menu item.
	macgap.menu.getItem("File").submenu().getItem("Foo").setTitle('Foonew');

	// Add a new submenu for a menu item.
	macgap.menu.getItem("File").submenu().getItem('Foo').addSubmenu().addItem("Foofoo", "cmd+opt+h", function() { alert("Foofoo!"); })

User Defaults:

    // Get all user defaults. Returns a JSON string.
    macgap.userDefaults.getUserDefaults();
    
    // example usage:
    
    var defaults = JSON.parse( macgap.userDefaults.getUserDefaults() );

    // Set the user default at the specified key. Objective-C is strongly typed, unlike JavaScript. For security, keys are automatically preceded with 'macgap.'. If this is omitted it will be added automatically. Thus the following two statements are functionally identical.
    
    macgap.userDefaults.setString('macgap.mykey', 'mystring');
    macgap.userDefaults.setString('mykey', 'mystring');

    macgap.userDefaults.setInteger('macgap.mykey', 5);
    macgap.userDefaults.setBool('macgap.mykey', 1);
    macgap.userDefaults.setFloat('macgap.mykey', 12.345678);

	// Get the user default for the specified key. Objective-C is strongly typed, unlike JavaScript.
	macgap.userDefaults.getString('macgap.mykey');
	macgap.userDefaults.getInteger('macgap.mykey');
	macgap.userDefaults.getBool('macgap.mykey');
	macgap.userDefaults.getFloat('macgap.mykey');
	
	// Remove the user default for the specified key.
	macgap.userDefaults.removeObjectForKey('macgap.mykey');

	// Be notified when the user defaults are changed. To see what was changed, store a local snapshot of the object and compare to it.
	document.addEventListener('userDefaultsChanged', function(e) {
		console.log(e.data);
    }, true);

User defaults added by JavaScript will be automatically namespaced by prefixing `macgap.`. This ensures it is not possible for JavaScript to modify or delete User Defaults which it did not create, as a security measure.

The User Defaults provide a large amount of interesting data that is now available to your JavaScript app.

It can also be used to implement an easy channel for communication between JavaScript and objects placed into the app using Interface Builder in Xcode eg Toolbars, buttons, preference windows. These can be bound directly to the User Defaults in Interface Builder, without writing any Objective-C code.

##Offline Patterns

Desktop apps load immediately and work offline, whilst web apps have the advantage of being easily updated and remotely managed. MacGap gives you the best of both worlds via HTML5's offline APIs.

First you can define a refresh tag in `index.html`, which will immediately forward your WebView to a given address.

    <meta http-equiv="refresh" content="0;url=http://example.com">

Then use [HTML5 offline APIs](http://www.w3.org/TR/offline-webapps/) to cache your application locally. The first time your application launches, it'll download all the remote resources for use offline. Then during subsequent launches the locally cached resources will be used, and the application will fully function offline. If your remote application changes, then the cache manifest will be updated and application re-cached.

##Attributes

MacGap was forked/ported from Phonegap-mac. It's under the same license (MIT).

##Custom Build

To build, make sure you have installed the latest Mac OSX Core Library. Download at [http://developer.apple.com/](http://developer.apple.com/).

Just clone the repository and build in Xcode. The file `public/index.html` is loaded on startup.
