Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2491C10F1B
	for <lttng-dev@archiver.kernel.org>; Tue, 27 Dec 2022 11:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1672142278;
	bh=L5mV89GPu5CwmA1d6ErU2UBSdkPyLuHd1+DW98MhO6E=;
	h=References:In-Reply-To:Date:To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=umOWA0XgjuuFfff1giHapNWuA4vkRE0xqIb1Jzhr4wAD7XwPuP7N92cd8fvHTKF5m
	 Kjm+tDbkuxnEaRVO4uOoyra0jlldfuZXNbvs1sVy2AHyQ3ysvO0hggRw3OuPHz1bfp
	 hzLRJhGxXOQ7LeHuVja85xALvONDAbP0f561AzGz+71yR3BHwLnwcsmQGjZWQDDqoL
	 y3lqEsRKc9CY3hkjrJovgAJ+RKY1sGRCtI+gf1R55e4LNIInthnNG1o/FEtaRQm3TM
	 8ZSMtZcl/66mYmtpw5J7XSFrRBBb2lrNS/nGIAEglW95M33JLUaeLUy4VaufF+jUoa
	 Ij0B8J65uCO0g==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4NhCpF5LPMz1HS8;
	Tue, 27 Dec 2022 06:57:57 -0500 (EST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com
 [209.85.217.43])
 by lists.lttng.org (Postfix) with ESMTPS id 4NhCpD2MbWz1HS6
 for <lttng-dev@lists.lttng.org>; Tue, 27 Dec 2022 06:57:56 -0500 (EST)
Received: by mail-vs1-f43.google.com with SMTP id a66so12438943vsa.6
 for <lttng-dev@lists.lttng.org>; Tue, 27 Dec 2022 03:57:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6pzdgW5i4+lrN31aANsx0fC5F+GMTJEHCktVgxRZCSY=;
 b=EJ+nehbqEJH14S4koSG5yiksLtkuVvlcPasPhrp35TD+re+KSkGVXBg1s2x0K7+CEh
 UFx1tvh3E5bQL0k3XsTeM23tWsaa5HQUIuz5EXPR4Xqr91sA36F9YH5miX5oQdq+O69X
 WYmc0BXOBvOcIQfq6DfldXFykh7Q1LOXQdIhTgFc+Amds2bePiDQdtWTvM7Oa4b2JQBK
 wsDzlrSdfP6vT4iwFMG2YdNwGEZX/9UPPn80ozFVYDxRZcEqnlUS5WarY1XRQJXeNOjZ
 SPMKhEdKy/6SwkAgOCcJguyufnG4VZ3bQJ2E5eNQ+atzgwTu2rvS11JgZW4sj46W76vl
 wNqw==
X-Gm-Message-State: AFqh2krcbstH1lZRxuhLR6Q0LD2/KN/PeRGYGuVYy82wd85c0+joHNfA
 RtePvc+tVDwloZX3pl+GN0W8HuePmvT0L6CTT+30hiE4zn+K8w==
X-Google-Smtp-Source: AMrXdXuEnIfWPEkme92+68YQwFW687OIYtXiy3JhuyyquuQWJHtVH+wivx6hllr5ZIE+1Ojyyy+0KAXkLF9olVYhdws=
X-Received: by 2002:a05:6102:2389:b0:3b1:352b:b22a with SMTP id
 v9-20020a056102238900b003b1352bb22amr2509064vsr.40.1672142215078; Tue, 27 Dec
 2022 03:56:55 -0800 (PST)
