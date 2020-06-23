Return-Path: <SRS0=nP6W=AE=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC4DC433E0
	for <lttng-dev@archiver.kernel.org>; Tue, 23 Jun 2020 16:53:20 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 409E62076E
	for <lttng-dev@archiver.kernel.org>; Tue, 23 Jun 2020 16:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="cqPiZ1Sd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 409E62076E
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49rsmG5GnBz13Vx;
	Tue, 23 Jun 2020 12:53:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1592931199;
	bh=L0B4bMgOm0pObY1sfmfr9LdUIqCsXCQwp0arHFqiU3c=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=cqPiZ1SdVbf8ssi5ghdWGS6A0XTpZ41+0/BG0xv+7O2Qmh1gP+u5h+1OeowCOSu1c
	 k6gogiOICWOKjDhX9ahU/sYiOZ7sJvOOTWNUVR5qkNNW6/7FEZmKt0UOAKduM2mb+y
	 gFStL9pm5bO6pysX9eo8iLO1rXZLzQcy+bNY15EhBUeGhA+YC4D3BTtsNTdzWBMHnN
	 D5Jakxe1hX9x5w9A6z/Uno5Oj4Mxhw80P0s6QudamY6LpmoeyGNW2FVSH5PL3e0EU0
	 bTxpJdUXr6qzgUEJ3KxEAqjQ9LWiEWvXXi4AlY/1bHoysgMgAsOjhSRtZc6GAfI7gG
	 J7RRRvRnbiknA==
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by lists.lttng.org (Postfix) with ESMTPS id 49rsmC63V5z13Vv
 for <lttng-dev@lists.lttng.org>; Tue, 23 Jun 2020 12:53:15 -0400 (EDT)
Received: by mail-ej1-x629.google.com with SMTP id l12so22323520ejn.10
 for <lttng-dev@lists.lttng.org>; Tue, 23 Jun 2020 09:53:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uwLyujqhGhGM2pwImWMFuDpK5LYckBMUv8ux6nxf8sU=;
 b=B2/hmdhhrUB9UJXF5pmU1lSGYR22kxFv1JOyHDbkDLhmwedt4spw6wgd81iMBGHXRl
 Z/zBSYxLPCSEbc85+NFyPvXPyjQ6/pCBeu9vdUu09NBUxtaTQucwhRaiE1K+u/QyKpJd
 tEXCxsdXCyv+WIyY5INTILN6PEzN3eYPQMa/nrXV/+ckJU3wNFeRFcu11l/WnAbrkAqy
 V5axfiMigOkg2iguVHikMQj8uVWoCcMhYuIMOy/m/y0jwc2XoS6+6vU48RkDeYqr1uIO
 T2wD6yAHkEVUADNFrP0LQoBjifUNsuA96XrG6C6q75b7lQvaxSmjH7Uj2hFliOgFDczu
 GHPg==
X-Gm-Message-State: AOAM5329KyOxK4rc2eC+Q8ng93FNpwTbAKUB6xO0bQtXcNOw2pxpsuP4
 jpOOoiuKQf5xpNxO0zzkXG47jf5nC1cHWLMW+ic=
X-Google-Smtp-Source: ABdhPJyigNB0euUj0tkHJXxd0PpWEXOm+d1YSh8TWPmuDEaolBg8KH3V4Q8r0DUQrILI4lN7BCnydrr3kp7fSQDFp2k=
X-Received: by 2002:a17:906:4ada:: with SMTP id
 u26mr22180395ejt.368.1592931194443; 
 Tue, 23 Jun 2020 09:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200623143758.GB4160129@jerryopenix>
 <SA0PR15MB38396A864018025F971F2A239E940@SA0PR15MB3839.namprd15.prod.outlook.com>
In-Reply-To: <SA0PR15MB38396A864018025F971F2A239E940@SA0PR15MB3839.namprd15.prod.outlook.com>
Date: Tue, 23 Jun 2020 12:52:38 -0400
Message-ID: <CAAS9doZNif9Cw=kmo0hvKuF_qVBiqX_233JWFr4fTc5A72eLvw@mail.gmail.com>
To: Matthew Khouzam <matthew.khouzam@ericsson.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "Liu,
 Changcheng" <changcheng.liu@intel.com>
Subject: Re: [lttng-dev] get function names with lttng-ust-cyg-profile
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
From: =?utf-8?q?Christophe_B=C3=A9dard_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Reply-To: =?UTF-8?Q?Christophe_B=C3=A9dard?= <bedard.christophe@gmail.com>
Content-Type: multipart/mixed; boundary="===============5959687904060015415=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200623165238.15BGGt6m_u-DHxCnQ_4AV5xlnQA5e3X5ECzoojyrOz0@z>

