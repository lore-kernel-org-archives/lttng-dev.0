Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 248F6EB64DB
	for <lttng-dev@archiver.kernel.org>; Tue, 20 Jun 2023 10:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1687256843;
	bh=05b3joueBY2thvZgshYp3qzHJ5jSvNObySgRjkVC05g=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=mZ+0kqGIkanAPLI+m5pggCNrFnPQiendplj1FBInPhaA2TvhgMy787qSGLxUrC5jO
	 g1CMy11uPme3vku+PHsoJRbzZEMyZMWhwGmS9eC5KtPw/ld/riRAAETaU4oDtcS2bV
	 zJ6c0G+uBKAWFF7YxDRsZiJt43I1T+FkCOVovwZL/U0moBusKvPg/0Vh/iStL+81gO
	 B65ZUx1ST7+qIEhE5A1EA3lSh3ZnqQGCq84wJdSdFzflnQe9UfDA+gm6b4PTMijCi9
	 QvT6a8Pj6qtrMyAm+4HDd7aezoloN2y9v3CfSnax94qFsr91V2bp9Zbg/PYURWL+UV
	 jvdfmYMQI/Gxw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QljVy3tbhz1y1V;
	Tue, 20 Jun 2023 06:27:22 -0400 (EDT)
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com
 [207.171.188.200])
 by lists.lttng.org (Postfix) with ESMTPS id 4QljVw59zjz1yKP
 for <lttng-dev@lists.lttng.org>; Tue, 20 Jun 2023 06:27:20 -0400 (EDT)
X-IronPort-AV: E=Sophos;i="6.00,256,1681171200"; 
 d="scan'208,217";a="1138494247"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO
 email-inbound-relay-pdx-2a-m6i4x-8a14c045.us-west-2.amazon.com)
 ([10.25.36.214]) by smtp-border-fw-9103.sea19.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 10:27:11 +0000
Received: from EX19D008EUC001.ant.amazon.com
 (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
 by email-inbound-relay-pdx-2a-m6i4x-8a14c045.us-west-2.amazon.com (Postfix)
 with ESMTPS id B089D80456
 for <lttng-dev@lists.lttng.org>; Tue, 20 Jun 2023 10:27:10 +0000 (UTC)
Received: from EX19D008EUC001.ant.amazon.com (10.252.51.165) by
 EX19D008EUC001.ant.amazon.com (10.252.51.165) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.26;
 Tue, 20 Jun 2023 10:27:09 +0000
Received: from EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1]) by
 EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1%3]) with
 mapi id 15.02.1118.026; Tue, 20 Jun 2023 10:27:09 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: Profiling LTTng tracepoint latency on different arm platforms
Thread-Index: AQHZo2HEplRT2zY9N0ijivZSO5DOOA==
Date: Tue, 20 Jun 2023 10:27:09 +0000
Message-ID: <6e06b605ec9f446da5dc8948c8621518@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.85.143.172]
MIME-Version: 1.0
Subject: [lttng-dev] Profiling LTTng tracepoint latency on different arm
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
Content-Type: multipart/mixed; boundary="===============6493914625085299052=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============6493914625085299052==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_6e06b605ec9f446da5dc8948c8621518amazoncom_"

--_000_6e06b605ec9f446da5dc8948c8621518amazoncom_
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

CPU implementer   : 0x41

CPU architecture: 8

CPU variant       : 0x0

CPU part  : 0xd08

CPU revision      : 3



     *    Saw an average latency of 2-3usec


  *   [platform 2] with CPU info running a linux kernel based on Amazon Lin=
ux (4.14.294-220.533.amzn2.aarch64 aarch64 GNU/Linux):



BogoMIPS        : 243.75

Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp a=
simdhp cpuid asimdrdm lrcpc dcpop asimddp ssbs

CPU implementer   : 0x41

CPU architecture: 8

CPU variant       : 0x3

CPU part  : 0xd0c

CPU revision      : 1



     *   Saw an average latency of ~0.5usec







Are there any suggestions to root cause the high latency and potentially im=
prove it on platform 1?



Thanks and best regards,

Anas.


--_000_6e06b605ec9f446da5dc8948c8621518amazoncom_
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
<p><span id=3D"ms-rterangepaste-start"></span></p>
<div id=3D"divtagdefaultwrapper" style=3D"font-family: Calibri, Helvetica, =
sans-serif, serif, EmojiFont; font-size: 16px;">
<font face=3D"Calibri,Helvetica,sans-serif,EmojiFont,Apple Color Emoji,Sego=
e UI Emoji,NotoColorEmoji,Segoe UI Symbol,Android Emoji,EmojiSymbols" size=
=3D"3" color=3D"black"><span id=3D"divtagdefaultwrapper" style=3D"font-size=
: 12pt;">
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"4" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
4pt;">Hello</span></font><font size=3D"4" color=3D"black" style=3D"font-fam=
ily: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font=
-size: 14pt;">,</span></font></font></pre>
</div>
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;">&nbsp;</font></pre>
</div>
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"4" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
4pt;">I</span></font><font size=3D"4" color=3D"black" style=3D"font-family:=
 Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-siz=
e: 14pt;">'ve recently profiled the latency of LTTng tracepoints on arm pla=
tforms,</span></font></font></pre>
</div>
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"4" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
4pt;">using</span></font><font size=3D"4" color=3D"black" style=3D"font-fam=
ily: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font=
-size: 14pt;"> </span></font><font size=3D"4" color=3D"black" style=3D"font=
-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"=
font-size: 14pt;">the</span></font><font size=3D"4" color=3D"black" style=
=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span s=
tyle=3D"font-size: 14pt;"> </span></font><font size=3D"4" color=3D"black" s=
tyle=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><sp=
an style=3D"font-size: 14pt;">follow</span></font><font size=3D"4" color=3D=
"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiF=
ont;"><span style=3D"font-size: 14pt;"> </span></font><font size=3D"4" colo=
r=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, Em=
ojiFont;"><span style=3D"font-size: 14pt;">sample</span></font><font size=
=3D"4" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif=
, serif, EmojiFont;"><span style=3D"font-size: 14pt;"> </span></font><font =
size=3D"4" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-s=
erif, serif, EmojiFont;"><span style=3D"font-size: 14pt;">program</span></f=
ont><font size=3D"4" color=3D"black" style=3D"font-family: Calibri, Helveti=
ca, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;">:</span=
></font></font></pre>
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;">&nbsp;</font></pre>
</div>
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"3"><span style=3D"font-size: 12pt;">--------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
--------------------</span></font></font></pre>
</div>
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"3" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
2pt;"><b>static</b></span></font><font size=3D"3" color=3D"black" style=3D"=
font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=
=3D"font-size: 12pt;"><b> </b></span></font><font size=3D"3" color=3D"black=
" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;">=
<span style=3D"font-size: 12pt;"><b>inline</b></span></font><font size=3D"3=
" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, ser=
if, EmojiFont;"><span style=3D"font-size: 12pt;"><b> </b></span></font><fon=
t size=3D"3" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans=
-serif, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b>uint64_t</b>=
</span></font><font size=3D"3" color=3D"black" style=3D"font-family: Calibr=
i, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 12pt=
;"><b> </b></span></font><font size=3D"3" color=3D"black" style=3D"font-fam=
ily: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font=
-size: 12pt;"><b>get_time_nsec</b></span></font><font size=3D"3" color=3D"b=
lack" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFon=
t;"><span style=3D"font-size: 12pt;"><b>(</b></span></font><font size=3D"3"=
 color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, seri=
f, EmojiFont;"><span style=3D"font-size: 12pt;"><b>void</b></span></font><f=
ont size=3D"3" color=3D"black" style=3D"font-family: Calibri, Helvetica, sa=
ns-serif, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b>)</b></spa=
n></font></font></pre>
</div>
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"3" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
2pt;"><b>{</b></span></font></font></pre>
</div>
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"3" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
2pt;"><b>        </b></span></font><font size=3D"3" color=3D"black" style=
=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span s=
tyle=3D"font-size: 12pt;"><b>struct</b></span></font><font size=3D"3" color=
=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, Emo=
jiFont;"><span style=3D"font-size: 12pt;"><b> </b></span></font><font size=
=3D"3" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif=
, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b>timespec</b></span=
></font><font size=3D"3" color=3D"black" style=3D"font-family: Calibri, Hel=
vetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b>=
 </b></span></font><font size=3D"3" color=3D"black" style=3D"font-family: C=
alibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size:=
 12pt;"><b>ts</b></span></font><font size=3D"3" color=3D"black" style=3D"fo=
