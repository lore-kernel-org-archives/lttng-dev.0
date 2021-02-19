Return-Path: <SRS0=UQx0=HV=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_SHORTFWD_URISHRT_QP,SPF_HELO_NONE,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1475C433DB
	for <lttng-dev@archiver.kernel.org>; Fri, 19 Feb 2021 18:39:34 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1095664E4B
	for <lttng-dev@archiver.kernel.org>; Fri, 19 Feb 2021 18:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1095664E4B
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Dj0jc3B67z2gb;
	Fri, 19 Feb 2021 13:39:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1613759973;
	bh=KnoCpQgVNFfH3bFdrWuBEtAZ8IxiDDgKT0WC211mChg=;
	h=References:In-Reply-To:Date:To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Nnk6QXpqRvxaLej+09diM2j31IJtmCmfNwKG+Y9g39xShZDfCQgDK89F4BKYBPVoD
	 HGiS+BFUOereMskwZDlHLQdonW0n0HixmJNb17LVpZToIQiEQmI7uWVhl/mQLuruAF
	 SVE+PQ89ojo5g8wjBImf4sF98BdtzteboLpJ4KIcZvbFHLO/TBCeMDeh21OVG6Pqks
	 a6tx1vh7M0F3Q5xE25YEbTfnpmV58QFca302nHKr6dmnR2m8Kesupc8mBezGamAN90
	 QYZf4B065VF24xahmIR6ujLLFVhS4RPhW/xGh9e38j8mc017hftVou2z02HNxD9qCC
	 pZ7OCSsAv/vCw==
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 by lists.lttng.org (Postfix) with ESMTPS id 4Dj0jZ5PWpz2gY
 for <lttng-dev@lists.lttng.org>; Fri, 19 Feb 2021 13:39:30 -0500 (EST)
Received: by mail-pg1-x52d.google.com with SMTP id o7so5292089pgl.1
 for <lttng-dev@lists.lttng.org>; Fri, 19 Feb 2021 10:39:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fGiZ5oEyf8VLSKHuA/KA3GrkYcXdWQrB1fT5lKUQhY0=;
 b=N6/JkRpnSWrv9MFt57PBgWd6Idf2Q3bonRNTeLDksSwyDLWij3Ece2Ywfmx9Wg9BrP
 Bgf77E1fH4bVYlwYCDSvCSVwBipcorQruwy8Ea+uFaVfvEgRC/zOGvCN3N3JubHkxIO3
 3IdUL7vRQXNpWVvxm6AZ6JQQO6lNBWyHUi07BZI6Jq8+u332oarn38kuypSPK4W1W92p
 AskBtH7PjvTN2VAnFoFu+lBYszrOtKx++J9DtFOfP1fF50jBLK06f+2FVklPdL5z7TNR
 5Tsbrq31t6ZYytcJrkFAI6CjiDYXzA/UbuyiqLHvmyP/PylQ+OaCZGCiVJqWphn8hfG/
 /3gw==
X-Gm-Message-State: AOAM533vORFCCI3hbx7QHesN1ZCi++fiSKhqnRoLRBZP5ZmI1xsM6LMu
 wU0Z2of0UGQ9Sn2XuZGS6KUFb+Njp+aSeguYxxU=
X-Google-Smtp-Source: ABdhPJwC95DKSpeuwjnfwWFtXfNYe8mZ752cJS33BGtHW3TgkCToUHciPezFk7Gq4YhGhZVJfg36ExBybND080Vd5Tc=
X-Received: by 2002:a05:6a00:1506:b029:1bc:6f53:8eb8 with SMTP id
 q6-20020a056a001506b02901bc6f538eb8mr10760363pfu.36.1613759969575; Fri, 19
 Feb 2021 10:39:29 -0800 (PST)
MIME-Version: 1.0
References: <CABB28Cy1yzw7DGMO2Hoi83pQbEPr521YTWszO7LbgkQ8OXFAOQ@mail.gmail.com>
 <CABB28Cxfnmj7FyRTRJdgOJJ6UdSmf8Nd7ZeDt2CF_7FQMQhsVA@mail.gmail.com>
 <846525289.26662.1613658859303.JavaMail.zimbra@efficios.com>
