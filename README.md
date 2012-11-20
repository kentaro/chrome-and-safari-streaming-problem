# Chrome/Safari buffer text/plain stream

## Problem

When response is streamed to Chrome/Safari as `text/plain`, both of the browsers don't handle the response immediately but buffer.

## How to reproduce

  1. Visit http://polar-badlands-7200.herokuapp.com/ by Chrome/Safari
  2. Dispatch GET request to http://polar-badlands-7200.herokuapp.com/broadcast/${some_message}. `${some_message}` is something arbitrary string. It'll be treaded as parameter in this app.
  3. With Firefox, the message above will appear immediately. On the other hand, with Chrome/Safari, it dosn't

I don't know (1) it's correct behavior or not against some HTTP spec. (2) when the browsers started this behavior.
