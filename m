Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C02CCEE14D8
	for <lttng-dev@archiver.kernel.org>; Sun, 10 Sep 2023 14:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1694355519;
	bh=pnz3qnOBY69xGNZGz5H0DEzNQkHO0SiBkdX9UzaqpJ8=;
	h=To:Date:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=ROymS+4PIKwk264eZs720hy1b5BZ4jnwgSLMshcTF298QgMt14fAflckYX/pX9Khm
	 5Nt1AjaN/O79o1n0nwx7M6j7RFIX9Qnqq8LVENUxCJ/TLbpR0SpXBA8H4kw2ERtWcX
	 DdTicwJK+XXy8bSzess4kc8Ndk6EHqTHRdo/5W3/cSn+iHRpQxp2fpP9y+TxI1FleS
	 FVo5okBMzw2UG31OX/q9325nRs5Ho7jiGkuRP44ydWSPpAlxy+wu82RH/knlkoMb7K
	 XogvoqQVHTaiHf5aqDirZjBcyjkvruQBWG3Z5S37sNpS+rSupLfTdjMvy7vCrDp0xq
	 9Ciwwn3NSWK8A==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4RkBly4T50z2XS4;
	Sun, 10 Sep 2023 10:18:38 -0400 (EDT)
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com
 [52.119.213.152])
 by lists.lttng.org (Postfix) with ESMTPS id 4RkBlx2VGCz2XS2
 for <lttng-dev@lists.lttng.org>; Sun, 10 Sep 2023 10:18:37 -0400 (EDT)
X-IronPort-AV: E=Sophos;i="6.02,241,1688428800"; 
 d="scan'208,217";a="607047031"
Thread-Topic: [lttng-dev] Profiling LTTng tracepoint latency on different arm
 platforms
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-iad-1a-m6i4x-bbc6e425.us-east-1.amazon.com) ([10.43.8.6])
 by smtp-border-fw-52003.iad7.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2023 14:18:35 +0000
Received: from EX19D011EUA003.ant.amazon.com
 (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
 by email-inbound-relay-iad-1a-m6i4x-bbc6e425.us-east-1.amazon.com (Postfix)
 with ESMTPS id AECB48069E; Sun, 10 Sep 2023 14:18:32 +0000 (UTC)
Received: from EX19D007EUA001.ant.amazon.com (10.252.50.133) by
 EX19D011EUA003.ant.amazon.com (10.252.50.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Sun, 10 Sep 2023 14:18:32 +0000
Received: from EX19D008EUC001.ant.amazon.com (10.252.51.165) by
 EX19D007EUA001.ant.amazon.com (10.252.50.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Sun, 10 Sep 2023 14:18:31 +0000
Received: from EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1]) by
 EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1%3]) with
 mapi id 15.02.1118.037; Sun, 10 Sep 2023 14:18:31 +0000
To: "Yitschak, Yehuda" <yehuday@amazon.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "lttng-dev@lists.lttng.org"
 <lttng-dev@lists.lttng.org>
Thread-Index: AQHZo2HEplRT2zY9N0ijivZSO5DOOK+TvfwAgAA+SACAAMJ3gIAAiEyAgAAJk4CAf0qKPw==
Date: Sun, 10 Sep 2023 14:18:31 +0000
Message-ID: <e658fc7033fd4a268dc9890093de6807@amazon.com>
References: <6e06b605ec9f446da5dc8948c8621518@amazon.com>
 <63288a1f-59b4-80f9-2a26-bc252ce9cd1f@efficios.com>
 <900fe19a-5642-9124-4d83-0716e0d11a22@efficios.com>
 <bb2ccac8e296450c96d0863937fc8db8@amazon.com>
 <fb397173-040c-9370-c6c7-3c7b1535becb@efficios.com>,
 <618d035e059840d3a32b75633aa378f5@amazon.com>
In-Reply-To: <618d035e059840d3a32b75633aa378f5@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.213.27]
MIME-Version: 1.0
Subject: Re: [lttng-dev] Profiling LTTng tracepoint latency on different arm
 platforms
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
From: "Mousa, Anas via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "Mousa, Anas" <anasmous@amazon.com>
Content-Type: multipart/mixed; boundary="===============6824250047945973309=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============6824250047945973309==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_e658fc7033fd4a268dc9890093de6807amazoncom_"

--_000_e658fc7033fd4a268dc9890093de6807amazoncom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hey Mathieu,

We see that upon recording a tracepoint, there are multiple stages of reser=
ve-commit-write,

where atomics and shared memory accesses take up a big part of the recordin=
g time,

we're wondering, is there a "light-mode" of recording a tracepoint involvin=
g less logic or

a mode which can potentially have lower latency?


Also, are there any recent docs to share regarding tracepoint latency?


Regards,

Anas.


