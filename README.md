# Mobilize

A political empowerment app that helps people to participate in local decisions.

TEMPLATE

# Instagenius Android [![Google Play](http://developer.android.com/images/brand/en_generic_rgb_wo_45.png)](https://play.google.com/store/apps/details?id=me.sgtpeppers.instagenio)

A trivia app for Android 5 (Lollipop) built by [CIn/UFPE] students [Miguel Araújo] and [Rodrigo Alves] in the 2015.1 semester for the __Programming for Android Devices__ discipline offered and lectured by [Professor Leopoldo Teixeira].

<img align="right" alt="Instagenius" src="https://dl.dropboxusercontent.com/u/7743293/Instagenius.png">

App Store description:

> Instagenius is a trivia app to make you smarter!
> On Instagenius you have fun while finding out about all kinds of things. This is the best time killer.
> Oh, BTW, it is free too! :heart_eyes: :moneybag: :+1:

This app features the following technologies:

1. Push notifications;
2. Facebook authentication (with `ParseUser` cloud integration);
3. Local SQL database operations (via SQLite);
4. Internationalization (I18n, for short);
5. Parse cloud database

###### Languages

Instagenius is available in two languages:

1. English
2. Portuguese

## Backend

Instagenius' backend infrastructure is powered by [Parse] and consists of a single data model (`Card`) which contains the app's core objects: cards of curiosities.

###### Push Notifications

Push notifications when responded are handled by a custom class, called `PushNotificationsReceiver`.

## Build

This app was developed on Android Studio, with [Gradle]. Anyone wishing to build and run this project should use that IDE as well.

###### Generating Production build

Go to the `MainApplication.java` file and change the `DEVELOPMENT_MODE` constant to `false`.

To generate the `.apk` file to be sent to the Google Play Store, go to **Build > Generate signed APK**....

Connect your device to the computer and execute the following command to run the app in production mode before submitting it to the Google Play Store:

`$ adb install ~/AndroidStudioProjects/Instagenius/app/app-release.apk`

## Authors

* Miguel Araújo <mra2@cin.ufpe.br>
* Rodrigo Alves <rav2@cin.ufpe.br>

## Copyright

&copy; 2015 Miguel Araújo & Rodrigo Alves. All Rights Reserved.

[Gradle]: https://gradle.org
[Parse]: https://parse.com
[CIn/UFPE]: http://www2.cin.ufpe.br/site/index.php
[Miguel Araújo]: https://github.com/miguelarauj1o
[Rodrigo Alves]: https://github.com/rodrigoalvesvieira
[Professor Leopoldo Teixeira]: https://github.com/leopoldomt