From: Matthew Khouzam <matthew.khouzam@ericsson.com>
Subject: Re: question
Date: Fri, 12 Jul 2013 16:22:45 -0400
Message-ID: <51E06595.7030209__14092.4103245654$1373660626$gmane$org@ericsson.com>
References: <CAEiarX0p47Cr4EC9k2PrgjrwR7X9_R4h0uoHcWPLH7KqLb2scg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0023125622=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg21.ericsson.net ([198.24.6.65])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <matthew.khouzam@ericsson.com>) id 1Uxjrw-0004om-B0
	for lttng-dev@lists.lttng.org; Fri, 12 Jul 2013 16:23:08 -0400
In-Reply-To: <CAEiarX0p47Cr4EC9k2PrgjrwR7X9_R4h0uoHcWPLH7KqLb2scg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: emy moore <emy.moore90@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0023125622==
Content-Type: multipart/alternative;
	boundary="------------080304070701040309010505"

--------------080304070701040309010505
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Hi Emy,

I'm a bit confused by your question, are you trying to modify an
obsolete system call let's say you want to instrument old code, it
should be moderately staightforward with kprobe. Lttng can read the
kprobes after.

Lttng can read the probes like this
http://lwn.net/Articles/491510/
here's some more info on kprobes
https://www.kernel.org/doc/Documentation/kprobes.txt

Hope this helps.
Matt


On 13-07-10 05:51 PM, emy moore wrote:
> hi all
>
> i try to understand how a system call is implemented so i do some
> modification in an obsolete system call.
>
> i want to know can i trace this system call using lttng knowing that
> it's an obsolete one ? if no how can i activate it's trace ?
>
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--------------080304070701040309010505
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <tt>Hi Emy, <br>
      <br>
      I'm a bit confused by your question, are you trying to modify an
      obsolete system call let's say you want to instrument old code, it
      should be moderately staightforward with kprobe. Lttng can read
      the kprobes after. <br>
      <br>
      Lttng can read the probes like this<br>
      <a class="moz-txt-link-freetext" href="http://lwn.net/Articles/491510/">http://lwn.net/Articles/491510/</a><br>
      here's some more info on kprobes<br>
      <a class="moz-txt-link-freetext" href="https://www.kernel.org/doc/Documentation/kprobes.txt">https://www.kernel.org/doc/Documentation/kprobes.txt</a><br>
      <br>
      Hope this helps.<br>
      Matt<br>
      <br>
      <br>
    </tt>
    <div class="moz-cite-prefix">On 13-07-10 05:51 PM, emy moore wrote:<br>
    </div>
    <blockquote
cite="mid:CAEiarX0p47Cr4EC9k2PrgjrwR7X9_R4h0uoHcWPLH7KqLb2scg@mail.gmail.com"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html;
        charset=ISO-8859-1">
      <div dir="ltr">
        <div>
          <div>hi all<br>
            <br>
          </div>
          i try to understand how a system call is implemented so i do
          some modification in an obsolete system call.<br>
          <br>
        </div>
        i want to know can i trace this system call using lttng knowing
        that it's an obsolete one ? if no how can i activate it's trace
        ?<br>
        <br>
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

--------------080304070701040309010505--


--===============0023125622==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0023125622==--
