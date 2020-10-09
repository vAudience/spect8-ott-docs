# General Information

This manual describes how to add the SPECT8 Chat module and the SPECT8 OTT Overlay to your video player.

<!-- You can jump directly to [Web Integration](web-integration.md) or [Android Integration](android-integration.md). -->

You can jump directly to [Chat Web Integration](chat-web-integration).

Note that a one-time [Tenant setup](tenant-setup.md) is required for any of our customers.

## Assumptions

Integration information given on these pages assumes the following:

- You have a access to a video stream for your event, which provides a reliable
  source of time signals that define the current video frame's event time

## Terminology

- A **broadcast** is some video content for any type of event, e.g. a tennis match or a casting show,
  for which a video stream is available somewhere (most likely some CDN). Every broadcast must have a
  unique id.
- The **overlay** is our OTT overlay solution, which is placed as a layer on top of the video player
  embedded in your app or web page.
- The **chat** module is embedded as iFrame in your app or web page.
