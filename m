Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5ABAC25B78
	for <lttng-dev@archiver.kernel.org>; Tue,  4 Jun 2024 15:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1717514761;
	bh=26XaNL6R5gyJ5y5VZOhX8JbOKvPm5SOw/QZEXiTW3tI=;
	h=To:Date:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=aADKODb0nAGO2QgvEocWvc/z4mZ8gD6oLsjaqtqjQnHOjJWCc62YMzo178gKJsSRN
	 fFrFWGDOgDJsLNvgaPqPjnNr+3RRc7NyLe9EYKftAMI1xdd4sJk/HEiht9cUJle89p
	 a4mE26k7f2yDK6bwgboaavzILZRPqb/rXvN+8oDqOdtAwYbmRD5KfmD8jzn90h3W4x
	 f95QtxftZcnxmMgvDn40xpsneCMW33Gr7fQ9WtmKTQvXDLW9Kjp4a6X9SKc5bB7ctz
	 Hn7hGrZFKxjiufUlpp1PV3uKNLUH07FmAxhtcTgDKOeqesPp7GqucaI7aaMDgjoG9i
	 LbNh6izqlDZ8w==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4VtvZ15s7tz2svn;
	Tue,  4 Jun 2024 11:26:01 -0400 (EDT)
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com
 [52.119.213.150])
 by lists.lttng.org (Postfix) with ESMTPS id 4VtvZ01jDRz2sq7
 for <lttng-dev@lists.lttng.org>; Tue,  4 Jun 2024 11:26:00 -0400 (EDT)
X-IronPort-AV: E=Sophos;i="6.08,214,1712620800"; 
 d="scan'208,217";a="637164509"
Thread-Topic: [lttng-dev] [lttng-relayd] is there existing cases for relayd to
 stream over Android usb based adb?
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
 by smtp-border-fw-52002.iad7.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 15:25:58 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:26081]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.252:2525]
 with esmtp (Farcaster)
 id ded56566-6005-4263-a4ce-3581d2aea46a; Tue, 4 Jun 2024 15:25:57 +0000 (UTC)
X-Farcaster-Flow-ID: ded56566-6005-4263-a4ce-3581d2aea46a
Received: from EX19D003ANC002.ant.amazon.com (10.37.240.215) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 4 Jun 2024 15:25:57 +0000
Received: from EX19D003ANC001.ant.amazon.com (10.37.240.216) by
 EX19D003ANC002.ant.amazon.com (10.37.240.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 4 Jun 2024 15:25:56 +0000
Received: from EX19D003ANC001.ant.amazon.com ([fe80::ed4e:7258:fa8c:17e8]) by
 EX19D003ANC001.ant.amazon.com ([fe80::ed4e:7258:fa8c:17e8%5]) with
 mapi id 15.02.1258.034; Tue, 4 Jun 2024 15:25:56 +0000
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Kienan Stewart
 <kstewart@efficios.com>, "lttng-dev@lists.lttng.org"
 <lttng-dev@lists.lttng.org>
Thread-Index: AQHaslKH7CI0j5/u4E6iXx4NZ5jN4bGwJewAgAU3KcyAAmC3AIAAAmEo
Date: Tue, 4 Jun 2024 15:25:55 +0000
Message-ID: <9c0522c7090b4523aac4166a232ca50a@amazon.com>
References: <b2e9c32fbcbe4067a64fd831bac70d81@amazon.com>
 <b974bf9f-b511-4fdb-8d67-93a6c1b273ab@efficios.com>
 <92cc12a956e1404691519a7f02b7607d@amazon.com>,
 <0d226e1c-ff15-47f1-a902-bad362053903@efficios.com>
In-Reply-To: <0d226e1c-ff15-47f1-a902-bad362053903@efficios.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.187.170.41]
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
Content-Type: multipart/mixed; boundary="===============2710909978227420475=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============2710909978227420475==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_9c0522c7090b4523aac4166a232ca50aamazoncom_"

--_000_9c0522c7090b4523aac4166a232ca50aamazoncom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The device is a rooted android device

On the device:

lttng-sessiond -d --no-kernel

lttng create my-live-session --live

lttng enable-event -u <mu customized event>

lttng start


On the host:

adb reverse tcp:5343 tcp:5343

The adb reverse will fail for "adb.exe: error: cannot bind to socket"


In the reversed order, if set up adb reverse from the host first and create=
 the live session after, lttng-relayd on device cannot be started.
Here is the error message:

PERROR - 15:23:30.915938387 [9813/9829]: Failed to bind socket: Address alr=
eady in use (in relay_socket_create() at /src/VodkaLttngTool/build/private/=
source/src/bin/lttng-relayd/main.c:1036)
Error: Health error occurred in relay_thread_listener
Error: A file descriptor leak has been detected: 1 tracked file descriptors=
 are still being tracked