--===============5959687904060015415==
Content-Type: multipart/alternative; boundary="000000000000ff213c05a8c331a9"

--000000000000ff213c05a8c331a9
Content-Type: text/plain; charset="UTF-8"

Hi,

Babeltrace is doing exactly what it should as far as I know.
>

yes, but babeltrace *can* provide the information if:

* ip and vpid contexts are enabled (for userspace), e.g.

$ lttng add-context --userspace --type=ip --type=vpid

* LTTng state dump events are enabled, e.g.

$ lttng enable-event --userspace 'lttng_ust_statedump:*'


see this (from bt2 but it also applies to bt1):
https://babeltrace.org/docs/v2.0/man7/babeltrace2-filter.lttng-utils.debug-info.7/#doc-lttng-prereq

Note that the Python bindings for babeltrace don't provide/expose this
debug info.


Christophe

On Tue, 23 Jun 2020 at 11:12, Matthew Khouzam via lttng-dev <
lttng-dev@lists.lttng.org> wrote:

> Hi,
>
> You have the pointers that are traced. Babeltrace is doing exactly what it
> should as far as I know.
>
> You could use the command 'nm' to get your symbols and look them up. I am
> sure Babeltrace can do this from a python level. You could also use a GUI
> based trace viewer to get the information.
>
> Hope that helps.
> Matthew
> ------------------------------
> *From:* lttng-dev <lttng-dev-bounces@lists.lttng.org> on behalf of Liu,
> Changcheng via lttng-dev <lttng-dev@lists.lttng.org>
> *Sent:* Tuesday, June 23, 2020 10:37 AM
> *To:* lttng-dev@lists.lttng.org <lttng-dev@lists.lttng.org>
> *Cc:* changcheng.liu@intel.com <changcheng.liu@intel.com>
> *Subject:* [lttng-dev] get function names with lttng-ust-cyg-profile
>
> Hi all,
>    I'm trying to use lttng-ust-cyg-profile to trace program.
>    Does anyone know how to get function names and offset through
> lttng-ust-cyg-profile?
>
>    In below example, the babeltrace could only get the function entry/exit
> value.
>    1. Source program: instrument.c
>          1 #include <stdio.h>
>          2
>          3 int add3(int val) {
>          4         return val + 3;
>          5 }
>          6
>          7 int main(int argc, char **argv) {
>          8     int x = 4;
>          9
>         10     puts("Press Enter to continue...");
>         11     getchar();
>         12
>         13     x = add3(x);
>         14
>         15     return 0;
>         16 }
>
>    2. build source code:
>         $ gcc -g -finstrument-functions instrument.c -o instrument
>
>    3. run program:
>        $ LD_PRELOAD=/usr/lib/x86_64-linux-gnu/liblttng-ust-cyg-profile.so
> ./instrument
>
>    4. start trace process:
>        trace@trace:~/cc$ sudo lttng create instrument
>        Session instrument created.
>        Traces will be output to
> /root/lttng-traces/instrument-20200623-222917
>
>        trace@trace:~/cc$ sudo lttng enable-channel user_func_trace
> --userspace
>        UST channel user_func_trace enabled for session instrument
>
>        trace@trace:~/cc$ sudo lttng enable-event --userspace
> lttng_ust_cyg_profile:func_entry --channel user_func_trace
>        UST event lttng_ust_cyg_profile:func_entry created in channel
> user_func_trace
>        trace@trace:~/cc$ sudo lttng enable-event --userspace
> lttng_ust_cyg_profile:func_exit --channel user_func_trace
>        UST event lttng_ust_cyg_profile:func_exit created in channel
> user_func_trace
>
>        trace@trace:~/cc$ sudo lttng start
>        Tracing started for session instrument
>
>        trace@trace:~/cc$ sudo lttng destroy
>        Destroying session instrument..
>        Session instrument destroyed
>
>        trace@trace:~/cc$ sudo babeltrace
> /root/lttng-traces/instrument-20200623-222917
>        [22:29:55.388607059] (+?.?????????) trace
> lttng_ust_cyg_profile:func_entry: { cpu_id = 2 }, { addr = 0x5625C88B01A9,
> call_site = 0x5625C88B0237 }
>        [22:29:55.388612293] (+0.000005234) trace
> lttng_ust_cyg_profile:func_exit: { cpu_id = 2 }, { addr = 0x5625C88B01A9,
> call_site = 0x5625C88B0237 }
>        [22:29:55.388613215] (+0.000000922) trace
> lttng_ust_cyg_profile:func_exit: { cpu_id = 2 }, { addr = 0x5625C88B01EE,
> call_site = 0x7FE40BD5C0B3 }
>
> B.R.
> Changcheng
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
>
> https://protect2.fireeye.com/v1/url?k=98478753-c6e73d3d-9847c7c8-869a14f4b08c-41638b2508ab85dd&q=1&e=703483a0-63a9-4269-ac8e-c1fc5a57edad&u=https%3A%2F%2Flists.lttng.org%2Fcgi-bin%2Fmailman%2Flistinfo%2Flttng-dev
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

