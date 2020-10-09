# Chat Web Integration

This guide assumes that there is some kind of HTML page rendered by your infrastructure, for which you want to embed our Chat module.

## Add iFrame

Add the following `<iFrame>` block to your HTML page:

```html
<iframe
  id="spect8Chat"
  src="https://static.ott.spect8.com/chat/{tenantId}/index.html"
  frameborder="0"
  width="100%"
  height="100%"
></iframe>
```

## Initialize Chat module

To initialize the chat module you need to send an init message with the following information:

- `appType: "WEB"` (required)
- `broadcastId` (required), a unique identifier of the video content, to which the chat should belong
- `tenantId` (required), a unique identifier of the tenant, which is generated in the tenanat setup

### Example

```javascript
document.getElementById("spect8Chat").contentWindow.postMessage(
  JSON.stringify({
    type: "init",
    payload: {
      appType: "WEB",
      broadcastId: "broadcast-123",
      tenantId: "tenant-123",
    },
  }),
  "https://static.ott.spect8.com"
);
```

## Set User data

To "authenticate" a logged in (on your HTML page) user you need to send a user message with the following information:

- `userId` (required), a unique identifer of your user
- `username` (required), a username that is displayed in front of the chat message
- `profileImageSrc` (optional), an URL pointing to the users profile image

### Example

```javascript
document.getElementById("spect8Chat").contentWindow.postMessage(
  JSON.stringify({
    type: "user",
    payload: {
      userId: "user-123",
      username: "test user",
    },
  }),
  "https://static.ott.spect8.com"
);
```

## Receive Event data from chat module

The chat module sends app and tracking event messages to the parent HTML page via `postMessage`.

Listening to messages from the iFrame in the parent window:

```javascript
window.addEventListener("message", (ev) => {
  if (ev.origin == "http://localhost:4200") {
    // var message = JSON.parse(ev.data);
  }
});
```

Message format:

```typescript
{
  type: "appEvent" | "trackingEvent",
  payload: {
    category: String, // optional
    action: String, // optional
    label: String, // optional
    value: Number, // optional
  }
}
```

### Example Message: Anonymous user tries to send a message

```javascript
{
  type: "appEvent",
  payload: {
    category: "anonymousUser",
    action: "send",
    label: "chat",
  }
}
```
