date: 2013-11-29
title: Sinatra and This Blog


<p><code>gem install sinatra</code></p>

<p>Sinatra, our introduction to web development using Ruby, is this week's project. I have written this web application (the one you're looking at)
in Sinatra. I also did my own HTML and CSS. Oh, and my <a href="/ask">Captcha</a>.</p>
<p><code>gem install sinatra-captcha</code></p>
<p>This was a challenge. The random Captcha image is received
from captchator.com/image/YourSessionID. When you type in the code you see, my Captcha Ruby class gets instantiated with the params sent in response to
 the post request. That code is sent to captchator.com with the token (your session id) and that will return a 0 or 1. The rest is turtles all the way down.</p>
<p>Try using that Ask page. If your Captcha code is wrong, it won't post your question. Otherwise, it will and I'll answer them in my blog posts.</p>