--000000000000ff213c05a8c331a9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,<div><br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex"><span style=3D"color:rgb(0,0,0);font-family:Cali=
bri,Arial,Helvetica,sans-serif;font-size:16px">Babeltrace is doing exactly =
what it should as far as I know.</span><br></blockquote><div><br></div><div=
>yes, but babeltrace <i>can</i> provide the information if:</div><div><br><=
/div><div>* ip and vpid contexts are enabled (for userspace), e.g.</div></d=
iv><blockquote style=3D"margin:0 0 0 40px;border:none;padding:0px"><div dir=
=3D"ltr"><div>$ lttng add-context --userspace --type=3Dip --type=3Dvpid</di=
v></div></blockquote><div dir=3D"ltr"><div>* LTTng state dump events are en=
abled, e.g.</div></div><blockquote style=3D"margin:0 0 0 40px;border:none;p=
adding:0px"><div dir=3D"ltr"><div>$ lttng enable-event --userspace &#39;ltt=
ng_ust_statedump:*&#39;</div></div></blockquote><div dir=3D"ltr"><div><br><=
/div><div>see this (from bt2 but it also applies to bt1):=C2=A0<a href=3D"h=
ttps://babeltrace.org/docs/v2.0/man7/babeltrace2-filter.lttng-utils.debug-i=
nfo.7/#doc-lttng-prereq">https://babeltrace.org/docs/v2.0/man7/babeltrace2-=
filter.lttng-utils.debug-info.7/#doc-lttng-prereq</a></div><div><br></div><=
div>Note that the Python bindings for babeltrace don&#39;t provide/expose t=
his debug info.</div><div><br></div><div><br></div><div>Christophe</div></d=
iv><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On =
Tue, 23 Jun 2020 at 11:12, Matthew Khouzam via lttng-dev &lt;<a href=3D"mai=
lto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">




<div dir=3D"ltr">
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
Hi,</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
You have the pointers that are traced. Babeltrace is doing exactly what it =
should as far as I know.</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
You could use the command &#39;nm&#39; to get your symbols and look them up=
. I am sure Babeltrace can do this from a python level. You could also use =
a GUI based trace viewer to get the information.=C2=A0</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
Hope that helps.</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
Matthew<br>
</div>
<div id=3D"gmail-m_-3967757338877835848appendonsend"></div>
<hr style=3D"display:inline-block;width:98%">
<div id=3D"gmail-m_-3967757338877835848divRplyFwdMsg" dir=3D"ltr"><font fac=
e=3D"Calibri, sans-serif" style=3D"font-size:11pt" color=3D"#000000"><b>Fro=
m:</b> lttng-dev &lt;<a href=3D"mailto:lttng-dev-bounces@lists.lttng.org" t=
arget=3D"_blank">lttng-dev-bounces@lists.lttng.org</a>&gt; on behalf of Liu=
, Changcheng via lttng-dev &lt;<a href=3D"mailto:lttng-dev@lists.lttng.org"=
 target=3D"_blank">lttng-dev@lists.lttng.org</a>&gt;<br>
