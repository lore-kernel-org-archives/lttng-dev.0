Return-Path: <SRS0=HU/H=BY=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC82CC433DF
	for <lttng-dev@archiver.kernel.org>; Fri, 14 Aug 2020 13:04:17 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23F62206B2
	for <lttng-dev@archiver.kernel.org>; Fri, 14 Aug 2020 13:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="gMIpiLwB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F62206B2
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4BSkCz1Tzvz1vNy;
	Fri, 14 Aug 2020 09:04:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1597410255;
	bh=GRXQeWiJnpueAx1SSd3u31jGCFOFoXWZ4D5rNXMvg+Y=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=gMIpiLwBpNAhGj98gDh65hfCg1SBHI2l2qFIxFf3aMy86KHbD+Qj12vykG9stgVR4
	 KX/P1T/8AlM/4z4msQ8iwCM5YxAapv/adzrrwbzrdmdY0TUFF/RDkINCkxLA+SVysE
	 LxDQI9CUHnYO7hDwhap5LMvJmAhqe4Vgj8X0C/YcTwW5JewiG4UCm2QEaBgY98JJZI
	 7dZo4WMaXCEjJK+L4dHKOgGnM8qGTFPmvHnfDcl/AkG76lIhrW89Efv7ew4v31R2fD
	 MgigHn9J0Br7Td2Rw2jPpTuXtYZG4/k+SMkSa50nEtG/1oCGPdpPtdVDvzIkXA9vn6
	 yJDL2OAka+Y/A==
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 by lists.lttng.org (Postfix) with ESMTPS id 4BSX6t6Ghlz1v1M
 for <lttng-dev@lists.lttng.org>; Fri, 14 Aug 2020 01:29:10 -0400 (EDT)
Received: by mail-il1-x130.google.com with SMTP id q14so7500129ilj.8
 for <lttng-dev@lists.lttng.org>; Thu, 13 Aug 2020 22:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=5phoG+7hBkd50tIfhhmJ047WMdIBISWCc8Q7iAeb7Mg=;
 b=lUa0CgfumPzwJnhkqrETH5M6h5BAIWjkwLkP0qq6ErLGTPtfHtibQrR+p2+gv6lyHc
 Cvt3+/zAMHKYN3AVmXILN4NBeuHp7DYUH7iKBYKLwf3yJypwQ06/tMtsYRhOCpp55+V5
 AWY7Jgwhw4Um6W+lD+FibQSbOYPnsVNDfZdvyUCrFpAFdVfRHDbWq1faNEjLaI6Uow4G
 ZRQqMCvL++9FB7kRa9Jzfp4ND8x8uF7NfCSwlI69XcEdHAg0mUXCwcjUXaDFmxzyCheU
 4/t2b1ZelHHmbIbP329wc0+h3EC4+ubnmvlKVdyta0pj0qs5XWOjNyruy/yYELaBC+jj
 J43w==
X-Gm-Message-State: AOAM532f+GfSexujxv7QCiWF7AYppbb+MUGTlhZm3A4HE0udSIOH2pOS
 +QtSmJrcg4RjSt4YT+FS9+eQRaEnZ/Rt7miJWlp7Jk3CTOw=
X-Google-Smtp-Source: ABdhPJw4qeRbb9p7TeNI1OBnd7BIwnNFEeXHEmfH8Ph8Q0Bd72E5rPSREQWuIssHS1nS75bwv4Oq+zJkE91hvg7Tq8Q=
X-Received: by 2002:a05:6e02:e13:: with SMTP id
 a19mr1142283ilk.172.1597382949709; 
 Thu, 13 Aug 2020 22:29:09 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 14 Aug 2020 01:28:59 -0400
Message-ID: <CACV+narvs1f+YXz1BhssmgtmiF4=Pp_Cg7u_1sdHCdaggKi7VQ@mail.gmail.com>
To: lttng-dev@lists.lttng.org
X-Mailman-Approved-At: Fri, 14 Aug 2020 09:04:13 -0400
Subject: [lttng-dev] [URCU]Bug Report
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Jin Huang via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Jin Huang <andy.jinhuang@gmail.com>
Content-Type: multipart/mixed; boundary="===============5567947012454016019=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============5567947012454016019==
Content-Type: multipart/alternative; boundary="00000000000049ab7505accfb3ff"

--00000000000049ab7505accfb3ff
Content-Type: text/plain; charset="UTF-8"

Hi, my name is Jin Huang.
I want to report 2 data races in userspace-rcu-master

Data Race 1: WW

Variable: crdp, defined at src/urcu-call-rcu-impl.h:424

