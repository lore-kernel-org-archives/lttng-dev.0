Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70736C25B74
	for <lttng-dev@archiver.kernel.org>; Thu, 30 May 2024 05:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1717048394;
	bh=kYQNlpED4JGQXqp101BAoMBdXIIBi5D+pergpsJdNZE=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=y8FAPJnsKa25Jmt9dFFYfkW8oKDj+jEPxptdIM2Dty9YPiRPRC+w/yBwcUlZb/wEn
	 GEXiXn+ggnAvoydohNeCwMHhysId1Xd9A1pQ7VOq9HNyWr6UOl/aymZnVnu8eXO0zm
	 hz6oCnMnPTT5Npc2zCK7bR9jGoCJf59MxlEvo2uOVG2rtxNZtClnv6Xk+09D+cBvy3
	 Z9U3AXOPPRkzBbkTaXme8yH5B7PFRliBuykIRRRCblZ45rzptBpEGrKq3sp7AYqbZd
	 5I7MKvUfrz1+4193+BI2m+WSYAop1F2YEMBh0LID2XSzz+1pcawfk4HmmiRssZG3PP
	 6UueArJX5J/xg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Vqb5P3qlwz2rWy;
	Thu, 30 May 2024 01:53:13 -0400 (EDT)
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com
 [99.78.197.219])
 by lists.lttng.org (Postfix) with ESMTPS id 4Vqb5L666mz2rkp
 for <lttng-dev@lists.lttng.org>; Thu, 30 May 2024 01:53:10 -0400 (EDT)
X-IronPort-AV: E=Sophos;i="6.08,199,1712620800"; d="scan'208,217";a="92865310"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
 by smtp-border-fw-80008.pdx80.corp.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 05:53:07 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:58030]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.143:2525]
 with esmtp (Farcaster)
 id c62057e2-328f-44c5-8b3a-a524fd8ae1f4; Thu, 30 May 2024 05:53:07 +0000 (UTC)
X-Farcaster-Flow-ID: c62057e2-328f-44c5-8b3a-a524fd8ae1f4
Received: from EX19D003ANC004.ant.amazon.com (10.37.240.207) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 30 May 2024 05:53:06 +0000
Received: from EX19D003ANC001.ant.amazon.com (10.37.240.216) by
 EX19D003ANC004.ant.amazon.com (10.37.240.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Thu, 30 May 2024 05:53:05 +0000
Received: from EX19D003ANC001.ant.amazon.com ([fe80::ed4e:7258:fa8c:17e8]) by
 EX19D003ANC001.ant.amazon.com ([fe80::ed4e:7258:fa8c:17e8%5]) with
 mapi id 15.02.1258.028; Thu, 30 May 2024 05:53:05 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: [lttng-relayd] is there existing cases for relayd to stream over
 Android usb based adb?
Thread-Index: AQHaslKH7CI0j5/u4E6iXx4NZ5jN4Q==
Date: Thu, 30 May 2024 05:53:05 +0000
Message-ID: <b2e9c32fbcbe4067a64fd831bac70d81@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.135.234.192]
MIME-Version: 1.0
Subject: [lttng-dev] [lttng-relayd] is there existing cases for relayd to
 stream over Android usb based adb?
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
Content-Type: multipart/mixed; boundary="===============0304910612282499374=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============0304910612282499374==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_b2e9c32fbcbe4067a64fd831bac70d81amazoncom_"

--_000_b2e9c32fbcbe4067a64fd831bac70d81amazoncom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hihi, there,

I am currently working on enabling lttng live mode over android usb adb. He=
re is the situation, during debugging some network related issues, we dont =
want the trace data to be streamed via network to cause extra load to the s=
ystem being profiled. Then we select to connect lttng-relayd with adb via p=
ort forwarding so that the data is "forward" to the host.

Here is the set up and the problem:

for the device:  adb reverse tcp:5342 tcp:5342; adb reverse tcp:5343 tcp:53=
43; adb reverse tcp:5344 tcp:5344
Then starting up lttng with --live enabled.

What is expected:
lttng start streaming to the localhost.
What is seen:
the lttng-relayd failed to start. For unable binding to the socket.

The cause of this issue:

both adb reverse and lttng relayd need binding to the socket which is confl=
ict with each other.


So what I wanna ask is, for embedded system use cases, do we have successfu=
l use cases among team that could stream the trace data in live mode to the=
 host with usb based adb? If not, any idea or suggestion to me on how to pr=
ocess forward?

Amanda




--_000_b2e9c32fbcbe4067a64fd831bac70d81amazoncom_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p>Hihi, there,</p>
<p>I am currently working on enabling lttng live mode over android usb adb.=
 Here is the situation, during debugging some network related issues, we do=
nt want the trace data to be streamed via network to cause extra load to th=
e system being profiled. Then we
 select to connect lttng-relayd with adb via port forwarding so that the da=
ta is &quot;forward&quot; to the host.</p>
<p><b>Here is the set up and the problem:</b></p>
<p>for the device:&nbsp; adb reverse tcp:5342 tcp:5342;&nbsp;<span>adb reve=
rse tcp:5343 tcp:5343</span>;&nbsp;<span>adb reverse tcp:5344 tcp:5344</spa=
n><br>
Then starting up lttng with --live enabled.</p>
<p><b>What is expected:</b><br>
lttng start streaming to the localhost.<br>
<b>What is seen: </b><span><br>
the lttng-relayd failed to start. </span>For unable binding to the socket.<=
/p>
<p><b>The cause of this issue: </b><br>
</p>
<p>both adb reverse and lttng relayd need binding to the socket which is co=
nflict with each other.</p>
<p><br>
</p>
<p>So what I wanna ask is, for embedded system use cases, do we have succes=
sful use cases among team that could stream the trace data in live mode to =
the host with usb based adb? If not, any idea or suggestion to me on how to=
 process forward?<br>
</p>
<p>Amanda<br>
</p>
<p><br>
</p>
<p><br>
</p>
<p><br>
</p>
</div>
</body>
</html>

--_000_b2e9c32fbcbe4067a64fd831bac70d81amazoncom_--

--===============0304910612282499374==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0304910612282499374==--
