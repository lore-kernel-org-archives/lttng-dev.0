Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D5EEB64DB
	for <lttng-dev@archiver.kernel.org>; Tue, 20 Jun 2023 10:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1687256479;
	bh=otGtXNlyqQdfo+sr2IORUS+TbEs/OYMvTT756qJsh/A=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=aQE6wBQpv1gdRRXOfz3xF+z8K8cIIeOV8GsaaoTyANhDB8dTEF67asj+nVQCjATmU
	 uDe1LW2WhGh23jC8WOwf/nMZwVadzkviDueEu0o5ZRCMiVm0kEVbDxx8kcgQpvWsen
	 fSt20StuXapd9+uuigBCFpDGPdDGSovXyRcTbYJmex9/uRg/gP4ZGL0BFYLQXgYps7
	 mzx3gRk+JwRim33xsuItSV5JW9neZMK0aurtRRenAqPr0kvqANM3iysQjGn0yQl9gU
	 7+pBs301+dAYp9kZkpiLL96msZ4cBROQ3TlXTchNqZ4pYUC5ENPk3m3v8/xsk0KqXF
	 tQv4IMOjynQHA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QljMy3cSGz1yBx;
	Tue, 20 Jun 2023 06:21:18 -0400 (EDT)
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com
 [52.119.213.150])
 by lists.lttng.org (Postfix) with ESMTPS id 4QljMw3qclz1yDM
 for <lttng-dev@lists.lttng.org>; Tue, 20 Jun 2023 06:21:16 -0400 (EDT)
X-IronPort-AV: E=Sophos;i="6.00,256,1681171200"; 
 d="scan'208,217";a="567554695"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-pdx-2b-m6i4x-a893d89c.us-west-2.amazon.com) ([10.43.8.6])
 by smtp-border-fw-52002.iad7.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 10:21:13 +0000
Received: from EX19D008EUC001.ant.amazon.com
 (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
 by email-inbound-relay-pdx-2b-m6i4x-a893d89c.us-west-2.amazon.com (Postfix)
 with ESMTPS id 88B3140D4C
 for <lttng-dev@lists.lttng.org>; Tue, 20 Jun 2023 10:21:11 +0000 (UTC)
Received: from EX19D008EUC001.ant.amazon.com (10.252.51.165) by
 EX19D008EUC001.ant.amazon.com (10.252.51.165) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.26;
 Tue, 20 Jun 2023 10:21:10 +0000
Received: from EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1]) by
 EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1%3]) with
 mapi id 15.02.1118.026; Tue, 20 Jun 2023 10:21:10 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Index: AQHZo1of9E6kcCAeVUyScQoTVjxCgw==
Date: Tue, 20 Jun 2023 10:21:10 +0000
Message-ID: <1255477015ae4da8a6523b5d204334da@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.85.143.172]
MIME-Version: 1.0
Subject: [lttng-dev] (no subject)
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
Content-Type: multipart/mixed; boundary="===============0369875271704751774=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============0369875271704751774==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_1255477015ae4da8a6523b5d204334daamazoncom_"

--_000_1255477015ae4da8a6523b5d204334daamazoncom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

I've recently profiled the latency of LTTng tracepoints on arm platforms,

using the follow sample program:

---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
----------------------------

static inline uint64_t get_time_nsec(void)

{

        struct timespec ts;

        if (caa_unlikely(clock_gettime(CLOCK_MONOTONIC, &ts))) {

                ts.tv_sec =3D 0;

                ts.tv_nsec =3D 0;

        }

        return ((uint64_t) ts.tv_sec * 1000000000ULL) + ts.tv_nsec;

}


int main(int argc, char *argv[])

{

    unsigned int i;

    int tp_num =3D 0;

    uint64_t total_time =3D 0;

    uint64_t now, nowz;

    if (argc > 1) {

        sscanf (argv[1],"%d",&tp_num);

    }

    for (i =3D 0; i < tp_num; i++) {

        now =3D get_time_nsec();

        lttng_ust_tracepoint(hello_world, my_first_tracepoint,

                             i, "some_str");

        nowz =3D get_time_nsec();

        total_time +=3D (nowz - now);

    }

    if (tp_num) {

        printf("---------------------------Average TP time is %"PRIu64"----=
-----------------------\n", total_time / tp_num);

    }

}

---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
----------------------------


I observed a big average latency variance on different platforms when traci=
ng a high number (many thousands to millions) of tracepoints:

  *   [platform 1] with CPU info running a linux kernel based on Buildroot =
(4.19.273 aarch64 GNU/Linux):

BogoMIPS        : 187.50

Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid

CPU implementer : 0x41

CPU architecture: 8

CPU variant     : 0x0

CPU part        : 0xd08

CPU revision    : 3

  *    Saw an average latency of 2-3usec


  *   [platform 2] with CPU info running a linux kernel based on Amazon Lin=
ux (4.14.294-220.533.amzn2.aarch64 aarch64 GNU/Linux):

BogoMIPS        : 243.75

Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp a=
simdhp cpuid asimdrdm lrcpc dcpop asimddp ssbs

CPU implementer : 0x41

CPU architecture: 8

CPU variant     : 0x3

CPU part        : 0xd0c

CPU revision    : 1

  *   Saw an average latency of ~0.5usec



Are there any suggestions to root cause the high latency and potentially im=
prove it on platform 1?


Thanks and best regards,

Anas.


--_000_1255477015ae4da8a6523b5d204334daamazoncom_
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
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size: 12pt; colo=
r: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-serif, EmojiFont, &q=
uot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &q=
uot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;">
<p></p>
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x">
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-=
serif; font-size:14pt; color:rgb(0,0,0)">Hello</span><span style=3D"font-fa=
mily:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)">,</spa=
n></pre>
</div>
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x">
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14pt;=
 color:rgb(0,0,0)"></span></pre>
</div>
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x">
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-=
serif; font-size:14pt; color:rgb(0,0,0)">I</span><span class=3D"cm-string" =
style=3D"color:rgb(0,0,0); font-family:Calibri,Helvetica,sans-serif; font-s=
ize:14pt">'ve recently profiled the latency of LTTng tracepoints on arm pla=
tforms,</span></pre>
</div>
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x">
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span class=3D"cm-keyword" style=3D"color:rgb(0,0,0); font-family:Calibr=
i,Helvetica,sans-serif; font-size:14pt">using</span><span style=3D"font-fam=
ily:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span=
><span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-se=
rif; font-size:14pt; color:rgb(0,0,0)">the</span><span style=3D"font-family=
:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><s=
pan class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif=
; font-size:14pt; color:rgb(0,0,0)">follow</span><span style=3D"font-family=
:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><s=
pan class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif=
; font-size:14pt; color:rgb(0,0,0)">sample</span><span style=3D"font-family=
:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><s=
pan class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif=
; font-size:14pt; color:rgb(0,0,0)">program</span><span style=3D"font-famil=
y:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)">:</span><=
/pre>
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);"></span></pre>
</div>
<div style=3D"counter-increment: snippet 1; margin-left: 32px; padding: 0px=
 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; font-s=
ize: inherit; line-height: inherit; tab-size: 4; word-break: normal; font-f=
amily: inherit; border-width: 0px; border-radius: 0px; color: inherit; over=
flow: visible;"><span style=3D"font-size: 12pt;">--------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
--</span></pre>
</div>
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x">
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><b><span class=3D"cm-keyword" style=3D"color: rgb(0, 0, 0); font-family:=
 Calibri, Helvetica, sans-serif; font-size: 12pt;">static</span><span style=
=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rg=
b(0, 0, 0);"> </span><span class=3D"cm-keyword" style=3D"color: rgb(0, 0, 0=
); font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;">inline</s=
pan><span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);"> </span><span class=3D"cm-type" style=3D"color:=
 rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-serif; font-size: 12pt=