Thread1: userspace-rcu/src/urcu-call-rcu-impl.h

Line 211, inside function set_thread_cpu_affinity:

if (++crdp->gp_count & SET_AFFINITY_CHECK_PERIOD_MASK)

Call order:

(1)pthread_create [src/urcu-call-rcu-impl.h:437]

(2)call_rcu_thread [src/urcu-call-rcu-impl.h:437]

(3)set_thread_cpu_affinity [src/urcu-call-rcu-impl.h:318]

Thread2: userspace-rcu/src/urcu-call-rcu-impl.h

Line 211, inside function set_thread_cpu_affinity:

if (++crdp->gp_count & SET_AFFINITY_CHECK_PERIOD_MASK)

Call order:

(1)pthread_create [src/urcu-call-rcu-impl.h:437]

(2)call_rcu_thread [src/urcu-call-rcu-impl.h:437]

(3)set_thread_cpu_affinity [src/urcu-call-rcu-impl.h:318]


Data Race 2: RW

Variable: crdp, defined at src/urcu-call-rcu-impl.h:424

Thread1: userspace-rcu/src/urcu-call-rcu-impl.h

Line 433, inside function call_rcu_data_init:

crdp->cpu_affinity = cpu_affinity;

Call order:

(1)perftest [src/rcutorture.h:590]

(2)perftestrun [src/rcutorture.h:244]

(3)urcu_signal_free_all_cpu_call_rcu_data [src/rcutorture.h:227]

(4)urcu_signal_get_default_call_rcu_data [src/urcu-call-rcu-impl.h:777]

(5)call_rcu_data_init [src/urcu-call-rcu-impl.h:572]

Thread2: userspace-rcu/src/urcu-call-rcu-impl.h

Line 209, inside function set_thread_cpu_affinity:

if (crdp->cpu_affinity < 0)

Call order:

(1)pthread_create [src/urcu-call-rcu-impl.h:437]

(2)call_rcu_thread [src/urcu-call-rcu-impl.h:437]

(3)set_thread_cpu_affinity [src/urcu-call-rcu-impl.h:318]




Thank You
Best
Jin Huang

