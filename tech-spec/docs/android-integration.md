# Android Integration

## Dependencies

Include the SPECT8-OTT Android dependency in your build file:

**Maven (pom.xml):**

    <dependency>  
        <groupId>org.vaudience</groupId>  
        <artifactId>spect8-ott-android</artifactId>  
        <version>1.0</version>  
    </dependency>  

**Gradle (build.gradle):**

    compile "org.vaudience:spect8-ott-android:1.0"

## Add overlay component

To add the overlay component to one of your activities (containing the video player) 
follow these steps:

### change layout xml
Add `<net.vaudience.spect8ott.OverlayView>` to add the OverlayView your layout.

### configure overlay in actvitiy
In the Java/Kotlin source code of your activity (most likely in your `onCreate()` method)
add the following code to bootstrap the overlay:

    // configure Overlay
    val overlayView = findViewById<OverlayView>(R.id.overlayView)
    overlayView.callbacks = object : OverlayCallbacks {
        @JavascriptInterface
        override fun getCurrentPosition(): Long {
            return videoView.currentPosition
        }
        @JavascriptInterface
        override fun fakeTouch() {
            mediaController.show(3000)
        }
        @JavascriptInterface
        getBroadcastId: function () {
            return "the-broadcast-id"; 
        }
        @JavascriptInterface
        getTenantId: function () {
            return "your-tenant-id";
        }
        @JavascriptInterface
        getUserToken: function () {
            return "some-token-from-your-infrastructure-identifying-the-user";
        }
        @JavascriptInterface
        getAppType: function () {
            return "type-of-app-that-integrates-the-overlay";
        }
    }

The code above obtains a reference to the `OverlayView` instance and
registers an instance providing several callbacks:

* <code>getCurrentPosition</code> returns the videos current time signal as a UNIX timestamp 
(using seconds, not milliseconds) defining the current time of the video stream, 
which is required for synchronizing data received from some event feed API (e.g. goal scored)
* <code>fakeTouch</code> This method is called from the overlay. The overlay consumes all touch events so that
no video controls are shown if a button etc is touched. But if an empty space is touched we want to show the
controls so we call the fakeTouch method. In this method you have to implement a way to show your video players
controls. The example above shows how the controls of a native android VideoView are shown.
* <code>getBroadcastId</code> returns the unique identifier of the video content. Assuming a CMS renders out 
a page for each streamed video, this identifier would be embedded into that page by the CMS
* <code>getTenantId</code> returns the id that identifies you as a tenant/customer (we give this to you)
* <code>getUserToken</code> returns some token/session-attribute that identifies a user. This token will
be parsed by a backend customization, which we implement as part of your tenant setup
* <code>getAppType</code> returns the type of the application which useses the overlay. A mobile app would return "APP"