;">uint64_t</span><span style=3D"font-family: Calibri, Helvetica, sans-seri=
f; font-size: 12pt; color: rgb(0, 0, 0);"> </span><span class=3D"cm-def" st=
yle=3D"color: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt;">get_time_nsec</span><span style=3D"font-family: Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">(</span><span c=
lass=3D"cm-type" style=3D"color: rgb(0, 0, 0); font-family: Calibri, Helvet=
ica, sans-serif; font-size: 12pt;">void</span><span style=3D"font-family: C=
alibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">)</sp=
an></b></pre>
<span style=3D"font-size: 12pt;"></span></div>
<span style=3D"font-size: 12pt;"></span>
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x"><span style=3D"font-size: 12pt;"></span>
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14pt;=
 color:rgb(0,0,0)"><b><span style=3D"font-size: 12pt;">{</span></b></span><=
/pre>
<span style=3D"font-size: 12pt;"></span></div>
<span style=3D"font-size: 12pt;"></span>
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x"><span style=3D"font-size: 12pt;"></span>
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><b><span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">	</span><span class=3D"cm-keyword" style=3D"c=
olor: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-serif; font-size:=
 12pt;">struct</span><span style=3D"font-family: Calibri, Helvetica, sans-s=
erif; font-size: 12pt; color: rgb(0, 0, 0);"> </span><span class=3D"cm-def"=
 style=3D"color: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-serif;=
 font-size: 12pt;">timespec</span><span style=3D"font-family: Calibri, Helv=
etica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"> </span><span cla=
ss=3D"cm-def" style=3D"color: rgb(0, 0, 0); font-family: Calibri, Helvetica=
, sans-serif; font-size: 12pt;">ts</span><span style=3D"font-family: Calibr=
i, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">;</span></=
b></pre>
<span style=3D"font-size: 12pt;"></span></div>
<span style=3D"font-size: 12pt;"></span>
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x"><span style=3D"font-size: 12pt;"></span>
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14pt;=
 color:rgb(0,0,0)"><b></b></span></pre>
<span style=3D"font-size: 12pt;"></span></div>
<span style=3D"font-size: 12pt;"></span>
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x"><span style=3D"font-size: 12pt;"></span>
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><b><span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">	</span><span class=3D"cm-keyword" style=3D"c=
olor: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-serif; font-size:=
 12pt;">if</span><span style=3D"font-family: Calibri, Helvetica, sans-serif=
; font-size: 12pt; color: rgb(0, 0, 0);"> (</span><span class=3D"cm-variabl=
e" style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">caa_unlikely</span><span style=3D"font-family: Calibri=
, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">(</span><sp=
an class=3D"cm-variable" style=3D"font-family: Calibri, Helvetica, sans-ser=
if; font-size: 12pt; color: rgb(0, 0, 0);">clock_gettime</span><span style=
=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rg=
b(0, 0, 0);">(</span><span class=3D"cm-variable" style=3D"font-family: Cali=
bri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">CLOCK_MO=
NOTONIC</span><span style=3D"font-family: Calibri, Helvetica, sans-serif; f=
ont-size: 12pt; color: rgb(0, 0, 0);">, </span><span class=3D"cm-operator" =
style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; colo=
r: rgb(0, 0, 0);">&amp;</span><span class=3D"cm-variable" style=3D"font-fam=
ily: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"=
>ts</span><span style=3D"font-family: Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">))) {</span></b></pre>
<span style=3D"font-size: 12pt;"></span></div>
<span style=3D"font-size: 12pt;"></span>
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x"><span style=3D"font-size: 12pt;"></span>
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><b><span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">		</span><span class=3D"cm-variable" style=3D=
"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">ts</span><span style=3D"font-family: Calibri, Helvetica, sans-ser=
if; font-size: 12pt; color: rgb(0, 0, 0);">.</span><span class=3D"cm-variab=
le" style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; =
color: rgb(0, 0, 0);">tv_sec</span><span style=3D"font-family: Calibri, Hel=
vetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"> </span><span cl=
ass=3D"cm-operator" style=3D"font-family: Calibri, Helvetica, sans-serif; f=
ont-size: 12pt; color: rgb(0, 0, 0);">=3D</span><span style=3D"font-family:=
 Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"> </=
span><span class=3D"cm-number" style=3D"color: rgb(0, 0, 0); font-family: C=
alibri, Helvetica, sans-serif; font-size: 12pt;">0</span><span style=3D"fon=
t-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0,=
 0);">;</span></b></pre>
<span style=3D"font-size: 12pt;"></span></div>
<span style=3D"font-size: 12pt;"></span>
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x"><span style=3D"font-size: 12pt;"></span>
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><b><span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">		</span><span class=3D"cm-variable" style=3D=
"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">ts</span><span style=3D"font-family: Calibri, Helvetica, sans-ser=
if; font-size: 12pt; color: rgb(0, 0, 0);">.</span><span class=3D"cm-variab=
le" style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; =
color: rgb(0, 0, 0);">tv_nsec</span><span style=3D"font-family: Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"> </span><span c=
lass=3D"cm-operator" style=3D"font-family: Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: rgb(0, 0, 0);">=3D</span><span style=3D"font-family=
: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"> <=
/span><span class=3D"cm-number" style=3D"color: rgb(0, 0, 0); font-family: =
Calibri, Helvetica, sans-serif; font-size: 12pt;">0</span><span style=3D"fo=
nt-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0=
, 0);">;</span></b></pre>
<span style=3D"font-size: 12pt;"></span></div>
<span style=3D"font-size: 12pt;"></span>
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x"><span style=3D"font-size: 12pt;"></span>
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14pt;=
 color:rgb(0,0,0)"><b><span style=3D"font-size: 12pt;">	}</span></b></span>=
</pre>
<span style=3D"font-size: 12pt;"></span></div>
<span style=3D"font-size: 12pt;"></span>
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x"><span style=3D"font-size: 12pt;"></span>
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><b><span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">	</span><span class=3D"cm-keyword" style=3D"c=
olor: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-serif; font-size:=
 12pt;">return</span><span style=3D"font-family: Calibri, Helvetica, sans-s=
erif; font-size: 12pt; color: rgb(0, 0, 0);"> ((</span><span class=3D"cm-ty=
pe" style=3D"color: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-ser=
if; font-size: 12pt;">uint64_t</span><span style=3D"font-family: Calibri, H=
elvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">) </span><span=
 class=3D"cm-variable" style=3D"font-family: Calibri, Helvetica, sans-serif=
; font-size: 12pt; color: rgb(0, 0, 0);">ts</span><span style=3D"font-famil=
y: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">.=
</span><span class=3D"cm-variable" style=3D"font-family: Calibri, Helvetica=
, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">tv_sec</span><span sty=
le=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color: =
rgb(0, 0, 0);"> </span><span class=3D"cm-operator" style=3D"font-family: Ca=
libri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">*</spa=
n><span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12=
pt; color: rgb(0, 0, 0);"> </span><span class=3D"cm-number" style=3D"color:=
 rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-serif; font-size: 12pt=
;">1000000000ULL</span><span style=3D"font-family: Calibri, Helvetica, sans=
-serif; font-size: 12pt; color: rgb(0, 0, 0);">) </span><span class=3D"cm-o=
perator" style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);">&#43;</span><span style=3D"font-family: Calibri,=
 Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"> </span><spa=
n class=3D"cm-variable" style=3D"font-family: Calibri, Helvetica, sans-seri=
f; font-size: 12pt; color: rgb(0, 0, 0);">ts</span><span style=3D"font-fami=
ly: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">=
.</span><span class=3D"cm-variable" style=3D"font-family: Calibri, Helvetic=
a, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">tv_nsec</span><span s=
tyle=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color=
: rgb(0, 0, 0);">;</span></b></pre>
<span style=3D"font-size: 12pt;"></span></div>
<span style=3D"font-size: 12pt;"></span>
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x"><span style=3D"font-size: 12pt;"></span>
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14pt;=
 color:rgb(0,0,0)"><b><span style=3D"font-size: 12pt;">}</span></b></span><=
/pre>
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14pt;=
 color:rgb(0,0,0)"><b><span style=3D"font-size: 12pt;"><br></span></b></spa=
n></pre>
<span style=3D"font-size: 12pt;"></span></div>
<span style=3D"font-size: 12pt;"></span>
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x"><span style=3D"font-size: 12pt;"></span>
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14pt;=
 color:rgb(0,0,0)"><b></b></span></pre>