--00000000000049ab7505accfb3ff
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi, my name is Jin Huang.<div>I want to report 2 data race=
s in userspace-rcu-master</div><div><br></div><div><span id=3D"gmail-docs-i=
nternal-guid-dc58651d-7fff-1d69-9921-3e62afcfa637"><p dir=3D"ltr" style=3D"=
line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size=
:11pt;font-family:Arial;color:rgb(0,0,0);background-color:transparent;font-=
variant-numeric:normal;font-variant-east-asian:normal;vertical-align:baseli=
ne;white-space:pre-wrap">Data Race 1: WW</span></p><p dir=3D"ltr" style=3D"=
line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size=
:11pt;font-family:Arial;color:rgb(0,0,0);background-color:transparent;font-=
variant-numeric:normal;font-variant-east-asian:normal;vertical-align:baseli=
ne;white-space:pre-wrap">Variable: </span><span style=3D"font-size:11pt;fon=
t-family:Arial;color:rgb(0,0,0);background-color:transparent;font-weight:70=
0;font-variant-numeric:normal;font-variant-east-asian:normal;vertical-align=
:baseline;white-space:pre-wrap">crdp</span><span style=3D"font-size:11pt;fo=
nt-family:Arial;color:rgb(0,0,0);background-color:transparent;font-variant-=
numeric:normal;font-variant-east-asian:normal;vertical-align:baseline;white=
-space:pre-wrap">, defined at src/urcu-call-rcu-impl.h:424</span></p><p dir=
=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span =
style=3D"font-size:11pt;font-family:Arial;color:rgb(0,0,0);background-color=
:transparent;font-weight:700;font-variant-numeric:normal;font-variant-east-=
asian:normal;vertical-align:baseline;white-space:pre-wrap">Thread1</span><s=
pan style=3D"font-size:11pt;font-family:Arial;color:rgb(0,0,0);background-c=
olor:transparent;font-variant-numeric:normal;font-variant-east-asian:normal=
;vertical-align:baseline;white-space:pre-wrap">: userspace-rcu/src/urcu-cal=
l-rcu-impl.h</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:=
0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial;colo=
r:rgb(0,0,0);background-color:transparent;font-variant-numeric:normal;font-=
variant-east-asian:normal;vertical-align:baseline;white-space:pre-wrap">Lin=
e 211, inside function set_thread_cpu_affinity:</span></p><p dir=3D"ltr" st=
yle=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"fo=
nt-size:11pt;font-family:Arial;color:rgb(0,0,0);background-color:transparen=
t;font-variant-numeric:normal;font-variant-east-asian:normal;vertical-align=
:baseline;white-space:pre-wrap">if (</span><span style=3D"font-size:11pt;fo=
nt-family:Arial;color:rgb(0,0,0);background-color:transparent;font-weight:7=
00;font-variant-numeric:normal;font-variant-east-asian:normal;vertical-alig=
n:baseline;white-space:pre-wrap">++crdp-&gt;gp_count</span><span style=3D"f=
ont-size:11pt;font-family:Arial;color:rgb(0,0,0);background-color:transpare=
nt;font-variant-numeric:normal;font-variant-east-asian:normal;vertical-alig=
n:baseline;white-space:pre-wrap"> &amp; SET_AFFINITY_CHECK_PERIOD_MASK)</sp=
an></p><br><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-b=
ottom:0pt"><span style=3D"font-size:11pt;font-family:Arial;color:rgb(0,0,0)=
;background-color:transparent;font-variant-numeric:normal;font-variant-east=
-asian:normal;vertical-align:baseline;white-space:pre-wrap">Call order:</sp=
an></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-botto=
m:0pt"><span style=3D"font-size:11pt;font-family:Arial;color:rgb(0,0,0);bac=
kground-color:transparent;font-variant-numeric:normal;font-variant-east-asi=
an:normal;vertical-align:baseline;white-space:pre-wrap">(1)pthread_create [=
src/urcu-call-rcu-impl.h:437]</span></p><p dir=3D"ltr" style=3D"line-height=
:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-=
family:Arial;color:rgb(0,0,0);background-color:transparent;font-variant-num=
eric:normal;font-variant-east-asian:normal;vertical-align:baseline;white-sp=
ace:pre-wrap">(2)call_rcu_thread [src/urcu-call-rcu-impl.h:437]</span></p><=
p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><=
span style=3D"font-size:11pt;font-family:Arial;color:rgb(0,0,0);background-=
color:transparent;font-variant-numeric:normal;font-variant-east-asian:norma=
l;vertical-align:baseline;white-space:pre-wrap">(3)set_thread_cpu_affinity =
[src/urcu-call-rcu-impl.h:318]</span></p><br><p dir=3D"ltr" style=3D"line-h=
eight:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;=
font-family:Arial;color:rgb(0,0,0);background-color:transparent;font-weight=
:700;font-variant-numeric:normal;font-variant-east-asian:normal;vertical-al=
ign:baseline;white-space:pre-wrap">Thread2</span><span style=3D"font-size:1=
1pt;font-family:Arial;color:rgb(0,0,0);background-color:transparent;font-va=
riant-numeric:normal;font-variant-east-asian:normal;vertical-align:baseline=
;white-space:pre-wrap">: userspace-rcu/src/urcu-call-rcu-impl.h</span></p><=
p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><=
span style=3D"font-size:11pt;font-family:Arial;color:rgb(0,0,0);background-=
color:transparent;font-variant-numeric:normal;font-variant-east-asian:norma=
l;vertical-align:baseline;white-space:pre-wrap">Line 211, inside function s=
et_thread_cpu_affinity:</span></p><p dir=3D"ltr" style=3D"line-height:1.38;=
margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family=
:Arial;color:rgb(0,0,0);background-color:transparent;font-variant-numeric:n=
ormal;font-variant-east-asian:normal;vertical-align:baseline;white-space:pr=
e-wrap">if (</span><span style=3D"font-size:11pt;font-family:Arial;color:rg=
b(0,0,0);background-color:transparent;font-weight:700;font-variant-numeric:=
normal;font-variant-east-asian:normal;vertical-align:baseline;white-space:p=
re-wrap">++crdp-&gt;gp_count</span><span style=3D"font-size:11pt;font-famil=
y:Arial;color:rgb(0,0,0);background-color:transparent;font-variant-numeric:=
normal;font-variant-east-asian:normal;vertical-align:baseline;white-space:p=
re-wrap"> &amp; SET_AFFINITY_CHECK_PERIOD_MASK)</span></p><br><p dir=3D"ltr=
" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=
=3D"font-size:11pt;font-family:Arial;color:rgb(0,0,0);background-color:tran=
sparent;font-variant-numeric:normal;font-variant-east-asian:normal;vertical=
-align:baseline;white-space:pre-wrap">Call order:</span></p><p dir=3D"ltr" =
style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"=
font-size:11pt;font-family:Arial;color:rgb(0,0,0);background-color:transpar=
ent;font-variant-numeric:normal;font-variant-east-asian:normal;vertical-ali=
gn:baseline;white-space:pre-wrap">(1)pthread_create [src/urcu-call-rcu-impl=
.h:437]</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;m=
argin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial;color:rgb=
(0,0,0);background-color:transparent;font-variant-numeric:normal;font-varia=
nt-east-asian:normal;vertical-align:baseline;white-space:pre-wrap">(2)call_=
rcu_thread [src/urcu-call-rcu-impl.h:437]</span></p><p dir=3D"ltr" style=3D=
"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-siz=
e:11pt;font-family:Arial;color:rgb(0,0,0);background-color:transparent;font=
-variant-numeric:normal;font-variant-east-asian:normal;vertical-align:basel=
ine;white-space:pre-wrap">(3)set_thread_cpu_affinity [src/urcu-call-rcu-imp=
l.h:318]</span></p><br><br><p dir=3D"ltr" style=3D"line-height:1.38;margin-=
top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial;=
color:rgb(0,0,0);background-color:transparent;font-variant-numeric:normal;f=
ont-variant-east-asian:normal;vertical-align:baseline;white-space:pre-wrap"=
>Data Race 2: RW</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-=
top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial;=
color:rgb(0,0,0);background-color:transparent;font-variant-numeric:normal;f=
ont-variant-east-asian:normal;vertical-align:baseline;white-space:pre-wrap"=
>Variable: </span><span style=3D"font-size:11pt;font-family:Arial;color:rgb=
(0,0,0);background-color:transparent;font-weight:700;font-variant-numeric:n=
ormal;font-variant-east-asian:normal;vertical-align:baseline;white-space:pr=
e-wrap">crdp</span><span style=3D"font-size:11pt;font-family:Arial;color:rg=
b(0,0,0);background-color:transparent;font-variant-numeric:normal;font-vari=
ant-east-asian:normal;vertical-align:baseline;white-space:pre-wrap">, defin=
ed at src/urcu-call-rcu-impl.h:424</span></p><p dir=3D"ltr" style=3D"line-h=
eight:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;=
font-family:Arial;color:rgb(0,0,0);background-color:transparent;font-weight=
:700;font-variant-numeric:normal;font-variant-east-asian:normal;vertical-al=
ign:baseline;white-space:pre-wrap">Thread1</span><span style=3D"font-size:1=
1pt;font-family:Arial;color:rgb(0,0,0);background-color:transparent;font-va=
riant-numeric:normal;font-variant-east-asian:normal;vertical-align:baseline=
;white-space:pre-wrap">: userspace-rcu/src/urcu-call-rcu-impl.h</span></p><=
p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><=
span style=3D"font-size:11pt;font-family:Arial;color:rgb(0,0,0);background-=
color:transparent;font-variant-numeric:normal;font-variant-east-asian:norma=
l;vertical-align:baseline;white-space:pre-wrap">Line 433, inside function c=
all_rcu_data_init:</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margi=
n-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Aria=
l;color:rgb(0,0,0);background-color:transparent;font-weight:700;font-varian=
t-numeric:normal;font-variant-east-asian:normal;vertical-align:baseline;whi=
te-space:pre-wrap">crdp</span><span style=3D"font-size:11pt;font-family:Ari=
al;color:rgb(0,0,0);background-color:transparent;font-variant-numeric:norma=
l;font-variant-east-asian:normal;vertical-align:baseline;white-space:pre-wr=
ap">-&gt;cpu_affinity =3D cpu_affinity;</span></p><br><p dir=3D"ltr" style=
=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-=
size:11pt;font-family:Arial;color:rgb(0,0,0);background-color:transparent;f=
ont-variant-numeric:normal;font-variant-east-asian:normal;vertical-align:ba=
seline;white-space:pre-wrap">Call order:</span></p><p dir=3D"ltr" style=3D"=
line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size=
:11pt;font-family:Arial;color:rgb(0,0,0);background-color:transparent;font-=
variant-numeric:normal;font-variant-east-asian:normal;vertical-align:baseli=
ne;white-space:pre-wrap">(1)perftest [src/rcutorture.h:590]</span></p><p di=
r=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span=
 style=3D"font-size:11pt;font-family:Arial;color:rgb(0,0,0);background-colo=
