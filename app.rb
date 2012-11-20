require 'sinatra'

set :server, :thin
connections = []

get '/' do
  erb :index
end

get '/stream' do
  content_type :txt
  stream(:keep_open) { |out| connections << out }
end

get '/broadcast/:message' do
 connections.each { |out| out << params[:message] << "\n" }
 'Broadcasted message.'
end

__END__

@@ index
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chrome/Safari buffer text/plain stream</title>
  </head>
  <body>
    <h1>Chrome/Safari buffer text/plain stream</h1>

    <h2>Problem</h2>
    <p>When response is streamed to Chrome/Safari as <code>text/plain</code>, both of the browsers don't handle the response immediately but buffer.</p>

    <h2>How to reproduce</h2>
    <ol>
      <li>Visit <a href="/stream">/stream</a> by Chrome/Safari</li>
      <li>Request <a href="/stream">/broadcast/${some_message}</a>. <code>${some_message}</code> is something arbitrary string. It'll treaded as parameter in this app.</li>
      <li>With Firefox, the message above will appear immediately. On the other hand, with Chrome/Safari, it dosn't</li>
    </ol>
    <p>I don't know (1) it's correct behavior or not against some HTTP spec. (2) when the browsers started this behavior.</p>

    <h2>Source</h2>
    <a href="http://github.com/kentaro/chrome-and-safari-streaming-problem">http://github.com/kentaro/chrome-streaming-problem</a>
  </body>
</html>