<span style=3D"font-size: 12pt;"></span></div>
<span style=3D"font-size: 12pt;"></span>
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x"><span style=3D"font-size: 12pt;"></span>
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><b><span class=3D"cm-type" style=3D"color: rgb(0, 0, 0); font-family: Ca=
libri, Helvetica, sans-serif; font-size: 12pt;">int</span><span style=3D"fo=
nt-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0=
, 0);"> </span><span class=3D"cm-def" style=3D"color: rgb(0, 0, 0); font-fa=
mily: Calibri, Helvetica, sans-serif; font-size: 12pt;">main</span><span st=
yle=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color:=
 rgb(0, 0, 0);">(</span><span class=3D"cm-type" style=3D"color: rgb(0, 0, 0=
); font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;">int</span=
><span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12p=
t; color: rgb(0, 0, 0);"> </span><span class=3D"cm-variable" style=3D"font-=
family: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0=
);">argc</span><span style=3D"font-family: Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: rgb(0, 0, 0);">, </span><span class=3D"cm-type" sty=
le=3D"color: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-serif; fon=
t-size: 12pt;">char</span><span style=3D"font-family: Calibri, Helvetica, s=
ans-serif; font-size: 12pt; color: rgb(0, 0, 0);"> </span><span class=3D"cm=
-type" style=3D"color: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-=
serif; font-size: 12pt;">*</span><span class=3D"cm-variable" style=3D"font-=
family: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0=
);">argv</span><span style=3D"font-family: Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: rgb(0, 0, 0);">[])</span></b></pre>
<span style=3D"font-size: 12pt;"></span></div>
<span style=3D"font-size: 12pt;"></span>
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x"><span style=3D"font-size: 12pt;"></span>
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14pt;=
 color:rgb(0,0,0)"><b><span style=3D"font-size: 12pt;">{</span></b></span><=
/pre>
<span style=3D"font-size: 12pt;"></span></div>
<span style=3D"font-size: 12pt;"></span>
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x"><span style=3D"font-size: 12pt;"></span>
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><b><span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">    </span><span class=3D"cm-type" style=3D"c=
olor: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-serif; font-size:=
 12pt;">unsigned</span><span style=3D"font-family: Calibri, Helvetica, sans=
-serif; font-size: 12pt; color: rgb(0, 0, 0);"> </span><span class=3D"cm-ty=
pe" style=3D"color: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-ser=
if; font-size: 12pt;">int</span><span style=3D"font-family: Calibri, Helvet=
ica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"> </span><span class=
=3D"cm-variable" style=3D"font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">i</span><span style=3D"font-family: Cali=
bri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">;</span>=
</b></pre>
<span style=3D"font-size: 12pt;"></span></div>
<span style=3D"font-size: 12pt;"></span>
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x"><span style=3D"font-size: 12pt;"></span>
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><b><span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">    </span><span class=3D"cm-type" style=3D"c=
olor: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-serif; font-size:=
 12pt;">int</span><span style=3D"font-family: Calibri, Helvetica, sans-seri=
f; font-size: 12pt; color: rgb(0, 0, 0);"> </span><span class=3D"cm-variabl=
e" style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">tp_num</span><span style=3D"font-family: Calibri, Helv=
etica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"> </span><span cla=
ss=3D"cm-operator" style=3D"font-family: Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);">=3D</span><span style=3D"font-family: =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"> </s=
pan><span class=3D"cm-number" style=3D"color: rgb(0, 0, 0); font-family: Ca=
libri, Helvetica, sans-serif; font-size: 12pt;">0</span><span style=3D"font=
-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, =
0);">;</span></b></pre>
<span style=3D"font-size: 12pt;"></span></div>
<span style=3D"font-size: 12pt;"></span>
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x"><span style=3D"font-size: 12pt;"></span>
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><b><span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">    </span><span class=3D"cm-type" style=3D"c=
olor: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-serif; font-size:=
 12pt;">uint64_t</span><span style=3D"font-family: Calibri, Helvetica, sans=
-serif; font-size: 12pt; color: rgb(0, 0, 0);"> </span><span class=3D"cm-va=
riable" style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12=
pt; color: rgb(0, 0, 0);">total_time</span><span style=3D"font-family: Cali=
bri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"> </span>=
<span class=3D"cm-operator" style=3D"font-family: Calibri, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">=3D</span><span style=3D"font=
-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, =
0);"> </span><span class=3D"cm-number" style=3D"color: rgb(0, 0, 0); font-f=
amily: Calibri, Helvetica, sans-serif; font-size: 12pt;">0</span><span styl=
e=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color: r=
gb(0, 0, 0);">;</span></b></pre>
<span style=3D"font-size: 12pt;"></span></div>
<span style=3D"font-size: 12pt;"></span>
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x"><span style=3D"font-size: 12pt;"></span>
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><b><span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">    </span><span class=3D"cm-type" style=3D"c=
olor: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-serif; font-size:=
 12pt;">uint64_t</span><span style=3D"font-family: Calibri, Helvetica, sans=
-serif; font-size: 12pt; color: rgb(0, 0, 0);"> </span><span class=3D"cm-va=
riable" style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12=
pt; color: rgb(0, 0, 0);">now</span><span style=3D"font-family: Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">, </span><span =
class=3D"cm-variable" style=3D"font-family: Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">nowz</span><span style=3D"font-fami=
ly: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">=
;</span></b></pre>
<span style=3D"font-size: 12pt;"></span></div>
<span style=3D"font-size: 12pt;"></span>
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x"><span style=3D"font-size: 12pt;"></span>
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14pt;=
 color:rgb(0,0,0)"><b></b></span></pre>
<span style=3D"font-size: 12pt;"></span></div>
<span style=3D"font-size: 12pt;"></span>
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x"><span style=3D"font-size: 12pt;"></span>
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><b><span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">    </span><span class=3D"cm-keyword" style=
=3D"color: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-serif; font-=
size: 12pt;">if</span><span style=3D"font-family: Calibri, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);"> (</span><span class=3D"cm-va=
riable" style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12=
pt; color: rgb(0, 0, 0);">argc</span><span style=3D"font-family: Calibri, H=
elvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"> </span><span =
class=3D"cm-operator" style=3D"font-family: Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">&gt;</span><span style=3D"font-fami=
ly: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">=
 </span><span class=3D"cm-number" style=3D"color: rgb(0, 0, 0); font-family=
: Calibri, Helvetica, sans-serif; font-size: 12pt;">1</span><span style=3D"=
font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">) {</span></b></pre>
<span style=3D"font-size: 12pt;"></span></div>
<span style=3D"font-size: 12pt;"></span>
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x"><span style=3D"font-size: 12pt;"></span>
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><b><span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">        </span><span class=3D"cm-variable" st=
yle=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color:=
 rgb(0, 0, 0);">sscanf</span><span style=3D"font-family: Calibri, Helvetica=
, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"> (</span><span class=
=3D"cm-variable" style=3D"font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">argv</span><span style=3D"font-family: C=
alibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">[</sp=
an><span class=3D"cm-number" style=3D"color: rgb(0, 0, 0); font-family: Cal=
ibri, Helvetica, sans-serif; font-size: 12pt;">1</span><span style=3D"font-=
family: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0=
);">],</span><span class=3D"cm-string" style=3D"color: rgb(0, 0, 0); font-f=
amily: Calibri, Helvetica, sans-serif; font-size: 12pt;">&quot;%d&quot;</sp=
an><span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);">,</span><span class=3D"cm-operator" style=3D"fon=
t-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0,=
 0);">&amp;</span><span class=3D"cm-variable" style=3D"font-family: Calibri=
, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">tp_num</spa=
n><span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12=
pt; color: rgb(0, 0, 0);">);</span></b></pre>
<span style=3D"font-size: 12pt;"></span></div>
<span style=3D"font-size: 12pt;"></span>
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x"><span style=3D"font-size: 12pt;"></span>
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14pt;=
 color:rgb(0,0,0)"><b><span style=3D"font-size: 12pt;">    }</span></b></sp=
an></pre>
<span style=3D"font-size: 12pt;"></span></div>
<span style=3D"font-size: 12pt;"></span>
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x"><span style=3D"font-size: 12pt;"></span>
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><b><span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">    </span><span class=3D"cm-keyword" style=
=3D"color: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-serif; font-=
size: 12pt;">for</span><span style=3D"font-family: Calibri, Helvetica, sans=
-serif; font-size: 12pt; color: rgb(0, 0, 0);"> (</span><span class=3D"cm-v=
ariable" style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);">i</span><span style=3D"font-family: Calibri, Hel=
vetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"> </span><span cl=
ass=3D"cm-operator" style=3D"font-family: Calibri, Helvetica, sans-serif; f=
ont-size: 12pt; color: rgb(0, 0, 0);">=3D</span><span style=3D"font-family:=
 Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"> </=
span><span class=3D"cm-number" style=3D"color: rgb(0, 0, 0); font-family: C=
alibri, Helvetica, sans-serif; font-size: 12pt;">0</span><span style=3D"fon=
t-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0,=
 0);">; </span><span class=3D"cm-variable" style=3D"font-family: Calibri, H=
elvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">i</span><span =
style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; colo=
r: rgb(0, 0, 0);"> </span><span class=3D"cm-operator" style=3D"font-family:=
 Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">&lt=
;</span><span style=3D"font-family: Calibri, Helvetica, sans-serif; font-si=
ze: 12pt; color: rgb(0, 0, 0);"> </span><span class=3D"cm-variable" style=
=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rg=
b(0, 0, 0);">tp_num</span><span style=3D"font-family: Calibri, Helvetica, s=
ans-serif; font-size: 12pt; color: rgb(0, 0, 0);">; </span><span class=3D"c=
m-variable" style=3D"font-family: Calibri, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">i</span><span class=3D"cm-operator" style=3D"=
font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">&#43;&#43;</span><span style=3D"font-family: Calibri, Helvetica, s=
ans-serif; font-size: 12pt; color: rgb(0, 0, 0);">) {</span></b></pre>
<span style=3D"font-size: 12pt;"></span></div>
<span style=3D"font-size: 12pt;"></span>
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x"><span style=3D"font-size: 12pt;"></span>
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><b><span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">        </span><span class=3D"cm-variable" st=
yle=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color:=
 rgb(0, 0, 0);">now</span><span style=3D"font-family: Calibri, Helvetica, s=
ans-serif; font-size: 12pt; color: rgb(0, 0, 0);"> </span><span class=3D"cm=
-operator" style=3D"font-family: Calibri, Helvetica, sans-serif; font-size:=
 12pt; color: rgb(0, 0, 0);">=3D</span><span style=3D"font-family: Calibri,=
 Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"> </span><spa=
n class=3D"cm-variable" style=3D"font-family: Calibri, Helvetica, sans-seri=
f; font-size: 12pt; color: rgb(0, 0, 0);">get_time_nsec</span><span style=
=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rg=
b(0, 0, 0);">();</span></b></pre>
<span style=3D"font-size: 12pt;"></span></div>
<span style=3D"font-size: 12pt;"></span>
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x"><span style=3D"font-size: 12pt;"></span>
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><b><span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">        </span><span class=3D"cm-variable" st=
yle=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color:=
 rgb(0, 0, 0);">lttng_ust_tracepoint</span><span style=3D"font-family: Cali=
bri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">(</span>=
<span class=3D"cm-variable" style=3D"font-family: Calibri, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">hello_world</span><span style=
=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rg=
b(0, 0, 0);">, </span><span class=3D"cm-variable" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">my_firs=
t_tracepoint</span><span style=3D"font-family: Calibri, Helvetica, sans-ser=
if; font-size: 12pt; color: rgb(0, 0, 0);">,</span></b></pre>
<span style=3D"font-size: 12pt;"></span></div>
<span style=3D"font-size: 12pt;"></span>
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x"><span style=3D"font-size: 12pt;"></span>
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><b><span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">                             </span><span cla=
ss=3D"cm-variable" style=3D"font-family: Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);">i</span><span style=3D"font-family: Ca=
libri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">, </sp=
an><span class=3D"cm-string" style=3D"color: rgb(0, 0, 0); font-family: Cal=
ibri, Helvetica, sans-serif; font-size: 12pt;">&quot;some_str&quot;</span><=
span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">);</span></b></pre>
<span style=3D"font-size: 12pt;"></span></div>
<span style=3D"font-size: 12pt;"></span>
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x"><span style=3D"font-size: 12pt;"></span>
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><b><span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">        </span><span class=3D"cm-variable" st=
yle=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color:=
 rgb(0, 0, 0);">nowz</span><span style=3D"font-family: Calibri, Helvetica, =
sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"> </span><span class=3D"c=
m-operator" style=3D"font-family: Calibri, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">=3D</span><span style=3D"font-family: Calibri=
, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"> </span><sp=
an class=3D"cm-variable" style=3D"font-family: Calibri, Helvetica, sans-ser=
if; font-size: 12pt; color: rgb(0, 0, 0);">get_time_nsec</span><span style=
=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rg=
b(0, 0, 0);">();</span></b></pre>
<span style=3D"font-size: 12pt;"></span></div>
<span style=3D"font-size: 12pt;"></span>
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x"><span style=3D"font-size: 12pt;"></span>
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><b><span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">        </span><span class=3D"cm-variable" st=
yle=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color:=
 rgb(0, 0, 0);">total_time</span><span style=3D"font-family: Calibri, Helve=
tica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"> </span><span clas=
s=3D"cm-operator" style=3D"font-family: Calibri, Helvetica, sans-serif; fon=
t-size: 12pt; color: rgb(0, 0, 0);">&#43;=3D</span><span style=3D"font-fami=
ly: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">=
 (</span><span class=3D"cm-variable" style=3D"font-family: Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">nowz</span><span sty=
le=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color: =
rgb(0, 0, 0);"> </span><span class=3D"cm-operator" style=3D"font-family: Ca=
libri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">-</spa=
n><span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12=
pt; color: rgb(0, 0, 0);"> </span><span class=3D"cm-variable" style=3D"font=
-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, =
0);">now</span><span style=3D"font-family: Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: rgb(0, 0, 0);">);</span></b></pre>
<span style=3D"font-size: 12pt;"></span></div>
<span style=3D"font-size: 12pt;"></span>
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x"><span style=3D"font-size: 12pt;"></span>
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14pt;=
 color:rgb(0,0,0)"><b><span style=3D"font-size: 12pt;">    }</span></b></sp=
an></pre>
<span style=3D"font-size: 12pt;"></span></div>
<span style=3D"font-size: 12pt;"></span>
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x"><span style=3D"font-size: 12pt;"></span>
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14pt;=
 color:rgb(0,0,0)"><b></b></span></pre>
<span style=3D"font-size: 12pt;"></span></div>
<span style=3D"font-size: 12pt;"></span>
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x"><span style=3D"font-size: 12pt;"></span>
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><b><span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">    </span><span class=3D"cm-keyword" style=
=3D"color: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-serif; font-=
size: 12pt;">if</span><span style=3D"font-family: Calibri, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);"> (</span><span class=3D"cm-va=
riable" style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12=
pt; color: rgb(0, 0, 0);">tp_num</span><span style=3D"font-family: Calibri,=
 Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">) {</span></=
b></pre>
<span style=3D"font-size: 12pt;"></span></div>
<span style=3D"font-size: 12pt;"></span>
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x"><span style=3D"font-size: 12pt;"></span>
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><b><span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">        </span><span class=3D"cm-variable" st=
yle=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color:=
 rgb(0, 0, 0);">printf</span><span style=3D"font-family: Calibri, Helvetica=
, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">(</span><span class=3D=
"cm-string" style=3D"color: rgb(0, 0, 0); font-family: Calibri, Helvetica, =
sans-serif; font-size: 12pt;">&quot;---------------------------Average TP t=
ime is %&quot;</span><span class=3D"cm-variable" style=3D"font-family: Cali=
bri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">PRIu64</=
span><span class=3D"cm-string" style=3D"color: rgb(0, 0, 0); font-family: C=
alibri, Helvetica, sans-serif; font-size: 12pt;">&quot;--------------------=
-------\n&quot;</span><span style=3D"font-family: Calibri, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">, </span><span class=3D"cm-va=
riable" style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12=
pt; color: rgb(0, 0, 0);">total_time</span><span style=3D"font-family: Cali=
bri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"> </span>=
<span class=3D"cm-operator" style=3D"font-family: Calibri, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">/</span><span style=3D"font-f=
amily: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0)=
;"> </span><span class=3D"cm-variable" style=3D"font-family: Calibri, Helve=
tica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">tp_num</span><span=
 style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; col=
or: rgb(0, 0, 0);">);      </span></b></pre>
<span style=3D"font-size: 12pt;"></span></div>
<span style=3D"font-size: 12pt;"></span>
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x"><span style=3D"font-size: 12pt;"></span>
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14pt;=
 color:rgb(0,0,0)"><b><span style=3D"font-size: 12pt;">    }</span></b></sp=
an></pre>
<span style=3D"font-size: 12pt;"></span></div>
<span style=3D"font-size: 12pt;"></span>
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x"><span style=3D"font-size: 12pt;"></span>
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14pt;=
 color:rgb(0,0,0)"><b><span style=3D"font-size: 12pt;">}</span></b></span><=
