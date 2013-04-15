From: Matthew Khouzam <matthew.khouzam@ericsson.com>
Subject: Re: [RFC lttng-tools] Triggers
Date: Mon, 15 Apr 2013 10:36:34 -0400
Message-ID: <516C1072.9030902__26812.9256241538$1366036678$gmane$org@ericsson.com>
References: <5166DFE7.8020802@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1261080726=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg20.ericsson.net ([198.24.6.45])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <matthew.khouzam@ericsson.com>) id 1URkX5-0003Rd-Qy
	for lttng-dev@lists.lttng.org; Mon, 15 Apr 2013 10:37:23 -0400
In-Reply-To: <5166DFE7.8020802@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1261080726==
Content-Type: multipart/alternative;
	boundary="------------070606020501060401000804"

--------------070606020501060401000804
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Hey tracing architects,
Just a thought of consistency.
we have
lttng add-context (you can have many)
lttng disable-context
lttng enable-consumer (you can only have one)
lttng disable-consumer
I would suggest
lttng add-trigger (you can have many)
lttng disable-trigger
lttng modify-trigger ???


TLDR: there should be a naming convention for lttng commands, there
probably are but I have not seen them, or maybe I have but I do not
remember seeing them.

TLDR-TLDR: name things the same way please. :)

On 13-04-11 12:08 PM, David Goulet wrote:
> Hi everyone,
>
> Here is the second RFC of the day.
>
> By reading this, your imagination will probably go pretty crazy with
> possibilities ;). The first implementation will only have one option
> describe in the RFC but note that with this kind of feature, the sky is
> the limit! and of course world domination is never far.
>
> Thanks!
> David
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--------------070606020501060401000804
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Hey tracing architects, <br>
    Just a thought of consistency. <br>
    we have <br>
    lttng add-context (you can have many)<br>
    lttng disable-context <br>
    lttng enable-consumer (you can only have one)<br>
    lttng disable-consumer <br>
    I would suggest <br>
    lttng add-trigger (you can have many)<br>
    lttng disable-trigger<br>
    lttng modify-trigger ??? <br>
    <br>
    <br>
    TLDR: there should be a naming convention for lttng commands, there
    probably are but I have not seen them, or maybe I have but I do not
    remember seeing them. <br>
    <br>
    TLDR-TLDR: name things the same way please. :)<br>
    <br>
    <div class="moz-cite-prefix">On 13-04-11 12:08 PM, David Goulet
      wrote:<br>
    </div>
    <blockquote cite="mid:5166DFE7.8020802@efficios.com" type="cite">
      <pre wrap="">Hi everyone,

Here is the second RFC of the day.

By reading this, your imagination will probably go pretty crazy with
possibilities ;). The first implementation will only have one option
describe in the RFC but note that with this kind of feature, the sky is
the limit! and of course world domination is never far.

Thanks!
David
</pre>
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

--------------070606020501060401000804--


--===============1261080726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1261080726==--