<b>Sent:</b> Tuesday, June 23, 2020 10:37 AM<br>
<b>To:</b> <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">l=
ttng-dev@lists.lttng.org</a> &lt;<a href=3D"mailto:lttng-dev@lists.lttng.or=
g" target=3D"_blank">lttng-dev@lists.lttng.org</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:changcheng.liu@intel.com" target=3D"_blank">ch=
angcheng.liu@intel.com</a> &lt;<a href=3D"mailto:changcheng.liu@intel.com" =
target=3D"_blank">changcheng.liu@intel.com</a>&gt;<br>
<b>Subject:</b> [lttng-dev] get function names with lttng-ust-cyg-profile</=
font>
<div>=C2=A0</div>
</div>
<div><font size=3D"2"><span style=3D"font-size:11pt">
<div>Hi all,<br>
=C2=A0=C2=A0 I&#39;m trying to use lttng-ust-cyg-profile to trace program.<=
br>
=C2=A0=C2=A0 Does anyone know how to get function names and offset through =
lttng-ust-cyg-profile?<br>
<br>
=C2=A0=C2=A0 In below example, the babeltrace could only get the function e=
ntry/exit value.<br>
=C2=A0=C2=A0 1. Source program: instrument.c<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 #include &lt;stdio.h&gt;=
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2 <br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3 int add3(int val) {<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return val + 3;<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5 }<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6 <br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7 int main(int argc, char =
**argv) {<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8=C2=A0=C2=A0=C2=A0=C2=A0 =
int x =3D 4;<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 9=C2=A0=C2=A0=C2=A0=C2=A0 =
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 10=C2=A0=C2=A0=C2=A0=C2=A0 puts(=
&quot;Press Enter to continue...&quot;);<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 11=C2=A0=C2=A0=C2=A0=C2=A0 getch=
ar();<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 12=C2=A0=C2=A0=C2=A0=C2=A0 <br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 13=C2=A0=C2=A0=C2=A0=C2=A0 x =3D=
 add3(x);<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 14=C2=A0=C2=A0=C2=A0=C2=A0 <br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 15=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n 0;<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16 }<br>
<br>
=C2=A0=C2=A0 2. build source code:<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ gcc -g -finstrument-functions =
instrument.c -o instrument<br>
<br>
=C2=A0=C2=A0 3. run program:<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ LD_PRELOAD=3D/usr/lib/x86_64-linux-g=
nu/liblttng-ust-cyg-profile.so ./instrument<br>
<br>
=C2=A0=C2=A0 4. start trace process:<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace@trace:~/cc$ sudo lttng create in=
strument<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Session instrument created.<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Traces will be output to /root/lttng-t=
races/instrument-20200623-222917<br>
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace@trace:~/cc$ sudo lttng enable-ch=
annel user_func_trace --userspace<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 UST channel user_func_trace enabled fo=
r session instrument<br>
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace@trace:~/cc$ sudo lttng enable-ev=
ent --userspace lttng_ust_cyg_profile:func_entry --channel user_func_trace<=
br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 UST event lttng_ust_cyg_profile:func_e=
ntry created in channel user_func_trace<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace@trace:~/cc$ sudo lttng enable-ev=
ent --userspace lttng_ust_cyg_profile:func_exit --channel user_func_trace<b=
r>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 UST event lttng_ust_cyg_profile:func_e=
xit created in channel user_func_trace<br>
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace@trace:~/cc$ sudo lttng start<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Tracing started for session instrument=
<br>
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace@trace:~/cc$ sudo lttng destroy<b=
r>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Destroying session instrument..<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Session instrument destroyed<br>
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace@trace:~/cc$ sudo babeltrace /roo=
t/lttng-traces/instrument-20200623-222917<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [22:29:55.388607059] (+?.?????????) tr=
ace lttng_ust_cyg_profile:func_entry: { cpu_id =3D 2 }, { addr =3D 0x5625C8=
8B01A9, call_site =3D 0x5625C88B0237 }<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [22:29:55.388612293] (+0.000005234) tr=
ace lttng_ust_cyg_profile:func_exit: { cpu_id =3D 2 }, { addr =3D 0x5625C88=
B01A9, call_site =3D 0x5625C88B0237 }<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [22:29:55.388613215] (+0.000000922) tr=
ace lttng_ust_cyg_profile:func_exit: { cpu_id =3D 2 }, { addr =3D 0x5625C88=
B01EE, call_site =3D 0x7FE40BD5C0B3 }<br>
<br>
B.R.<br>
Changcheng<br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"https://protect2.fireeye.com/v1/url?k=3D98478753-c6e73d3d-9847c7=
c8-869a14f4b08c-41638b2508ab85dd&amp;q=3D1&amp;e=3D703483a0-63a9-4269-ac8e-=
c1fc5a57edad&amp;u=3Dhttps%3A%2F%2Flists.lttng.org%2Fcgi-bin%2Fmailman%2Fli=
stinfo%2Flttng-dev" target=3D"_blank">https://protect2.fireeye.com/v1/url?k=
=3D98478753-c6e73d3d-9847c7c8-869a14f4b08c-41638b2508ab85dd&amp;q=3D1&amp;e=
=3D703483a0-63a9-4269-ac8e-c1fc5a57edad&amp;u=3Dhttps%3A%2F%2Flists.lttng.o=
rg%2Fcgi-bin%2Fmailman%2Flistinfo%2Flttng-dev</a><br>
</div>
</span></font></div>
</div>

_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailman/l=
istinfo/lttng-dev</a><br>
</blockquote></div></div>

--000000000000ff213c05a8c331a9--

--===============5959687904060015415==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5959687904060015415==--