r:transparent;font-variant-numeric:normal;font-variant-east-asian:normal;ve=
rtical-align:baseline;white-space:pre-wrap">(2)perftestrun [src/rcutorture.=
h:244]</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;ma=
rgin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial;color:rgb(=
0,0,0);background-color:transparent;font-variant-numeric:normal;font-varian=
t-east-asian:normal;vertical-align:baseline;white-space:pre-wrap">(3)urcu_s=
ignal_free_all_cpu_call_rcu_data [src/rcutorture.h:227]</span></p><p dir=3D=
"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span sty=
le=3D"font-size:11pt;font-family:Arial;color:rgb(0,0,0);background-color:tr=
ansparent;font-variant-numeric:normal;font-variant-east-asian:normal;vertic=
al-align:baseline;white-space:pre-wrap">(4)urcu_signal_get_default_call_rcu=
_data [src/urcu-call-rcu-impl.h:777]</span></p><p dir=3D"ltr" style=3D"line=
-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11p=
t;font-family:Arial;color:rgb(0,0,0);background-color:transparent;font-vari=
ant-numeric:normal;font-variant-east-asian:normal;vertical-align:baseline;w=
hite-space:pre-wrap">(5)call_rcu_data_init [src/urcu-call-rcu-impl.h:572]</=
span></p><br><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin=
-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial;color:rgb(0,0,=
0);background-color:transparent;font-weight:700;font-variant-numeric:normal=
;font-variant-east-asian:normal;vertical-align:baseline;white-space:pre-wra=
p">Thread2</span><span style=3D"font-size:11pt;font-family:Arial;color:rgb(=
0,0,0);background-color:transparent;font-variant-numeric:normal;font-varian=
t-east-asian:normal;vertical-align:baseline;white-space:pre-wrap">: userspa=
ce-rcu/src/urcu-call-rcu-impl.h</span></p><p dir=3D"ltr" style=3D"line-heig=
ht:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;fon=
t-family:Arial;color:rgb(0,0,0);background-color:transparent;font-variant-n=
umeric:normal;font-variant-east-asian:normal;vertical-align:baseline;white-=
space:pre-wrap">Line 209, inside function set_thread_cpu_affinity:</span></=
p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt=
"><span style=3D"font-size:11pt;font-family:Arial;color:rgb(0,0,0);backgrou=
nd-color:transparent;font-variant-numeric:normal;font-variant-east-asian:no=
rmal;vertical-align:baseline;white-space:pre-wrap">if (</span><span style=
=3D"font-size:11pt;font-family:Arial;color:rgb(0,0,0);background-color:tran=
sparent;font-weight:700;font-variant-numeric:normal;font-variant-east-asian=
:normal;vertical-align:baseline;white-space:pre-wrap">crdp</span><span styl=
e=3D"font-size:11pt;font-family:Arial;color:rgb(0,0,0);background-color:tra=
nsparent;font-variant-numeric:normal;font-variant-east-asian:normal;vertica=
l-align:baseline;white-space:pre-wrap">-&gt;cpu_affinity &lt; 0)</span></p>=
<br><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0=
pt"><span style=3D"font-size:11pt;font-family:Arial;color:rgb(0,0,0);backgr=
ound-color:transparent;font-variant-numeric:normal;font-variant-east-asian:=
normal;vertical-align:baseline;white-space:pre-wrap">Call order:</span></p>=
<p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt">=
<span style=3D"font-size:11pt;font-family:Arial;color:rgb(0,0,0);background=
-color:transparent;font-variant-numeric:normal;font-variant-east-asian:norm=
al;vertical-align:baseline;white-space:pre-wrap">(1)pthread_create [src/urc=
u-call-rcu-impl.h:437]</span></p><p dir=3D"ltr" style=3D"line-height:1.38;m=
argin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:=
Arial;color:rgb(0,0,0);background-color:transparent;font-variant-numeric:no=
rmal;font-variant-east-asian:normal;vertical-align:baseline;white-space:pre=
-wrap">(2)call_rcu_thread [src/urcu-call-rcu-impl.h:437]</span></p><p dir=
=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span =
style=3D"font-size:11pt;font-family:Arial;color:rgb(0,0,0);background-color=
:transparent;font-variant-numeric:normal;font-variant-east-asian:normal;ver=
tical-align:baseline;white-space:pre-wrap">(3)set_thread_cpu_affinity [src/=
urcu-call-rcu-impl.h:318]</span></p></span><br class=3D"gmail-Apple-interch=
ange-newline"></div><div><br></div><div><br clear=3D"all"><div><div dir=3D"=
ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=
=3D"ltr"><div><br></div><div>Thank You</div>Best<div>Jin Huang</div></div><=
/div></div></div></div>

--00000000000049ab7505accfb3ff--

--===============5567947012454016019==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5567947012454016019==--
