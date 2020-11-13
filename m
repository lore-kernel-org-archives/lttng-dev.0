Return-Path: <SRS0=d4Wd=ET=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB6BC4742C
	for <lttng-dev@archiver.kernel.org>; Fri, 13 Nov 2020 13:38:54 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E412622201
	for <lttng-dev@archiver.kernel.org>; Fri, 13 Nov 2020 13:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="JeS3E7Ow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E412622201
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4CXfgw0qQBz1HRY;
	Fri, 13 Nov 2020 08:38:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1605274732;
	bh=qES1pDlh4aSbMIh9FjIk3RPu3FnpUjgLHL109Z4TjsU=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=JeS3E7OwpoGAdV7ST5vz38b5dPEWNrwQUjABb72TTpv43eiENbaCBKl1MuxbeEdgZ
	 E5URmKHY87ehgCYH21mAjmwJmZ+QdzUdQ6yxSPAl2YYRA4YyVHyA/yI7F9tnAts2yq
	 473GsIpIvIn3So/df48A+AZNenhFIumOlBB7e/oq/KR1g6VA0i5wagcwbm9st/nRkX
	 s69+Cm33bXofftNXNDPkD85fCVQHlNkHpClqzoBfj9ORzUFWyMqWjsfzO0jN0Y1QYh
	 XWedCPP9eb7q4YMDtLSV8lzU8Q2K/W7i+hSHW/owavc8G6HEXj4FOXq2lylgWTT4yv
	 GbcNKFrWQFhWg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4CXfgs6yPWz1HT5
 for <lttng-dev@lists.lttng.org>; Fri, 13 Nov 2020 08:38:49 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id DB23F288F7A
 for <lttng-dev@lists.lttng.org>; Fri, 13 Nov 2020 08:30:55 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id KLScyWSYWHjj; Fri, 13 Nov 2020 08:30:55 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 8A219288FE4;
 Fri, 13 Nov 2020 08:30:55 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 8A219288FE4
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id kbwkGwOgL0NR; Fri, 13 Nov 2020 08:30:55 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 7DEB328928D;
 Fri, 13 Nov 2020 08:30:55 -0500 (EST)
Date: Fri, 13 Nov 2020 08:30:55 -0500 (EST)
To: "wangshuo (AF)" <wangshuo47@huawei.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Hushiyuan <hushiyuan@huawei.com>
Message-ID: <497724542.44120.1605274255374.JavaMail.zimbra@efficios.com>
In-Reply-To: <3f94d86a19ef4d3d84487768fde3d7b1@huawei.com>
References: <3f94d86a19ef4d3d84487768fde3d7b1@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3975 (ZimbraWebClient - FF82 (Linux)/8.8.15_GA_3975)
Thread-Topic: README: fix typo in README.md
Thread-Index: Ada5nzno1TkUN+DwSVu16JhN3Od9ePOVaWX3
Subject: Re: [lttng-dev] [PATCH] README: fix typo in README.md
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
Content-Type: multipart/mixed; boundary="===============3599706579661363347=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============3599706579661363347==
Content-Type: multipart/alternative; 
	boundary="=_755c7589-1636-4011-a751-4a0b853c2088"

--=_755c7589-1636-4011-a751-4a0b853c2088
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi, 

This fix does not apply with "git am", probably due to the fact that the email is not 
formatted as plain text without alteration by your email client. I recommend using 
git send-email to send patches. Can you try sending it again in the proper format 
expected by git am ? 

You will likely find useful information about why your email client changed the 
patch formatting here: 