/pre>
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 1=
4pt; color: rgb(0, 0, 0);"><span style=3D"font-size: 12pt;"></span></span><=
span style=3D"font-size: 12pt;">-------------------------------------------=
---------------------------------------------------------------------------=
------------------------------------------------------------</span></pre>
<span style=3D"font-size: 12pt;"></span></div>
<span style=3D"font-size: 12pt;"></span>
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x"><span style=3D"font-size: 12pt;"></span>
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14pt;=
 color:rgb(0,0,0)"></span></pre>
<span style=3D"font-size: 12pt;"></span></div>
<span style=3D"font-size: 12pt;"></span>
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x"><span style=3D"font-size: 12pt;"></span>
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span class=3D"cm-keyword" style=3D"color:rgb(0,0,0); font-family:Calibr=
i,Helvetica,sans-serif; font-size:14pt"><br></span></pre>
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span class=3D"cm-keyword" style=3D"color:rgb(0,0,0); font-family:Calibr=
i,Helvetica,sans-serif; font-size:14pt">I</span><span style=3D"font-family:=
Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><sp=
an class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif;=
 font-size:14pt; color:rgb(0,0,0)">observed</span><span style=3D"font-famil=
y:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><=
span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-seri=
f; font-size:14pt; color:rgb(0,0,0)">a</span><span style=3D"font-family:Cal=
ibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span =
class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; fo=
nt-size:14pt; color:rgb(0,0,0)">big</span><span style=3D"font-family:Calibr=
i,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span cla=
ss=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; font-=
size:14pt; color:rgb(0,0,0)">average</span><span style=3D"font-family:Calib=
ri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span cl=
ass=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; font=
-size:14pt; color:rgb(0,0,0)">latency</span><span style=3D"font-family:Cali=
bri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span c=
lass=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; fon=
t-size:14pt; color:rgb(0,0,0)">variance</span><span style=3D"font-family:Ca=
libri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span=
 class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; f=
ont-size:14pt; color:rgb(0,0,0)">on</span><span style=3D"font-family:Calibr=
i,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span cla=
ss=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; font-=
size:14pt; color:rgb(0,0,0)">different</span><span style=3D"font-family:Cal=
ibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span =
class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; fo=
nt-size:14pt; color:rgb(0,0,0)">platforms</span><span style=3D"font-family:=
Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><sp=
an class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif;=
 font-size:14pt; color:rgb(0,0,0)">when</span><span style=3D"font-family:Ca=
libri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span=
 class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; f=
ont-size:14pt; color:rgb(0,0,0)">tracing</span><span style=3D"font-family:C=
alibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><spa=
n class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; =
font-size:14pt; color:rgb(0,0,0)">a</span><span style=3D"font-family:Calibr=
i,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span cla=
ss=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; font-=
size:14pt; color:rgb(0,0,0)">high</span><span style=3D"font-family:Calibri,=
Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span class=
=3D"cm-def" style=3D"color:rgb(0,0,0); font-family:Calibri,Helvetica,sans-s=
erif; font-size:14pt">number</span><span style=3D"font-family:Calibri,Helve=
tica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> (</span><span class=3D"=
cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:1=
4pt; color:rgb(0,0,0)">many</span><span style=3D"font-family:Calibri,Helvet=
ica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span class=3D"cm=
-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14p=
t; color:rgb(0,0,0)">thousands</span><span style=3D"font-family:Calibri,Hel=
vetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span class=3D=
"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:=
14pt; color:rgb(0,0,0)">to</span><span style=3D"font-family:Calibri,Helveti=
ca,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span class=3D"cm-=
variable" style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14pt=
; color:rgb(0,0,0)">millions</span><span style=3D"font-family:Calibri,Helve=
tica,sans-serif; font-size:14pt; color:rgb(0,0,0)">) </span><span class=3D"=
cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:1=
4pt; color:rgb(0,0,0)">of</span><span style=3D"font-family:Calibri,Helvetic=
a,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span class=3D"cm-v=
ariable" style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14pt;=
 color:rgb(0,0,0)">tracepoints</span><span style=3D"font-family:Calibri,Hel=
vetica,sans-serif; font-size:14pt; color:rgb(0,0,0)">:</span></pre>
</div>
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x">
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14pt;=
 color:rgb(0,0,0)"></span></pre>
</div>
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x">
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><ul style=3D"margin-bottom: 0px; margin-top: 0px;"><li><b><span class=3D=
"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:=
14pt; color:rgb(0,0,0)">[platform</span><span style=3D"font-family:Calibri,=
Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span></b><span c=
lass=3D"cm-number" style=3D"color:rgb(0,0,0); font-family:Calibri,Helvetica=
,sans-serif; font-size:14pt"><b>1]</b></span><span style=3D"font-family:Cal=
ibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span =
class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; fo=
nt-size:14pt; color:rgb(0,0,0)">with</span><span style=3D"font-family:Calib=
ri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span cl=
ass=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; font=
-size:14pt; color:rgb(0,0,0)">CPU</span><span style=3D"font-family:Calibri,=
Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span class=
=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; font-si=
ze:14pt; color:rgb(0,0,0)">info</span><span style=3D"font-family:Calibri,He=
lvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span class=
=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; font-si=
ze:14pt; color:rgb(0,0,0)">running</span><span style=3D"font-family:Calibri=
,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span clas=
s=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; font-s=
ize:14pt; color:rgb(0,0,0)">a</span><span style=3D"font-family:Calibri,Helv=
etica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span class=3D"=
cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:1=
4pt; color:rgb(0,0,0)">linux</span><span style=3D"font-family:Calibri,Helve=
tica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span class=3D"c=
m-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14=
pt; color:rgb(0,0,0)">kernel</span><span style=3D"font-family:Calibri,Helve=
tica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span class=3D"c=
m-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14=
pt; color:rgb(0,0,0)">based</span><span style=3D"font-family:Calibri,Helvet=
ica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span class=3D"cm=
-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14p=
t; color:rgb(0,0,0)">on</span><span style=3D"font-family:Calibri,Helvetica,=
sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span class=3D"cm-def=
" style=3D"color:rgb(0,0,0); font-family:Calibri,Helvetica,sans-serif; font=
-size:14pt">Buildroot</span><span style=3D"font-family:Calibri,Helvetica,sa=
ns-serif; font-size:14pt; color:rgb(0,0,0)"> (</span><span class=3D"cm-numb=
er" style=3D"color:rgb(0,0,0); font-family:Calibri,Helvetica,sans-serif; fo=
nt-size:14pt">4.19.273</span><span style=3D"font-family:Calibri,Helvetica,s=
ans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span class=3D"cm-vari=
able" style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14pt; co=
lor:rgb(0,0,0)">aarch64</span><span style=3D"font-family:Calibri,Helvetica,=
sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span class=3D"cm-var=
iable" style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14pt; c=
olor:rgb(0,0,0)">GNU</span><span class=3D"cm-operator" style=3D"font-family=
:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)">/</span><s=
pan class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif=
; font-size:14pt; color:rgb(0,0,0)">Linux</span><span style=3D"font-family:=
Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)">):</span></=
li></ul></pre>
</div>
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x">
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14pt;=
 color:rgb(0,0,0)"></span></pre>
</div>
</div>
<blockquote style=3D"margin: 0 0 0 40px; border: none; padding: 0px;">
<blockquote style=3D"margin: 0 0 0 40px; border: none; padding: 0px;">
<div dir=3D"ltr" style=3D"font-size: 12pt; color: rgb(0, 0, 0); font-family=
: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;,=
 &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &=
quot;Android Emoji&quot;, EmojiSymbols;">
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x">
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-=
serif; font-size:14pt; color:rgb(0,0,0)">BogoMIPS</span><span style=3D"font=
-family:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)">	: =
</span><span class=3D"cm-number" style=3D"color:rgb(0,0,0); font-family:Cal=
ibri,Helvetica,sans-serif; font-size:14pt">187.50</span></pre>
</div>
</div>
</blockquote>
<blockquote style=3D"margin: 0 0 0 40px; border: none; padding: 0px;">
<div dir=3D"ltr" style=3D"font-size: 12pt; color: rgb(0, 0, 0); font-family=
: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;,=
 &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &=
