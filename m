From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: Re: tracing scheduler wakeup latency with lttng
Date: Tue, 13 Aug 2013 11:30:22 -0400
Message-ID: <520A510E.7060804__16033.2133215435$1376407898$gmane$org@gmail.com>
References: <BLU170-W489208B5DACFA89CF0F8ADB85B0@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0022090808=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <francis.giraldeau@gmail.com>) id 1V9GYJ-00025m-18
	for lttng-dev@lists.lttng.org; Tue, 13 Aug 2013 11:30:36 -0400
Received: by mail-qa0-f48.google.com with SMTP id o19so386060qap.7
	for <lttng-dev@lists.lttng.org>; Tue, 13 Aug 2013 08:30:25 -0700 (PDT)
Received: from [132.207.220.194] (Sansfil-Public-Lassonde-220-194.polymtl.ca.
	[132.207.220.194])
	by mx.google.com with ESMTPSA id 9sm12054932qau.3.2013.08.13.08.30.23
	for <lttng-dev@lists.lttng.org>
	(version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Tue, 13 Aug 2013 08:30:24 -0700 (PDT)
In-Reply-To: <BLU170-W489208B5DACFA89CF0F8ADB85B0@phx.gbl>
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

This is a multi-part message in MIME format.
--===============0022090808==
Content-Type: multipart/alternative;
 boundary="------------030604040500040504060406"

This is a multi-part message in MIME format.
--------------030604040500040504060406
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.polymtl.ca id r7DFUvXC015849

Le 2013-08-12 11:15, Kannan Ramaswamy a =E9crit :
> Hi,
> I am new to lttng and am reading through the documentation. Does
> anyone have experience tracing linux scheduler latencies with lttng? I
> will be grateful if you could provide a cheat sheet of instructions to
> follow. I want to get a call trace of kernel operations for each time
> the scheduler wakeup was over some prespecified microsecond duration.

The scheduler latency is the delay between a task becomes runnable and
the time it's actually running. The event that indicates the task was
waiting and is now runnable is sched_wakeup (or sched_wakeup_new in the
case of a newly forked task). The time between this event and it's
corresponding sched_switch indicates the scheduling latency.

I'm using Java library to do the analysis. Here is a simple example of
how to perform some analysis on a trace.

https://github.com/giraldeau/org.eclipse.linuxtools.lttng2.kmem

>
> I have compiled lttng 2.2 on a vanilla 3.10.5 kernel on a 16 core
> Intel Xeon CPU E5-2690 @2.90GHz. I am trying to identify and reduce my
> multithreaded multicast based application service latency.

You should make sure there is no event loss, because it would yield
wrong results. You can increase kernel buffer size when enabling
channels. Have a look at how it's done in lttng-simple.

https://github.com/giraldeau/workload-kit/blob/master/utils/lttng-simple

Is it an open source app? Is it possible to publish the traces? I could
take a look at it.

Cheers,

Francis

--------------030604040500040504060406
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Le 2013-08-12 11:15, Kannan Ramaswamy a
      &eacute;crit&nbsp;:<br>
    </div>
    <blockquote cite="mid:BLU170-W489208B5DACFA89CF0F8ADB85B0@phx.gbl"
      type="cite">
      <style><!--
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 12pt;
font-family:Calibri
}
--></style>
      <div dir="ltr">Hi,
        <div>I am new to lttng and am reading through the documentation.
          Does anyone have experience tracing linux scheduler latencies
          with lttng? I will be grateful if you could provide a cheat
          sheet of instructions to follow. I want to get a call trace of
          kernel operations for each time the scheduler wakeup was over
          some prespecified microsecond duration.</div>
      </div>
    </blockquote>
    <br>
    The scheduler latency is the delay between a task becomes runnable
    and the time it's actually running. The event that indicates the
    task was waiting and is now runnable is sched_wakeup (or
    sched_wakeup_new in the case of a newly forked task). The time
    between this event and it's corresponding sched_switch indicates the
    scheduling latency. <br>
    <br>
    I'm using Java library to do the analysis. Here is a simple example
    of how to perform some analysis on a trace. <br>
    <br>
    <meta http-equiv="content-type" content="text/html;
      charset=ISO-8859-1">
    <a
      href="https://github.com/giraldeau/org.eclipse.linuxtools.lttng2.kmem">https://github.com/giraldeau/org.eclipse.linuxtools.lttng2.kmem</a><br>
    <br>
    <blockquote cite="mid:BLU170-W489208B5DACFA89CF0F8ADB85B0@phx.gbl"
      type="cite">
      <div dir="ltr">
        <div><br>
        </div>
        <div>I have compiled lttng 2.2 on a vanilla 3.10.5 kernel on a
          16 core Intel Xeon CPU E5-2690 @2.90GHz. I am trying to
          identify and reduce my multithreaded multicast based
          application service latency.</div>
      </div>
    </blockquote>
    <br>
    You should make sure there is no event loss, because it would yield
    wrong results. You can increase kernel buffer size when enabling
    channels. Have a look at how it's done in lttng-simple. <br>
    <br>
    <meta http-equiv="content-type" content="text/html;
      charset=ISO-8859-1">
    <a
href="https://github.com/giraldeau/workload-kit/blob/master/utils/lttng-simple">https://github.com/giraldeau/workload-kit/blob/master/utils/lttng-simple</a><br>
    <br>
    Is it an open source app? Is it possible to publish the traces? I
    could take a look at it. <br>
    <br>
    Cheers,<br>
    <br>
    Francis<br>
  </body>
</html>

--------------030604040500040504060406--


--===============0022090808==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0022090808==--
