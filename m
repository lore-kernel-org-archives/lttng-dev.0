Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D15C25B74
	for <lttng-dev@archiver.kernel.org>; Mon,  3 Jun 2024 02:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1717383369;
	bh=tLuCBSGgD469TMsfSE/v2oYh6qsl3fONrOF+k0jycu8=;
	h=To:Date:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=aCqRfx4aMZ0yiO5jBO+Xc4ix1yJrgk0JEpz5KD57M44C9yQKrR+CfsYJFXIx/Tfe+
	 URsNAP7xy8/ACQgTwPixf495WHOoAJ75ftkYyow0sWeL83/sl7ApZNAXa4Zj32OejG
	 2ZARp+sQlPglse+VAxk9AFVRU1pn4daUuDSDDibYl2GOchk/ZOYIEJaGWtrdQR09dg
	 oR8kgirdDZqrG36bZb9LgvSqMsPxDSgR1CaNCJArUVKaQfcP30a6D+aEpQh5sRYR49
	 4+zLZFOjSXiBp7Fhdx5P8E/pdvV1aPX/eAmmjZPhPQ5Unpf3x3guf5WeL6rMo8d5Xo
	 c5EjzPwG0sPlg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4VsyzD5hwDz2sZQ;
	Sun,  2 Jun 2024 22:56:08 -0400 (EDT)
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com
 [207.171.188.206])
 by lists.lttng.org (Postfix) with ESMTPS id 4Vsyz723lsz2sZP
 for <lttng-dev@lists.lttng.org>; Sun,  2 Jun 2024 22:56:03 -0400 (EDT)
X-IronPort-AV: E=Sophos;i="6.08,210,1712620800"; 
 d="scan'208,217";a="729964940"
Thread-Topic: [lttng-dev] [lttng-relayd] is there existing cases for relayd to
 stream over Android usb based adb?
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
 by smtp-border-fw-9106.sea19.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 02:55:57 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:22932]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.236:2525]
 with esmtp (Farcaster)
 id 2fae7a9e-dd17-45d0-8794-be96c200481c; Mon, 3 Jun 2024 02:55:56 +0000 (UTC)
X-Farcaster-Flow-ID: 2fae7a9e-dd17-45d0-8794-be96c200481c
Received: from EX19D003ANC003.ant.amazon.com (10.37.240.197) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 3 Jun 2024 02:55:56 +0000
Received: from EX19D003ANC001.ant.amazon.com (10.37.240.216) by
 EX19D003ANC003.ant.amazon.com (10.37.240.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Mon, 3 Jun 2024 02:55:54 +0000
Received: from EX19D003ANC001.ant.amazon.com ([fe80::ed4e:7258:fa8c:17e8]) by
 EX19D003ANC001.ant.amazon.com ([fe80::ed4e:7258:fa8c:17e8%5]) with
 mapi id 15.02.1258.028; Mon, 3 Jun 2024 02:55:54 +0000
To: Kienan Stewart <kstewart@efficios.com>, "lttng-dev@lists.lttng.org"
 <lttng-dev@lists.lttng.org>
Thread-Index: AQHaslKH7CI0j5/u4E6iXx4NZ5jN4bGwJewAgAU3Kcw=
Date: Mon, 3 Jun 2024 02:55:54 +0000
Message-ID: <92cc12a956e1404691519a7f02b7607d@amazon.com>
References: <b2e9c32fbcbe4067a64fd831bac70d81@amazon.com>,
 <b974bf9f-b511-4fdb-8d67-93a6c1b273ab@efficios.com>
In-Reply-To: <b974bf9f-b511-4fdb-8d67-93a6c1b273ab@efficios.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.119.100.232]
MIME-Version: 1.0
Subject: Re: [lttng-dev] [lttng-relayd] is there existing cases for relayd
 to stream over Android usb based adb?
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: "Wu, Yannan via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "Wu, Yannan" <yannanwu@amazon.com>
Content-Type: multipart/mixed; boundary="===============8333387275601088798=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============8333387275601088798==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_92cc12a956e1404691519a7f02b7607damazoncom_"

--_000_92cc12a956e1404691519a7f02b7607damazoncom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Yes. My test command is like below:

  1.  lttng-sessiond --d --no-kernel
  2.

yannanwu@ue91e96f2951b5c:~/trees/lttng_test_run$ lttng create my-user-space=
-live-session --live
Live session my-user-space-live-session created.
Traces will be output to tcp4://127.0.0.1:5342/ [data: 5343]
Live timer interval set to 1000000 us

  3.  After this, I could "ps -Ax|grep lttng" and see lttng-relayd started.=
 But once I start adb reverse, it will failed for failed binding to socket.
  4.  In the other order, if I start adb reverse first and lttng-create lat=
