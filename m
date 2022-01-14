Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E28AC433F5
	for <lttng-dev@archiver.kernel.org>; Fri, 14 Jan 2022 21:02:49 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4JbDK43KSzzFgv;
	Fri, 14 Jan 2022 16:02:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1642194168;
	bh=iqHFV3iIdrT7+jbHz4lv2ErFzKmP/OKWDLyspuvZ8dM=;
	h=To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=B7xfA+G1ekkUABTwvzRwIbU1zTQ+XFenFslfZDRI5MyZtTE/ET78CE8nUo/ynKWwy
	 hSKc4vRFZI9HK4e9TRcooDHOMFxJp9XcrmEMlsrhHN87i3U7RzhokcNKH56gayeV2p
	 bBB3qCzov06fY10aSDOAXPj7Y4Ra57E5VHQVsa1N1sh8aBF99J5LeySHy5uRSurZk9
	 ZHYb2kze7UXB1I1c43Kqe+Sa6hIvVau65L8V1/9Nuj78CyFGM6Vp6YQGtyB92fWFEO
	 HyBXUBIywEdr1XtXLVzIU9JGbMtXnSAqacctChvSiIFmPDu69Znr+xJXO+JkO/uVFH
	 WYYnZ8B1fZ7LQ==
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-oln040092071094.outbound.protection.outlook.com [40.92.71.94])
 by lists.lttng.org (Postfix) with ESMTPS id 4JbDK320ytzFVw
 for <lttng-dev@lists.lttng.org>; Fri, 14 Jan 2022 16:02:47 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kaXmSvCOF6HJNUfO+8wD9whc6IH/IYubbYLJcpuyTHMp+lyf4bgatCyCvkGCkiYOzlhvGYyEjT8IKvNVXmp/Gvb9q5Sy8sFgjk5GWv4DRx9f97Ekhb20gaNSp2FkVdUJpM8MLJea4bn4SNVPx23J9342BR4cdkjdYDq0WM7xflQLZSux4U7+ujhRhB3z8Ea8ovDcCzXvqbpQt07cCUIOAa0wutGXhbELCvIlhMqP6OdLFwT7WIqX+5ALJ7Id/e85Hm2ap6azi32+RD2+fToBcAewElLkUMYweTQN/V/OeIozOe44/RTPoGkkeBWl5YwdIkXZVyJCWm4BOL8e0HAbTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCe4L63q9v4oFzCK5ACZvpT4f3tb+0kVxMRwjRpbq8w=;
 b=Bb9/L5DP8dIzSbVg3bLi71+uu9eSg1rJKuJowz8z5MoKdX8x6yMnjkHl2qa7Cyw02sY1m0DbAOJgII1JLRsl1b+kcOZnT2UWNnLtT7QgLIw2Nsy1qtOy8drNNUuyQE80XYIzNuYOcGcWqxJfzdfZzZC7vndnFx/vO4i/ikl0ZmeZTPzi266LvanbbsyrzzYn8NGfqRILB4nD6S+OsvF81vBuEhYjepiz09SREQ3g4HJBai6HdplQ6KFyyr7bBm2g+95Fq5bK6jDwzkiULVlb0fiEoMDNkbQuBo8xK08IOjYR8ybL5Fv6SZ5LILVKnXicuk+OyiozniFMVQRmvPxOKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DB8P195MB0485.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:15d::21)
 by AM0P195MB0273.EURP195.PROD.OUTLOOK.COM (2603:10a6:208:af::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Fri, 14 Jan
 2022 21:02:45 +0000
Received: from DB8P195MB0485.EURP195.PROD.OUTLOOK.COM
 ([fe80::a938:440a:a4c4:7e57]) by DB8P195MB0485.EURP195.PROD.OUTLOOK.COM
 ([fe80::a938:440a:a4c4:7e57%7]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 21:02:45 +0000
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau
 <jgalar@efficios.com>
Thread-Topic: Transfer of LTTng copyright ownership: Jesper Derehag
Thread-Index: qlthIN068Y9G8oCF3gODd9j77VMBFvlQ0eZn
Date: Fri, 14 Jan 2022 21:02:44 +0000
Message-ID: <DB8P195MB04858A81D23B3070BC4D3F2DDD549@DB8P195MB0485.EURP195.PROD.OUTLOOK.COM>
References: <2023865153.34173.1642193451936.JavaMail.zimbra@efficios.com>
In-Reply-To: <2023865153.34173.1642193451936.JavaMail.zimbra@efficios.com>
Accept-Language: sv-SE, en-US
Content-Language: sv-SE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [+ieC7g2bN37HXgHxhLryM75wtipdJgPj]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bae5afc0-1191-41e8-e976-08d9d7a13651
x-ms-traffictypediagnostic: AM0P195MB0273:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N2aHYl5sFIrYi+1JhrWUTkpH1qo1uKkgBLyKS0VBKy07LdxAWP8UkDS+tFITjvH37eBVfEfxE6dWPnmzH8CbkaXkWuYcexU93aURRSO5mycCXs38/Qhye+cO6bLUvq2Zi49DY70aB5cWGbd83V959VpA0hHK5H8PbVEi2pWAR2cqCGUTIIbMou9G1KufUzmi3vh3pdhgsGozn9qryBCrl82aYqmtbwKmmRkl/sLggND7S6ImHxlC0Cgp8fTf3bnpEMT9QlEfjBCfF4GKtaSbR+c2Bl6J+dtP6v/2N/7gYGd0y3HuH9aZyZ4Er2GVt6yaOuYWZylHRHCn2Ta2SbWhIha93pq28yYGkY9TK5EZTuEclWy416vXxvb4YZhZUq0DewuV3uRgGAxzLl9tSCneGUTjiPyColMrIhgDgyUwo+vDyvz6UCvCPA5DNUxlpc3VvDMDVfprJLKhQ95e49NCDZ2xcvuL/pfIL8OTKp7KlsD6A93vE3Xl1lAth4/cshwPw1LlrgQrPDQk73yQLTunrxup2rw7mBAz238FVEmrny0W8XOwM3QsQGu9fMjdjfg33x5pxSYhe0BsudsZ6xd0RDxgo5xDkYo07E/rcyZ/i4teuChEjx+yjTBByBnP8gLf
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4KbkxWX85hPZsulzaGayFUnssmTUGa9bZYSpuIlwglWzVjnoi4BPr8hCw7?=
 =?iso-8859-1?Q?F/7JOqbY9AhU5aWse0pNVQbpDKdX6se2LuORjhl8is8lj5ueWfqz6kDgFA?=
 =?iso-8859-1?Q?ghLT4Y5rd1E3HW36fQxr4gwRXWbzJujopHELfKozUAxLobj3ZeciojGseU?=
 =?iso-8859-1?Q?CT3kpTbohMpABiZJHGy17rfe+qYwoEO3tiBTwGlvjanGxeV2BACBF4RpNg?=
 =?iso-8859-1?Q?0MVgjfijR17qCyExafduOGF+Hbkb7VKX1itSjHcHRt+QcidzvnLnEvvHW/?=
 =?iso-8859-1?Q?iRXam5KPh3qktgsBmDlk46BG6zXwIIE4bOVoA4DIt0JMlYeKQmp2bh4mID?=
 =?iso-8859-1?Q?L06oTqks0O3hWYCo/lm3f2rgocm9gdJXcKy2j8slpJfNQaJ+Spn7JeoPHp?=
 =?iso-8859-1?Q?CDXTHR2IkRg79KeLhSnUCOBBl+Bfld+a3pwjDUdgKeC5bi3JMf242+BNbg?=
 =?iso-8859-1?Q?xHAvggjYi5w2OrGrtlpEnSyIhENyFGMPve/bQyloG7YrKWBbu61o/4rWY3?=
 =?iso-8859-1?Q?f+tX5dTMqPXbQKPXbfho9tTFNDX9Yp8f2Anhvs3QRe1HCDqzkjZSGSMk0z?=
 =?iso-8859-1?Q?o8E+RCjFjaeRDeiee/C5U5x8Ffgvyrgnm/gx0zhPhcWDF60a/y3XOAPRxJ?=
 =?iso-8859-1?Q?GUvo/m39g605ooEa1kP1ps7D89WTZ3QgtxHFgXNoALSZGJoYVCPZ7AGdsn?=
 =?iso-8859-1?Q?1VZZTp9OHisDqvjUMjIriV616/8lYGZNU0LYaAk+I8PudRrENklb6ALdMp?=
 =?iso-8859-1?Q?B+nmdpIYtI4rii8kVqaAsGhRJqxkgXeO87yeseIJf42+o1Mm/yD7UcKvVg?=
 =?iso-8859-1?Q?NJd6RooHfxesEUVI8z3sZVq4syQS8xRbYPUtDNv76Xf3ws0bI34ozvhRtJ?=
 =?iso-8859-1?Q?2XNsIllP3ciL9eIdPDpkakJTIx0pqi7tIWvwarMV5+zNTU8opET1S7JNyE?=
 =?iso-8859-1?Q?QOnBbW0z4lhpqJk9iYU4DsppgO/fLOoTeBuxBNvak71FQ3vRcV9H70fNPI?=
 =?iso-8859-1?Q?bNw1bfXopeifv/AZU=3D?=
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-49ed2.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8P195MB0485.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: bae5afc0-1191-41e8-e976-08d9d7a13651
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2022 21:02:44.9743 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P195MB0273
Subject: Re: [lttng-dev] Transfer of LTTng copyright ownership: Jesper
 Derehag
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.35
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Jesper Derehag via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Jesper Derehag <jderehag@hotmail.com>
Content-Type: multipart/mixed; boundary="===============5104837887001547576=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============5104837887001547576==
Content-Language: sv-SE
Content-Type: multipart/alternative;
	boundary="_000_DB8P195MB04858A81D23B3070BC4D3F2DDD549DB8P195MB0485EURP_"

--_000_DB8P195MB04858A81D23B3070BC4D3F2DDD549DB8P195MB0485EURP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Yes, I acknowledge that copyright can be transferred to EfficiOS inc.

Don't spend it all in one place! =3D)

/Jesper

________________________________
Fr=E5n: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Skickat: fredag 14 januari 2022 21:50
Till: Jesper Derehag
Kopia: lttng-dev; Jeremie Galarneau
=C4mne: Transfer of LTTng copyright ownership: Jesper Derehag

Hi Jesper,

In order to facilitate maintenance of the LTTng project, would you agree to
transfer your copyright ownership for code authored in your own time to
EfficiOS Inc. ?

Even though most of those changes are somewhat trivial, I would prefer that
we keep a public record of this for the future.

Those changes are authored with this email:

Jesper Derehag <jderehag@hotmail.com>

This affects the lttng-tools and lttng-ust projects.

Mathieu

--
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com


--_000_DB8P195MB04858A81D23B3070BC4D3F2DDD549DB8P195MB0485EURP_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
Yes, I acknowledge that copyright can be transferred to EfficiOS inc.</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
<br>
</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
Don't spend it all in one place! =3D)</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div><br>
</div>
/Jesper</div>
<div id=3D"id-f486b91f-8901-4c5e-a2ba-e79ad9c2d192" class=3D"ms-outlook-mob=
ile-reference-message" dir=3D"auto">
<div style=3D"font-family: sans-serif; font-size: 12pt; color: rgb(0, 0, 0)=
;"><br>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg"><strong>Fr=E5n:</strong> Mathieu Desnoyers &lt;ma=
thieu.desnoyers@efficios.com&gt;<br>
<strong>Skickat:</strong> fredag 14 januari 2022 21:50<br>
<strong>Till:</strong> Jesper Derehag<br>
<strong>Kopia:</strong> lttng-dev; Jeremie Galarneau<br>
<strong>=C4mne:</strong> Transfer of LTTng copyright ownership: Jesper Dere=
hag<br>
</div>
<br>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style><font size=3D"=
2"><span style=3D"font-size:11pt;">
<div class=3D"PlainText">Hi Jesper,<br>
<br>
In order to facilitate maintenance of the LTTng project, would you agree to=
<br>
transfer your copyright ownership for code authored in your own time to<br>
EfficiOS Inc. ?<br>
<br>
Even though most of those changes are somewhat trivial, I would prefer that=
<br>
we keep a public record of this for the future.<br>
<br>
Those changes are authored with this email:<br>
<br>
Jesper Derehag &lt;jderehag@hotmail.com&gt;<br>
<br>
This affects the lttng-tools and lttng-ust projects.<br>
<br>
Mathieu<br>
<br>
-- <br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com">http://www.efficios.com</a><br>
</div>
</span></font><br>
</div>
</body>
</html>

--_000_DB8P195MB04858A81D23B3070BC4D3F2DDD549DB8P195MB0485EURP_--

--===============5104837887001547576==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5104837887001547576==--
