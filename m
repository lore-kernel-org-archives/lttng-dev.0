From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Re: Getting started with UST
Date: Sun, 26 May 2013 09:10:46 -0400
Message-ID: <51A209D6.6010802__31933.9692163796$1369573887$gmane$org@gmail.com>
References: <CAE5ibEneMm2D1=3Zy8hbtV42Y22TwW2rRAqimyMSfMPvtiYCiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0311798464=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1Ugais-0003Da-H6
	for lttng-dev@lists.lttng.org; Sun, 26 May 2013 09:10:54 -0400
Received: by mail-qc0-f169.google.com with SMTP id k15so3173956qcv.28
	for <lttng-dev@lists.lttng.org>; Sun, 26 May 2013 06:10:49 -0700 (PDT)
In-Reply-To: <CAE5ibEneMm2D1=3Zy8hbtV42Y22TwW2rRAqimyMSfMPvtiYCiA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Aryeh Weinreb <weinrea@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--===============0311798464==
Content-Type: multipart/alternative;
 boundary="------------000400080504060908070201"

This is a multi-part message in MIME format.
--------------000400080504060908070201
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

Did you forgot to enable some event, for example:
lttng enable-event -u -a
(For all userspace events)

On 2013-05-26 08:51, Aryeh Weinreb wrote:
> Hi,
> I'm trying to get UST working for the first time on RHEL 6.4.
>
> I compiled and installed the following packages:
> userspace-rcu-0.7.6
> lttng-ust-2.1.2
> lttng-tools-2.0.5
> babeltrace-1.1.0
>
> When I ran the sample app in lttng-ust/examples I couldn't see any traces.
>
> # lttng create test_session
> Session test_session created.
> Traces will be written in /root/lttng-traces/test_session-20130526-071315
>
> # lttng start
> Tracing started for session test_session
>
> # cd /usr/local/share/doc/lttng-ust/examples/gen-tp/
>
> # make
> lttng-gen-tp -o sample_tracepoint.h sample_tracepoint.tp
> gcc  -c -o sample.o sample.c
> lttng-gen-tp -o sample_tracepoint.c sample_tracepoint.tp
> lttng-gen-tp -o sample_tracepoint.o sample_tracepoint.tp
> gcc -o sample sample.o sample_tracepoint.o -ldl -llttng-ust
> rm sample_tracepoint.c
>
> # ./sample
>
> # lttng stop
> Tracing stopped for session test_session
>
> # lttng view
> Trace directory: /root/lttng-traces/test_session-20130526-071315
>
> [error] Cannot open any trace for reading.
>
> [error] opening trace
> "/root/lttng-traces/test_session-20130526-071315" for reading.
>
> [error] none of the specified trace paths could be opened.
>
> # ls -l /root/lttng-traces/test_session-20130526-071315
> total 0
>
>
> What am I doing wrong? I attached the debug log from the lttng-sessiond.
>
> Thanks,
> Aryeh
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--------------000400080504060908070201
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Hi,<br>
    <br>
    Did you forgot to enable some event, for example:<br>
    lttng enable-event -u -a<br>
    (For all userspace events)<br>
    <br>
    On 2013-05-26 08:51, Aryeh Weinreb wrote:
    <blockquote
cite="mid:CAE5ibEneMm2D1=3Zy8hbtV42Y22TwW2rRAqimyMSfMPvtiYCiA@mail.gmail.com"
      type="cite">
      <pre wrap="">Hi,
I'm trying to get UST working for the first time on RHEL 6.4.

I compiled and installed the following packages:
userspace-rcu-0.7.6
lttng-ust-2.1.2
lttng-tools-2.0.5
babeltrace-1.1.0

When I ran the sample app in lttng-ust/examples I couldn't see any traces.

# lttng create test_session
Session test_session created.
Traces will be written in /root/lttng-traces/test_session-20130526-071315

# lttng start
Tracing started for session test_session

# cd /usr/local/share/doc/lttng-ust/examples/gen-tp/

# make
lttng-gen-tp -o sample_tracepoint.h sample_tracepoint.tp
gcc  -c -o sample.o sample.c
lttng-gen-tp -o sample_tracepoint.c sample_tracepoint.tp
lttng-gen-tp -o sample_tracepoint.o sample_tracepoint.tp
gcc -o sample sample.o sample_tracepoint.o -ldl -llttng-ust
rm sample_tracepoint.c

# ./sample

# lttng stop
Tracing stopped for session test_session

# lttng view
Trace directory: /root/lttng-traces/test_session-20130526-071315

[error] Cannot open any trace for reading.

[error] opening trace
"/root/lttng-traces/test_session-20130526-071315" for reading.

[error] none of the specified trace paths could be opened.

# ls -l /root/lttng-traces/test_session-20130526-071315
total 0


What am I doing wrong? I attached the debug log from the lttng-sessiond.

Thanks,
Aryeh
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

--------------000400080504060908070201--


--===============0311798464==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0311798464==--