MIME-Version: 1.0
References: <CAGWKocYTK=vVyh3DjHHoKWj_Fua_Qjc+7ruG1R6d=Y2ki7uraQ@mail.gmail.com>
In-Reply-To: <CAGWKocYTK=vVyh3DjHHoKWj_Fua_Qjc+7ruG1R6d=Y2ki7uraQ@mail.gmail.com>
Date: Tue, 27 Dec 2022 17:26:44 +0530
Message-ID: <CAGWKocZ9E=oMDD09sm9zstKyt7yOxSW2pk0aDxeuxD0tSCb9DQ@mail.gmail.com>
To: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] Suspected Bug in lttng-tools
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
From: Shubham Kulkarni via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Shubham Kulkarni <shubhambkul16@gmail.com>
Content-Type: multipart/mixed; boundary="===============2110879733823383622=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============2110879733823383622==
Content-Type: multipart/alternative; boundary="000000000000be693b05f0cdf234"

--000000000000be693b05f0cdf234
Content-Type: text/plain; charset="UTF-8"

Hi,

Please ignore the previous mail from me saying there might be a bug in
lttng-tools. After some analysis, I found this is expected functionality as
per the commit https://github.com/lttng/lttng-tools/commit/cb034ca.
It's NOT A BUG.

Thanks,
Shubham


On Mon, Dec 26, 2022 at 3:52 PM Shubham Kulkarni <shubhambkul16@gmail.com>
wrote:

