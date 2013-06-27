From: Matthew Khouzam <matthew.khouzam@ericsson.com>
Subject: Re: New LTTNG user
Date: Thu, 27 Jun 2013 12:18:37 -0400
Message-ID: <51CC65DD.8040804__2115.01261587745$1372349984$gmane$org@ericsson.com>
References: <CAPxN80A4-Fa3hhA8+zmmckhwRrp0qb2+xXcebw8tmB1QXGULzw@mail.gmail.com>
	<CAPxN80BrtX4Y7RT-O9FUc72TWj-9Oh7MtzbteoRNaMqwgEZB1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1528690914=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg20.ericsson.net ([198.24.6.45])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <matthew.khouzam@ericsson.com>) id 1UsEuT-0002px-Do
	for lttng-dev@lists.lttng.org; Thu, 27 Jun 2013 12:19:01 -0400
In-Reply-To: <CAPxN80BrtX4Y7RT-O9FUc72TWj-9Oh7MtzbteoRNaMqwgEZB1Q@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jessica Foest <jessica.foest@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1528690914==
Content-Type: multipart/alternative;
	boundary="------------000506010809070208090203"

--------------000506010809070208090203
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Hi,

Welcome to LTTng-dev.

What distro are you using?

I am looking at the tracepoints, I see system tap has
probe:netdev.set_promiscuity, it's probably not in the default list but
it hooked onto set_promiscuity.

Maybe you can use a kprobe on set_promiscuity and then check later
events to infer if enabled is true. I'm sorry, I work more on the trace
viewing side than the kernel side so my knowledge is rather limited.

Hope this helps and please keep us updated, this is an interesting problem.

Matthew


On 13-06-26 04:14 PM, Jessica Foest wrote:
> Hi
>
> when use lttng network tracepoint it didn't display network interface
> mode (like promiscuous mode or other ) . did i miss some tracepoint
> option or it's a limitation ?
> regard
>
>
> 2013/6/26 Jessica Foest <jessica.foest@gmail.com
> <mailto:jessica.foest@gmail.com>>
>
>     Hi
>
>     when use lttng network tracepoint it didn't display network
>     interface mode (like promiscuous mode or other ) . did i miss some
>     tracepoint option or it's a limitation ?
>     regard
>
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--------------000506010809070208090203
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <tt>Hi, <br>
      <br>
      Welcome to LTTng-dev.<br>
    </tt><br>
    <tt><tt>What distro are you using? <br>
        <br>
      </tt>I am looking at the tracepoints, I see system tap has
      probe:netdev.set_promiscuity, it's probably not in the default
      list but it hooked onto set_promiscuity.<br>
      <br>
      Maybe you can use a kprobe on set_promiscuity and then check later
      events to infer if enabled is true. I'm sorry, I work more on the
      trace viewing side than the kernel side so my knowledge is rather
      limited. <br>
      <br>
      Hope this helps and please keep us updated, this is an interesting
      problem.<br>
      <br>
      Matthew<br>
      <br>
      <br>
    </tt>
    <div class="moz-cite-prefix">On 13-06-26 04:14 PM, Jessica Foest
      wrote:<br>
    </div>
    <blockquote
cite="mid:CAPxN80BrtX4Y7RT-O9FUc72TWj-9Oh7MtzbteoRNaMqwgEZB1Q@mail.gmail.com"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html;
        charset=ISO-8859-1">
      <div dir="ltr">
        <div>
          <div>
            <div>Hi<br>
              <br>
              when use lttng network tracepoint it didn't display
              network interface mode (like promiscuous mode or other ) .
              did i miss some tracepoint option or it's a limitation ?<br>
            </div>
          </div>
        </div>
        regard</div>
      <div class="gmail_extra"><br>
        <br>
        <div class="gmail_quote">2013/6/26 Jessica Foest <span
            dir="ltr">&lt;<a moz-do-not-send="true"
              href="mailto:jessica.foest@gmail.com" target="_blank">jessica.foest@gmail.com</a>&gt;</span><br>
          <blockquote class="gmail_quote" style="margin:0 0 0
            .8ex;border-left:1px #ccc solid;padding-left:1ex">
            <div dir="ltr">
              <div>
                <div>
                  <div>Hi<br>
                    <br>
                    when use lttng network tracepoint it didn't display
                    network interface mode (like promiscuous mode or
                    other ) . did i miss some tracepoint option or it's
                    a limitation ?<br>
                  </div>
                </div>
              </div>
              regard<br>
            </div>
          </blockquote>
        </div>
        <br>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
lttng-dev mailing list
<a class="moz-txt-link-abbreviated" href="mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a>
<a class="moz-txt-link-freetext" href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------000506010809070208090203--


--===============1528690914==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1528690914==--