________________________________
From: Yitschak, Yehuda
Sent: Wednesday, June 21, 2023 5:21:35 PM
To: Mathieu Desnoyers; Mousa, Anas; lttng-dev@lists.lttng.org
Subject: RE: [EXTERNAL][lttng-dev] Profiling LTTng tracepoint latency on di=
fferent arm platforms


> On 6/21/23 01:39, Yitschak, Yehuda wrote:
> >> On 6/20/23 10:20, Mathieu Desnoyers via lttng-dev wrote:
> >>> On 6/20/23 06:27, Mousa, Anas via lttng-dev wrote:
> >>>> Hello,
> >>>
> >>>>
> >>>>
> >>
> Arethereanysuggestionstorootcausethehighlatencyandpotentiallyimprovei
> >> to
> >> n*platform****1*?
> >>>>
> >>>> Thanks and best regards,
> >>>>
> >>>> Anas.
> >>>>
> >>>
> >>> I recommend using "perf" when tracing with the sample program in a
> >>> loop to figure out the hot spots. With that information on the "fast"
> >>> and "slow" system, we might be able to figure out what differs.
> >>>
> >>> Also, comparing the kernel configurations of the two systems can help=
.
> >>> Also comparing the glibc versions of the two systems would be relevan=
t.
> >>>
> >>
> >> Also make sure you benchmark the lttng "snapshot" mode [1] to make
> >> sure you don't run into a situation where the disk/network I/O
> >> throughput cannot cope with the generated event throughput, thus
> >> causing the ring buffer to discard events. This would therefore
> >> "speed up" tracing from the application perspective because
> >> discarding an event is faster than writing it to a ring buffer.
> >
> > You mean we should avoid the "discard" loss mode and use "overwrite"
> loss mode since discard mode can fake fast performance ?
>
> Yes. In addition to use "overwrite-when-buffer-full" mode, the "snapshot"
> session also ensures that no consumer daemon extracts the trace data
> (unless an explicit snapshot record is performed), which allows comparing
> the ring buffer producer performance with minimal noise.
>
> If you really want to benchmark the discard-when-buffer-full mode and the
> the consumer daemon I/O behavior, then you need to take into account
> event discarded counts and the actual trace data size that was written to
> disk.

Since you mentioned this, is there any "stat" command which lists events su=
ch as discards and disk writes, etc ?
I looked this up in the past but couldn't find anything

>
> Thanks,
>
> Mathieu
>
> >
> >>
> >> Thanks,
> >>
> >> Mathieu
> >>
> >> [1] https://lttng.org/docs/v2.13/#doc-taking-a-snapshot
> >>
> >>> Thanks,
> >>>
> >>> Mathieu
> >>>
> >>>
> >>
> >> --
> >> Mathieu Desnoyers
> >> EfficiOS Inc.
> >> https://www.efficios.com
> >>
> >> _______________________________________________
> >> lttng-dev mailing list
> >> lttng-dev@lists.lttng.org
> >> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com


