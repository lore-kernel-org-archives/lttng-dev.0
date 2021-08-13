Return-Path: <SRS0=UoRB=NE=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64103C4338F
	for <lttng-dev@archiver.kernel.org>; Fri, 13 Aug 2021 15:02:22 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60B236113E
	for <lttng-dev@archiver.kernel.org>; Fri, 13 Aug 2021 15:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 60B236113E
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4GmRcC3sHMz9RJ;
	Fri, 13 Aug 2021 11:02:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1628866940;
	bh=HQlo+hY781KGBXjam4sfzqUCFLHIKm8pw1fJuiiZ95E=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=BbMpwo7jAH42WQsIqcmyIz7+6xzr1gSzyYvqPNBethmB7+aAJ+bExfbxP/KES8WGW
	 Lny7DT1dYrDMTXwGyHpaauEfckGY0PqX0zk9lmlIMZ9VM4h2pbsbZvAE30o3h1bu5K
	 PoOkYPL2zCYI3dqT+fvoi6jhrVqmzRv1/kOq1iLSXeFJDFZO+y6UG2LeD8mkBLMMi1
	 jAAJAg8q4O3hJC7P054EwM487Ef6k+4ulinVAKHCp0+6FhcaqPPdfzHDquSCFRyfqf
	 i6XR/WpUsAoXEdZ6VKJzFughcWPO79s7A9xhn2ey3Fr2ojSI5RyFxc+qFPtSeByGew
	 FQ9gOjCta11sQ==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4GmRc933Mrz9RG
 for <lttng-dev@lists.lttng.org>; Fri, 13 Aug 2021 11:02:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 43E8D364EAB;
 Fri, 13 Aug 2021 10:56:24 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id UJ2Iic-tRDFc; Fri, 13 Aug 2021 10:56:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 528EE364FB7;
 Fri, 13 Aug 2021 10:56:19 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 528EE364FB7
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 3FIPseYbe30C; Fri, 13 Aug 2021 10:56:19 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 40727364B6B;
 Fri, 13 Aug 2021 10:56:19 -0400 (EDT)
Date: Fri, 13 Aug 2021 10:56:19 -0400 (EDT)
To: "Kramer, Zach" <Zach.Kramer@cognex.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, 
 Philippe Proulx <pproulx@efficios.com>
Message-ID: <1088457655.14235.1628866579209.JavaMail.zimbra@efficios.com>
In-Reply-To: <DM6PR06MB61863EC46C9025E1C0250F3A91FA9@DM6PR06MB6186.namprd06.prod.outlook.com>
References: <DM6PR06MB61863EC46C9025E1C0250F3A91FA9@DM6PR06MB6186.namprd06.prod.outlook.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4101 (ZimbraWebClient - FF90 (Linux)/8.8.15_GA_4059)
Thread-Topic: Question about rotating session limitations
Thread-Index: AdeQFBe4MiBffDDMSoGgI23a8d3kQ95ixdaP
Subject: Re: [lttng-dev] Question about rotating session limitations
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
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Galarneau_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Reply-To: =?utf-8?B?SsOpcsOpbWll?= Galarneau <jeremie.galarneau@efficios.com>
Content-Type: multipart/mixed; boundary="===============0934465056189138407=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============0934465056189138407==
Content-Type: multipart/alternative; 
	boundary="=_20c27c58-7aa4-49a4-a726-6e10603a13c7"

--=_20c27c58-7aa4-49a4-a726-6e10603a13c7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> From: "lttng-dev" <lttng-dev@lists.lttng.org>
> To: "lttng-dev" <lttng-dev@lists.lttng.org>
> Sent: Friday, August 13, 2021 3:28:14 AM
> Subject: [lttng-dev] Question about rotating session limitations

> Hello,