nt-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=
=3D"font-size: 12pt;"><b>;</b></span></font></font></pre>
</div>
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;">&nbsp;</font></pre>
</div>
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"3" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
2pt;"><b>        </b></span></font><font size=3D"3" color=3D"black" style=
=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span s=
tyle=3D"font-size: 12pt;"><b>if</b></span></font><font size=3D"3" color=3D"=
black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFo=
nt;"><span style=3D"font-size: 12pt;"><b> (</b></span></font><font size=3D"=
3" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, se=
rif, EmojiFont;"><span style=3D"font-size: 12pt;"><b>caa_unlikely</b></span=
></font><font size=3D"3" color=3D"black" style=3D"font-family: Calibri, Hel=
vetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b>=
(</b></span></font><font size=3D"3" color=3D"black" style=3D"font-family: C=
alibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size:=
 12pt;"><b>clock_gettime</b></span></font><font size=3D"3" color=3D"black" =
style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><s=
pan style=3D"font-size: 12pt;"><b>(</b></span></font><font size=3D"3" color=
=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, Emo=
jiFont;"><span style=3D"font-size: 12pt;"><b>CLOCK_MONOTONIC</b></span></fo=
nt><font size=3D"3" color=3D"black" style=3D"font-family: Calibri, Helvetic=
a, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b>, </b=
></span></font><font size=3D"3" color=3D"black" style=3D"font-family: Calib=
ri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 12p=
t;"><b>&amp;</b></span></font><font size=3D"3" color=3D"black" style=3D"fon=
t-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D=
"font-size: 12pt;"><b>ts</b></span></font><font size=3D"3" color=3D"black" =
style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><s=
pan style=3D"font-size: 12pt;"><b>))) {</b></span></font></font></pre>
</div>
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"3" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
2pt;"><b>                </b></span></font><font size=3D"3" color=3D"black"=
 style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><=
span style=3D"font-size: 12pt;"><b>ts</b></span></font><font size=3D"3" col=
or=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, E=
mojiFont;"><span style=3D"font-size: 12pt;"><b>.</b></span></font><font siz=
e=3D"3" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-seri=
f, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b>tv_sec</b></span>=
</font><font size=3D"3" color=3D"black" style=3D"font-family: Calibri, Helv=
etica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b> =
</b></span></font><font size=3D"3" color=3D"black" style=3D"font-family: Ca=
libri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: =
12pt;"><b>=3D</b></span></font><font size=3D"3" color=3D"black" style=3D"fo=
nt-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=
=3D"font-size: 12pt;"><b> </b></span></font><font size=3D"3" color=3D"black=
" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;">=
<span style=3D"font-size: 12pt;"><b>0</b></span></font><font size=3D"3" col=
or=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, E=
mojiFont;"><span style=3D"font-size: 12pt;"><b>;</b></span></font></font></=
pre>
</div>
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"3" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
2pt;"><b>                </b></span></font><font size=3D"3" color=3D"black"=
 style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><=
span style=3D"font-size: 12pt;"><b>ts</b></span></font><font size=3D"3" col=
or=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, E=
mojiFont;"><span style=3D"font-size: 12pt;"><b>.</b></span></font><font siz=
e=3D"3" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-seri=
f, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b>tv_nsec</b></span=
></font><font size=3D"3" color=3D"black" style=3D"font-family: Calibri, Hel=
vetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b>=
 </b></span></font><font size=3D"3" color=3D"black" style=3D"font-family: C=
alibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size:=
 12pt;"><b>=3D</b></span></font><font size=3D"3" color=3D"black" style=3D"f=
ont-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=
=3D"font-size: 12pt;"><b> </b></span></font><font size=3D"3" color=3D"black=
" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;">=
<span style=3D"font-size: 12pt;"><b>0</b></span></font><font size=3D"3" col=
or=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, E=
mojiFont;"><span style=3D"font-size: 12pt;"><b>;</b></span></font></font></=
pre>
</div>
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"3" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
2pt;"><b>        }</b></span></font></font></pre>
</div>
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"3" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
2pt;"><b>        </b></span></font><font size=3D"3" color=3D"black" style=
=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span s=
tyle=3D"font-size: 12pt;"><b>return</b></span></font><font size=3D"3" color=
=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, Emo=
jiFont;"><span style=3D"font-size: 12pt;"><b> ((</b></span></font><font siz=
e=3D"3" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-seri=
f, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b>uint64_t</b></spa=
n></font><font size=3D"3" color=3D"black" style=3D"font-family: Calibri, He=
lvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b=
>) </b></span></font><font size=3D"3" color=3D"black" style=3D"font-family:=
 Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-siz=
e: 12pt;"><b>ts</b></span></font><font size=3D"3" color=3D"black" style=3D"=
font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=
=3D"font-size: 12pt;"><b>.</b></span></font><font size=3D"3" color=3D"black=
" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;">=
<span style=3D"font-size: 12pt;"><b>tv_sec</b></span></font><font size=3D"3=
" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, ser=
if, EmojiFont;"><span style=3D"font-size: 12pt;"><b> </b></span></font><fon=
t size=3D"3" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans=
-serif, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b>*</b></span>=
</font><font size=3D"3" color=3D"black" style=3D"font-family: Calibri, Helv=
etica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b> =
</b></span></font><font size=3D"3" color=3D"black" style=3D"font-family: Ca=
libri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: =
12pt;"><b>1000000000ULL</b></span></font><font size=3D"3" color=3D"black" s=
tyle=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><sp=
an style=3D"font-size: 12pt;"><b>) </b></span></font><font size=3D"3" color=
=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, Emo=
jiFont;"><span style=3D"font-size: 12pt;"><b>&#43;</b></span></font><font s=
ize=3D"3" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-se=
rif, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b> </b></span></f=
ont><font size=3D"3" color=3D"black" style=3D"font-family: Calibri, Helveti=
ca, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b>ts</=
b></span></font><font size=3D"3" color=3D"black" style=3D"font-family: Cali=
bri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 12=
pt;"><b>.</b></span></font><font size=3D"3" color=3D"black" style=3D"font-f=
amily: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"fo=
nt-size: 12pt;"><b>tv_nsec</b></span></font><font size=3D"3" color=3D"black=
" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;">=
<span style=3D"font-size: 12pt;"><b>;</b></span></font></font></pre>
</div>
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"3" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
2pt;"><b>}</b></span></font></font></pre>
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"3" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
2pt;"><b>=0A=
</b></span></font></font></pre>
</div>
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;">&nbsp;</font></pre>
</div>
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"3" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
2pt;"><b>int</b></span></font><font size=3D"3" color=3D"black" style=3D"fon=
t-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D=
"font-size: 12pt;"><b> </b></span></font><font size=3D"3" color=3D"black" s=
tyle=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><sp=
an style=3D"font-size: 12pt;"><b>main</b></span></font><font size=3D"3" col=
or=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, E=
mojiFont;"><span style=3D"font-size: 12pt;"><b>(</b></span></font><font siz=
e=3D"3" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-seri=
f, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b>int</b></span></f=
ont><font size=3D"3" color=3D"black" style=3D"font-family: Calibri, Helveti=
ca, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b> </b=
></span></font><font size=3D"3" color=3D"black" style=3D"font-family: Calib=
ri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 12p=
t;"><b>argc</b></span></font><font size=3D"3" color=3D"black" style=3D"font=
-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"=
font-size: 12pt;"><b>, </b></span></font><font size=3D"3" color=3D"black" s=
tyle=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><sp=
an style=3D"font-size: 12pt;"><b>char</b></span></font><font size=3D"3" col=
or=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, E=
mojiFont;"><span style=3D"font-size: 12pt;"><b> </b></span></font><font siz=
e=3D"3" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-seri=
f, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b>*</b></span></fon=
t><font size=3D"3" color=3D"black" style=3D"font-family: Calibri, Helvetica=
, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b>argv</=
b></span></font><font size=3D"3" color=3D"black" style=3D"font-family: Cali=
bri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 12=
pt;"><b>[])</b></span></font></font></pre>
</div>
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"3" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
2pt;"><b>{</b></span></font></font></pre>
</div>
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"3" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
2pt;"><b>    </b></span></font><font size=3D"3" color=3D"black" style=3D"fo=
nt-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=
=3D"font-size: 12pt;"><b>unsigned</b></span></font><font size=3D"3" color=
=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, Emo=
jiFont;"><span style=3D"font-size: 12pt;"><b> </b></span></font><font size=
=3D"3" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif=
, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b>int</b></span></fo=
nt><font size=3D"3" color=3D"black" style=3D"font-family: Calibri, Helvetic=
a, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b> </b>=
</span></font><font size=3D"3" color=3D"black" style=3D"font-family: Calibr=
i, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 12pt=
;"><b>i</b></span></font><font size=3D"3" color=3D"black" style=3D"font-fam=
ily: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font=
-size: 12pt;"><b>;</b></span></font></font></pre>
</div>
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"3" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
2pt;"><b>    </b></span></font><font size=3D"3" color=3D"black" style=3D"fo=
nt-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=
=3D"font-size: 12pt;"><b>int</b></span></font><font size=3D"3" color=3D"bla=
ck" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;=
"><span style=3D"font-size: 12pt;"><b> </b></span></font><font size=3D"3" c=
olor=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif,=
 EmojiFont;"><span style=3D"font-size: 12pt;"><b>tp_num</b></span></font><f=
ont size=3D"3" color=3D"black" style=3D"font-family: Calibri, Helvetica, sa=
ns-serif, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b> </b></spa=
n></font><font size=3D"3" color=3D"black" style=3D"font-family: Calibri, He=
lvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b=
>=3D</b></span></font><font size=3D"3" color=3D"black" style=3D"font-family=
: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-si=
ze: 12pt;"><b> </b></span></font><font size=3D"3" color=3D"black" style=3D"=
font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=
=3D"font-size: 12pt;"><b>0</b></span></font><font size=3D"3" color=3D"black=
" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;">=
<span style=3D"font-size: 12pt;"><b>;</b></span></font></font></pre>
</div>
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"3" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
2pt;"><b>    </b></span></font><font size=3D"3" color=3D"black" style=3D"fo=
nt-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=
=3D"font-size: 12pt;"><b>uint64_t</b></span></font><font size=3D"3" color=
=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, Emo=
jiFont;"><span style=3D"font-size: 12pt;"><b> </b></span></font><font size=
=3D"3" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif=
, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b>total_time</b></sp=
an></font><font size=3D"3" color=3D"black" style=3D"font-family: Calibri, H=
elvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><=
b> </b></span></font><font size=3D"3" color=3D"black" style=3D"font-family:=
 Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-siz=