________________________________
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Sent: Tuesday, June 4, 2024 11:09:40 PM
To: Wu, Yannan; Kienan Stewart; lttng-dev@lists.lttng.org
Subject: RE: [EXTERNAL] [lttng-dev] [lttng-relayd] is there existing cases =
for relayd to stream over Android usb based adb?

CAUTION: This email originated from outside of the organization. Do not cli=
ck links or open attachments unless you can confirm the sender and know the=
 content is safe.



Hi Amanda,

For each of the 4 commands described below, please clarify on
which device they are executed, whether on the Android device
or on the Development device.

Please make sure to follow to the letter the commands proposed
by Kienan: in the correct order, and on the appropriate device.

Thanks,

Mathieu


On 2024-06-02 22:55, Wu, Yannan via lttng-dev wrote:
> Yes. My test command is like below:
>
>  1. lttng-sessiond --d --no-kernel
>  2.
>
>     yannanwu@ue91e96f2951b5c:~/trees/lttng_test_run$ lttng create my-user=
-space-live-session --live
>     Live session my-user-space-live-session created.
>     Traces will be output to tcp4://127.0.0.1:5342/ [data: 5343]
>     Live timer interval set to 1000000 us
>
>  3. After this, I could "ps -Ax|grep lttng" and see lttng-relayd
>     started. But once I start adb reverse, it will failed for failed
>     binding to socket.
>  4. In the other order, if I start adb reverse first and lttng-create
>     later, lttng-create will not fail but lttng-relayd is not started.
>     By manually start lttng-relayd it will also failed for unable
>     binding to socket.
>
> Amanda
>
> ------------------------------------------------------------------------
> *From:* Kienan Stewart <kstewart@efficios.com>
> *Sent:* Friday, May 31, 2024 3:12:16 AM
> *To:* Wu, Yannan; lttng-dev@lists.lttng.org
> *Subject:* RE: [EXTERNAL] [lttng-dev] [lttng-relayd] is there existing
> cases for relayd to stream over Android usb based adb?
> CAUTION: This email originated from outside of the organization. Do not
> click links or open attachments unless you can confirm the sender and
> know the content is safe.
>
>
>
> Hi Amanda,
>
> I'd like to confirm my understanding the situation.
>
> Android device
>     - Running lttng-sessiond with one or more configured sessions
>
> Development device
>     - Connected to the android device over usb using adb
>
> You want want the data captured on the android device to be streamed via
> the usb connection rather than the other networks on the android device.
>
> Could you expand on the commands you used to set up the tracing sessions
> and relay, and where each of those commands were run?
>
> It sounds to me like you might want to be doing something like the
> following:
>
> (Development device) Start lttng-relayd:
>     - tcp://0.0.0.0:5342 and :5343 will be bound on the development devic=
e
>     - tcp://127.0.0.1:5344 will be available for the live reader
>
> (Development device) Create the reverses for the following ports: 5342
> and 5343
>     - At this point :5342 and :5343 should be available on the android
> device and reach the relayd running on the development device
>
> (Android device) Start lttng-sessiond
> (Android device) Create session(s): `lttng create -U tcp://localhost/
>     - Using `-U/--set-url`, no relayd will be spawned on the android devi=
ce
> (Android device) Start session(s)
>
> This setup should have the relayd running on the development and writing
> the traces there and/or viewing them with a live viewer. On the android
> device, the UST applications (if any) will connect to the local sessiond
> and consumers, which will shuttle the information over :5342 and :5343
> to the developer device via the reverse sockets.
>
> Please note that I didn't have time to test this, so there might be some
> mistakes. As I requested above, clear details of the exact commands you
> use for the tracing setup would be very helpful to have the clearest
> understanding of what you're doing.
>
> hope this helps,
> kienan
>
> On 5/30/24 1:53 AM, Wu, Yannan via lttng-dev wrote:
>> Hihi, there,
>>
>> I am currently working on enabling lttng live mode over android usb adb.
>> Here is the situation, during debugging some network related issues, we
>> dont want the trace data to be streamed via network to cause extra load
>> to the system being profiled. Then we select to connect lttng-relayd
>> with adb via port forwarding so that the data is "forward" to the host.
>>
>> *Here is the set up and the problem:*
>>
>> for the device:  adb reverse tcp:5342 tcp:5342; adb reverse tcp:5343
>> tcp:5343; adb reverse tcp:5344 tcp:5344
>> Then starting up lttng with --live enabled.
>>
>> *What is expected:*
>> lttng start streaming to the localhost.
>> *What is seen: *
>> the lttng-relayd failed to start. For unable binding to the socket.
>>
>> *The cause of this issue: *
>>
>> both adb reverse and lttng relayd need binding to the socket which is
>> conflict with each other.
>>
>>
>> So what I wanna ask is, for embedded system use cases, do we have
>> successful use cases among team that could stream the trace data in live
>> mode to the host with usb based adb? If not, any idea or suggestion to
>> me on how to process forward?
>>
>> Amanda
>>
>>
>>
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


--_000_9c0522c7090b4523aac4166a232ca50aamazoncom_
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
<p>The device is a rooted android device</p>
<p><b>On the device:</b></p>
<p><span style=3D"font-size:12pt">lttng-sessiond -d --no-kernel</span></p>
<p>lttng create my-live-session --live</p>
<p>lttng enable-event -u &lt;mu customized event&gt;</p>
<p>lttng start</p>
<p><br>
</p>
<p><b>On the host:</b></p>
<p>adb reverse tcp:5343 tcp:5343</p>
<p>The adb reverse will fail for &quot;<span><i>adb.exe: error: cannot bind=
 to socket</i></span>&quot;</p>
<p><br>
</p>
<p>In the reversed&nbsp;order, if set up adb reverse from the host first an=
d create the live session after, lttng-relayd on device cannot be started.&=
nbsp;<br>
Here is the error message:</p>
<p></p>
<div><i>PERROR - 15:23:30.915938387 [9813/9829]: Failed to bind socket: Add=
ress already in use (in relay_socket_create() at /src/VodkaLttngTool/build/=
private/source/src/bin/lttng-relayd/main.c:1036)</i></div>
<div><i>Error: Health error occurred in relay_thread_listener</i></div>
<div><i>Error: A file descriptor leak has been detected: 1 tracked file des=
criptors are still being tracked</i></div>
<br>
<p></p>
<p><br>
</p>
<p><br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Mathieu Desnoyers &=
lt;mathieu.desnoyers@efficios.com&gt;<br>
<b>Sent:</b> Tuesday, June 4, 2024 11:09:40 PM<br>
<b>To:</b> Wu, Yannan; Kienan Stewart; lttng-dev@lists.lttng.org<br>
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
For each of the 4 commands described below, please clarify on<br>
which device they are executed, whether on the Android device<br>
or on the Development device.<br>
<br>
Please make sure to follow to the letter the commands proposed<br>
by Kienan: in the correct order, and on the appropriate device.<br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<br>
<br>
On 2024-06-02 22:55, Wu, Yannan via lttng-dev wrote:<br>
&gt; Yes. My test command is like below:<br>
&gt;<br>
&gt;&nbsp; 1. lttng-sessiond --d --no-kernel<br>
&gt;&nbsp; 2.<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; yannanwu@ue91e96f2951b5c:~/trees/lttng_test_ru=
n$ lttng create my-user-space-live-session --live<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; Live session my-user-space-live-session create=
d.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; Traces will be output to tcp4://127.0.0.1:5342=
/ [data: 5343]<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; Live timer interval set to 1000000 us<br>
&gt;<br>
&gt;&nbsp; 3. After this, I could &quot;ps -Ax|grep lttng&quot; and see ltt=
ng-relayd<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; started. But once I start adb reverse, it will=
 failed for failed<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; binding to socket.<br>
&gt;&nbsp; 4. In the other order, if I start adb reverse first and lttng-cr=
eate<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; later, lttng-create will not fail but lttng-re=
layd is not started.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; By manually start lttng-relayd it will also fa=
iled for unable<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; binding to socket.<br>
&gt;<br>
&gt; Amanda<br>
&gt;<br>
&gt; ----------------------------------------------------------------------=
--<br>
&gt; *From:* Kienan Stewart &lt;kstewart@efficios.com&gt;<br>
&gt; *Sent:* Friday, May 31, 2024 3:12:16 AM<br>
&gt; *To:* Wu, Yannan; lttng-dev@lists.lttng.org<br>
&gt; *Subject:* RE: [EXTERNAL] [lttng-dev] [lttng-relayd] is there existing=
<br>
&gt; cases for relayd to stream over Android usb based adb?<br>
&gt; CAUTION: This email originated from outside of the organization. Do no=
t<br>
&gt; click links or open attachments unless you can confirm the sender and<=
br>
&gt; know the content is safe.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Hi Amanda,<br>
&gt;<br>
&gt; I'd like to confirm my understanding the situation.<br>
&gt;<br>
&gt; Android device<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; - Running lttng-sessiond with one or more conf=
igured sessions<br>
&gt;<br>
&gt; Development device<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; - Connected to the android device over usb usi=
ng adb<br>
&gt;<br>
&gt; You want want the data captured on the android device to be streamed v=
ia<br>
&gt; the usb connection rather than the other networks on the android devic=
e.<br>
&gt;<br>
&gt; Could you expand on the commands you used to set up the tracing sessio=
ns<br>
&gt; and relay, and where each of those commands were run?<br>
&gt;<br>
&gt; It sounds to me like you might want to be doing something like the<br>
&gt; following:<br>
&gt;<br>
&gt; (Development device) Start lttng-relayd:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; - tcp://0.0.0.0:5342 and :5343 will be bound o=
n the development device<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; - tcp://127.0.0.1:5344 will be available for t=
he live reader<br>
&gt;<br>
&gt; (Development device) Create the reverses for the following ports: 5342=
<br>
&gt; and 5343<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; - At this point :5342 and :5343 should be avai=
lable on the android<br>
&gt; device and reach the relayd running on the development device<br>
&gt;<br>
&gt; (Android device) Start lttng-sessiond<br>
&gt; (Android device) Create session(s): `lttng create -U tcp://localhost/<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; - Using `-U/--set-url`, no relayd will be spaw=
ned on the android device<br>
&gt; (Android device) Start session(s)<br>
&gt;<br>
&gt; This setup should have the relayd running on the development and writi=
ng<br>
&gt; the traces there and/or viewing them with a live viewer. On the androi=
d<br>
&gt; device, the UST applications (if any) will connect to the local sessio=
nd<br>
&gt; and consumers, which will shuttle the information over :5342 and :5343=
<br>
&gt; to the developer device via the reverse sockets.<br>
&gt;<br>
&gt; Please note that I didn't have time to test this, so there might be so=
me<br>
&gt; mistakes. As I requested above, clear details of the exact commands yo=
u<br>
&gt; use for the tracing setup would be very helpful to have the clearest<b=
r>
&gt; understanding of what you're doing.<br>
&gt;<br>
&gt; hope this helps,<br>
&gt; kienan<br>
&gt;<br>
&gt; On 5/30/24 1:53 AM, Wu, Yannan via lttng-dev wrote:<br>
&gt;&gt; Hihi, there,<br>
&gt;&gt;<br>
&gt;&gt; I am currently working on enabling lttng live mode over android us=
b adb.<br>
&gt;&gt; Here is the situation, during debugging some network related issue=
s, we<br>
&gt;&gt; dont want the trace data to be streamed via network to cause extra=
 load<br>