--_000_e658fc7033fd4a268dc9890093de6807amazoncom_
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
<p></p>
<p style=3D"font-family:Calibri,Helvetica,sans-serif,EmojiFont,&quot;Apple =
Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe UI =
Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols; font-size:16px">
Hey Mathieu,</p>
<p style=3D"font-family:Calibri,Helvetica,sans-serif,EmojiFont,&quot;Apple =
Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe UI =
Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols; font-size:16px">
We see that upon recording a tracepoint, there are multiple stages of reser=
ve-commit-write,</p>
<p style=3D"font-family:Calibri,Helvetica,sans-serif,EmojiFont,&quot;Apple =
Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe UI =
Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols; font-size:16px">
where atomics and shared memory accesses take up a big part of the recordin=
g time,</p>
<p style=3D"font-family:Calibri,Helvetica,sans-serif,EmojiFont,&quot;Apple =
Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe UI =
Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols; font-size:16px">
we're wondering, is there a &quot;light-mode&quot; of recording a tracepoin=
t involving less logic or</p>
<p style=3D"font-family:Calibri,Helvetica,sans-serif,EmojiFont,&quot;Apple =
Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe UI =
Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols; font-size:16px">
a mode which can potentially have lower latency?</p>
<p style=3D"font-family:Calibri,Helvetica,sans-serif,EmojiFont,&quot;Apple =
Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe UI =
Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols; font-size:16px">
<br>
</p>
<p style=3D"font-family:Calibri,Helvetica,sans-serif,EmojiFont,&quot;Apple =
Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe UI =
Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols; font-size:16px">
Also, are there any recent&nbsp;docs to share regarding&nbsp;tracepoint lat=
ency?</p>
<p style=3D"font-family:Calibri,Helvetica,sans-serif,EmojiFont,&quot;Apple =
Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe UI =
Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols; font-size:16px">
<br>
</p>
<p style=3D"font-family:Calibri,Helvetica,sans-serif,EmojiFont,&quot;Apple =
Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe UI =
Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols; font-size:16px">
Regards,</p>
<p style=3D"font-family:Calibri,Helvetica,sans-serif,EmojiFont,&quot;Apple =
Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe UI =
Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols; font-size:16px">
Anas.</p>
<br>
<p></p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Yitschak, Yehuda<br=
>
<b>Sent:</b> Wednesday, June 21, 2023 5:21:35 PM<br>
<b>To:</b> Mathieu Desnoyers; Mousa, Anas; lttng-dev@lists.lttng.org<br>
<b>Subject:</b> RE: [EXTERNAL][lttng-dev] Profiling LTTng tracepoint latenc=
y on different arm platforms</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText"><br>
&gt; On 6/21/23 01:39, Yitschak, Yehuda wrote:<br>
&gt; &gt;&gt; On 6/20/23 10:20, Mathieu Desnoyers via lttng-dev wrote:<br>
&gt; &gt;&gt;&gt; On 6/20/23 06:27, Mousa, Anas via lttng-dev wrote:<br>
&gt; &gt;&gt;&gt;&gt; Hello,<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; Arethereanysuggestionstorootcausethehighlatencyandpotentiallyimprovei<=
br>
&gt; &gt;&gt; to<br>
&gt; &gt;&gt; n*platform****1*?<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; Thanks and best regards,<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; Anas.<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; I recommend using &quot;perf&quot; when tracing with the =
sample program in a<br>
&gt; &gt;&gt;&gt; loop to figure out the hot spots. With that information o=
n the &quot;fast&quot;<br>
&gt; &gt;&gt;&gt; and &quot;slow&quot; system, we might be able to figure o=
ut what differs.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Also, comparing the kernel configurations of the two syst=
ems can help.<br>
&gt; &gt;&gt;&gt; Also comparing the glibc versions of the two systems woul=
d be relevant.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Also make sure you benchmark the lttng &quot;snapshot&quot; m=
ode [1] to make<br>
&gt; &gt;&gt; sure you don't run into a situation where the disk/network I/=
O<br>
&gt; &gt;&gt; throughput cannot cope with the generated event throughput, t=
hus<br>
&gt; &gt;&gt; causing the ring buffer to discard events. This would therefo=
re<br>
&gt; &gt;&gt; &quot;speed up&quot; tracing from the application perspective=
 because<br>
&gt; &gt;&gt; discarding an event is faster than writing it to a ring buffe=
r.<br>
&gt; &gt;<br>
&gt; &gt; You mean we should avoid the &quot;discard&quot; loss mode and us=
e &quot;overwrite&quot;<br>
&gt; loss mode since discard mode can fake fast performance ?<br>
&gt; <br>
&gt; Yes. In addition to use &quot;overwrite-when-buffer-full&quot; mode, t=
he &quot;snapshot&quot;<br>
&gt; session also ensures that no consumer daemon extracts the trace data<b=
r>
&gt; (unless an explicit snapshot record is performed), which allows compar=
ing<br>
&gt; the ring buffer producer performance with minimal noise.<br>
&gt; <br>
&gt; If you really want to benchmark the discard-when-buffer-full mode and =
the<br>
&gt; the consumer daemon I/O behavior, then you need to take into account<b=
r>
&gt; event discarded counts and the actual trace data size that was written=
 to<br>
&gt; disk.<br>
<br>
Since you mentioned this, is there any &quot;stat&quot; command which lists=
 events such as discards and disk writes, etc ?
<br>
I looked this up in the past but couldn't find anything<br>
<br>
&gt; <br>
&gt; Thanks,<br>
&gt; <br>
&gt; Mathieu<br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Thanks,<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Mathieu<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; [1] <a href=3D"https://lttng.org/docs/v2.13/#doc-taking-a-sna=
pshot">https://lttng.org/docs/v2.13/#doc-taking-a-snapshot</a><br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt; Thanks,<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Mathieu<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; --<br>
&gt; &gt;&gt; Mathieu Desnoyers<br>
&gt; &gt;&gt; EfficiOS Inc.<br>
&gt; &gt;&gt; <a href=3D"https://www.efficios.com">https://www.efficios.com=
</a><br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; _______________________________________________<br>
&gt; &gt;&gt; lttng-dev mailing list<br>
&gt; &gt;&gt; lttng-dev@lists.lttng.org<br>
&gt; &gt;&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/l=
ttng-dev">https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br=
>
&gt; <br>
&gt; --<br>
&gt; Mathieu Desnoyers<br>
&gt; EfficiOS Inc.<br>
&gt; <a href=3D"https://www.efficios.com">https://www.efficios.com</a><br>
<br>
</div>
</span></font>
</body>
</html>

--_000_e658fc7033fd4a268dc9890093de6807amazoncom_--

--===============6824250047945973309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6824250047945973309==--
