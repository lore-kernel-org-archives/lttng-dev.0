Return-Path: <SRS0=79Yp=DT=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33CBC433DF
	for <lttng-dev@archiver.kernel.org>; Mon, 12 Oct 2020 09:05:28 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D17F620773
	for <lttng-dev@archiver.kernel.org>; Mon, 12 Oct 2020 09:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="SU49TV8s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17F620773
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4C8t794R2Xz108W;
	Mon, 12 Oct 2020 05:05:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1602493526;
	bh=Vuo/dkC+MWdRBy8MU5WyjiOqYrrxX+vJOmfJzXqXYso=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=SU49TV8sGtCCjVEWXoh/UqoXfVTOk6btkT3U4vtikw2Dc/gfz+04LFwsD+UGObT34
	 XyxqyrxwdETqUdRELmcZF+h7TtR8Ih0+VWIFVVldoZl+oeSKWx5dF+W4tXp2at1m4G
	 q7dhcJJPO9tRpPQY7xTq1euvz1gBykdahgUWj6N/rCOn2vRBYVVyVwnd7wNS77rq/q
	 hU2curDb2l6t1jQAuCwWTArOl/nAXYGYovf9TDrsKe3+OAfa2s/x/IutmOasgbq61m
	 MOCrisJTRa3FOeobhWMywA2lcvBdLCpOQP/uaTi7TBNg3dptEXEbvkxaF3pmcFd4s6
	 MM2sIz9boYDEg==
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com
 [68.232.159.90])
 by lists.lttng.org (Postfix) with ESMTPS id 4C8t773jBxz1015
 for <lttng-dev@lists.lttng.org>; Mon, 12 Oct 2020 05:05:23 -0400 (EDT)
IronPort-SDR: q/oaZ81vAhMAQ4QUNk/6Mm7CS22yHcfixYwhnevwOfVCK72dqT1fgKsj8gS2ZbNfCOS5kV7tDs
 5TJXrCFqAP5enAZ1G6SR6yyNvkIAmEGiCTej2thRtTIybAqZemw3D5A03tzzgh+4jEnAXHu9U4
 IaQO7UqsGvZZAB4qKuTeamJI64c0sBaeX9X/rGFETwNW5RuVYg4Lbl7XXym8Ub7G0AGEUbVF1X
 okLZMXDD+FP2NZtNh/dzqaKHfGgrC37+X/s6i4ku/BCIg1/p1jmmr5QZbt+JQNPnuOXjxsd1cH
 yGE=
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="19496221"
X-IronPort-AV: E=Sophos;i="5.77,366,1596466800"; d="scan'208";a="19496221"
Received: from mail-db8eur05lp2106.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.106])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2020 18:04:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDo/cvW1khEgBOBCU4f9Sn+FnKhIbHT1kiEVP4jWZSHeNT7b9q/yq0seihfmWB/j6r2K2a9PfO9oBuSqc0Qa0UN481mEeiZFpdJLIJ17Pxdd/Lx85JYn5bK6BCCoLp8TFtL9OjF5h0BDw1BdDJwEL/XD9t52JTyh+6hAz8oUn+n8Xm0tNt2blca8MojZyoSkckL31vQO7jpkD1wH/lsFz4UKyaor6RpvMCrvuPwwvDEWvaGa/JFFov1U+o0Ap+Sp4uhYrNaCuPPCqmXn1s2gfa3gRVKtRIxPtc2LNwIz7vsVInV9588MY4fpdSe+H9jHaeBuqbv9O2fgQpJKg0SPtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDKsh2yAqyBJTHL8Zjym3epHcbhhbFHfELK4xrWzR/Y=;
 b=k8ygrzeKXlNoTX2xreWJLG2zQhIDnl04z4qtYJqVpnW3hgGRkHXhJBD7Xz/vQ1qYkxJgg3WTVl28FqQl30bDR4WugD/Pzt4KwvrkVau+TXZMjFUyn/kkQUNmTpDb59feD7C+bm1DLT59zFT+Y61Ci5FQj/ImVtu5DC53HAYfDgxfh5ciAV7vI03f2oM1G4YG0reTChyjii8jBZQ/GpuJEuIdu4MOJs5o2RTAwrRgCrYLmXvxcgvng/4JE7NezxQCt9tVYehogqOk3abBIxiWB0edUSuk78nXny5b8bvsT11s1nBgLz/3g6dqZE2xPlxHDIGscmCArFrY19A59Tju1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from DB8P191MB1016.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:163::14)
 by DB8P191MB0823.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:169::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Mon, 12 Oct
 2020 09:04:04 +0000