er, lttng-create will not fail but lttng-relayd is not started. By manually=
 start lttng-relayd it will also failed for unable binding to socket.

Amanda

________________________________
From: Kienan Stewart <kstewart@efficios.com>
Sent: Friday, May 31, 2024 3:12:16 AM
To: Wu, Yannan; lttng-dev@lists.lttng.org
Subject: RE: [EXTERNAL] [lttng-dev] [lttng-relayd] is there existing cases =
for relayd to stream over Android usb based adb?

CAUTION: This email originated from outside of the organization. Do not cli=
ck links or open attachments unless you can confirm the sender and know the=
 content is safe.



Hi Amanda,

I'd like to confirm my understanding the situation.

Android device
   - Running lttng-sessiond with one or more configured sessions

Development device
   - Connected to the android device over usb using adb

You want want the data captured on the android device to be streamed via
the usb connection rather than the other networks on the android device.

Could you expand on the commands you used to set up the tracing sessions
and relay, and where each of those commands were run?

It sounds to me like you might want to be doing something like the
following:

(Development device) Start lttng-relayd:
   - tcp://0.0.0.0:5342 and :5343 will be bound on the development device
   - tcp://127.0.0.1:5344 will be available for the live reader

(Development device) Create the reverses for the following ports: 5342
and 5343
   - At this point :5342 and :5343 should be available on the android
device and reach the relayd running on the development device

