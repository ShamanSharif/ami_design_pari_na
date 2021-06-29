<img src="./assets/images/logo.png" alt="Ami Design Pari Na Logo" width="200"/>

# Ami Design Pari Na

A Flutter Application For [Evident BD](https://www.evidentbd.com/)

[Download This Application](https://1drv.ms/u/s!Al--ARnUlMOkdSMdYRn9TavHVqA?e=tI1zMC)

## Sections

this application has 3 sections

1. [Authentication](#authentication)
    * [Sign In](#sign-in)
    * [Sign Up](#sign-up)
2. [Khoj The Search](#khoj-the-search)
3. [Dekhao Chobi](#dekhao-chobi)

also this application have two other pages

* Splash Screen
* Settings & Info Screen


### Authentication

Authentication on this application is handled with Firebase Authentication. I've used a simple Email
and Password Authentication to keep it simple. This authentication system is handled with FirebaseAuth package (see [Packages & Plugins](#packages--plugins)).

There is two section for this authentication process namely [Sign In](#sign-in) and [Sign Up](#sign-up).
After completing the log in or signing up process successfully, the user will be navigated to
[Khoj The Search](#khoj-the-search) Screen. Any error on this authentication process will be shown
to the user with the help of Cool Alert package (see [Packages & Plugins](#packages--plugins)).

#### Sign In

On the Sign In Screen, there is two input fields with two buttons and a logo.

On the __first__ input field, user will enter the email address. For visual feedback, the leading logo
of the input field will be colored on focus and will get desaturated upon unfocused.

On the __second__ input field, user will enter the password. For safety, the user won't see the typed password.
A small dot will appear on the place of the password.
But if the user wants to see what he/she typed, clicking on the trailing _eye-off_ button will reveal the password
he/she typed. If the user wants to hide the password again, he/she can press the _eye_ button, which will appear on the
place of previous button to hide the password again.  
For visual feedback, the leading logo
of the input field will be colored on focus and will get desaturated upon unfocused.

The __LOG IN__ button will take the input given by the user and with the help of FirebaseAuth package (see [Packages & Plugins](#packages--plugins))
will try to authenticate the user.
If it is successful, the user will be navigated to [Khoj The Search](#khoj-the-search) Screen. Or get a __Error Alert__
with the help of Cool Alert package (see [Packages & Plugins](#packages--plugins)) otherwise.

Lastly, there is a _Text Button_ named __Don't have an account?__ in the end. By clicking on that button the user will get
navigated to the [Sign Up](#sign-up) Screen.

#### Sign Up

On the Sign Up Screen, there is again the logo, two buttons and three text fields.

On the __first__ input field user will input his/her name. For visual feedback, the leading logo
of the input field will be colored on focus and will get desaturated upon unfocused.

On the __second__ input field, user will enter the email address. For visual feedback, the leading logo
of the input field will be colored on focus and will get desaturated upon unfocused.

On the __third__ input field, user will enter the password. For safety, the user won't see the typed password.
A small dot will appear on the place of the password.
But if the user wants to see what he/she typed, clicking on the trailing _eye-off_ button will reveal the password
he/she typed. If the user wants to hide the password again, he/she can press the _eye_ button, which will appear on the
place of previous button to hide the password again.  
For visual feedback, the leading logo
of the input field will be colored on focus and will get desaturated upon unfocused.

The __SIGN UP__ button will take the input given by the user and with the help of FirebaseAuth package (see [Packages & Plugins](#packages--plugins))
will try to authenticate the user.
If it is successful, the user will be navigated to [Khoj The Search](#khoj-the-search) Screen. Or get a __Error Alert__
with the help of Cool Alert package (see [Packages & Plugins](#packages--plugins)) otherwise.

Lastly, there is a _Icon Button_ with the icon "__?__". By clicking on that button the user will get a 
helpful pop up guide to fill the __Sign Up__ form.

### Khoj The Search

After a successful authentication, user will get navigated to this Screen where they will find a picture 
of a sleeping panda with two input field and a button named __KHOJ__.  

After pressing the __KHOJ__ button, this Screen will get Input data and Search data from the user, and Try to find the search data within the input data.  
If it is able to find the search data within the input data, it will show __True__ with a happy panda or it will show __False__
with a sad panda otherwise. 

Also, __behind the scene__, this screen will take the input data with current user id and a timestamp of clicking __KHOJ__ button
and store them locally with the help of Sqflite package (see [Packages & Plugins](#packages--plugins)) after clicking the __KHOJ__ button.

Any error on this screen will be shown as a __Error Alert__ with the help of Cool Alert package (see [Packages & Plugins](#packages--plugins)) otherwise.

There is also a __icon button__ on the app bar to navigate user to the settings screen, 
where the user can test out the db functionality and also __log out__ from the application. And a bottom navigation bar to navigate 
between this page and [Dekhao Chobi](#dekhao-chobi) screen.

### Dekhao Chobi

This Screen will show the thumbnail of first 100 pictures from [this url](https://jsonplaceholder.typicode.com/photos) and 
show them is a 3 column grid with the help of Photo View package (see [Packages & Plugins](#packages--plugins)). 

on __tapping__ any of the thumbnail, user will get the full screen view of that image, where they can swipe left or right to change
the images just like an image gallery. 

on __long tapping__ on any thumbnail, user will get a popup with the image title, image id and album id.

like [Khoj The Search](#khoj-the-search) section, there is also a __icon button__ on the app bar to navigate user to the settings screen, 
where the user can test out the db functionality and also __log out__ from the application. And a bottom navigation bar to navigate 
between this page and [Khoj The Search](#khoj-the-search) screen.

## Packages & Plugins

Packages and Plugins used in this project:

- [Feather Icons](https://pub.dev/packages/feather_icons) for iconography
- [Animated Splash Screen](https://pub.dev/packages/animated_splash_screen) for splash screen
- [Firebase Core](https://pub.dev/packages/firebase_core) requirement for firebase authentication
- [Firebase Auth](https://pub.dev/packages/firebase_auth) for authentication
- [HTTP](https://pub.dev/packages/http) for online connectivity
- [Flutter Secure Storage](https://pub.dev/packages/flutter_secure_storage) for storing authentication data locally
- [Cool Alert](https://pub.dev/packages/cool_alert) for showing animated popup alert to user
- [Modal Progress HUD](https://pub.dev/packages/modal_progress_hud) for showing a loading animation
- [SQFLite](https://pub.dev/packages/sqflite) for local database
- [Cached Network Image](https://pub.dev/packages/cached_network_image) for caching network images
- [Photo View](https://pub.dev/packages/photo_view) for viewing photos in a more natural way