Received: from DB8P191MB1016.EURP191.PROD.OUTLOOK.COM
 ([fe80::384d:2fb7:c1d0:bd47]) by DB8P191MB1016.EURP191.PROD.OUTLOOK.COM
 ([fe80::384d:2fb7:c1d0:bd47%5]) with mapi id 15.20.3455.030; Mon, 12 Oct 2020
 09:04:04 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: Deleted files held open by LTTng
Thread-Index: AdagdWz1nQMxavrbS9eYaI0jR/YKaA==
Date: Mon, 12 Oct 2020 09:04:04 +0000
Message-ID: <DB8P191MB1016B09FD65AF6B091A78C729D070@DB8P191MB1016.EURP191.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.8.157.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2955fe4-097a-43c9-fe64-08d86e8dc4b2
x-ms-traffictypediagnostic: DB8P191MB0823:
x-microsoft-antispam-prvs: <DB8P191MB08230DA4E75D282BBC0A3CBC9D070@DB8P191MB0823.EURP191.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kF8+xdM92d91q3+r3v2D79Ca3sgf9xS5Eb59cCPMmYQyacZj0br8sUhxZ4jMjbTcLja9u52wn65cZ+YIrGBnN32T3QLQk62GRK/vTmVzLOHuVtYGZnWFzx+wrdNh7T+L8idRIsMw5i255qQWZPS6Ya88w8cOayIpPjmUc4TQcf8+G/Hs/H02XPJu9K2e3kfJ2+u7FHnvoe7EMtMqpvQPZcmeEYUxYOA+Uwo8Xkks1wOM08ZgD6cNxRWBUW3xMOuJ2V7F2f2uKcZ7EEprs7G+PUVubYS4gwehWN4ZtivD91H54YT9MuSYVLLksuRUHhYuR46uvQ4cBMdbmqsg/gl0seXhz6C27360aDtMntD4jQDCirk7GljMVL6GI/VDfpiL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8P191MB1016.EURP191.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(39860400002)(136003)(366004)(55016002)(316002)(33656002)(4744005)(8676002)(478600001)(85202003)(186003)(76116006)(2906002)(26005)(52536014)(85182001)(86362001)(83380400001)(5660300002)(8936002)(71200400001)(6506007)(64756008)(66556008)(66476007)(9686003)(66946007)(6916009)(66446008)(7696005)(777600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: wpnR9WK7oK11Vnb/IJTYSclfAqsNCs3LbqQIOs3SQzk0TzrSIAHI45jJUUnTWUeqFwrs5hrIpJBFRCyReBkTsTv3v0GH3uFRDbNHFwfTWx+3eoZtSqRkol1p8+CElnvpP+kUIl0WrMVzHk0wZwDM8QJQ5gWolPl8rZAJC7a5g/te4olU/1POlbty3ATV+sydJmwAT3ouk3hpK0AT9nVtv8bSEpc48ActlrCjo8h9vmjCRiv/05sju0Zs2aok9axP02vlYQZwkmARq6ZOi55SSVqgbO5mY+aU/gQthZg6dtius4EhNe5pL3BbcnZrHKL/AwGrn6k/QCbWowAJ5ea8K3CT87x17tMwhhLwWeYGSp8HsKUY1hMsjalfpCYcx+rgKh/UznPPwzSbSFLQZM41EdLg1EcMcSdc8Tyw2MemGbGMtafYsU3XJkwqhqVm5I1cSw5myenIrTxccW1C42Zd5hGmjCjt/SU+kna8dXl5eUALQp8jBddmucuE+Pwp+uXvZLih7VU1miphkzRhgN5te1YPuLoUoqyK44Fdx6fC/T9MbT8hKa79fM4SbIfKEfXGqSVWyjg/2r18hUd5kDBSi0qndWqRl8fJWHRaFk2W69b8nk03cnBT0PEO3j4Y5C4PmYGHdQBhKg1YyLNhzkI6bw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8P191MB1016.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d2955fe4-097a-43c9-fe64-08d86e8dc4b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2020 09:04:04.1348 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OttnrtOZIFnoypQKHNj2FxcQsCJMSkZJh51kz2WbTXyeMjfILshwKYxD29SGpu3TJY8MqbwUlYBerYWanXEzjJcLRYW30SZyqRIbYDOFlTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P191MB0823
Subject: [lttng-dev] Deleted files held open by LTTng
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
From: "nils.doering--- via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "nils.doering@fujitsu.com" <nils.doering@fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

SGkgYWxsLA0KDQpJIGhhdmUgcmVjZW50bHkgc3RhcnRlZCB1c2luZyBMVFRuZyBhbmQgc3R1bWJs
ZWQgdXBvbiB0aGUgZmFjdCwgdGhhdA0KTFRUbmcgaXMga2VlcGluZyBhIGxvdCBvZiBvcGVuIGZp
bGUgcG9pbnRlcnMgdG8gYSBzaW5nbGUgZGVsZXRlZCBmaWxlLg0KDQpTcGVjaWZpY2FsbHkgdGhl
IHByb2Nlc3MgdGhhdCBob2xkcyB0aGVzZSBvcGVuIGlzIHRoZSBsdHRuZy1jb25zdW1lcmQgYW5k
IGl0cw0KdGhyZWFkcy4gVGhlIGZpbGUgdGhhdCBpcyBoZWxkIG9wZW4sIGJ1dCBpcyBkZWxldGVk
IGlzDQovZGV2L3NobS91c3Qtc2htLWNvbnN1bWVyLSR7UElEfSB3aXRoIHRoZSBQSUQgb2YgdGhl
IGx0dG5nLWNvbXN1bWVyZC4gVGhlDQpudW1iZXIgb2Ygb3BlbiBmaWxlIGRlc2NyaXB0b3JzIGlz
IGRlcGVuZGVudCBvbiB0aGUgbnVtYmVyIG9mIENQVXMgdGhlDQpzeXN0ZW0gaGFzIGFuZCByZXN1
bHRzIHRvIDE2ICsgKCNDUFVzICogMTYpLiBJcyB0aGlzIGJlaGF2aW9yIGV4cGVjdGVkPw0KDQoj
IGxzb2YgfCBncmVwIGx0dG5nIHwgZ3JlcCBERUwNCmx0dG5nLWNvbiAgMjI4MCAgICAgICAgICAg
ICByb290ICBERUwgICAgICAgUkVHICAgICAgICAgICAgICAgMCwxOCAgICAgICAgICAgICAgIDEx
MTI4DQogICAgICAgIC9kZXYvc2htL3VzdC1zaG0tY29uc3VtZXItMjI4MA0KbHR0bmctY29uICAy
MjgwICAgICAgICAgICAgIHJvb3QgIERFTCAgICAgICBSRUcgICAgICAgICAgICAgICAwLDE4ICAg
ICAgICAgICAgICAgMTExMjcNCiAgICAgICAgL2Rldi9zaG0vdXN0LXNobS1jb25zdW1lci0yMjgw
DQpsdHRuZy1jb24gIDIyODAgICAgICAgICAgICAgcm9vdCAgREVMICAgICAgIFJFRyAgICAgICAg
ICAgICAgIDAsMTggICAgICAgICAgICAgICAxMTEyNg0KICAgICAgICAvZGV2L3NobS91c3Qtc2ht
LWNvbnN1bWVyLTIyODANClsuLi5dDQoNCkkgaGF2ZSB0ZXN0ZWQgdGhpcyBvbiBhIFhlbi1Eb20w
IHN5c3RlbSBydW5uaW5nIFNMRVMgMTIgU1A1IGFuZCBvbiBhDQpTTEVTMTIgU1A1IHdpdGhvdXQg
WGVuLg0KDQpCZXN0IHJlZ2FyZHMsDQpOaWxzIETDtnJpbmcNCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmct
ZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxt
YW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