> Hi,
>
> I am entirely new to the lttng-tools and frankly not aware of anything.
> But, one of our company's customer reported this issue, so I tried
> reproducing. I was able to reproduce it with the version of lttng-tool
> (2.12.4 - (Ta) Meilleure) installed on my Ubuntu 16.04 (
> https://lttng.org/docs/v2.12/#doc-ubuntu-ppa).
>
> Issue is, if I try to snapshot a session with an output filename
> containing a ".", it fails. Steps I followed are given below :
>
> *"*
> root@MVIN00032:~# lttng create flightrecorder --snapshot
> Snapshot session flightrecorder created.
> Default snapshot output set to
> /home/shubham/lttng-traces/flightrecorder-20221223-153147
> Every channel enabled for this session will be set to mmap output and
> default to overwrite mode.
>
> root@MVIN00032:~# lttng enable-event -k -a
> All Kernel events are enabled in channel channel0
>
> root@MVIN00032:~# lttng start
> Tracing started for session flightrecorder
>
> root@MVIN00032:~# lttng -vvv snapshot record -s flightrecorder -n
> *record.dump*
> DEBUG1 - 15:32:15.173476719 [7159/7159]: LSM cmd type : 28 (in
> send_session_msg() at lttng-ctl.c:128)
> *Error: Create directory failed*
> DEBUG1 - 15:32:15.197542565 [7159/7159]: Clean exit (in clean_exit() at
> lttng.c:152)
>
> root@MVIN00032:~# lttng -vvv snapshot record -s flightrecorder -n
> *record_dump*
> DEBUG1 - 15:32:24.013450964 [7442/7442]: LSM cmd type : 28 (in
> send_session_msg() at lttng-ctl.c:128)
> *Snapshot recorded successfully for session flightrecorder*
>
> root@MVIN00032:~# lttng stop
> Waiting for data availability
> Tracing stopped for session flightrecorder
>
> root@MVIN00032:~# lttng destroy
> Session flightrecorder destroyed *"*
>
> -----------------------------------------------------------------------------------------------------------------------------------------------------------
>
> I tried the same with lttng-tools v2.9.5 (as one of my company's product
> uses this version) under runqemu session, which worked fine for
> 'record.dump' & with lttng-tools v2.11.5 (another product uses this
> version) failed with the same error. So, maybe in between these versions an
> issue was introduced.
>
> I am not sure whether this is the correct location to send this mail, but
> I didn't find any solution on the Internet and I am not aware of lttng at
> all. I was able to reproduce the issue with help from the internet, so
> thought to report it via this mailing list.
>
> Thanks,
> Shubham
>

--000000000000be693b05f0cdf234
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>Please ignore the previo=
us mail from me saying there might be a bug in lttng-tools. After some anal=
ysis, I found this is expected functionality as per the commit=C2=A0<a href=
=3D"https://github.com/lttng/lttng-tools/commit/cb034ca">https://github.com=
/lttng/lttng-tools/commit/cb034ca</a>. It&#39;s=C2=A0NOT A BUG.</div><div><=
br></div><div>Thanks,</div><div>Shubham</div><div dir=3D"ltr"><br></div><br=
><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, D=
ec 26, 2022 at 3:52 PM Shubham Kulkarni &lt;<a href=3D"mailto:shubhambkul16=
@gmail.com">shubhambkul16@gmail.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Hi,<div><br></div><div>=
I am entirely new to the lttng-tools and frankly not aware of anything. But=
, one of our company&#39;s customer reported=C2=A0this issue, so I tried re=
producing. I was able to reproduce=C2=A0it with the version of lttng-tool (=
2.12.4 - (Ta) Meilleure) installed on my Ubuntu 16.04 (<a href=3D"https://l=
ttng.org/docs/v2.12/#doc-ubuntu-ppa" target=3D"_blank">https://lttng.org/do=
cs/v2.12/#doc-ubuntu-ppa</a>).</div><div><br></div><div>Issue is, if I try =
to snapshot a session with an output filename containing a &quot;.&quot;, i=
t fails. Steps I followed are given below :</div><div><br></div><div><b>&qu=
ot;</b></div><div>root@MVIN00032:~# lttng create flightrecorder --snapshot<=
br>Snapshot session flightrecorder created.<br>Default snapshot output set =
to /home/shubham/lttng-traces/flightrecorder-20221223-153147<br>Every chann=
el enabled for this session will be set to mmap output and default to overw=
rite mode.<br><br>root@MVIN00032:~# lttng enable-event -k -a<br>All Kernel =
events are enabled in channel channel0<br><br>root@MVIN00032:~# lttng start=
<br>Tracing started for session flightrecorder<br><br>root@MVIN00032:~# ltt=
ng -vvv snapshot record -s flightrecorder -n=C2=A0<b>record.dump</b><br>DEB=
UG1 - 15:32:15.173476719 [7159/7159]: LSM cmd type : 28 (in send_session_ms=
g() at lttng-ctl.c:128)<br><b>Error: Create directory failed</b><br>DEBUG1 =
- 15:32:15.197542565 [7159/7159]: Clean exit (in clean_exit() at lttng.c:15=
2)<br><br>root@MVIN00032:~# lttng -vvv snapshot record -s flightrecorder -n=
=C2=A0<b>record_dump</b><br>DEBUG1 - 15:32:24.013450964 [7442/7442]: LSM cm=
d type : 28 (in send_session_msg() at lttng-ctl.c:128)<br><b>Snapshot recor=
ded successfully for session flightrecorder</b><br><br>root@MVIN00032:~# lt=
tng stop<br>Waiting for data availability<br>Tracing stopped for session fl=
ightrecorder<br><br>root@MVIN00032:~# lttng destroy<br>Session flightrecord=
er destroyed=C2=A0<b>&quot;</b><br></div><div>-----------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------</div><div><br></div><di=
v>I tried the same with=C2=A0lttng-tools v2.9.5 (as one of my company&#39;s=
 product uses this version) under runqemu session, which worked fine for &#=
39;record.dump&#39; &amp; with lttng-tools v2.11.5 (another product uses th=
is version) failed with the same error. So, maybe in between=C2=A0these ver=
sions an issue was introduced.</div><div><br></div><div>I am not sure wheth=
er this is the correct location to send this mail, but I didn&#39;t find an=
y solution on the Internet and I am not aware of lttng at all. I was able t=
o reproduce the issue with help from the internet, so thought to report it =
via this mailing list.</div><div><br></div><div>Thanks,</div><div>Shubham</=
div></div>
</blockquote></div></div>

--000000000000be693b05f0cdf234--

--===============2110879733823383622==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2110879733823383622==--