quot;Android Emoji&quot;, EmojiSymbols;">
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x">
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-=
serif; font-size:14pt; color:rgb(0,0,0)">Features</span><span style=3D"font=
-family:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)">	: =
</span><span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,s=
ans-serif; font-size:14pt; color:rgb(0,0,0)">fp</span><span style=3D"font-f=
amily:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </sp=
an><span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-=
serif; font-size:14pt; color:rgb(0,0,0)">asimd</span><span style=3D"font-fa=
mily:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </spa=
n><span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-s=
erif; font-size:14pt; color:rgb(0,0,0)">evtstrm</span><span style=3D"font-f=
amily:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </sp=
an><span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-=
serif; font-size:14pt; color:rgb(0,0,0)">aes</span><span style=3D"font-fami=
ly:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span>=
<span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-ser=
if; font-size:14pt; color:rgb(0,0,0)">pmull</span><span style=3D"font-famil=
y:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><=
span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-seri=
f; font-size:14pt; color:rgb(0,0,0)">sha1</span><span style=3D"font-family:=
Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><sp=
an class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif;=
 font-size:14pt; color:rgb(0,0,0)">sha2</span><span style=3D"font-family:Ca=
libri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span=
 class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; f=
ont-size:14pt; color:rgb(0,0,0)">crc32</span><span style=3D"font-family:Cal=
ibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span =
class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; fo=
nt-size:14pt; color:rgb(0,0,0)">cpuid</span></pre>
</div>
</div>
</blockquote>
<blockquote style=3D"margin: 0 0 0 40px; border: none; padding: 0px;">
<div dir=3D"ltr" style=3D"font-size: 12pt; color: rgb(0, 0, 0); font-family=
: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;,=
 &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &=
quot;Android Emoji&quot;, EmojiSymbols;">
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x">
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-=
serif; font-size:14pt; color:rgb(0,0,0)">CPU</span><span style=3D"font-fami=
ly:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span>=
<span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-ser=
if; font-size:14pt; color:rgb(0,0,0)">implementer</span><span style=3D"font=
-family:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)">	: =
</span><span class=3D"cm-number" style=3D"color:rgb(0,0,0); font-family:Cal=
ibri,Helvetica,sans-serif; font-size:14pt">0x41</span></pre>
</div>
</div>
</blockquote>
<blockquote style=3D"margin: 0 0 0 40px; border: none; padding: 0px;">
<div dir=3D"ltr" style=3D"font-size: 12pt; color: rgb(0, 0, 0); font-family=
: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;,=
 &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &=
quot;Android Emoji&quot;, EmojiSymbols;">
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x">
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-=
serif; font-size:14pt; color:rgb(0,0,0)">CPU</span><span style=3D"font-fami=
ly:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span>=
<span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-ser=
if; font-size:14pt; color:rgb(0,0,0)">architecture</span><span style=3D"fon=
t-family:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)">: =
</span><span class=3D"cm-number" style=3D"color:rgb(0,0,0); font-family:Cal=
ibri,Helvetica,sans-serif; font-size:14pt">8</span></pre>
</div>
</div>
</blockquote>
<blockquote style=3D"margin: 0 0 0 40px; border: none; padding: 0px;">
<div dir=3D"ltr" style=3D"font-size: 12pt; color: rgb(0, 0, 0); font-family=
: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;,=
 &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &=
quot;Android Emoji&quot;, EmojiSymbols;">
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x">
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-=
serif; font-size:14pt; color:rgb(0,0,0)">CPU</span><span style=3D"font-fami=
ly:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span>=
<span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-ser=
if; font-size:14pt; color:rgb(0,0,0)">variant</span><span style=3D"font-fam=
ily:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)">	: </sp=
an><span class=3D"cm-number" style=3D"color:rgb(0,0,0); font-family:Calibri=
,Helvetica,sans-serif; font-size:14pt">0x0</span></pre>
</div>
</div>
</blockquote>
<blockquote style=3D"margin: 0 0 0 40px; border: none; padding: 0px;">
<div dir=3D"ltr" style=3D"font-size: 12pt; color: rgb(0, 0, 0); font-family=
: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;,=
 &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &=
quot;Android Emoji&quot;, EmojiSymbols;">
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x">
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-=
serif; font-size:14pt; color:rgb(0,0,0)">CPU</span><span style=3D"font-fami=
ly:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span>=
<span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-ser=
if; font-size:14pt; color:rgb(0,0,0)">part</span><span style=3D"font-family=
:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)">	: </span>=
<span class=3D"cm-number" style=3D"color:rgb(0,0,0); font-family:Calibri,He=
lvetica,sans-serif; font-size:14pt">0xd08</span></pre>
</div>
</div>
</blockquote>
<blockquote style=3D"margin: 0 0 0 40px; border: none; padding: 0px;">
<div dir=3D"ltr" style=3D"font-size: 12pt; color: rgb(0, 0, 0); font-family=
: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;,=
 &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &=
quot;Android Emoji&quot;, EmojiSymbols;">
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x">
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-=
serif; font-size:14pt; color:rgb(0,0,0)">CPU</span><span style=3D"font-fami=
ly:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span>=
<span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-ser=
if; font-size:14pt; color:rgb(0,0,0)">revision</span><span style=3D"font-fa=
mily:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)">	: </s=
pan><span class=3D"cm-number" style=3D"color:rgb(0,0,0); font-family:Calibr=
i,Helvetica,sans-serif; font-size:14pt">3</span></pre>
</div>
</div>
</blockquote>
</blockquote>
<blockquote style=3D"margin: 0 0 0 40px; border: none; padding: 0px;">
<div dir=3D"ltr" style=3D"font-size: 12pt; color: rgb(0, 0, 0); font-family=
: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;,=
 &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &=
quot;Android Emoji&quot;, EmojiSymbols;">
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x">
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span class=3D"cm-number" style=3D"color:rgb(0,0,0); font-family:Calibri=
,Helvetica,sans-serif; font-size:14pt"></span></pre>
</div>
</div>
</blockquote>
<div dir=3D"ltr" style=3D"font-size: 12pt; color: rgb(0, 0, 0); font-family=
: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;,=
 &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &=
quot;Android Emoji&quot;, EmojiSymbols;">
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x">
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span class=3D"cm-number" style=3D"color:rgb(0,0,0); font-family:Calibri=
,Helvetica,sans-serif; font-size:14pt"></span></pre>
</div>
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x">
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><ul style=3D"margin-bottom: 0px; margin-top: 0px;"><li><span class=3D"cm=
-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14p=
t; color:rgb(0,0,0)">&nbsp;Saw</span><span style=3D"font-family:Calibri,Hel=
vetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span class=3D=
"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:=
14pt; color:rgb(0,0,0)">an</span><span style=3D"font-family:Calibri,Helveti=
ca,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span class=3D"cm-=
variable" style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14pt=
; color:rgb(0,0,0)">average</span><span style=3D"font-family:Calibri,Helvet=
ica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span class=3D"cm=
-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14p=
t; color:rgb(0,0,0)">latency</span><span style=3D"font-family:Calibri,Helve=
tica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span class=3D"c=
m-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14=
pt; color:rgb(0,0,0)">of</span><span style=3D"font-family:Calibri,Helvetica=
,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><b><span class=3D"cm=
-number" style=3D"color:rgb(0,0,0); font-family:Calibri,Helvetica,sans-seri=
f; font-size:14pt">2</span><span class=3D"cm-operator" style=3D"font-family=
:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)">-</span></=
b><span class=3D"cm-number" style=3D"color:rgb(0,0,0); font-family:Calibri,=
Helvetica,sans-serif; font-size:14pt"><b>3usec=0A=
</b>=0A=
</span></li><li><b><span class=3D"cm-variable" style=3D"font-family:Calibri=
,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)">[platform</span><s=
pan style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14pt; colo=
r:rgb(0,0,0)"> </span></b><span class=3D"cm-number" style=3D"color:rgb(0,0,=
0); font-family:Calibri,Helvetica,sans-serif; font-size:14pt"><b>2]</b></sp=
an><span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14pt;=
 color:rgb(0,0,0)"> </span><span class=3D"cm-variable" style=3D"font-family=
:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)">with</span=
><span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14pt; c=
olor:rgb(0,0,0)"> </span><span class=3D"cm-variable" style=3D"font-family:C=
alibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)">CPU</span><s=
pan style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14pt; colo=
r:rgb(0,0,0)"> </span><span class=3D"cm-variable" style=3D"font-family:Cali=
bri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)">info</span><spa=
n style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14pt; color:=
rgb(0,0,0)"> </span><span class=3D"cm-variable" style=3D"font-family:Calibr=
i,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)">running</span><sp=
an style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14pt; color=
:rgb(0,0,0)"> </span><span class=3D"cm-variable" style=3D"font-family:Calib=
ri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)">a</span><span st=
yle=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(=
0,0,0)"> </span><span class=3D"cm-variable" style=3D"font-family:Calibri,He=
lvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)">linux</span><span sty=
le=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0=
,0,0)"> </span><span class=3D"cm-variable" style=3D"font-family:Calibri,Hel=
vetica,sans-serif; font-size:14pt; color:rgb(0,0,0)">kernel</span><span sty=
le=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0=
,0,0)"> </span><span class=3D"cm-variable" style=3D"font-family:Calibri,Hel=
vetica,sans-serif; font-size:14pt; color:rgb(0,0,0)">based</span><span styl=
e=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,=
0,0)"> </span><span class=3D"cm-variable" style=3D"font-family:Calibri,Helv=
etica,sans-serif; font-size:14pt; color:rgb(0,0,0)">on</span><span style=3D=
"font-family:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)=
"> </span><span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetic=
a,sans-serif; font-size:14pt; color:rgb(0,0,0)">Amazon</span><span style=3D=
"font-family:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)=
"> </span><span class=3D"cm-def" style=3D"color:rgb(0,0,0); font-family:Cal=
ibri,Helvetica,sans-serif; font-size:14pt">Linux</span><span style=3D"font-=
family:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> (</=
span><span class=3D"cm-number" style=3D"color:rgb(0,0,0); font-family:Calib=
ri,Helvetica,sans-serif; font-size:14pt">4.14.294</span><span class=3D"cm-o=
perator" style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14pt;=
 color:rgb(0,0,0)">-</span><span class=3D"cm-number" style=3D"color:rgb(0,0=
,0); font-family:Calibri,Helvetica,sans-serif; font-size:14pt">220.533.amzn=
2.aarch64</span><span style=3D"font-family:Calibri,Helvetica,sans-serif; fo=
nt-size:14pt; color:rgb(0,0,0)"> </span><span class=3D"cm-variable" style=
=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0=
,0)">aarch64</span><span style=3D"font-family:Calibri,Helvetica,sans-serif;=
 font-size:14pt; color:rgb(0,0,0)"> </span><span class=3D"cm-variable" styl=
e=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,=
0,0)">GNU</span><span class=3D"cm-operator" style=3D"font-family:Calibri,He=
lvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)">/</span><span class=
=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; font-si=
ze:14pt; color:rgb(0,0,0)">Linux</span><span style=3D"font-family:Calibri,H=
elvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)">):</span></li></ul><=
/pre>
</div>
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x">
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14pt;=
 color:rgb(0,0,0)"></span></pre>
</div>
</div>
<blockquote style=3D"margin: 0 0 0 40px; border: none; padding: 0px;">
<blockquote style=3D"margin: 0 0 0 40px; border: none; padding: 0px;">
<div dir=3D"ltr" style=3D"font-size: 12pt; color: rgb(0, 0, 0); font-family=
: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;,=
 &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &=
quot;Android Emoji&quot;, EmojiSymbols;">
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x">
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-=
serif; font-size:14pt; color:rgb(0,0,0)">BogoMIPS</span><span style=3D"font=
-family:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)">	: =
</span><span class=3D"cm-number" style=3D"color:rgb(0,0,0); font-family:Cal=
ibri,Helvetica,sans-serif; font-size:14pt">243.75</span></pre>
</div>
</div>
</blockquote>
<blockquote style=3D"margin: 0 0 0 40px; border: none; padding: 0px;">
<div dir=3D"ltr" style=3D"font-size: 12pt; color: rgb(0, 0, 0); font-family=
: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;,=
 &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &=
quot;Android Emoji&quot;, EmojiSymbols;">
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x">
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-=
serif; font-size:14pt; color:rgb(0,0,0)">Features</span><span style=3D"font=
-family:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)">	: =
</span><span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,s=
ans-serif; font-size:14pt; color:rgb(0,0,0)">fp</span><span style=3D"font-f=
amily:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </sp=
an><span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-=
serif; font-size:14pt; color:rgb(0,0,0)">asimd</span><span style=3D"font-fa=
mily:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </spa=
n><span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-s=
erif; font-size:14pt; color:rgb(0,0,0)">evtstrm</span><span style=3D"font-f=
amily:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </sp=
an><span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-=
serif; font-size:14pt; color:rgb(0,0,0)">aes</span><span style=3D"font-fami=
ly:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span>=
<span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-ser=
if; font-size:14pt; color:rgb(0,0,0)">pmull</span><span style=3D"font-famil=
y:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><=
span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-seri=
f; font-size:14pt; color:rgb(0,0,0)">sha1</span><span style=3D"font-family:=
Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><sp=
an class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif;=
 font-size:14pt; color:rgb(0,0,0)">sha2</span><span style=3D"font-family:Ca=
libri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span=
 class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; f=
ont-size:14pt; color:rgb(0,0,0)">crc32</span><span style=3D"font-family:Cal=
ibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span =
class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; fo=
nt-size:14pt; color:rgb(0,0,0)">atomics</span><span style=3D"font-family:Ca=
libri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span=
 class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; f=
ont-size:14pt; color:rgb(0,0,0)">fphp</span><span style=3D"font-family:Cali=
bri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span c=
lass=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; fon=
t-size:14pt; color:rgb(0,0,0)">asimdhp</span><span style=3D"font-family:Cal=
ibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span =
class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; fo=
nt-size:14pt; color:rgb(0,0,0)">cpuid</span><span style=3D"font-family:Cali=
bri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span c=
lass=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; fon=
t-size:14pt; color:rgb(0,0,0)">asimdrdm</span><span style=3D"font-family:Ca=
libri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span=
 class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; f=
ont-size:14pt; color:rgb(0,0,0)">lrcpc</span><span style=3D"font-family:Cal=
ibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span =
class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; fo=
nt-size:14pt; color:rgb(0,0,0)">dcpop</span><span style=3D"font-family:Cali=
bri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span c=
lass=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; fon=
t-size:14pt; color:rgb(0,0,0)">asimddp</span><span style=3D"font-family:Cal=
ibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span =
class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; fo=
nt-size:14pt; color:rgb(0,0,0)">ssbs</span></pre>
</div>
</div>
</blockquote>
<blockquote style=3D"margin: 0 0 0 40px; border: none; padding: 0px;">
<div dir=3D"ltr" style=3D"font-size: 12pt; color: rgb(0, 0, 0); font-family=
: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;,=
 &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &=
quot;Android Emoji&quot;, EmojiSymbols;">
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x">
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-=
serif; font-size:14pt; color:rgb(0,0,0)">CPU</span><span style=3D"font-fami=
ly:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span>=
<span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-ser=
if; font-size:14pt; color:rgb(0,0,0)">implementer</span><span style=3D"font=
-family:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)">	: =
</span><span class=3D"cm-number" style=3D"color:rgb(0,0,0); font-family:Cal=
ibri,Helvetica,sans-serif; font-size:14pt">0x41</span></pre>
</div>
</div>
</blockquote>
<blockquote style=3D"margin: 0 0 0 40px; border: none; padding: 0px;">
<div dir=3D"ltr" style=3D"font-size: 12pt; color: rgb(0, 0, 0); font-family=
: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;,=
 &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &=
quot;Android Emoji&quot;, EmojiSymbols;">
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x">
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-=
serif; font-size:14pt; color:rgb(0,0,0)">CPU</span><span style=3D"font-fami=
ly:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span>=
<span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-ser=
if; font-size:14pt; color:rgb(0,0,0)">architecture</span><span style=3D"fon=
t-family:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)">: =
</span><span class=3D"cm-number" style=3D"color:rgb(0,0,0); font-family:Cal=
ibri,Helvetica,sans-serif; font-size:14pt">8</span></pre>
</div>
</div>
</blockquote>
<blockquote style=3D"margin: 0 0 0 40px; border: none; padding: 0px;">
<div dir=3D"ltr" style=3D"font-size: 12pt; color: rgb(0, 0, 0); font-family=
: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;,=
 &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &=
quot;Android Emoji&quot;, EmojiSymbols;">
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x">
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-=
serif; font-size:14pt; color:rgb(0,0,0)">CPU</span><span style=3D"font-fami=
ly:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span>=
<span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-ser=
if; font-size:14pt; color:rgb(0,0,0)">variant</span><span style=3D"font-fam=
ily:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)">	: </sp=
an><span class=3D"cm-number" style=3D"color:rgb(0,0,0); font-family:Calibri=
,Helvetica,sans-serif; font-size:14pt">0x3</span></pre>
</div>
</div>
</blockquote>
<blockquote style=3D"margin: 0 0 0 40px; border: none; padding: 0px;">
<div dir=3D"ltr" style=3D"font-size: 12pt; color: rgb(0, 0, 0); font-family=
: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;,=
 &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &=