(Android device) Start lttng-sessiond
(Android device) Create session(s): `lttng create -U tcp://localhost/
   - Using `-U/--set-url`, no relayd will be spawned on the android device
(Android device) Start session(s)

This setup should have the relayd running on the development and writing
the traces there and/or viewing them with a live viewer. On the android
device, the UST applications (if any) will connect to the local sessiond
and consumers, which will shuttle the information over :5342 and :5343
to the developer device via the reverse sockets.

Please note that I didn't have time to test this, so there might be some
mistakes. As I requested above, clear details of the exact commands you
use for the tracing setup would be very helpful to have the clearest
understanding of what you're doing.

hope this helps,
kienan

On 5/30/24 1:53 AM, Wu, Yannan via lttng-dev wrote:
> Hihi, there,
>
> I am currently working on enabling lttng live mode over android usb adb.
> Here is the situation, during debugging some network related issues, we
> dont want the trace data to be streamed via network to cause extra load
> to the system being profiled. Then we select to connect lttng-relayd
> with adb via port forwarding so that the data is "forward" to the host.
>
> *Here is the set up and the problem:*
>
> for the device:  adb reverse tcp:5342 tcp:5342; adb reverse tcp:5343
> tcp:5343; adb reverse tcp:5344 tcp:5344
> Then starting up lttng with --live enabled.
>
> *What is expected:*
> lttng start streaming to the localhost.
> *What is seen: *
> the lttng-relayd failed to start. For unable binding to the socket.
>
> *The cause of this issue: *
>
> both adb reverse and lttng relayd need binding to the socket which is
> conflict with each other.
>
>
> So what I wanna ask is, for embedded system use cases, do we have
> successful use cases among team that could stream the trace data in live
> mode to the host with usb based adb? If not, any idea or suggestion to
> me on how to process forward?
>
> Amanda
>
>
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--_000_92cc12a956e1404691519a7f02b7607damazoncom_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<meta content=3D"text/html; charset=3DUTF-8">
<style type=3D"text/css" style=3D"">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Helvetica,sans-serif">
<p>Yes. My test command is like below:</p>
<p></p>
<ol style=3D"margin-bottom:0px; margin-top:0px">
<li>lttng-sessiond --d --no-kernel</li><li>
<pre>yannanwu@ue91e96f2951b5c:~/trees/lttng_test_run$ lttng create my-user-=
space-live-session --live <br>Live session my-user-space-live-session creat=
ed.<br>Traces will be output to tcp4://127.0.0.1:5342/ [data: 5343]<br>Live=
 timer interval set to 1000000 us</pre>
</li><li>After this, I could &quot;ps -Ax|grep lttng&quot; and see lttng-re=
layd started. But once I start adb reverse, it will failed for failed bindi=
ng to socket.</li><li>In the other order, if I start adb reverse first and =
lttng-create later, lttng-create will not fail but lttng-relayd is not star=
ted. By manually start lttng-relayd it will also failed for unable binding =
to socket.</li></ol>
<div>Amanda</div>
<p></p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Kienan Stewart &lt;=
kstewart@efficios.com&gt;<br>
<b>Sent:</b> Friday, May 31, 2024 3:12:16 AM<br>
<b>To:</b> Wu, Yannan; lttng-dev@lists.lttng.org<br>
<b>Subject:</b> RE: [EXTERNAL] [lttng-dev] [lttng-relayd] is there existing=
 cases for relayd to stream over Android usb based adb?</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">CAUTION: This email originated from outside of the=
 organization. Do not click links or open attachments unless you can confir=
m the sender and know the content is safe.<br>
<br>
<br>
<br>
Hi Amanda,<br>
<br>
I'd like to confirm my understanding the situation.<br>
<br>
Android device<br>
&nbsp;&nbsp; - Running lttng-sessiond with one or more configured sessions<=
br>
<br>
Development device<br>
&nbsp;&nbsp; - Connected to the android device over usb using adb<br>
<br>
You want want the data captured on the android device to be streamed via<br=
>
the usb connection rather than the other networks on the android device.<br=
>
<br>
Could you expand on the commands you used to set up the tracing sessions<br=
>
and relay, and where each of those commands were run?<br>
<br>
It sounds to me like you might want to be doing something like the<br>
following:<br>
<br>
(Development device) Start lttng-relayd:<br>
&nbsp;&nbsp; - tcp://0.0.0.0:5342 and :5343 will be bound on the developmen=
t device<br>
&nbsp;&nbsp; - tcp://127.0.0.1:5344 will be available for the live reader<b=
r>
<br>
(Development device) Create the reverses for the following ports: 5342<br>
and 5343<br>
&nbsp;&nbsp; - At this point :5342 and :5343 should be available on the and=
roid<br>
device and reach the relayd running on the development device<br>
<br>
(Android device) Start lttng-sessiond<br>
(Android device) Create session(s): `lttng create -U tcp://localhost/<br>
&nbsp;&nbsp; - Using `-U/--set-url`, no relayd will be spawned on the andro=
id device<br>
(Android device) Start session(s)<br>
<br>
This setup should have the relayd running on the development and writing<br=
>
the traces there and/or viewing them with a live viewer. On the android<br>
device, the UST applications (if any) will connect to the local sessiond<br=
>
and consumers, which will shuttle the information over :5342 and :5343<br>
to the developer device via the reverse sockets.<br>
<br>
Please note that I didn't have time to test this, so there might be some<br=
>
mistakes. As I requested above, clear details of the exact commands you<br>
use for the tracing setup would be very helpful to have the clearest<br>
understanding of what you're doing.<br>
<br>
hope this helps,<br>
kienan<br>
<br>
On 5/30/24 1:53 AM, Wu, Yannan via lttng-dev wrote:<br>
&gt; Hihi, there,<br>
&gt;<br>
&gt; I am currently working on enabling lttng live mode over android usb ad=
b.<br>
&gt; Here is the situation, during debugging some network related issues, w=
e<br>
&gt; dont want the trace data to be streamed via network to cause extra loa=
d<br>
&gt; to the system being profiled. Then we select to connect lttng-relayd<b=
r>
&gt; with adb via port forwarding so that the data is &quot;forward&quot; t=
o the host.<br>
&gt;<br>
&gt; *Here is the set up and the problem:*<br>
&gt;<br>
&gt; for the device:&nbsp; adb reverse tcp:5342 tcp:5342; adb reverse tcp:5=
343<br>
&gt; tcp:5343; adb reverse tcp:5344 tcp:5344<br>
&gt; Then starting up lttng with --live enabled.<br>
&gt;<br>
&gt; *What is expected:*<br>
&gt; lttng start streaming to the localhost.<br>
&gt; *What is seen: *<br>
&gt; the lttng-relayd failed to start. For unable binding to the socket.<br=
>
&gt;<br>
&gt; *The cause of this issue: *<br>
&gt;<br>
&gt; both adb reverse and lttng relayd need binding to the socket which is<=
br>
&gt; conflict with each other.<br>
&gt;<br>
&gt;<br>
&gt; So what I wanna ask is, for embedded system use cases, do we have<br>
&gt; successful use cases among team that could stream the trace data in li=
ve<br>
&gt; mode to the host with usb based adb? If not, any idea or suggestion to=
<br>
&gt; me on how to process forward?<br>
&gt;<br>
&gt; Amanda<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; lttng-dev@lists.lttng.org<br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
>https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>
</div>
</span></font>
</body>
</html>

--_000_92cc12a956e1404691519a7f02b7607damazoncom_--

--===============8333387275601088798==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8333387275601088798==--
