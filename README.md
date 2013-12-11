[![Build Status](https://travis-ci.org/markazevedo/changes.png)](https://travis-ci.org/markazevedo/changes) [![Code Climate](https://codeclimate.com/repos/52a7ba8956b102304200694c/badges/38a4b900e1caf58a1de8/gpa.png)](https://codeclimate.com/repos/52a7ba8956b102304200694c/feed)

## Changes

The `Changes` module allows you to inspect an object on an interval, firing a callback when the value is different than its last recorded state. Useful for observing objects that don't emit events or would be better to check at regular intervals. Examples: browser location, scroll position, etc.

```js
var Changes = require('./lib/changes');

// Function for checking if browser url has changed
var checkUrl = function() {
  return document.location.href;
};

// Executed when change is observed
var whenChanged = function(oldUrl, newUrl) {
  console.log('Url changed from '+oldUrl+' to '+newUrl);
};

// Observer object created and started
var urlObserver = new Changes(checkUrl, whenChanged);
urlObserver.start();
```