quot;Android Emoji&quot;, EmojiSymbols;">
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x">
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-=
serif; font-size:14pt; color:rgb(0,0,0)">CPU</span><span style=3D"font-fami=
ly:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span>=
<span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-ser=
if; font-size:14pt; color:rgb(0,0,0)">part</span><span style=3D"font-family=
:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)">	: </span>=
<span class=3D"cm-number" style=3D"color:rgb(0,0,0); font-family:Calibri,He=
lvetica,sans-serif; font-size:14pt">0xd0c</span></pre>
</div>
</div>
</blockquote>
<blockquote style=3D"margin: 0 0 0 40px; border: none; padding: 0px;">
<div dir=3D"ltr" style=3D"font-size: 12pt; color: rgb(0, 0, 0); font-family=
: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;,=
 &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &=
quot;Android Emoji&quot;, EmojiSymbols;">
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x">
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-=
serif; font-size:14pt; color:rgb(0,0,0)">CPU</span><span style=3D"font-fami=
ly:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span>=
<span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-ser=
if; font-size:14pt; color:rgb(0,0,0)">revision</span><span style=3D"font-fa=
mily:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)">	: </s=
pan><span class=3D"cm-number" style=3D"color:rgb(0,0,0); font-family:Calibr=
i,Helvetica,sans-serif; font-size:14pt">1</span></pre>
</div>
</div>
</blockquote>
</blockquote>
<blockquote style=3D"margin: 0 0 0 40px; border: none; padding: 0px;">
<div dir=3D"ltr" style=3D"font-size: 12pt; color: rgb(0, 0, 0); font-family=
: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;,=
 &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &=
quot;Android Emoji&quot;, EmojiSymbols;">
<div style=3D"counter-increment:snippet 1; margin-left:32px; padding:0px 8p=
x">
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span class=3D"cm-number" style=3D"color:rgb(0,0,0); font-family:Calibri=
,Helvetica,sans-serif; font-size:14pt"></span></pre>
</div>
</div>
</blockquote>
<div dir=3D"ltr" style=3D"color: rgb(0, 0, 0);">
<div style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot=
;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot=
;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size:=
 12pt; counter-increment: snippet 1; margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span class=3D"cm-number" style=3D"color:rgb(0,0,0); font-family:Calibri=
,Helvetica,sans-serif; font-size:14pt"></span></pre>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot=
;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot=
;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size:=
 12pt; counter-increment: snippet 1; margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14pt;=
 color:rgb(0,0,0)"></span></pre>
</div>
<div style=3D"counter-increment: snippet 1; margin-left: 32px; padding: 0px=
 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; line-h=
eight: inherit; tab-size: 4; word-break: normal; border-width: 0px; border-=
radius: 0px; color: inherit; overflow: visible;"><ul style=3D"font-family: =
inherit; font-size: inherit; margin-bottom: 0px; margin-top: 0px;"><li><spa=
n class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; =
font-size:14pt; color:rgb(0,0,0)">Saw</span><span style=3D"font-family:Cali=
bri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span c=
lass=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; fon=
t-size:14pt; color:rgb(0,0,0)">an</span><span style=3D"font-family:Calibri,=
Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span class=
=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; font-si=
ze:14pt; color:rgb(0,0,0)">average</span><span style=3D"font-family:Calibri=
,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span clas=
s=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; font-s=
ize:14pt; color:rgb(0,0,0)">latency</span><span style=3D"font-family:Calibr=
i,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span cla=
ss=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; font-=
size:14pt; color:rgb(0,0,0)">of</span><span style=3D"font-family:Calibri,He=
lvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><b><span clas=
s=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; font-s=
ize:14pt; color:rgb(0,0,0)">~0</span><span class=3D"cm-number" style=3D"col=
or:rgb(0,0,0); font-family:Calibri,Helvetica,sans-serif; font-size:14pt">.5=
u</span></b><span class=3D"cm-variable" style=3D"font-family:Calibri,Helvet=
ica,sans-serif; font-size:14pt; color:rgb(0,0,0)"><b>sec=0A=
</b></span></li></ul><div style=3D""><font face=3D"Calibri, Helvetica, sans=
-serif"><span style=3D"font-size: 18.6667px;"><b><br></b></span></font></di=
v></pre>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot=
;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot=
;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size:=
 12pt; counter-increment: snippet 1; margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14pt;=
 color:rgb(0,0,0)"></span></pre>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot=
;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot=
;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size:=
 12pt; counter-increment: snippet 1; margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-=
serif; font-size:14pt; color:rgb(0,0,0)">Are</span><span style=3D"font-fami=
ly:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span>=
<span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-ser=
if; font-size:14pt; color:rgb(0,0,0)">there</span><span style=3D"font-famil=
y:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><=
span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-seri=
f; font-size:14pt; color:rgb(0,0,0)">any</span><span style=3D"font-family:C=
alibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><spa=
n class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; =
font-size:14pt; color:rgb(0,0,0)">suggestions</span><span style=3D"font-fam=
ily:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span=
><span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-se=
rif; font-size:14pt; color:rgb(0,0,0)">to</span><span style=3D"font-family:=
Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><sp=
an class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif;=
 font-size:14pt; color:rgb(0,0,0)">root</span><span style=3D"font-family:Ca=
libri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span=
 class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; f=
ont-size:14pt; color:rgb(0,0,0)">cause</span><span style=3D"font-family:Cal=
ibri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span =
class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; fo=
nt-size:14pt; color:rgb(0,0,0)">the</span><span style=3D"font-family:Calibr=
i,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span cla=
ss=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; font-=
size:14pt; color:rgb(0,0,0)">high</span><span style=3D"font-family:Calibri,=
Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span class=
=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; font-si=
ze:14pt; color:rgb(0,0,0)">latency</span><span style=3D"font-family:Calibri=
,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span clas=
s=3D"cm-keyword" style=3D"color:rgb(0,0,0); font-family:Calibri,Helvetica,s=
ans-serif; font-size:14pt">and</span><span style=3D"font-family:Calibri,Hel=
vetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span class=3D=
"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:=
14pt; color:rgb(0,0,0)">potentially</span><span style=3D"font-family:Calibr=
i,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span cla=
ss=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; font-=
size:14pt; color:rgb(0,0,0)">improve</span><span style=3D"font-family:Calib=
ri,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span cl=
ass=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; font=
-size:14pt; color:rgb(0,0,0)">it</span><span style=3D"font-family:Calibri,H=
elvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><span class=
=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; font-si=
ze:14pt; color:rgb(0,0,0)">on</span><span style=3D"font-family:Calibri,Helv=
etica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span><b><span class=
=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-serif; font-si=
ze:14pt; color:rgb(0,0,0)">platform</span><span style=3D"font-family:Calibr=
i,Helvetica,sans-serif; font-size:14pt; color:rgb(0,0,0)"> </span></b><span=
 class=3D"cm-number" style=3D"color:rgb(0,0,0); font-family:Calibri,Helveti=
ca,sans-serif; font-size:14pt"><b>1</b></span><span class=3D"cm-operator" s=
tyle=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14pt; color:rgb=
(0,0,0)">?</span></pre>
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span class=3D"cm-operator" style=3D"font-family:Calibri,Helvetica,sans-=
serif; font-size:14pt; color:rgb(0,0,0)"><br></span></pre>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot=
;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot=
;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size:=
 12pt; counter-increment: snippet 1; margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:14pt;=
 color:rgb(0,0,0)"></span></pre>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot=
;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot=
;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size:=
 12pt; counter-increment: snippet 1; margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-=
serif; font-size:14pt; color:rgb(0,0,0)">Thanks and best regards,</span></p=
re>
<pre style=3D"margin-top:0px; margin-bottom:0px; padding:0px 4px; font-size=
:inherit; line-height:inherit; tab-size:4; word-break:normal; font-family:i=
nherit; border-width:0px; border-radius:0px; color:inherit; overflow:visibl=
e"><span class=3D"cm-variable" style=3D"font-family:Calibri,Helvetica,sans-=
serif; font-size:14pt; color:rgb(0,0,0)">Anas.</span></pre>
</div>
<br>
<p style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot;A=
pple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;S=
egoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size: 1=
2pt;">
</p>
</div>
</div>
</body>
</html>

--_000_1255477015ae4da8a6523b5d204334daamazoncom_--

--===============0369875271704751774==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0369875271704751774==--
