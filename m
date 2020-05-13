Return-Path: <SRS0=A40Q=63=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C13ECA90AF
	for <lttng-dev@archiver.kernel.org>; Wed, 13 May 2020 13:43:24 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41C5B204EF
	for <lttng-dev@archiver.kernel.org>; Wed, 13 May 2020 13:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="D2wZZSSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C5B204EF
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49MbV174R3z220b;
	Wed, 13 May 2020 09:43:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1589377402;
	bh=pX4ExcPNcVSX5BRjOBfYCP5x7US5Eb/RpKEkpg7n3HU=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=D2wZZSSfT96EE3fuRbGHdSr3qJpRJnRiIzmDTJJbA5p+bP77STAnw1xAoIaRQ+dWY
	 ufXWk0UpB0nNKoEZxDQjAeSMI1qJC6dSGdETMrR1mZE/0DQ4VlhrlkghhCIxenL9te
	 rWI5V3UFLCY70b5Hn6tI/IUeVaKJQ0oZiiqSN95JRpPABiPm3HemV0CNUDXS1KQKI6
	 yF/BrFeY81dhXTZ8JP0LfGeOSMs2nNHdEj/P+1NFPAtK14GdKMZ5u6uOzqyxNb+mzn
	 gXxU+G+GgOh9A7xv5hJXgN5l4yvfDAfxribtbmj9PyCa0DsMLjhBschiGIIPR+7MYA
	 3FUsi6aA2UDOQ==
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by lists.lttng.org (Postfix) with ESMTPS id 49MbTz6z4Sz220Y
 for <lttng-dev@lists.lttng.org>; Wed, 13 May 2020 09:43:19 -0400 (EDT)
Received: by mail-ej1-x630.google.com with SMTP id s21so6120323ejd.2
 for <lttng-dev@lists.lttng.org>; Wed, 13 May 2020 06:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Nz4Tillg4DfuwSOaD4qUJf1CyuD8iSTM+GcotXfMcFI=;
 b=Cl8xDY+4gmvG9PJXkrERml7dFAugUUnNd/AN8+3LcECNQ4zhDblBeH70EmluUiFeXA
 TaUaShtD2aEZgrpu64u7vsIsG68KBTvjD3ngASnjqWc9tcyQE3WqWS5Z3qMa2X6vB+7s
 kVG5zrBFdYc3qQbETlvIbF5zsE6/ZF5IMRy8b8D48L6fP3275I3dZkk6NgC9UgubGXC5
 BwMGgrBghkShEIEBTWsRmIDY42INF5z0fwFIsLAf5xNTpij+RznWShCrOlksKI2FR0+W
 Z5i57YVvhP9EKEzAXcL3SKDzgVw0wL7Uvca6naYfjliTP8O2Jo4ZstP0LbvflcJzN0LY
 xqCA==
X-Gm-Message-State: AGi0PuZKIqKUdiUtFCgxUR7jyHnezEIdG0n7XWfahKSWVG5QLroeqytp
 TRj+qaOBuVsQmWKpY0WE+7Prun7FHBGRulHsj2E=
X-Google-Smtp-Source: APiQypLpt6SUNnF50YR0RqzXmLCL0z0ifMa0oeD+5Om4ntSFPhy77gCKI7FOJxaoTrUDajkOIqsdp/rqKoirHrYPaDk=
X-Received: by 2002:a17:906:6411:: with SMTP id
 d17mr22644317ejm.109.1589377398494; 
 Wed, 13 May 2020 06:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAAS9doY1Ez7N=_H6e-w9eWg0LBJp+MMasuOEmzbO0DGyLSzViA@mail.gmail.com>
 <1486835767.11198.1589286441675.JavaMail.zimbra@efficios.com>
In-Reply-To: <1486835767.11198.1589286441675.JavaMail.zimbra@efficios.com>
Date: Wed, 13 May 2020 09:42:42 -0400
Message-ID: <CAAS9dobxi52FyWn=9zVDkMMpmZztc1Q1msdiErMKhkDEYCtqCA@mail.gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: [lttng-dev] Correctly using callstack-user context
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
Content-Type: multipart/mixed; boundary="===============5450112476235330822=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200513134242.B8ftyiYEWF_mIXu9zk6HIUpz_e3Kwsy7zEtnX3GdY_g@z>

--===============5450112476235330822==
Content-Type: multipart/alternative; boundary="0000000000004058e905a587c316"

--0000000000004058e905a587c316
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 May 2020 at 08:27, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> How does your test program issue the system call ? Is it directly with
> syscall() (see syscall(2) man page), or
> does it call into libc ? Is your entire libc compiled with
> -fno-omit-frame-pointer ?
>

Indirectly, through libc/libstdc++. We use the default system libs (which I
assume use -O, which in turn implies -fomit-frame-pointer).


> As soon as one library in the chain to the system call is compiled without
> frame pointers, this is where the
> stack walk stops. This is usually libc.
>

I see. Thanks for the information. Not sure we want to ship a custom libc
unfortunately.

Related question: how feasible would adding the callstack-user context to
userspace events be? If it is feasible, is such a feature planned?



Christophe

--0000000000004058e905a587c316
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Tue, 12 May 2020 at 08:27, Mathieu Des=
noyers &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_bla=
nk">mathieu.desnoyers@efficios.com</a>&gt; wrote:</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex"><div><div style=3D"font-family:arial,helvetic=
a,sans-serif;font-size:12pt;color:rgb(0,0,0)"><div><div>How does your test =
program issue the system call ? Is it directly with syscall() (see syscall(=
2) man page), or<br></div><div>does it call into libc ? Is your entire libc=
 compiled with -fno-omit-frame-pointer ?</div></div></div></div></blockquot=
e><div><br></div><div>Indirectly, through libc/libstdc++. We use the defaul=
t system libs (which I assume use -O, which in turn implies -fomit-frame-po=
inter).</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><div style=3D"font-family:arial,helvetica,sans-serif;font-size:12pt;co=
lor:rgb(0,0,0)"><div></div><div>As soon as one library in the chain to the =
system call is compiled without frame pointers, this is where the<br></div>=
<div>stack walk stops. This is usually libc.</div></div></blockquote><div><=
br></div><div>I see. Thanks for the information. Not sure we want to ship a=
 custom libc unfortunately.</div><div><br></div><div>Related question: how =
feasible would adding the callstack-user context to userspace=C2=A0events b=
e? If it is feasible, is such a feature planned?</div><div><br></div><div><=
br></div><div><br></div><div>Christophe=C2=A0</div></div></div>

--0000000000004058e905a587c316--

--===============5450112476235330822==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5450112476235330822==--
