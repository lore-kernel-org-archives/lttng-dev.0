Return-Path: <SRS0=MKX/=HA=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982F1C433DB
	for <lttng-dev@archiver.kernel.org>; Fri, 29 Jan 2021 15:07:12 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A224E64E03
	for <lttng-dev@archiver.kernel.org>; Fri, 29 Jan 2021 15:07:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A224E64E03
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4DS10F3kXSz15X1;
	Fri, 29 Jan 2021 10:07:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1611932830;
	bh=8U5ayVqPxNx3Z8V9Pt0Aru5L+ND+REzpkdlsxxo7jUc=;
	h=To:Date:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=GjKQfabORUu58c+s1S3nrAlRP3DLbpyLgWYIsa+ie1A1FvttVlV0yl9xhMP1bWXbQ
	 otDtV7YEPI14+Gn21t867LXe0Fll7kOCct6EwrGQ4SaJWn/MY3sOh5zC1uxrwXbftJ
	 j7Z+H9AEoDoVw7qEx/ZNVZN9WWmbtY41W71wNSQ4gy+8F3mCYIya2zmyQ61xJ5k3WT
	 P3ug/uzuez9gMr9v1AB0hFX1tmIVKkU5qbcje5ecj6E1ZT3G8HAh9BKjuKEWg5gG7p
	 kQL9B14761ixtn/0JplHbBYBpXKUkQXt7VB62wEWzJxfwvfgevfMHt6sozpKSJRtCV
	 LUBd879e/hyIg==
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-oln040092075074.outbound.protection.outlook.com [40.92.75.74])
 by lists.lttng.org (Postfix) with ESMTPS id 4DS10C5p0Zz15Wy
 for <lttng-dev@lists.lttng.org>; Fri, 29 Jan 2021 10:07:07 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndLgHbG+iwb5lmhAi+tbL8hC5I9tIHnQNRl8qiKx9YFr7Kvj2uJ+PKRzXZbfv75vn+Q5tL3w81HWeSfWpUTRkUdfpAfYZI2eWF8U/j8xKI0eerLcScuGuEZGreswKygyqQ4UkAdMqRB9mAv6FoVY848xOK+pIo5dgs/Bg5tAT7RDPs1cRWWRa9Hg+emYwyVzH803v/VRZlxKd7PvsOfqbLG/u5Xd+yYl8xS8QrCN1x9tvOkBiWBEzT43z8imidNlNejDLS7S6oKf0iw5wfHIv6xbLPDj5dBi7hIKXlZLNZr3ZHzJYUkYsPf9Ox/3brAM3Syp6DRbUQ1GDHvVa8jeQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/nQaLAWHk4tXTLE/J9y7MQYRIUlu8drbxBs9PevaTk=;
 b=oIzE6zzGQmlGkRhGGJk6fxbFdP8HPa1qjS7TwS4AqQunNwJvvIQGwxziHMQ8LGZERd3Yz/P0Rg0g14kJy8ncozwjlmGg6IXoVqBtA2MJnmq1zaGY3fu1u3H3R0WBNJmcGSk2pltF2Qzl26DcZIH1SwZfspCWR5gs9KBa1a5lWitTcK6ddcZuHQyZDZh99tnG3CHWy+frYieOGQrif2gtDKsjh4H71LBj7j5m5L374STAVBBn7Eg4HhNR/xwBnH9IFhngo6r3U3R8xHGlDkl9cjvMwlqMYqXsLTBVuI2hV9jHDE/7TWHoyoe5IDq/Nl7E4SGZjyCz/xt7vB3FqgbhIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from VI1EUR04FT012.eop-eur04.prod.protection.outlook.com
 (2a01:111:e400:7e0e::47) by
 VI1EUR04HT083.eop-eur04.prod.protection.outlook.com (2a01:111:e400:7e0e::216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Fri, 29 Jan
 2021 15:07:02 +0000
Received: from AM4PR05MB3153.eurprd05.prod.outlook.com
 (2a01:111:e400:7e0e::46) by VI1EUR04FT012.mail.protection.outlook.com
 (2a01:111:e400:7e0e::105) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend
 Transport; Fri, 29 Jan 2021 15:07:02 +0000
Received: from AM4PR05MB3153.eurprd05.prod.outlook.com
 ([fe80::d931:e797:b5e4:4cb2]) by AM4PR05MB3153.eurprd05.prod.outlook.com
 ([fe80::d931:e797:b5e4:4cb2%7]) with mapi id 15.20.3763.019; Fri, 29 Jan 2021
 15:07:02 +0000
To: lttng-dev <lttng-dev@lists.lttng.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Thread-Topic: Community input: Feedback on use of enumeration type within
 LTTng-UST
Thread-Index: 5+AEU0e4tawuTd2JT3Ht+0f1na3RkO3j9o3W
Date: Fri, 29 Jan 2021 15:07:02 +0000
Message-ID: <AM4PR05MB31530BB10FFB0D30228D46B0DDB99@AM4PR05MB3153.eurprd05.prod.outlook.com>
References: <1389106165.6573.1611674358449.JavaMail.zimbra@efficios.com>
In-Reply-To: <1389106165.6573.1611674358449.JavaMail.zimbra@efficios.com>
Accept-Language: sv-SE, en-US
Content-Language: sv-SE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:6D1E2E7E159668BFF29746925669A5AEDF5AC482F18241748DE41C20F0ACA82D;
 UpperCasedChecksum:014F129E6428AE23B3EE78DE993CA2C773C145606D4D14CDF301F9805AC37843;
 SizeAsReceived:6937; Count:44
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [IEbM7jX4Udl2TFFOlafMtZykLr0uPl9P]
x-ms-publictraffictype: Email
x-incomingheadercount: 44
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: c4ec9a28-c5ea-4c1b-8ae6-08d8c4678864
x-ms-traffictypediagnostic: VI1EUR04HT083:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GztGQuPyuFS+IDba8R2qqxRK+UhneaLC4vwvs/NEvjLX+1p41Eszy+AjQpTevrQvdaDgkizpTe2Mk0D49shbSVbQ2r3vfHGu+WwPEEtBw/79GqlWpm5RW9izzsd3VZFFu8dcnzprBesraJgo5Gp46+7SwPMCDONr97o3Pa3bex5lnY2g2gTheArYGEz9fXxq6vaz2hHXTR2cym+gzcA5m0C+2tOa3mT6QXnM2HjWBqglj/n/NvEes278s5xbRqVaB6ComgJI3ezxy40zw2NhnPiIV94jA5VJbpZXrZah0RfFDlHuDPT1NZv4nPK121Omsm83cJa658cHpTeEIbbkdmtl4Y6201uRu65p4J91NIBokGcXMSGGA1dVG6KGzsowLF3LOuxWhCQmJVlgqOYNbvkMmBwwlnpC4ApU8cRvRmQ=
x-ms-exchange-antispam-messagedata: dP/eLI5KPX2I6w9I+OCgAp/NGFl4Z4bymcYPzmXiW4+Dr6KV8rE1hAMmGAJVq2f6ZpMY+JMYDZYL+kOV2nrJIhRhNe6Q6CcBSPajOw84K6aof3trhKLE1y5S/Xi15My1sV7mS68Rq1IZuiNmHd9tvw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR04FT012.eop-eur04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ec9a28-c5ea-4c1b-8ae6-08d8c4678864
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2021 15:07:02.1491 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1EUR04HT083
Subject: Re: [lttng-dev] Community input: Feedback on use of enumeration
 type within LTTng-UST
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
From: Jesper Derehag via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Jesper Derehag <jderehag@hotmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi,

I dont have any data regarding enum usage unfortunatly.

But is it possible to share metadata between multiple tp-providers?
If so, would you not be required anyway to re-generate the enumeration labe=
ls given that any trace producer (sharing the same metadata) may have diffe=
rent enumeration definitions?
For example if you would lets say trace different versions of the same app =
but where the enum definition have changed?
Cases like those I guess would force you to atleast version enum labels or =
somesuch?

/Jesper

________________________________________
Fr=E5n: lttng-dev <lttng-dev-bounces@lists.lttng.org> f=F6r Mathieu Desnoye=
rs via lttng-dev <lttng-dev@lists.lttng.org>
Skickat: den 26 januari 2021 16:19
Till: lttng-dev
=C4mne: [lttng-dev] Community input: Feedback on use of enumeration type wi=
thin LTTng-UST

Hi,

We are currently working on the CTF2 specification [1] at EfficiOS, and the=
re is
a user metric we would need to help us with a design decision with respect
to enumerations. This is where we would need community input.

The usage metrics in question are with respect to LTTng-UST enumeration typ=
es
(TRACEPOINT_ENUM) [2] used by tracepoint events within instrumented applica=
tions.

A tracepoint enumeration can be used by many events. What we are looking fo=
r is to get
an idea of the common use, and extreme cases as well.

Ideally, what we would need is:

- For each enumeration within your application instrumentation (TRACEPOINT_=
ENUM), how
  many events refer to each enumeration ? (average, mode, and maximum)
- For each TRACEPOINT_ENUM, how many labels do they possess ? (sum number of
  ctf_enum_value/ctf_enum_range/ctf_enum_auto entries) (average, mode, and =
maximum)
- For each TRACEPOINT_ENUM, for each label, what is the string length ? (av=
erage, mode, and maximum)

Based on this information, we can estimate the data overhead generated by r=
epeating enumeration
labels in the LTTng-UST metadata. We need to decide whether we allow refere=
nces to a single
enumeration description when it is used by many events, or if we require re=
peatedly serializing
the entire enumeration description for each event field using the enumerati=
on.

Thanks,

Mathieu

[1] https://lists.lttng.org/pipermail/lttng-dev/2020-November/029777.html
[2] https://lttng.org/man/3/lttng-ust/v2.12/#doc-tracepoint-enum

--
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