&gt;&gt; to the system being profiled. Then we select to connect lttng-rela=
yd<br>
&gt;&gt; with adb via port forwarding so that the data is &quot;forward&quo=
t; to the host.<br>
&gt;&gt;<br>
&gt;&gt; *Here is the set up and the problem:*<br>
&gt;&gt;<br>
&gt;&gt; for the device:&nbsp; adb reverse tcp:5342 tcp:5342; adb reverse t=
cp:5343<br>
&gt;&gt; tcp:5343; adb reverse tcp:5344 tcp:5344<br>
&gt;&gt; Then starting up lttng with --live enabled.<br>
&gt;&gt;<br>
&gt;&gt; *What is expected:*<br>
&gt;&gt; lttng start streaming to the localhost.<br>
&gt;&gt; *What is seen: *<br>
&gt;&gt; the lttng-relayd failed to start. For unable binding to the socket=
.<br>
&gt;&gt;<br>
&gt;&gt; *The cause of this issue: *<br>
&gt;&gt;<br>
&gt;&gt; both adb reverse and lttng relayd need binding to the socket which=
 is<br>
&gt;&gt; conflict with each other.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; So what I wanna ask is, for embedded system use cases, do we have<=
br>
&gt;&gt; successful use cases among team that could stream the trace data i=
n live<br>
&gt;&gt; mode to the host with usb based adb? If not, any idea or suggestio=
n to<br>
&gt;&gt; me on how to process forward?<br>
&gt;&gt;<br>
&gt;&gt; Amanda<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; lttng-dev mailing list<br>
&gt;&gt; lttng-dev@lists.lttng.org<br>
&gt;&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-=
dev">https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>
&gt; &lt;<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-=
dev">https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a>&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; lttng-dev@lists.lttng.org<br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
>https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>
<br>
--<br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
<a href=3D"https://www.efficios.com">https://www.efficios.com</a><br>
<br>
</div>
</span></font>
</body>
</html>

--_000_9c0522c7090b4523aac4166a232ca50aamazoncom_--

--===============2710909978227420475==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2710909978227420475==--
