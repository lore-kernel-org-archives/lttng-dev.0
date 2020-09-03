Return-Path: <SRS0=QVYh=CM=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822A2C433E9
	for <lttng-dev@archiver.kernel.org>; Thu,  3 Sep 2020 14:17:37 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EF03206A5
	for <lttng-dev@archiver.kernel.org>; Thu,  3 Sep 2020 14:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="oPSXghd+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF03206A5
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Bj2vM4J28z6vL;
	Thu,  3 Sep 2020 10:17:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1599142656;
	bh=N+DddgSL88a+XuymXsnRo48vL7ho4WHwQvaSWFfIQ/0=;
	h=Date:To:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=oPSXghd+VWrg9g9dKogoKt3R7ygK93Ay1ICOLmc0ymR0Yxwn1YgXVDvoL2wmgUXd8
	 yzbYjNOZZJm0+UUQcZ0THk5w8j3H2XHgdRHYnXGZN+Az836B3Cs/JgYSfasBhaRtwy
	 XJiGnDoCBX2T5KoQOoU4BhjCRsCrv/l5Wn1I13Dpve4p+7trWEwuy8XjCInH20uqXS
	 q8AeMrUw6fy/0eqFGga71YRLZ6qgblL0ibOc6RbGspJaFbH61CIqHJLnOMxHdFESt5
	 CHZu4elGyPL13MKZK8755SoCm1+xfx4VI4zlAuqojSalaZqqxD850tdDn0ZiOtHwib
	 k7vIaZ25YD1dQ==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4Bj2vK3frNz7Sg
 for <lttng-dev@lists.lttng.org>; Thu,  3 Sep 2020 10:17:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id EE7D22614C4
 for <lttng-dev@lists.lttng.org>; Thu,  3 Sep 2020 10:17:27 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id A5zbz3mg_nR9; Thu,  3 Sep 2020 10:17:27 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id B78C8261702;
 Thu,  3 Sep 2020 10:17:27 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B78C8261702
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id J4aRDyd8C0J8; Thu,  3 Sep 2020 10:17:27 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id AA8F62613D7;
 Thu,  3 Sep 2020 10:17:27 -0400 (EDT)
Date: Thu, 3 Sep 2020 10:17:27 -0400 (EDT)
To: =?utf-8?B?54aK5q+T5Y2O?= <xiongyuhua@zju.edu.cn>
Message-ID: <2099957101.27976.1599142647638.JavaMail.zimbra@efficios.com>
In-Reply-To: <5ceed60f.1d021.17451e23278.Coremail.xiongyuhua@zju.edu.cn>
References: <6e9da9cb.16e65.17448f14499.Coremail.xiongyuhua@zju.edu.cn>
 <1835947492.25584.1598967460978.JavaMail.zimbra@efficios.com>
 <5ceed60f.1d021.17451e23278.Coremail.xiongyuhua@zju.edu.cn>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3959 (ZimbraWebClient - FF80 (Linux)/8.8.15_GA_3953)
Thread-Topic: How to use the lttng-untrack command
Thread-Index: RMMNfNs+G/Zb4iXNy1owAQ5BTyaZ8Q==
Subject: Re: [lttng-dev] How to use the lttng-untrack command
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Content-Type: multipart/mixed; boundary="===============5701743249757471200=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============5701743249757471200==
Content-Type: multipart/alternative; 
	boundary="=_d19cc029-051e-4f22-b3d0-07406c21b917"

--=_d19cc029-051e-4f22-b3d0-07406c21b917
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- On Sep 2, 2020, at 10:53 PM, =E7=86=8A=E6=AF=93=E5=8D=8E <xiongyuhua@=
zju.edu.cn> wrote:=20

> Thanks=EF=BC=8Cnow I understand the tracking policy of lttng.

> And I want to know=EF=BC=8Cdo you have any plans for "exclusion set"?
Not at this point. None of our customers expressed interest in that feature=
 so far.=20

Thanks,=20

Mathieu=20

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

--=_d19cc029-051e-4f22-b3d0-07406c21b917
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br data-mce-bogus=3D"1"></div><div><span i=
d=3D"zwchr" data-marker=3D"__DIVIDER__">----- On Sep 2, 2020, at 10:53 PM, =
=E7=86=8A=E6=AF=93=E5=8D=8E &lt;xiongyuhua@zju.edu.cn&gt; wrote:<br></span>=
</div><div data-marker=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left=
:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:=
normal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,s=
ans-serif;font-size:12pt;"><p>
=09Thanks=EF=BC=8Cnow I understand the tracking policy of lttng.
</p>
<p>
=09And I want to know=EF=BC=8Cdo you have any plans for "exclusion set"?
</p></blockquote><div>Not at this point. None of our customers expressed in=
terest in that feature so far.<br></div><div><br data-mce-bogus=3D"1"></div=
><div>Thanks,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"><=
/div><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"=
1"></div><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px=
;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-deco=
ration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;">
</blockquote></div><div data-marker=3D"__SIG_POST__">-- <br></div><div>Math=
ieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com</div></div></body=
></html>
--=_d19cc029-051e-4f22-b3d0-07406c21b917--

--===============5701743249757471200==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5701743249757471200==--
