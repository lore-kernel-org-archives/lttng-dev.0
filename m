Return-Path: <SRS0=zN6S=HK=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391DBC433E0
	for <lttng-dev@archiver.kernel.org>; Mon,  8 Feb 2021 10:27:48 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D89664ECC
	for <lttng-dev@archiver.kernel.org>; Mon,  8 Feb 2021 10:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D89664ECC
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4DZ2KF1Ld0z19QG;
	Mon,  8 Feb 2021 05:27:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1612780065;
	bh=RaJodXlb6XFvngh9siu2Oi3xE748elUHGulHRyWp4Gg=;
	h=To:Date:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=buICytwwdUGjwHhHokg4DEZq3oXffVS+G7s/lUEAMC0M092tOXUzYHIfN3lVCAwlZ
	 T4Dxiq+qHI+3oO4iS6U4GhjUJwKfW1CQv/aOU/mOKrlenAuH9TuD4iIfVVDwix3jv4
	 sWmYxSr0Fo91yYaxQOh8YlJ0TIpl1ypLqZ39h3hoqQzWDR3r/1Hv3QOKvIn7iSnWsi
	 5SVWfF81D9ZVIMWP24lsltRusNF0bSkW/P3RRRBwKLQirWR9J7TqWyX33KzX5w33F4
	 ENv6Q40bAjwB79Zlbu5+VMZHGrcM6qNxHA6E+Qc9+oNiPFq73jpWxdnrNqYi8pJ6U4
	 9dC7AUsutbboQ==
Received: from oxalide-smtp-out.extra.cea.fr (oxalide-smtp-out.extra.cea.fr
 [132.168.224.13])
 by lists.lttng.org (Postfix) with ESMTPS id 4DZ2KB4lHlz19FC
 for <lttng-dev@lists.lttng.org>; Mon,  8 Feb 2021 05:27:42 -0500 (EST)
Received: from pisaure.intra.cea.fr (pisaure.intra.cea.fr [132.166.88.21])
 by oxalide-sys.extra.cea.fr (8.14.7/8.14.7/CEAnet-Internet-out-4.0) with ESMTP
 id 118ARY0A005667
 for <lttng-dev@lists.lttng.org>; Mon, 8 Feb 2021 11:27:34 +0100
Received: from pisaure.intra.cea.fr (localhost [127.0.0.1])
 by localhost (Postfix) with SMTP id 89A362044C6
 for <lttng-dev@lists.lttng.org>; Mon,  8 Feb 2021 11:27:34 +0100 (CET)
Received: from muguet1-smtp-out.intra.cea.fr (muguet1-smtp-out.intra.cea.fr
 [132.166.192.12])
 by pisaure.intra.cea.fr (Postfix) with ESMTP id 7DE8D2037E1
 for <lttng-dev@lists.lttng.org>; Mon,  8 Feb 2021 11:27:34 +0100 (CET)
Received: from EXCAH-B3.intra.cea.fr (excah-b3.intra.cea.fr [132.166.88.88])
 by muguet1-sys.intra.cea.fr (8.14.7/8.14.7/CEAnet-Internet-out-4.0) with ESMTP
 id 118ARYZg022598
 for <lttng-dev@lists.lttng.org>; Mon, 8 Feb 2021 11:27:34 +0100
Received: from EXDAG0-B1.intra.cea.fr ([fe80::c18e:d8e8:9a27:5b84]) by
 EXCAH-B3.intra.cea.fr ([fe80::947a:e02d:e083:3de0%10]) with mapi id
 14.03.0487.000; Mon, 8 Feb 2021 11:27:34 +0100
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: [barectf] no nested types?
Thread-Index: AQHW/AoHQ3cZRzuTQEmId5OA6m/FiKpODejh
Date: Mon, 8 Feb 2021 10:27:33 +0000
Message-ID: <386C5D4D5C53C24CBC2C60CAAFD2136A5B4A9D26@EXDAG0-B1.intra.cea.fr>
References: <386C5D4D5C53C24CBC2C60CAAFD2136A5B4A9BAB@EXDAG0-B1.intra.cea.fr>
In-Reply-To: <386C5D4D5C53C24CBC2C60CAAFD2136A5B4A9BAB@EXDAG0-B1.intra.cea.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [132.167.194.33]
x-tm-as-product-ver: SMEX-11.0.0.4179-8.100.1062-25960.003
x-tm-as-result: No--5.778500-0.000000-31
x-tm-as-user-approved-sender: Yes
x-tm-as-user-blocked-sender: No
MIME-Version: 1.0
Subject: Re: [lttng-dev] [barectf] no nested types?
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
From: RADERMACHER Ansgar via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: RADERMACHER Ansgar <Ansgar.RADERMACHER@cea.fr>
Content-Type: multipart/mixed; boundary="===============0100574889402195767=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============0100574889402195767==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_386C5D4D5C53C24CBC2C60CAAFD2136A5B4A9D26EXDAG0B1intrace_"

--_000_386C5D4D5C53C24CBC2C60CAAFD2136A5B4A9D26EXDAG0B1intrace_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Dear all,

having thought a bit more about it, I can see now that nested types are pro=
blematic in general: some types in the language need to be mapped to types =
that match but are not identical, i.e. have likely a different memory layou=
t. This would be problematic for nested types.
Thus, I'm opting for flattening data (with the exception of lists).