> On [ https://lttng.org/man/1/lttng-rotate/v2.12/ |
> https://lttng.org/man/1/lttng-rotate/v2.12/ ] one of the limitations is l=
isted
> as:

> The lttng rotate command only works when:

> =C2=B7 No channel was created with a configured trace file count or size =
limit (see
> the --tracefile-size and --tracefile-count options in [
> https://lttng.org/man/1/lttng-enable-channel/v2.12 | lttng-enable-channel=
(1) ]
> ).

> However on v2.12.1 I am able to:

>     1. Create a userspace session
>     2. Create a channel w/ configured trace file count and size limit
>     3. Start tracing
>     4. lttng rotate

> Within each chunk these restrictions are respected.

> Therefore my question is what does this limitation actually mean? Is it m=
ore so
> in the direction that the archives will not respect these limits because =
the
> chunks accumulate? Or am I missing the point entirely?

Hi Zach,=20

I think it's simply a documentation error, probably on my part from misadvi=
sing Philippe.=20
I'll open a change against the manual page.=20

Thanks for reporting this!=20
J=C3=A9r=C3=A9mie=20

> Thanks,

> Zach

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=_20c27c58-7aa4-49a4-a726-6e10603a13c7
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br></div><div><br></div><hr id=3D"zwchr" d=
ata-marker=3D"__DIVIDER__"><div data-marker=3D"__HEADERS__"><blockquote sty=
le=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:=
#000;font-weight:normal;font-style:normal;text-decoration:none;font-family:=
Helvetica,Arial,sans-serif;font-size:12pt;"><b>From: </b>"lttng-dev" &lt;lt=
tng-dev@lists.lttng.org&gt;<br><b>To: </b>"lttng-dev" &lt;lttng-dev@lists.l=
ttng.org&gt;<br><b>Sent: </b>Friday, August 13, 2021 3:28:14 AM<br><b>Subje=
ct: </b>[lttng-dev] Question about rotating session limitations<br></blockq=
uote></div><div><style>/*<![CDATA[*/p.MsoNormal, li.MsoNormal, div.MsoNorma=
l {
=09margin: 0.0cm;
=09font-size: 11.0pt;
=09font-family: Calibri , sans-serif;
}
a:link, span.MsoHyperlink {
=09color: rgb(5,99,193);
=09text-decoration: underline;
}
code {
=09font-family: "Courier New";
}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph {
=09margin-top: 0.0cm;
=09margin-right: 0.0cm;
=09margin-bottom: 0.0cm;
=09margin-left: 36.0pt;
=09font-size: 11.0pt;
=09font-family: Calibri , sans-serif;
}
span.s {
}
*.MsoChpDefault {
=09font-family: Calibri , sans-serif;
}
div.WordSection1 {
=09page: WordSection1;
}
* {
}
* {
}
* {
}
* {
}
* {
}
* {
}
* {
}
* {
}
* {
}
* {
}
* {
}
* {
}
* {
}
* {
}
* {
}
* {
}
* {
}
* {
}
* {
}
* {
}
ol {
=09margin-bottom: 0.0cm;
}
ul {
=09margin-bottom: 0.0cm;
}
/*]]>*/</style></div><div data-marker=3D"__QUOTED_TEXT__"><blockquote style=
=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#0=
00;font-weight:normal;font-style:normal;text-decoration:none;font-family:He=
lvetica,Arial,sans-serif;font-size:12pt;">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"DE">Hello,</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">On <a href=3D"https://lttng.org=
/man/1/lttng-rotate/v2.12/" target=3D"_blank" rel=3D"nofollow noopener nore=
ferrer">
https://lttng.org/man/1/lttng-rotate/v2.12/</a> one of the limitations is l=
isted as:</span></p>
<p style=3D"margin-left:18pt">The <code><span style=3D"font-size:10pt">lttn=
g rotate</span></code> command only works when:</p>
<p style=3D"margin-left:54pt;text-indent:-18pt"><span style=3D"font-family:=
'symbol'">=C2=B7</span>No channel was created with a configured trace file =
count or size limit (see the
<code><span style=3D"font-size:10pt">--tracefile-size</span></code> and <co=
de><span style=3D"font-size:10pt">--tracefile-count</span></code> options i=
n
<a href=3D"https://lttng.org/man/1/lttng-enable-channel/v2.12" target=3D"_b=
lank" rel=3D"nofollow noopener noreferrer">lttng-enable-channel<span class=
=3D"s"><span style=3D"color:blue">(1)</span></span></a>).
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">However on v2.12.1 I am able to=
:</span></p>
<ol style=3D"margin-top:0cm" type=3D"1" start=3D"1"><li class=3D"MsoListPar=
agraph" style=3D"margin-left:0cm"><span lang=3D"EN-US">Create a userspace s=
ession</span></li><li class=3D"MsoListParagraph" style=3D"margin-left:0cm">=
<span lang=3D"EN-US">Create a channel w/ configured trace file count and si=
ze limit</span></li><li class=3D"MsoListParagraph" style=3D"margin-left:0cm=
"><span lang=3D"EN-US">Start tracing</span></li><li class=3D"MsoListParagra=
ph" style=3D"margin-left:0cm"><span lang=3D"EN-US">lttng rotate</span></li>=
</ol>

<p class=3D"MsoNormal"><span lang=3D"EN-US">Within each chunk these restric=
tions are respected.</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">Therefore my question is what d=
oes this limitation actually mean? Is it more so in the direction that the =
archives will not respect these limits because the chunks accumulate? Or am=
 I missing the point entirely?</span></p>
</div></blockquote><div><br></div><div>Hi Zach,<br data-mce-bogus=3D"1"></d=
iv><div><br data-mce-bogus=3D"1"></div><div>I think it's simply a documenta=
tion error, probably on my part from misadvising Philippe.<br data-mce-bogu=
s=3D"1"></div><div>I'll open a change against the manual page.<br data-mce-=
bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Thanks for repor=
ting this!<br data-mce-bogus=3D"1"></div><div>J=C3=A9r=C3=A9mie<br data-mce=
-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><blockquote style=3D=
"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;=
font-weight:normal;font-style:normal;text-decoration:none;font-family:Helve=
tica,Arial,sans-serif;font-size:12pt;"><div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">Thanks,</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Zach</span></p>
</div>

<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/=
listinfo/lttng-dev<br></blockquote></div></div></body></html>
--=_20c27c58-7aa4-49a4-a726-6e10603a13c7--

--===============0934465056189138407==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0934465056189138407==--