e: 12pt;"><b>=3D</b></span></font><font size=3D"3" color=3D"black" style=3D=
"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span styl=
e=3D"font-size: 12pt;"><b> </b></span></font><font size=3D"3" color=3D"blac=
k" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"=
><span style=3D"font-size: 12pt;"><b>0</b></span></font><font size=3D"3" co=
lor=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, =
EmojiFont;"><span style=3D"font-size: 12pt;"><b>;</b></span></font></font><=
/pre>
</div>
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"3" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
2pt;"><b>    </b></span></font><font size=3D"3" color=3D"black" style=3D"fo=
nt-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=
=3D"font-size: 12pt;"><b>uint64_t</b></span></font><font size=3D"3" color=
=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, Emo=
jiFont;"><span style=3D"font-size: 12pt;"><b> </b></span></font><font size=
=3D"3" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif=
, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b>now</b></span></fo=
nt><font size=3D"3" color=3D"black" style=3D"font-family: Calibri, Helvetic=
a, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b>, </b=
></span></font><font size=3D"3" color=3D"black" style=3D"font-family: Calib=
ri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 12p=
t;"><b>nowz</b></span></font><font size=3D"3" color=3D"black" style=3D"font=
-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"=
font-size: 12pt;"><b>;</b></span></font></font></pre>
</div>
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;">&nbsp;</font></pre>
</div>
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"3" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
2pt;"><b>    </b></span></font><font size=3D"3" color=3D"black" style=3D"fo=
nt-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=
=3D"font-size: 12pt;"><b>if</b></span></font><font size=3D"3" color=3D"blac=
k" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"=
><span style=3D"font-size: 12pt;"><b> (</b></span></font><font size=3D"3" c=
olor=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif,=
 EmojiFont;"><span style=3D"font-size: 12pt;"><b>argc</b></span></font><fon=
t size=3D"3" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans=
-serif, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b> </b></span>=
</font><font size=3D"3" color=3D"black" style=3D"font-family: Calibri, Helv=
etica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b>&=
gt;</b></span></font><font size=3D"3" color=3D"black" style=3D"font-family:=
 Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-siz=
e: 12pt;"><b> </b></span></font><font size=3D"3" color=3D"black" style=3D"f=
ont-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=
=3D"font-size: 12pt;"><b>1</b></span></font><font size=3D"3" color=3D"black=
" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;">=
<span style=3D"font-size: 12pt;"><b>) {</b></span></font></font></pre>
</div>
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"3" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
2pt;"><b>        </b></span></font><font size=3D"3" color=3D"black" style=
=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span s=
tyle=3D"font-size: 12pt;"><b>sscanf</b></span></font><font size=3D"3" color=
=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, Emo=
jiFont;"><span style=3D"font-size: 12pt;"><b> (</b></span></font><font size=
=3D"3" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif=
, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b>argv</b></span></f=
ont><font size=3D"3" color=3D"black" style=3D"font-family: Calibri, Helveti=
ca, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b>[</b=
></span></font><font size=3D"3" color=3D"black" style=3D"font-family: Calib=
ri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 12p=
t;"><b>1</b></span></font><font size=3D"3" color=3D"black" style=3D"font-fa=
mily: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"fon=
t-size: 12pt;"><b>],</b></span></font><font size=3D"3" color=3D"black" styl=
e=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span =
style=3D"font-size: 12pt;"><b>&quot;%d&quot;</b></span></font><font size=3D=
"3" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, s=
erif, EmojiFont;"><span style=3D"font-size: 12pt;"><b>,</b></span></font><f=
ont size=3D"3" color=3D"black" style=3D"font-family: Calibri, Helvetica, sa=
ns-serif, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b>&amp;</b><=
/span></font><font size=3D"3" color=3D"black" style=3D"font-family: Calibri=
, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 12pt;=
"><b>tp_num</b></span></font><font size=3D"3" color=3D"black" style=3D"font=
-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"=
font-size: 12pt;"><b>);</b></span></font></font></pre>
</div>
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"3" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
2pt;"><b>    }</b></span></font></font></pre>
</div>
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"3" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
2pt;"><b>    </b></span></font><font size=3D"3" color=3D"black" style=3D"fo=
nt-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=
=3D"font-size: 12pt;"><b>for</b></span></font><font size=3D"3" color=3D"bla=
ck" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;=
"><span style=3D"font-size: 12pt;"><b> (</b></span></font><font size=3D"3" =
color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif=
, EmojiFont;"><span style=3D"font-size: 12pt;"><b>i</b></span></font><font =
size=3D"3" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-s=
erif, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b> </b></span></=
font><font size=3D"3" color=3D"black" style=3D"font-family: Calibri, Helvet=
ica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b>=3D=
</b></span></font><font size=3D"3" color=3D"black" style=3D"font-family: Ca=
libri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: =
12pt;"><b> </b></span></font><font size=3D"3" color=3D"black" style=3D"font=
-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"=
font-size: 12pt;"><b>0</b></span></font><font size=3D"3" color=3D"black" st=
yle=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><spa=
n style=3D"font-size: 12pt;"><b>; </b></span></font><font size=3D"3" color=
=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, Emo=
jiFont;"><span style=3D"font-size: 12pt;"><b>i</b></span></font><font size=
=3D"3" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif=
, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b> </b></span></font=
><font size=3D"3" color=3D"black" style=3D"font-family: Calibri, Helvetica,=
 sans-serif, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b>&lt;</b=
></span></font><font size=3D"3" color=3D"black" style=3D"font-family: Calib=
ri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 12p=
t;"><b> </b></span></font><font size=3D"3" color=3D"black" style=3D"font-fa=
mily: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"fon=
t-size: 12pt;"><b>tp_num</b></span></font><font size=3D"3" color=3D"black" =
style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><s=
pan style=3D"font-size: 12pt;"><b>; </b></span></font><font size=3D"3" colo=
r=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, Em=
ojiFont;"><span style=3D"font-size: 12pt;"><b>i</b></span></font><font size=
=3D"3" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif=
, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b>&#43;&#43;</b></sp=
an></font><font size=3D"3" color=3D"black" style=3D"font-family: Calibri, H=
elvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><=
b>) {</b></span></font></font></pre>
</div>
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"3" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
2pt;"><b>        </b></span></font><font size=3D"3" color=3D"black" style=
=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span s=
tyle=3D"font-size: 12pt;"><b>now</b></span></font><font size=3D"3" color=3D=
"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiF=
ont;"><span style=3D"font-size: 12pt;"><b> </b></span></font><font size=3D"=
3" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, se=
rif, EmojiFont;"><span style=3D"font-size: 12pt;"><b>=3D</b></span></font><=
font size=3D"3" color=3D"black" style=3D"font-family: Calibri, Helvetica, s=
ans-serif, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b> </b></sp=
an></font><font size=3D"3" color=3D"black" style=3D"font-family: Calibri, H=
elvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><=
b>get_time_nsec</b></span></font><font size=3D"3" color=3D"black" style=3D"=
font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=
=3D"font-size: 12pt;"><b>();</b></span></font></font></pre>
</div>
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"3" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
2pt;"><b>        </b></span></font><font size=3D"3" color=3D"black" style=
=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span s=
tyle=3D"font-size: 12pt;"><b>lttng_ust_tracepoint</b></span></font><font si=
ze=3D"3" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-ser=
if, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b>(</b></span></fo=
nt><font size=3D"3" color=3D"black" style=3D"font-family: Calibri, Helvetic=
a, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b>hello=
_world</b></span></font><font size=3D"3" color=3D"black" style=3D"font-fami=
ly: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-=
size: 12pt;"><b>, </b></span></font><font size=3D"3" color=3D"black" style=
=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span s=
tyle=3D"font-size: 12pt;"><b>my_first_tracepoint</b></span></font><font siz=
e=3D"3" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-seri=
f, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b>,</b></span></fon=
t></font></pre>
</div>
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"3" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
2pt;"><b>                             </b></span></font><font size=3D"3" co=
lor=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, =
EmojiFont;"><span style=3D"font-size: 12pt;"><b>i</b></span></font><font si=
ze=3D"3" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-ser=
if, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b>, </b></span></f=
ont><font size=3D"3" color=3D"black" style=3D"font-family: Calibri, Helveti=
ca, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b>&quo=
t;some_str&quot;</b></span></font><font size=3D"3" color=3D"black" style=3D=
"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span styl=
e=3D"font-size: 12pt;"><b>);</b></span></font></font></pre>
</div>
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"3" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
2pt;"><b>        </b></span></font><font size=3D"3" color=3D"black" style=
=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span s=
tyle=3D"font-size: 12pt;"><b>nowz</b></span></font><font size=3D"3" color=
=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, Emo=
jiFont;"><span style=3D"font-size: 12pt;"><b> </b></span></font><font size=
=3D"3" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif=
, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b>=3D</b></span></fo=
nt><font size=3D"3" color=3D"black" style=3D"font-family: Calibri, Helvetic=
a, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b> </b>=
</span></font><font size=3D"3" color=3D"black" style=3D"font-family: Calibr=
i, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 12pt=
;"><b>get_time_nsec</b></span></font><font size=3D"3" color=3D"black" style=
=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span s=
tyle=3D"font-size: 12pt;"><b>();</b></span></font></font></pre>
</div>
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"3" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
2pt;"><b>        </b></span></font><font size=3D"3" color=3D"black" style=
=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span s=
tyle=3D"font-size: 12pt;"><b>total_time</b></span></font><font size=3D"3" c=
olor=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif,=
 EmojiFont;"><span style=3D"font-size: 12pt;"><b> </b></span></font><font s=
ize=3D"3" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-se=
rif, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b>&#43;=3D</b></s=
pan></font><font size=3D"3" color=3D"black" style=3D"font-family: Calibri, =
Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 12pt;">=
<b> (</b></span></font><font size=3D"3" color=3D"black" style=3D"font-famil=
y: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-s=
ize: 12pt;"><b>nowz</b></span></font><font size=3D"3" color=3D"black" style=
=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span s=
tyle=3D"font-size: 12pt;"><b> </b></span></font><font size=3D"3" color=3D"b=
lack" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFon=
t;"><span style=3D"font-size: 12pt;"><b>-</b></span></font><font size=3D"3"=
 color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, seri=
f, EmojiFont;"><span style=3D"font-size: 12pt;"><b> </b></span></font><font=
 size=3D"3" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-=
serif, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b>now</b></span=
></font><font size=3D"3" color=3D"black" style=3D"font-family: Calibri, Hel=
vetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b>=
);</b></span></font></font></pre>
</div>
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"3" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
2pt;"><b>    }</b></span></font></font></pre>
</div>
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;">&nbsp;</font></pre>
</div>
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"3" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
2pt;"><b>    </b></span></font><font size=3D"3" color=3D"black" style=3D"fo=
nt-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=
=3D"font-size: 12pt;"><b>if</b></span></font><font size=3D"3" color=3D"blac=
k" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"=
><span style=3D"font-size: 12pt;"><b> (</b></span></font><font size=3D"3" c=
olor=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif,=
 EmojiFont;"><span style=3D"font-size: 12pt;"><b>tp_num</b></span></font><f=
ont size=3D"3" color=3D"black" style=3D"font-family: Calibri, Helvetica, sa=
ns-serif, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b>) {</b></s=
pan></font></font></pre>
</div>
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"3" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
2pt;"><b>        </b></span></font><font size=3D"3" color=3D"black" style=
=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span s=
tyle=3D"font-size: 12pt;"><b>printf</b></span></font><font size=3D"3" color=
=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, Emo=
jiFont;"><span style=3D"font-size: 12pt;"><b>(</b></span></font><font size=
=3D"3" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif=
, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b>&quot;------------=
---------------Average TP time is %&quot;</b></span></font><font size=3D"3"=
 color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, seri=
f, EmojiFont;"><span style=3D"font-size: 12pt;"><b>PRIu64</b></span></font>=
<font size=3D"3" color=3D"black" style=3D"font-family: Calibri, Helvetica, =
sans-serif, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b>&quot;--=
-------------------------\n&quot;</b></span></font><font size=3D"3" color=
=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, Emo=
jiFont;"><span style=3D"font-size: 12pt;"><b>, </b></span></font><font size=
=3D"3" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif=
, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><b>total_time</b></sp=
an></font><font size=3D"3" color=3D"black" style=3D"font-family: Calibri, H=
elvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 12pt;"><=
b> </b></span></font><font size=3D"3" color=3D"black" style=3D"font-family:=
 Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-siz=
e: 12pt;"><b>/</b></span></font><font size=3D"3" color=3D"black" style=3D"f=
ont-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=
=3D"font-size: 12pt;"><b> </b></span></font><font size=3D"3" color=3D"black=
" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;">=
<span style=3D"font-size: 12pt;"><b>tp_num</b></span></font><font size=3D"3=
" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, ser=
if, EmojiFont;"><span style=3D"font-size: 12pt;"><b>);      </b></span></fo=
nt></font></pre>
</div>
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"3" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
2pt;"><b>    }</b></span></font></font></pre>
</div>
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"3" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
2pt;"><b>}</b></span></font></font></pre>
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"3"><span style=3D"font-size: 12pt;">--------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
--------------------</span></font></font></pre>
</div>
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;">&nbsp;</font></pre>
</div>
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"4" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
4pt;">=0A=
</span></font></font></pre>
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"4" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
4pt;">I</span></font><font size=3D"4" color=3D"black" style=3D"font-family:=
 Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-siz=
e: 14pt;"> </span></font><font size=3D"4" color=3D"black" style=3D"font-fam=
ily: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font=
-size: 14pt;">observed</span></font><font size=3D"4" color=3D"black" style=
=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span s=
tyle=3D"font-size: 14pt;"> </span></font><font size=3D"4" color=3D"black" s=
tyle=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><sp=
an style=3D"font-size: 14pt;">a</span></font><font size=3D"4" color=3D"blac=
k" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"=
><span style=3D"font-size: 14pt;"> </span></font><font size=3D"4" color=3D"=
black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFo=
nt;"><span style=3D"font-size: 14pt;">big</span></font><font size=3D"4" col=
or=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, E=
mojiFont;"><span style=3D"font-size: 14pt;"> </span></font><font size=3D"4"=
 color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, seri=
f, EmojiFont;"><span style=3D"font-size: 14pt;">average</span></font><font =
size=3D"4" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-s=
erif, serif, EmojiFont;"><span style=3D"font-size: 14pt;"> </span></font><f=
ont size=3D"4" color=3D"black" style=3D"font-family: Calibri, Helvetica, sa=
ns-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;">latency</span=
></font><font size=3D"4" color=3D"black" style=3D"font-family: Calibri, Hel=
vetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;"> </=
span></font><font size=3D"4" color=3D"black" style=3D"font-family: Calibri,=
 Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;"=
>variance</span></font><font size=3D"4" color=3D"black" style=3D"font-famil=
y: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-s=
ize: 14pt;"> </span></font><font size=3D"4" color=3D"black" style=3D"font-f=
amily: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"fo=
nt-size: 14pt;">on</span></font><font size=3D"4" color=3D"black" style=3D"f=
ont-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=
=3D"font-size: 14pt;"> </span></font><font size=3D"4" color=3D"black" style=
=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span s=
tyle=3D"font-size: 14pt;">different</span></font><font size=3D"4" color=3D"=
black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFo=
nt;"><span style=3D"font-size: 14pt;"> </span></font><font size=3D"4" color=
=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, Emo=
jiFont;"><span style=3D"font-size: 14pt;">platforms</span></font><font size=
=3D"4" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif=
, serif, EmojiFont;"><span style=3D"font-size: 14pt;"> </span></font><font =
size=3D"4" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-s=
erif, serif, EmojiFont;"><span style=3D"font-size: 14pt;">when</span></font=
><font size=3D"4" color=3D"black" style=3D"font-family: Calibri, Helvetica,=
 sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;"> </span></=
font><font size=3D"4" color=3D"black" style=3D"font-family: Calibri, Helvet=
ica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;">tracin=
g</span></font><font size=3D"4" color=3D"black" style=3D"font-family: Calib=
ri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14p=
t;"> </span></font><font size=3D"4" color=3D"black" style=3D"font-family: C=
alibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size:=
 14pt;">a</span></font><font size=3D"4" color=3D"black" style=3D"font-famil=
y: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-s=
ize: 14pt;"> </span></font><font size=3D"4" color=3D"black" style=3D"font-f=
amily: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"fo=
nt-size: 14pt;">high</span></font><font size=3D"4" color=3D"black" style=3D=
"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span styl=
e=3D"font-size: 14pt;"> </span></font><font size=3D"4" color=3D"black" styl=
e=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span =
style=3D"font-size: 14pt;">number</span></font><font size=3D"4" color=3D"bl=
ack" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont=
;"><span style=3D"font-size: 14pt;"> (</span></font><font size=3D"4" color=
=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, Emo=
jiFont;"><span style=3D"font-size: 14pt;">many</span></font><font size=3D"4=
" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, ser=
if, EmojiFont;"><span style=3D"font-size: 14pt;"> </span></font><font size=
=3D"4" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif=
, serif, EmojiFont;"><span style=3D"font-size: 14pt;">thousands</span></fon=
t><font size=3D"4" color=3D"black" style=3D"font-family: Calibri, Helvetica=
, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;"> </span><=
/font><font size=3D"4" color=3D"black" style=3D"font-family: Calibri, Helve=
tica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;">to</s=
pan></font><font size=3D"4" color=3D"black" style=3D"font-family: Calibri, =
Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;">=
 </span></font><font size=3D"4" color=3D"black" style=3D"font-family: Calib=
ri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14p=
t;">millions</span></font><font size=3D"4" color=3D"black" style=3D"font-fa=
mily: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"fon=
t-size: 14pt;">) </span></font><font size=3D"4" color=3D"black" style=3D"fo=
nt-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=
=3D"font-size: 14pt;">of</span></font><font size=3D"4" color=3D"black" styl=
e=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span =
style=3D"font-size: 14pt;"> </span></font><font size=3D"4" color=3D"black" =
style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><s=
pan style=3D"font-size: 14pt;">tracepoints</span></font><font size=3D"4" co=
lor=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, =
EmojiFont;"><span style=3D"font-size: 14pt;">:</span></font></font></pre>
</div>
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;">&nbsp;</font></pre>
</div>
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><ul style=3D"margin-top: 0px; margin-bottom: 0px;"><li><fo=
nt size=3D"4" color=3D"black" style=3D"font-family: Calibri, Helvetica, san=
s-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;"><b>[platform</=
b></span></font><font size=3D"4" color=3D"black" style=3D"font-family: Cali=
bri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14=
pt;"><b> </b></span></font><font size=3D"4" color=3D"black" style=3D"font-f=
amily: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"fo=
nt-size: 14pt;"><b>1]</b></span></font><font size=3D"4" color=3D"black" sty=
le=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span=
 style=3D"font-size: 14pt;"> </span></font><font size=3D"4" color=3D"black"=
 style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><=
span style=3D"font-size: 14pt;">with</span></font><font size=3D"4" color=3D=
"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiF=
ont;"><span style=3D"font-size: 14pt;"> </span></font><font size=3D"4" colo=
r=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, Em=
ojiFont;"><span style=3D"font-size: 14pt;">CPU</span></font><font size=3D"4=
" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, ser=
if, EmojiFont;"><span style=3D"font-size: 14pt;"> </span></font><font size=
=3D"4" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif=
, serif, EmojiFont;"><span style=3D"font-size: 14pt;">info</span></font><fo=
nt size=3D"4" color=3D"black" style=3D"font-family: Calibri, Helvetica, san=
s-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;"> </span></font=
><font size=3D"4" color=3D"black" style=3D"font-family: Calibri, Helvetica,=
 sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;">running</s=
pan></font><font size=3D"4" color=3D"black" style=3D"font-family: Calibri, =
Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;">=
 </span></font><font size=3D"4" color=3D"black" style=3D"font-family: Calib=
ri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14p=
t;">a</span></font><font size=3D"4" color=3D"black" style=3D"font-family: C=
alibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size:=
 14pt;"> </span></font><font size=3D"4" color=3D"black" style=3D"font-famil=
y: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-s=
ize: 14pt;">linux</span></font><font size=3D"4" color=3D"black" style=3D"fo=
nt-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=
=3D"font-size: 14pt;"> </span></font><font size=3D"4" color=3D"black" style=
=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span s=
tyle=3D"font-size: 14pt;">kernel</span></font><font size=3D"4" color=3D"bla=
ck" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;=
"><span style=3D"font-size: 14pt;"> </span></font><font size=3D"4" color=3D=
"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiF=
ont;"><span style=3D"font-size: 14pt;">based</span></font><font size=3D"4" =
color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif=
, EmojiFont;"><span style=3D"font-size: 14pt;"> </span></font><font size=3D=
"4" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, s=
erif, EmojiFont;"><span style=3D"font-size: 14pt;">on</span></font><font si=
ze=3D"4" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-ser=
if, serif, EmojiFont;"><span style=3D"font-size: 14pt;"> </span></font><fon=
t size=3D"4" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans=
-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;">Buildroot</span=
></font><font size=3D"4" color=3D"black" style=3D"font-family: Calibri, Hel=
vetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;"> (<=
/span></font><font size=3D"4" color=3D"black" style=3D"font-family: Calibri=
, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;=
">4.19.273</span></font><font size=3D"4" color=3D"black" style=3D"font-fami=
ly: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-=
size: 14pt;"> </span></font><font size=3D"4" color=3D"black" style=3D"font-=
family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"f=
ont-size: 14pt;">aarch64</span></font><font size=3D"4" color=3D"black" styl=
e=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span =
style=3D"font-size: 14pt;"> </span></font><font size=3D"4" color=3D"black" =
style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><s=
pan style=3D"font-size: 14pt;">GNU</span></font><font size=3D"4" color=3D"b=
lack" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFon=
t;"><span style=3D"font-size: 14pt;">/</span></font><font size=3D"4" color=
=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, Emo=
jiFont;"><span style=3D"font-size: 14pt;">Linux</span></font><font size=3D"=
4" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, se=
rif, EmojiFont;"><span style=3D"font-size: 14pt;">):</span></font></li></ul=
></font></pre>
</div>
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;">&nbsp;</font></pre>
</div>
</span></font></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont=
; font-size: 16px; margin: 0px 0px 0px 40px; padding: 0px; border-style: no=
ne;">
<div style=3D"margin: 0px 0px 0px 40px; padding: 0px; border-style: none;">
<div><font face=3D"Calibri,Helvetica,sans-serif,EmojiFont,Apple Color Emoji=
,Segoe UI Emoji,NotoColorEmoji,Segoe UI Symbol,Android Emoji,EmojiSymbols" =
size=3D"3" color=3D"black"><span style=3D"font-size: 12pt;">
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"4" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
4pt;">BogoMIPS</span></font><font size=3D"4" color=3D"black" style=3D"font-=
family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"f=
ont-size: 14pt;">        : </span></font><font size=3D"4" color=3D"black" s=
tyle=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><sp=
an style=3D"font-size: 14pt;">187.50</span></font></font></pre>
</div>
</span></font></div>
</div>
<div style=3D"margin: 0px 0px 0px 40px; padding: 0px; border-style: none;">
<div><font face=3D"Calibri,Helvetica,sans-serif,EmojiFont,Apple Color Emoji=
,Segoe UI Emoji,NotoColorEmoji,Segoe UI Symbol,Android Emoji,EmojiSymbols" =
size=3D"3" color=3D"black"><span style=3D"font-size: 12pt;">
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"4" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
4pt;">Features</span></font><font size=3D"4" color=3D"black" style=3D"font-=
family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"f=
ont-size: 14pt;">        : </span></font><font size=3D"4" color=3D"black" s=
tyle=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><sp=
an style=3D"font-size: 14pt;">fp</span></font><font size=3D"4" color=3D"bla=
ck" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;=
"><span style=3D"font-size: 14pt;"> </span></font><font size=3D"4" color=3D=
"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiF=
ont;"><span style=3D"font-size: 14pt;">asimd</span></font><font size=3D"4" =
color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif=
, EmojiFont;"><span style=3D"font-size: 14pt;"> </span></font><font size=3D=
"4" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, s=
erif, EmojiFont;"><span style=3D"font-size: 14pt;">evtstrm</span></font><fo=
nt size=3D"4" color=3D"black" style=3D"font-family: Calibri, Helvetica, san=
s-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;"> </span></font=
><font size=3D"4" color=3D"black" style=3D"font-family: Calibri, Helvetica,=
 sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;">aes</span>=
</font><font size=3D"4" color=3D"black" style=3D"font-family: Calibri, Helv=
etica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;"> </s=
pan></font><font size=3D"4" color=3D"black" style=3D"font-family: Calibri, =
Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;">=
pmull</span></font><font size=3D"4" color=3D"black" style=3D"font-family: C=
alibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size:=
 14pt;"> </span></font><font size=3D"4" color=3D"black" style=3D"font-famil=
y: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-s=
ize: 14pt;">sha1</span></font><font size=3D"4" color=3D"black" style=3D"fon=
t-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D=
"font-size: 14pt;"> </span></font><font size=3D"4" color=3D"black" style=3D=
"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span styl=
e=3D"font-size: 14pt;">sha2</span></font><font size=3D"4" color=3D"black" s=
tyle=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><sp=
an style=3D"font-size: 14pt;"> </span></font><font size=3D"4" color=3D"blac=
k" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"=
><span style=3D"font-size: 14pt;">crc32</span></font><font size=3D"4" color=
=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, Emo=
jiFont;"><span style=3D"font-size: 14pt;"> </span></font><font size=3D"4" c=
olor=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif,=
 EmojiFont;"><span style=3D"font-size: 14pt;">cpuid</span></font></font></p=
re>
</div>
</span></font></div>
</div>
<div style=3D"margin: 0px 0px 0px 40px; padding: 0px; border-style: none;">
<div><font face=3D"Calibri,Helvetica,sans-serif,EmojiFont,Apple Color Emoji=
,Segoe UI Emoji,NotoColorEmoji,Segoe UI Symbol,Android Emoji,EmojiSymbols" =
size=3D"3" color=3D"black"><span style=3D"font-size: 12pt;">
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"4" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
4pt;">CPU</span></font><font size=3D"4" color=3D"black" style=3D"font-famil=
y: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-s=
ize: 14pt;"> </span></font><font size=3D"4" color=3D"black" style=3D"font-f=
amily: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"fo=
nt-size: 14pt;">implementer</span></font><font size=3D"4" color=3D"black" s=
tyle=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><sp=
an style=3D"font-size: 14pt;">   : </span></font><font size=3D"4" color=3D"=
black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFo=
nt;"><span style=3D"font-size: 14pt;">0x41</span></font></font></pre>
</div>
</span></font></div>
</div>
<div style=3D"margin: 0px 0px 0px 40px; padding: 0px; border-style: none;">
<div><font face=3D"Calibri,Helvetica,sans-serif,EmojiFont,Apple Color Emoji=
,Segoe UI Emoji,NotoColorEmoji,Segoe UI Symbol,Android Emoji,EmojiSymbols" =
size=3D"3" color=3D"black"><span style=3D"font-size: 12pt;">
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"4" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
4pt;">CPU</span></font><font size=3D"4" color=3D"black" style=3D"font-famil=
y: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-s=
ize: 14pt;"> </span></font><font size=3D"4" color=3D"black" style=3D"font-f=
amily: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"fo=
nt-size: 14pt;">architecture</span></font><font size=3D"4" color=3D"black" =
style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><s=
pan style=3D"font-size: 14pt;">: </span></font><font size=3D"4" color=3D"bl=
ack" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont=
;"><span style=3D"font-size: 14pt;">8</span></font></font></pre>
</div>
</span></font></div>
</div>
<div style=3D"margin: 0px 0px 0px 40px; padding: 0px; border-style: none;">
<div><font face=3D"Calibri,Helvetica,sans-serif,EmojiFont,Apple Color Emoji=
,Segoe UI Emoji,NotoColorEmoji,Segoe UI Symbol,Android Emoji,EmojiSymbols" =
size=3D"3" color=3D"black"><span style=3D"font-size: 12pt;">
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"4" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
4pt;">CPU</span></font><font size=3D"4" color=3D"black" style=3D"font-famil=
y: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-s=
ize: 14pt;"> </span></font><font size=3D"4" color=3D"black" style=3D"font-f=
amily: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"fo=
nt-size: 14pt;">variant</span></font><font size=3D"4" color=3D"black" style=
=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span s=
tyle=3D"font-size: 14pt;">       : </span></font><font size=3D"4" color=3D"=
black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFo=
nt;"><span style=3D"font-size: 14pt;">0x0</span></font></font></pre>
</div>
</span></font></div>
</div>
<div style=3D"margin: 0px 0px 0px 40px; padding: 0px; border-style: none;">
<div><font face=3D"Calibri,Helvetica,sans-serif,EmojiFont,Apple Color Emoji=
,Segoe UI Emoji,NotoColorEmoji,Segoe UI Symbol,Android Emoji,EmojiSymbols" =
size=3D"3" color=3D"black"><span style=3D"font-size: 12pt;">
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"4" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
4pt;">CPU</span></font><font size=3D"4" color=3D"black" style=3D"font-famil=
y: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-s=
ize: 14pt;"> </span></font><font size=3D"4" color=3D"black" style=3D"font-f=
amily: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"fo=
nt-size: 14pt;">part</span></font><font size=3D"4" color=3D"black" style=3D=
"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span styl=
e=3D"font-size: 14pt;">  : </span></font><font size=3D"4" color=3D"black" s=
tyle=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><sp=
an style=3D"font-size: 14pt;">0xd08</span></font></font></pre>
</div>
</span></font></div>
</div>
<div style=3D"margin: 0px 0px 0px 40px; padding: 0px; border-style: none;">
<div><font face=3D"Calibri,Helvetica,sans-serif,EmojiFont,Apple Color Emoji=
,Segoe UI Emoji,NotoColorEmoji,Segoe UI Symbol,Android Emoji,EmojiSymbols" =
size=3D"3" color=3D"black"><span style=3D"font-size: 12pt;">
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"4" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
4pt;">CPU</span></font><font size=3D"4" color=3D"black" style=3D"font-famil=
y: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-s=
ize: 14pt;"> </span></font><font size=3D"4" color=3D"black" style=3D"font-f=
amily: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"fo=
nt-size: 14pt;">revision</span></font><font size=3D"4" color=3D"black" styl=
e=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span =
style=3D"font-size: 14pt;">      : </span></font><font size=3D"4" color=3D"=
black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFo=
nt;"><span style=3D"font-size: 14pt;">3</span></font></font></pre>
</div>
</span></font></div>
</div>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont=
; font-size: 16px; margin: 0px 0px 0px 40px; padding: 0px; border-style: no=
ne;">
<font face=3D"Calibri,Helvetica,sans-serif,EmojiFont,Apple Color Emoji,Sego=
e UI Emoji,NotoColorEmoji,Segoe UI Symbol,Android Emoji,EmojiSymbols" size=
=3D"3" color=3D"black"><span style=3D"font-size: 12pt;">
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;">&nbsp;</font></pre>
</div>
</span></font></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont=
; font-size: 16px;">
<font face=3D"Calibri,Helvetica,sans-serif,EmojiFont,Apple Color Emoji,Sego=
e UI Emoji,NotoColorEmoji,Segoe UI Symbol,Android Emoji,EmojiSymbols" size=
=3D"3" color=3D"black"><span style=3D"font-size: 12pt;">
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><ul style=3D"margin-top: 0px; margin-bottom: 0px;"><ul><li=
><font size=3D"4" color=3D"black" style=3D"font-family: Calibri, Helvetica,=
 sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;">&nbsp;Saw<=
/span></font><font size=3D"4" color=3D"black" style=3D"font-family: Calibri=
, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;=
"> </span></font><font size=3D"4" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
4pt;">an</span></font><font size=3D"4" color=3D"black" style=3D"font-family=
: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-si=
ze: 14pt;"> </span></font><font size=3D"4" color=3D"black" style=3D"font-fa=
mily: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"fon=
t-size: 14pt;">average</span></font><font size=3D"4" color=3D"black" style=
=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span s=
tyle=3D"font-size: 14pt;"> </span></font><font size=3D"4" color=3D"black" s=
tyle=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><sp=
an style=3D"font-size: 14pt;">latency</span></font><font size=3D"4" color=
=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, Emo=
jiFont;"><span style=3D"font-size: 14pt;"> </span></font><font size=3D"4" c=
olor=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif,=
 EmojiFont;"><span style=3D"font-size: 14pt;">of</span></font><font size=3D=
"4" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, s=
erif, EmojiFont;"><span style=3D"font-size: 14pt;"> </span></font><font siz=
e=3D"4" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-seri=
f, serif, EmojiFont;"><span style=3D"font-size: 14pt;"><b>2</b></span></fon=
t><font size=3D"4" color=3D"black" style=3D"font-family: Calibri, Helvetica=
, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;"><b>-</b><=
/span></font><font size=3D"4" color=3D"black" style=3D"font-family: Calibri=
, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;=
"><b>3usec=0A=
=0A=
</b></span></font></li></ul><li><font size=3D"4" color=3D"black" style=3D"f=
ont-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=
=3D"font-size: 14pt;"><b>[platform</b></span></font><font size=3D"4" color=
=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, Emo=
jiFont;"><span style=3D"font-size: 14pt;"><b> </b></span></font><font size=
=3D"4" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif=
, serif, EmojiFont;"><span style=3D"font-size: 14pt;"><b>2]</b></span></fon=
t><font size=3D"4" color=3D"black" style=3D"font-family: Calibri, Helvetica=
, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;"> </span><=
/font><font size=3D"4" color=3D"black" style=3D"font-family: Calibri, Helve=
tica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;">with<=
/span></font><font size=3D"4" color=3D"black" style=3D"font-family: Calibri=
, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;=
"> </span></font><font size=3D"4" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
4pt;">CPU</span></font><font size=3D"4" color=3D"black" style=3D"font-famil=
y: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-s=
ize: 14pt;"> </span></font><font size=3D"4" color=3D"black" style=3D"font-f=
amily: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"fo=
nt-size: 14pt;">info</span></font><font size=3D"4" color=3D"black" style=3D=
"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span styl=
e=3D"font-size: 14pt;"> </span></font><font size=3D"4" color=3D"black" styl=
e=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span =
style=3D"font-size: 14pt;">running</span></font><font size=3D"4" color=3D"b=
lack" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFon=
t;"><span style=3D"font-size: 14pt;"> </span></font><font size=3D"4" color=
=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, Emo=
jiFont;"><span style=3D"font-size: 14pt;">a</span></font><font size=3D"4" c=
olor=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif,=
 EmojiFont;"><span style=3D"font-size: 14pt;"> </span></font><font size=3D"=
4" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, se=
rif, EmojiFont;"><span style=3D"font-size: 14pt;">linux</span></font><font =
size=3D"4" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-s=
erif, serif, EmojiFont;"><span style=3D"font-size: 14pt;"> </span></font><f=
ont size=3D"4" color=3D"black" style=3D"font-family: Calibri, Helvetica, sa=
ns-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;">kernel</span>=
</font><font size=3D"4" color=3D"black" style=3D"font-family: Calibri, Helv=
etica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;"> </s=
pan></font><font size=3D"4" color=3D"black" style=3D"font-family: Calibri, =
Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;">=
based</span></font><font size=3D"4" color=3D"black" style=3D"font-family: C=
alibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size:=
 14pt;"> </span></font><font size=3D"4" color=3D"black" style=3D"font-famil=
y: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-s=
ize: 14pt;">on</span></font><font size=3D"4" color=3D"black" style=3D"font-=
family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"f=
ont-size: 14pt;"> </span></font><font size=3D"4" color=3D"black" style=3D"f=
ont-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=
=3D"font-size: 14pt;">Amazon</span></font><font size=3D"4" color=3D"black" =
style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><s=
pan style=3D"font-size: 14pt;"> </span></font><font size=3D"4" color=3D"bla=
ck" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;=
"><span style=3D"font-size: 14pt;">Linux</span></font><font size=3D"4" colo=
r=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, Em=
ojiFont;"><span style=3D"font-size: 14pt;"> (</span></font><font size=3D"4"=
 color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, seri=
f, EmojiFont;"><span style=3D"font-size: 14pt;">4.14.294</span></font><font=
 size=3D"4" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-=
serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;">-</span></font><=
font size=3D"4" color=3D"black" style=3D"font-family: Calibri, Helvetica, s=
ans-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;">220.533.amzn=
2.aarch64</span></font><font size=3D"4" color=3D"black" style=3D"font-famil=
y: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-s=
ize: 14pt;"> </span></font><font size=3D"4" color=3D"black" style=3D"font-f=
amily: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"fo=
nt-size: 14pt;">aarch64</span></font><font size=3D"4" color=3D"black" style=
=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span s=
tyle=3D"font-size: 14pt;"> </span></font><font size=3D"4" color=3D"black" s=
tyle=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><sp=
an style=3D"font-size: 14pt;">GNU</span></font><font size=3D"4" color=3D"bl=
ack" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont=
;"><span style=3D"font-size: 14pt;">/</span></font><font size=3D"4" color=
=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, Emo=
jiFont;"><span style=3D"font-size: 14pt;">Linux</span></font><font size=3D"=
4" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, se=
rif, EmojiFont;"><span style=3D"font-size: 14pt;">):</span></font></li></ul=
></font></pre>
</div>
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;">&nbsp;</font></pre>
</div>
</span></font></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont=
; font-size: 16px; margin: 0px 0px 0px 40px; padding: 0px; border-style: no=
ne;">
<div style=3D"margin: 0px 0px 0px 40px; padding: 0px; border-style: none;">
<div><font face=3D"Calibri,Helvetica,sans-serif,EmojiFont,Apple Color Emoji=
,Segoe UI Emoji,NotoColorEmoji,Segoe UI Symbol,Android Emoji,EmojiSymbols" =
size=3D"3" color=3D"black"><span style=3D"font-size: 12pt;">
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"4" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
4pt;">BogoMIPS</span></font><font size=3D"4" color=3D"black" style=3D"font-=
family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"f=
ont-size: 14pt;">        : </span></font><font size=3D"4" color=3D"black" s=
tyle=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><sp=
an style=3D"font-size: 14pt;">243.75</span></font></font></pre>
</div>
</span></font></div>
</div>
<div style=3D"margin: 0px 0px 0px 40px; padding: 0px; border-style: none;">
<div><font face=3D"Calibri,Helvetica,sans-serif,EmojiFont,Apple Color Emoji=
,Segoe UI Emoji,NotoColorEmoji,Segoe UI Symbol,Android Emoji,EmojiSymbols" =
size=3D"3" color=3D"black"><span style=3D"font-size: 12pt;">
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"4" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
4pt;">Features</span></font><font size=3D"4" color=3D"black" style=3D"font-=
family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"f=
ont-size: 14pt;">        : </span></font><font size=3D"4" color=3D"black" s=
tyle=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><sp=
an style=3D"font-size: 14pt;">fp</span></font><font size=3D"4" color=3D"bla=
ck" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;=
"><span style=3D"font-size: 14pt;"> </span></font><font size=3D"4" color=3D=
"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiF=
ont;"><span style=3D"font-size: 14pt;">asimd</span></font><font size=3D"4" =
color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif=
, EmojiFont;"><span style=3D"font-size: 14pt;"> </span></font><font size=3D=
"4" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, s=
erif, EmojiFont;"><span style=3D"font-size: 14pt;">evtstrm</span></font><fo=
nt size=3D"4" color=3D"black" style=3D"font-family: Calibri, Helvetica, san=
s-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;"> </span></font=
><font size=3D"4" color=3D"black" style=3D"font-family: Calibri, Helvetica,=
 sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;">aes</span>=
</font><font size=3D"4" color=3D"black" style=3D"font-family: Calibri, Helv=
etica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;"> </s=
pan></font><font size=3D"4" color=3D"black" style=3D"font-family: Calibri, =
Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;">=
pmull</span></font><font size=3D"4" color=3D"black" style=3D"font-family: C=
alibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size:=
 14pt;"> </span></font><font size=3D"4" color=3D"black" style=3D"font-famil=
y: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-s=
ize: 14pt;">sha1</span></font><font size=3D"4" color=3D"black" style=3D"fon=
t-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D=
"font-size: 14pt;"> </span></font><font size=3D"4" color=3D"black" style=3D=
"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span styl=
e=3D"font-size: 14pt;">sha2</span></font><font size=3D"4" color=3D"black" s=
tyle=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><sp=
an style=3D"font-size: 14pt;"> </span></font><font size=3D"4" color=3D"blac=
k" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"=
><span style=3D"font-size: 14pt;">crc32</span></font><font size=3D"4" color=
=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, Emo=
jiFont;"><span style=3D"font-size: 14pt;"> </span></font><font size=3D"4" c=
olor=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif,=
 EmojiFont;"><span style=3D"font-size: 14pt;">atomics</span></font><font si=
ze=3D"4" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-ser=
if, serif, EmojiFont;"><span style=3D"font-size: 14pt;"> </span></font><fon=
t size=3D"4" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans=
-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;">fphp</span></fo=
nt><font size=3D"4" color=3D"black" style=3D"font-family: Calibri, Helvetic=
a, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;"> </span>=
</font><font size=3D"4" color=3D"black" style=3D"font-family: Calibri, Helv=
etica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;">asim=
dhp</span></font><font size=3D"4" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
4pt;"> </span></font><font size=3D"4" color=3D"black" style=3D"font-family:=
 Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-siz=
e: 14pt;">cpuid</span></font><font size=3D"4" color=3D"black" style=3D"font=
-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"=
font-size: 14pt;"> </span></font><font size=3D"4" color=3D"black" style=3D"=
font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=
=3D"font-size: 14pt;">asimdrdm</span></font><font size=3D"4" color=3D"black=
" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;">=
<span style=3D"font-size: 14pt;"> </span></font><font size=3D"4" color=3D"b=
lack" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFon=
t;"><span style=3D"font-size: 14pt;">lrcpc</span></font><font size=3D"4" co=
lor=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, =
EmojiFont;"><span style=3D"font-size: 14pt;"> </span></font><font size=3D"4=
" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, ser=
if, EmojiFont;"><span style=3D"font-size: 14pt;">dcpop</span></font><font s=
ize=3D"4" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-se=
rif, serif, EmojiFont;"><span style=3D"font-size: 14pt;"> </span></font><fo=
nt size=3D"4" color=3D"black" style=3D"font-family: Calibri, Helvetica, san=
s-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;">asimddp</span>=
</font><font size=3D"4" color=3D"black" style=3D"font-family: Calibri, Helv=
etica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;"> </s=
pan></font><font size=3D"4" color=3D"black" style=3D"font-family: Calibri, =
Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;">=
ssbs</span></font></font></pre>
</div>
</span></font></div>
</div>
<div style=3D"margin: 0px 0px 0px 40px; padding: 0px; border-style: none;">
<div><font face=3D"Calibri,Helvetica,sans-serif,EmojiFont,Apple Color Emoji=
,Segoe UI Emoji,NotoColorEmoji,Segoe UI Symbol,Android Emoji,EmojiSymbols" =
size=3D"3" color=3D"black"><span style=3D"font-size: 12pt;">
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"4" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
4pt;">CPU</span></font><font size=3D"4" color=3D"black" style=3D"font-famil=
y: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-s=
ize: 14pt;"> </span></font><font size=3D"4" color=3D"black" style=3D"font-f=
amily: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"fo=
nt-size: 14pt;">implementer</span></font><font size=3D"4" color=3D"black" s=
tyle=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><sp=
an style=3D"font-size: 14pt;">   : </span></font><font size=3D"4" color=3D"=
black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFo=
nt;"><span style=3D"font-size: 14pt;">0x41</span></font></font></pre>
</div>
</span></font></div>
</div>
<div style=3D"margin: 0px 0px 0px 40px; padding: 0px; border-style: none;">
<div><font face=3D"Calibri,Helvetica,sans-serif,EmojiFont,Apple Color Emoji=
,Segoe UI Emoji,NotoColorEmoji,Segoe UI Symbol,Android Emoji,EmojiSymbols" =
size=3D"3" color=3D"black"><span style=3D"font-size: 12pt;">
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"4" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
4pt;">CPU</span></font><font size=3D"4" color=3D"black" style=3D"font-famil=
y: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-s=
ize: 14pt;"> </span></font><font size=3D"4" color=3D"black" style=3D"font-f=
amily: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"fo=
nt-size: 14pt;">architecture</span></font><font size=3D"4" color=3D"black" =
style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><s=
pan style=3D"font-size: 14pt;">: </span></font><font size=3D"4" color=3D"bl=
ack" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont=
;"><span style=3D"font-size: 14pt;">8</span></font></font></pre>
</div>
</span></font></div>
</div>
<div style=3D"margin: 0px 0px 0px 40px; padding: 0px; border-style: none;">
<div><font face=3D"Calibri,Helvetica,sans-serif,EmojiFont,Apple Color Emoji=
,Segoe UI Emoji,NotoColorEmoji,Segoe UI Symbol,Android Emoji,EmojiSymbols" =
size=3D"3" color=3D"black"><span style=3D"font-size: 12pt;">
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"4" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
4pt;">CPU</span></font><font size=3D"4" color=3D"black" style=3D"font-famil=
y: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-s=
ize: 14pt;"> </span></font><font size=3D"4" color=3D"black" style=3D"font-f=
amily: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"fo=
nt-size: 14pt;">variant</span></font><font size=3D"4" color=3D"black" style=
=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span s=
tyle=3D"font-size: 14pt;">       : </span></font><font size=3D"4" color=3D"=
black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFo=
nt;"><span style=3D"font-size: 14pt;">0x3</span></font></font></pre>
</div>
</span></font></div>
</div>
<div style=3D"margin: 0px 0px 0px 40px; padding: 0px; border-style: none;">
<div><font face=3D"Calibri,Helvetica,sans-serif,EmojiFont,Apple Color Emoji=
,Segoe UI Emoji,NotoColorEmoji,Segoe UI Symbol,Android Emoji,EmojiSymbols" =
size=3D"3" color=3D"black"><span style=3D"font-size: 12pt;">
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"4" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
4pt;">CPU</span></font><font size=3D"4" color=3D"black" style=3D"font-famil=
y: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-s=
ize: 14pt;"> </span></font><font size=3D"4" color=3D"black" style=3D"font-f=
amily: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"fo=
nt-size: 14pt;">part</span></font><font size=3D"4" color=3D"black" style=3D=
"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span styl=
e=3D"font-size: 14pt;">  : </span></font><font size=3D"4" color=3D"black" s=
tyle=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><sp=
an style=3D"font-size: 14pt;">0xd0c</span></font></font></pre>
</div>
</span></font></div>
</div>
<div style=3D"margin: 0px 0px 0px 40px; padding: 0px; border-style: none;">
<div><font face=3D"Calibri,Helvetica,sans-serif,EmojiFont,Apple Color Emoji=
,Segoe UI Emoji,NotoColorEmoji,Segoe UI Symbol,Android Emoji,EmojiSymbols" =
size=3D"3" color=3D"black"><span style=3D"font-size: 12pt;">
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"4" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
4pt;">CPU</span></font><font size=3D"4" color=3D"black" style=3D"font-famil=
y: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-s=
ize: 14pt;"> </span></font><font size=3D"4" color=3D"black" style=3D"font-f=
amily: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"fo=
nt-size: 14pt;">revision</span></font><font size=3D"4" color=3D"black" styl=
e=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span =
style=3D"font-size: 14pt;">      : </span></font><font size=3D"4" color=3D"=
black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFo=
nt;"><span style=3D"font-size: 14pt;">1</span></font></font></pre>
</div>
</span></font></div>
</div>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont=
; font-size: 16px; margin: 0px 0px 0px 40px; padding: 0px; border-style: no=
ne;">
<font face=3D"Calibri,Helvetica,sans-serif,EmojiFont,Apple Color Emoji,Sego=
e UI Emoji,NotoColorEmoji,Segoe UI Symbol,Android Emoji,EmojiSymbols" size=
=3D"3" color=3D"black"><span style=3D"font-size: 12pt;">
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;">&nbsp;</font></pre>
</div>
</span></font></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont=
; font-size: 16px;">
<font color=3D"black">
<div style=3D"margin-left: 32px; padding: 0px 8px;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><ul style=3D"margin-top: 0px; margin-bott=
om: 0px;"><font style=3D"font-family: monospace, serif, EmojiFont;"><ul><li=
><font size=3D"4" color=3D"black" style=3D"font-family: Calibri, Helvetica,=
 sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;">Saw</span>=
</font><font size=3D"4" color=3D"black" style=3D"font-family: Calibri, Helv=
etica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;"> </s=
pan></font><font size=3D"4" color=3D"black" style=3D"font-family: Calibri, =
Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;">=
an</span></font><font size=3D"4" color=3D"black" style=3D"font-family: Cali=
bri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14=
pt;"> </span></font><font size=3D"4" color=3D"black" style=3D"font-family: =
Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size=
: 14pt;">average</span></font><font size=3D"4" color=3D"black" style=3D"fon=
t-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D=
"font-size: 14pt;"> </span></font><font size=3D"4" color=3D"black" style=3D=
"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span styl=
e=3D"font-size: 14pt;">latency</span></font><font size=3D"4" color=3D"black=
" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;">=
<span style=3D"font-size: 14pt;"> </span></font><font size=3D"4" color=3D"b=
lack" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFon=
t;"><span style=3D"font-size: 14pt;">of</span></font><font size=3D"4" color=
=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, Emo=
jiFont;"><span style=3D"font-size: 14pt;"> </span></font><font size=3D"4" c=
olor=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif,=
 EmojiFont;"><span style=3D"font-size: 14pt;"><b>~0</b></span></font><font =
size=3D"4" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-s=
erif, serif, EmojiFont;"><span style=3D"font-size: 14pt;"><b>.5u</b></span>=
</font><font size=3D"4" color=3D"black" style=3D"font-family: Calibri, Helv=
etica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;"><b>s=
ec=0A=
</b></span></font></li></ul></font></ul><div style=3D"font-family: monospac=
e, serif, EmojiFont;"><font size=3D"3" style=3D"font-family: Calibri, Helve=
tica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 18.67px;"><b=
>=0A=
</b></span></font></div></pre>
</div>
<div style=3D"margin-left: 32px; padding: 0px 8px;"><font face=3D"Calibri,H=
elvetica,sans-serif,EmojiFont,Apple Color Emoji,Segoe UI Emoji,NotoColorEmo=
ji,Segoe UI Symbol,Android Emoji,EmojiSymbols" size=3D"3"><span style=3D"fo=
nt-size: 12pt;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;">&nbsp;</font></pre>
</span></font></div>
<div style=3D"margin-left: 32px; padding: 0px 8px;"><font face=3D"Calibri,H=
elvetica,sans-serif,EmojiFont,Apple Color Emoji,Segoe UI Emoji,NotoColorEmo=
ji,Segoe UI Symbol,Android Emoji,EmojiSymbols" size=3D"3"><span style=3D"fo=
nt-size: 12pt;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"4" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
4pt;">Are</span></font><font size=3D"4" color=3D"black" style=3D"font-famil=
y: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-s=
ize: 14pt;"> </span></font><font size=3D"4" color=3D"black" style=3D"font-f=
amily: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"fo=
nt-size: 14pt;">there</span></font><font size=3D"4" color=3D"black" style=
=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span s=
tyle=3D"font-size: 14pt;"> </span></font><font size=3D"4" color=3D"black" s=
tyle=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><sp=
an style=3D"font-size: 14pt;">any</span></font><font size=3D"4" color=3D"bl=
ack" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont=
;"><span style=3D"font-size: 14pt;"> </span></font><font size=3D"4" color=
=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, Emo=
jiFont;"><span style=3D"font-size: 14pt;">suggestions</span></font><font si=
ze=3D"4" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-ser=
if, serif, EmojiFont;"><span style=3D"font-size: 14pt;"> </span></font><fon=
t size=3D"4" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans=
-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;">to</span></font=
><font size=3D"4" color=3D"black" style=3D"font-family: Calibri, Helvetica,=
 sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;"> </span></=
font><font size=3D"4" color=3D"black" style=3D"font-family: Calibri, Helvet=
ica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;">root</=
span></font><font size=3D"4" color=3D"black" style=3D"font-family: Calibri,=
 Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;"=
> </span></font><font size=3D"4" color=3D"black" style=3D"font-family: Cali=
bri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14=
pt;">cause</span></font><font size=3D"4" color=3D"black" style=3D"font-fami=
ly: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-=
size: 14pt;"> </span></font><font size=3D"4" color=3D"black" style=3D"font-=
family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"f=
ont-size: 14pt;">the</span></font><font size=3D"4" color=3D"black" style=3D=
"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span styl=
e=3D"font-size: 14pt;"> </span></font><font size=3D"4" color=3D"black" styl=
e=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span =
style=3D"font-size: 14pt;">high</span></font><font size=3D"4" color=3D"blac=
k" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"=
><span style=3D"font-size: 14pt;"> </span></font><font size=3D"4" color=3D"=
black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFo=
nt;"><span style=3D"font-size: 14pt;">latency</span></font><font size=3D"4"=
 color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, seri=
f, EmojiFont;"><span style=3D"font-size: 14pt;"> </span></font><font size=
=3D"4" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif=
, serif, EmojiFont;"><span style=3D"font-size: 14pt;">and</span></font><fon=
t size=3D"4" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans=
-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;"> </span></font>=
<font size=3D"4" color=3D"black" style=3D"font-family: Calibri, Helvetica, =
sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;">potentially=
</span></font><font size=3D"4" color=3D"black" style=3D"font-family: Calibr=
i, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt=
;"> </span></font><font size=3D"4" color=3D"black" style=3D"font-family: Ca=
libri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: =
14pt;">improve</span></font><font size=3D"4" color=3D"black" style=3D"font-=
family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"f=
ont-size: 14pt;"> </span></font><font size=3D"4" color=3D"black" style=3D"f=
ont-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=
=3D"font-size: 14pt;">it</span></font><font size=3D"4" color=3D"black" styl=
e=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><span =
style=3D"font-size: 14pt;"> </span></font><font size=3D"4" color=3D"black" =
style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont;"><s=
pan style=3D"font-size: 14pt;">on</span></font><font size=3D"4" color=3D"bl=
ack" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont=
;"><span style=3D"font-size: 14pt;"> </span></font><font size=3D"4" color=
=3D"black" style=3D"font-family: Calibri, Helvetica, sans-serif, serif, Emo=
jiFont;"><span style=3D"font-size: 14pt;"><b>platform</b></span></font><fon=
t size=3D"4" color=3D"black" style=3D"font-family: Calibri, Helvetica, sans=
-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;"><b> </b></span>=
</font><font size=3D"4" color=3D"black" style=3D"font-family: Calibri, Helv=
etica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 14pt;"><b>1=
</b></span></font><font size=3D"4" color=3D"black" style=3D"font-family: Ca=
libri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: =
14pt;">?</span></font></font></pre>
</span></font></div>
<div style=3D"margin-left: 32px; padding: 0px 8px;"><font face=3D"Calibri,H=
elvetica,sans-serif,EmojiFont,Apple Color Emoji,Segoe UI Emoji,NotoColorEmo=
ji,Segoe UI Symbol,Android Emoji,EmojiSymbols" size=3D"3"><span style=3D"fo=
nt-size: 12pt;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;">&nbsp;</font></pre>
</span></font></div>
<div style=3D"margin-left: 32px; padding: 0px 8px;"><font face=3D"Calibri,H=
elvetica,sans-serif,EmojiFont,Apple Color Emoji,Segoe UI Emoji,NotoColorEmo=
ji,Segoe UI Symbol,Android Emoji,EmojiSymbols" size=3D"3"><span style=3D"fo=
nt-size: 12pt;">
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"4" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
4pt;">Thanks and best regards,</span></font></font></pre>
<pre style=3D"margin-top: 0px; margin-bottom: 0px; padding: 0px 4px; border=
-width: 0px; border-radius: 0px;"><font style=3D"font-family: monospace, se=
rif, EmojiFont;"><font size=3D"4" color=3D"black" style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, serif, EmojiFont;"><span style=3D"font-size: 1=
4pt;">Anas.</span></font></font></pre>
</span></font></div>
</font></div>
<span id=3D"ms-rterangepaste-end"></span><br>
<p></p>
</div>
</body>
</html>

--_000_6e06b605ec9f446da5dc8948c8621518amazoncom_--

--===============6493914625085299052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6493914625085299052==--
