Return-Path: <SRS0=qBpU=C3=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826A1C43464
	for <lttng-dev@archiver.kernel.org>; Fri, 18 Sep 2020 15:17:10 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 897E82389E
	for <lttng-dev@archiver.kernel.org>; Fri, 18 Sep 2020 15:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="hl0m14lV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 897E82389E
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4BtHW132nVzHbq;
	Fri, 18 Sep 2020 11:17:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1600442222;
	bh=jUo5YrUWs9XjtSkBhKuHUlGltBnYLKFss9SUh3kw1cY=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=hl0m14lVuYFDoy446udSQjgTnbSfE8GqHMZXBacnjhRFprmCZiX/Kr0Ukv6pau5DZ
	 B5RfmILrXSq2Q7R9nBZq8kF3AG/ziUuAnaO7ABg+5iJvAbivRLqQiUsfWzyZnwsu+V
	 TAC3UzpcZPWH4rbu7a/uW8E4hK54R98eMm83ELu5FEauwpQbTiyM+B1oZtp9zatgur
	 RA1soV6dJM5CkONKdwNpJONfFsTCBMCHfTlL82P5JYKIRIxX/cuGyr9BGTlnrcMNkO
	 Zf4AeQdaixcQPYU/4YHtFihWd2BlP4TTIHaA5sSVHuiZAeo71IGwBLwCj91iN/ZpPt
	 UlEYgDlZJJAJA==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4BtHVy65rJzHK8
 for <lttng-dev@lists.lttng.org>; Fri, 18 Sep 2020 11:16:58 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 746A12712C4
 for <lttng-dev@lists.lttng.org>; Fri, 18 Sep 2020 11:16:52 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 2al_bnamZ13s; Fri, 18 Sep 2020 11:16:52 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 1E9D527113D;
 Fri, 18 Sep 2020 11:16:52 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1E9D527113D
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id KjeyLIt4chE1; Fri, 18 Sep 2020 11:16:52 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 1181D27113C;
 Fri, 18 Sep 2020 11:16:52 -0400 (EDT)
Date: Fri, 18 Sep 2020 11:16:51 -0400 (EDT)
To: Abdelrahman ElShabrawy <abdelrahman130@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <1381831273.34861.1600442211965.JavaMail.zimbra@efficios.com>
In-Reply-To: <CA+weNbniCKiGV+cSz+A3rfzxO09a8DtF8O27LPxK8Oz-a9PbBA@mail.gmail.com>
References: <CA+weNbniCKiGV+cSz+A3rfzxO09a8DtF8O27LPxK8Oz-a9PbBA@mail.gmail.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3965 (ZimbraWebClient - FF80 (Linux)/8.8.15_GA_3963)
Thread-Topic: Lttng-UST requires shared libraries
Thread-Index: a88JBMpEk/N/KZIg0Reo8pvGzIltyQ==
Subject: Re: [lttng-dev] Lttng-UST requires shared libraries
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: multipart/mixed; boundary="===============0264693462449443389=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============0264693462449443389==
Content-Type: multipart/alternative; 
	boundary="=_6762b1ae-035a-434c-a42c-a54fe2d63bd3"

--=_6762b1ae-035a-434c-a42c-a54fe2d63bd3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Sep 16, 2020, at 3:57 AM, lttng-dev <lttng-dev@lists.lttng.org> wrote: 

> Hello All,
> I'm trying to configure Lttng-UST and disabling shared libraries using the
> option --enable-shared=no.

> I always get an Error that Lttng-UST requires shared libraries enabled.

> Why is this option available if I can't use it ? Is there something I'm missing

This option is only there because it's part of the autotools boilerplate. It has been disabled 
by the lttng-ust project on purpose. 

See README.md: 

"LTTng-UST needs to be a shared library, _even if_ the tracepoint probe provider is statically 
linked into the application." 

Static linking of liblttng-ust has never been a supported use-case, and would require a significant 
design/implementation effort. 

Thanks, 

Mathieu 

> Regards,
> Abdelrahman.

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_6762b1ae-035a-434c-a42c-a54fe2d63bd3
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br data-mce-bogus=3D"1"></div><div><span i=
d=3D"zwchr" data-marker=3D"__DIVIDER__">----- On Sep 16, 2020, at 3:57 AM, =
lttng-dev &lt;lttng-dev@lists.lttng.org&gt; wrote:<br></span></div><div dat=
a-marker=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #10=
10FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-st=
yle:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font=
-size:12pt;"><div dir=3D"ltr">Hello All,<br><div>I'm trying to configure Lt=
tng-UST and disabling shared libraries using the option --enable-shared=3Dn=
o.</div><br><div>I always get an Error that Lttng-UST requires shared libra=
ries enabled.</div><br><div>Why is this option available if I can't use it =
? Is there something I'm missing</div></div></blockquote><div><br></div><di=
v>This option is only there because it's part of the autotools boilerplate.=
 It has been disabled<br data-mce-bogus=3D"1"></div><div>by the lttng-ust p=
roject on purpose.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D=
"1"></div><div>See README.md:<br data-mce-bogus=3D"1"></div><div><br data-m=
ce-bogus=3D"1"></div><div>"LTTng-UST needs to be a shared library, _even if=
_ the tracepoint probe provider is statically</div><div>linked into the app=
lication."<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></di=
v><div>Static linking of liblttng-ust has never been a supported use-case, =
and would require a significant</div><div>design/implementation effort.<br =
data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Thanks,=
<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Mat=
hieu<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div=
><br data-mce-bogus=3D"1"></div><blockquote style=3D"border-left:2px solid =
#1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font=
-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;f=
ont-size:12pt;"><div dir=3D"ltr"><br><div>Regards,</div><div>Abdelrahman.</=
div></div>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/=
listinfo/lttng-dev<br></blockquote></div><div><br></div><div data-marker=3D=
"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http=
://www.efficios.com</div></div></body></html>
--=_6762b1ae-035a-434c-a42c-a54fe2d63bd3--

--===============0264693462449443389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0264693462449443389==--