[ https://www.kernel.org/doc/html/v5.9/process/submitting-patches.html | https://www.kernel.org/doc/html/v5.9/process/submitting-patches.html ] 
[ https://www.kernel.org/doc/html/v5.9/process/email-clients.html#email-clients | https://www.kernel.org/doc/html/v5.9/process/email-clients.html#email-clients ] 

Thanks, 

Mathieu 

----- On Nov 13, 2020, at 4:28 AM, wangshuo (AF) <wangshuo47@huawei.com> wrote: 

> README: fix typo in README.md

> Signed-off-by: Shuo Wang < [ mailto:wangshuo47@huawei.com |
> wangshuo47@huawei.com ] >

> ---

> README.md | 2 +-

> 1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/README.md b/README.md

> index 2d6dcaa..dd7ebd1 100644

> --- a/README.md

> +++ b/README.md

> @@ -388,7 +388,7 @@ For always-on debugging self-checks:

> ./configure --enable-rcu-debug

> For fine grained enabling of debugging self-checks, build

> -urserspace-rcu with DEBUG_RCU defined and compile dependent

> +userspace-rcu with DEBUG_RCU defined and compile dependent

> applications with DEBUG_RCU defined when necessary.

> Warning: Enabling this feature result in a performance penalty.

> --

> 2.23.0

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_755c7589-1636-4011-a751-4a0b853c2088
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div>Hi,<br></div><div><br data-mce-bogus=3D"1">=
</div><div>This fix does not apply with "git am", probably due to the fact =
that the email is not<br data-mce-bogus=3D"1"></div><div>formatted as plain=
 text without alteration by your email client. I recommend using</div><div>=
git send-email to send patches. Can you try sending it again in the proper =
format</div><div>expected by git am ?<br data-mce-bogus=3D"1"></div><div><b=
r data-mce-bogus=3D"1"></div><div>You will likely find useful information a=
bout why your email client changed the<br data-mce-bogus=3D"1"></div><div>p=
atch formatting here:<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=
=3D"1"></div><div><a href=3D"https://www.kernel.org/doc/html/v5.9/process/s=
ubmitting-patches.html">https://www.kernel.org/doc/html/v5.9/process/submit=
ting-patches.html</a><br data-mce-bogus=3D"1"></div><div><a href=3D"https:/=
/www.kernel.org/doc/html/v5.9/process/email-clients.html#email-clients">htt=
ps://www.kernel.org/doc/html/v5.9/process/email-clients.html#email-clients<=
/a><br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>=
Thanks,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><=
div>Mathieu<br data-mce-bogus=3D"1"></div><div><br></div><div><span id=3D"z=
wchr" data-marker=3D"__DIVIDER__">----- On Nov 13, 2020, at 4:28 AM, wangsh=
uo (AF) &lt;wangshuo47@huawei.com&gt; wrote:<br></span><style>/*<![CDATA[*/=
p.MsoNormal, li.MsoNormal, div.MsoNormal {
=09margin: 0.0cm;
=09text-align: justify;
=09font-size: 10.5pt;
=09font-family: Calibri , sans-serif;
}
a:link, span.MsoHyperlink {
=09color: rgb(5,99,193);
=09text-decoration: underline;
}
a:visited, span.MsoHyperlinkFollowed {
=09color: rgb(149,79,114);
=09text-decoration: underline;
}
span.EmailStyle17 {
=09font-family: Calibri , sans-serif;
=09color: windowtext;
}
*.MsoChpDefault {
=09font-family: Calibri , sans-serif;
}
div.WordSection1 {
=09page: WordSection1;
}
/*]]>*/</style></div><div data-marker=3D"__QUOTED_TEXT__"><blockquote style=
=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#0=
00;font-weight:normal;font-style:normal;text-decoration:none;font-family:He=
lvetica,Arial,sans-serif;font-size:12pt;">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">README: fix typo in README.md</=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Signed-off-by: Shuo Wang &lt;<a=
 href=3D"mailto:wangshuo47@huawei.com" target=3D"_blank" rel=3D"nofollow no=
opener noreferrer">wangshuo47@huawei.com</a>&gt;</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">---</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">README.md | 2 +-</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">1 file changed, 1 insertion(+),=
 1 deletion(-)</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/README.md b/README=
.md</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 2d6dcaa..dd7ebd1 100644</=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/README.md</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+++ b/README.md</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -388,7 +388,7 @@ For always-=
on debugging self-checks:</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; ./configure --enable-rcu-debug</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;For fine grained enabling=
 of debugging self-checks, build</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-urserspace-rcu with DEBUG_RCU =
defined and compile dependent</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+userspace-rcu with DEBUG_RCU d=
efined and compile dependent</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">applications with DEBUG_RCU def=
ined when necessary.</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;Warning: Enabling this fe=
ature result in a performance penalty.</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-- </span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2.23.0</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;</span></p>
</div><br></blockquote></div><div><br></div><div data-marker=3D"__SIG_POST_=
_">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.effic=
ios.com</div></div></body></html>
--=_755c7589-1636-4011-a751-4a0b853c2088--

--===============3599706579661363347==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3599706579661363347==--
