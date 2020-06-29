# Web Integration

This guide assumes that there is some kind of HTML page rendered by your OTT infrastructure, which 
includes a video player for which you want to enable our OTT overlay.


## Include dependencies

Add the following `<script>` block to the end of your HTML page to include our overlay code:

```html
<script src=https://vaudience.github.io/spect8-ott-frontend/js/chunk-vendors-0.1.0.js></script>
<script src=https://vaudience.github.io/spect8-ott-frontend/js/app-0.1.0.js></script>
```

## Add overlay div

Your HTML page must contain a `<div>` element with id "app", which will be the DOM-root for the overlay contents:

```html
<div id="app"></div>
```

It is usually added as a subsequent sibling of the video element and styled having the same position and 
size, such as:

```html
<div id="video-container">
    <video></video>
    <div id="app"></div>
</div>
```

## Implement a configuration callback wrapper

Our overlay code requires a global `wrapper` variable to exist. This wrapper contains a few callback
functions, which must be implemented to provide the required configuration and runtime data to
the overlay:

```javascript
const wrapper = {
  vid: document.getElementById("video"),

  getVideo: function () {
    return wrapper.vid;
  },
  getCurrentPosition: function () {
    return (wrapper.vid.currentTime * 1000);
  },
  getBroadcastId: function () {
    return "the-broadcast-id"; 
  },
  getTenantId: function () {
    return "your-tenant-id";
  },
  getUserToken: function () {
    return "some-token-from-your-infrastructure-identifying-the-user";
  },
  getAppType: function () {
    return "type-of-app-that-integrates-the-overlay";
  }
};
window.wrapper = wrapper;
```

Here are details about each callback:

* <code>getVideo</code> returns the video player element, which is required for the video capturing feature
* <code>getCurrentPosition</code> returns the videos current time signal as a UNIX timestamp 
(using seconds, not milliseconds) defining the current time of the video stream, 
which is required for synchronizing data received from some event feed API (e.g. goal scored)
* <code>getBroadcastId</code> returns the unique identifier of the video content. Assuming a CMS renders out 
a page for each streamed video, this identifier would be embedded into that page by the CMS
* <code>getTenantId</code> returns the id that identifies you as a tenant/customer (we give this to you)
* <code>getUserToken</code> returns some token/session-attribute that identifies a user. This token will
be parsed by a backend customization, which we implement as part of your tenant setup
* <code>getAppType</code> returns the type of the application which useses the overlay. A website would return "WEB"