Best regards

Ansgar


________________________________
From: lttng-dev [lttng-dev-bounces@lists.lttng.org] on behalf of RADERMACHE=
R Ansgar via lttng-dev [lttng-dev@lists.lttng.org]
Sent: Friday, February 05, 2021 22:58
To: lttng-dev@lists.lttng.org
Subject: [lttng-dev] [barectf] no nested types?

Hello,

I've generated a config.yaml from type definitions in UML. If the type of a=
 payload field is a UML DataType, the generator produces an associated type=
 alias file with "class =3D structure" and the contained members.

When I tried to compile the configuration file, I get an error message from=
 barectf:
`field-type` property: Nested structure field types are not supported

It this really not supported or are there other mechanisms that enable the =
use of nested types? If not supported, it would be an important restriction=
 which seems to be not prominently documented (in [1], there is a parenthes=
is "except a structure field type object" but it's easy to miss)

Best regards

Ansgar


[1] https://barectf.org/docs/barectf/3.0/yaml/struct-ft-obj.html



--_000_386C5D4D5C53C24CBC2C60CAAFD2136A5B4A9D26EXDAG0B1intrace_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html dir=3D"ltr">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" id=3D"owaParaStyle"></style>
</head>
<body fpstyle=3D"1" ocsi=3D"0">
<div style=3D"direction: ltr;font-family: Tahoma;color: #000000;font-size: =
10pt;">
<div>Dear all,</div>
<div><br>
</div>
<div>having thought a bit more about it, I can see now that nested types ar=
e problematic in general: some types in the language need to be mapped to t=
ypes that match but are not identical, i.e. have likely a different memory =
layout. This would be problematic
 for nested types.</div>
<div>Thus, I'm opting for flattening data (with the exception of lists).</d=
iv>
<div><br>
</div>
<div>Best regards</div>
<div><br>
</div>
<div>Ansgar<br>
</div>
<div><br>
</div>
<div><br>
</div>
<div style=3D"font-family: Times New Roman; color: #000000; font-size: 16px=
">
<hr tabindex=3D"-1">
<div id=3D"divRpF241604" style=3D"direction: ltr;"><font size=3D"2" face=3D=
"Tahoma" color=3D"#000000"><b>From:</b> lttng-dev [lttng-dev-bounces@lists.=
lttng.org] on behalf of RADERMACHER Ansgar via lttng-dev [lttng-dev@lists.l=
ttng.org]<br>
<b>Sent:</b> Friday, February 05, 2021 22:58<br>
<b>To:</b> lttng-dev@lists.lttng.org<br>
<b>Subject:</b> [lttng-dev] [barectf] no nested types?<br>
</font><br>
</div>
<div></div>
<div>
<div style=3D"direction:ltr; font-family:Tahoma; color:#000000; font-size:1=
0pt">
<div>Hello,</div>
<div><br>
</div>
<div>I've generated a config.yaml from type definitions in UML. If the type=
 of a payload field is a UML DataType, the generator produces an associated=
 type alias file with &quot;class =3D structure&quot; and the contained mem=
bers.</div>
<div><br>
</div>
<div>When I tried to compile the configuration file, I get an error message=
 from barectf:</div>
<div><span style=3D"font-family:monospace"><span style=3D"font-weight:bold;=
 color:#ff5454; background-color:#ffffff">`field-type` property</span><span=
 style=3D"color:#b21818; background-color:#ffffff">: Nested structure field=
 types are not supported</span></span></div>
<div><font color=3D"000000"><span style=3D"background-color:rgb(255,255,255=
)"><br>
</span></font></div>
<div><font color=3D"000000"><span style=3D"background-color:rgb(255,255,255=
)">It this really not supported or are there other mechanisms that enable t=
he use of nested types? If not supported, it would be an important restrict=
ion which seems to be not prominently
 documented (in [1], there is a parenthesis &quot;except a structure field =
type object&quot; but it's easy to miss)&nbsp;
<br>
</span></font></div>
<div><font color=3D"000000"><span style=3D"background-color:rgb(255,255,255=
)"><br>
</span></font></div>
<div><font color=3D"000000"><span style=3D"background-color:rgb(255,255,255=
)">Best regards</span></font></div>
<div><font color=3D"000000"><span style=3D"background-color:rgb(255,255,255=
)"><br>
</span></font></div>
<div><font color=3D"000000"><span style=3D"background-color:rgb(255,255,255=
)">Ansgar<br>
</span></font></div>
<div><font color=3D"000000"><span style=3D"background-color:rgb(255,255,255=
)"><br>
</span></font></div>
<div><font color=3D"000000"><span style=3D"background-color:rgb(255,255,255=
)"><br>
</span></font></div>
<div><font color=3D"000000"><span style=3D"background-color:rgb(255,255,255=
)">[1] https://barectf.org/docs/barectf/3.0/yaml/struct-ft-obj.html<br>
</span></font></div>
<div><span style=3D"font-family:monospace"><br>
<br>
</span></div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_386C5D4D5C53C24CBC2C60CAAFD2136A5B4A9D26EXDAG0B1intrace_--

--===============0100574889402195767==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0100574889402195767==--