In-Reply-To: <846525289.26662.1613658859303.JavaMail.zimbra@efficios.com>
Date: Fri, 19 Feb 2021 18:39:04 +0000
Message-ID: <CABB28Cy=1q3nEkW_zZheovzX5Lfa6f3HMO940mEHTE4QY7RYZw@mail.gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [lttng-dev] userspace-rcu 0.12.2: build fails
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: =?utf-8?q?Tomasz_K=C5=82oczko_via_lttng-dev?= <lttng-dev@lists.lttng.org>
Reply-To: =?UTF-8?Q?Tomasz_K=C5=82oczko?= <kloczko.tomasz@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Content-Type: multipart/mixed; boundary="===============3166890978064027145=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============3166890978064027145==
Content-Type: multipart/alternative; boundary="000000000000bd47bf05bbb4c534"

--000000000000bd47bf05bbb4c534
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Feb 2021 at 14:34, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> ----- On Feb 17, 2021, at 8:41 PM, Tomasz K=C5=82oczko kloczko.tomasz@gma=
il.com
> wrote:
>
> > Hi,
>
> > Just tested 0.12.2 and look s like build fails on compile test programs=
:
>
> Hi,
>
> Adding Michael and the lttng-dev mailing list in CC.
>
> Can you provide information about your build environment ? Which
> distribution are you
> building on ?
>
> Is it a pristine tree on which bootstrap and configure have been executed
> locally ?
>
> Can you reproduce this issue with 0.12.1 ?
>

Just done that test and in exactly the same build env 0.12.1 builds without
any problems.

kloczek
--=20
Tomasz K=C5=82oczko | LinkedIn: http://lnkd.in/FXPWxH

--000000000000bd47bf05bbb4c534
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace,monospace"><span style=3D"font-family:Arial,Helvetica,sa=
ns-serif">On Thu, 18 Feb 2021 at 14:34, Mathieu Desnoyers &lt;<a href=3D"ma=
ilto:mathieu.desnoyers@efficios.com">mathieu.desnoyers@efficios.com</a>&gt;=
 wrote:</span><br></div></div><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">----- On Feb 17, 2021, at 8:41 PM, Tomasz =
K=C5=82oczko <a href=3D"mailto:kloczko.tomasz@gmail.com" target=3D"_blank">=
kloczko.tomasz@gmail.com</a> wrote:<br>
<br>
&gt; Hi,<br>
<br>
&gt; Just tested 0.12.2 and look s like build fails on compile test program=
s:<br>
<br>
Hi, <br>
<br>
Adding Michael and the lttng-dev mailing list in CC. <br>
<br>
Can you provide information about your build environment ? Which distributi=
on are you <br>
building on ? <br>
<br>
Is it a pristine tree on which bootstrap and configure have been executed l=
ocally ? <br>
<br>
Can you reproduce this issue with <span class=3D"gmail_default" style=3D"fo=
nt-family:monospace,monospace"></span>0.12.1 ?<br></blockquote><div><br></d=
iv><div class=3D"gmail_default" style=3D"font-family:monospace,monospace">J=
ust done that test and in exactly the same build env=C2=A0<span class=3D"gm=
ail_default"></span><span style=3D"font-family:Arial,Helvetica,sans-serif">=
0.12.1 builds=C2=A0without any problems.</span></div><div class=3D"gmail_de=
fault" style=3D"font-family:monospace,monospace"><br clear=3D"all"></div><d=
iv class=3D"gmail_default" style=3D"font-family:monospace,monospace">klocze=
k</div><div><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><di=
v dir=3D"ltr"><font face=3D"monospace, monospace">--=C2=A0</font></div></di=
v></div></div><div class=3D"gmail_default" style=3D"font-family:monospace,m=
onospace">Tomasz K=C5=82oczko | LinkedIn:=C2=A0<a href=3D"http://lnkd.in/FX=
PWxH" target=3D"_blank" style=3D"text-decoration-line:none"><span style=3D"=
font-size:13px;background-color:transparent;text-decoration-line:underline;=
vertical-align:baseline;white-space:pre-wrap">http://lnkd.in/FXPWxH</span><=
/a></div></div></div>

--000000000000bd47bf05bbb4c534--

--===============3166890978064027145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3166890978064027145==--
