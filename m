Return-Path: <SRS0=JNAJ=DU=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC2AC433DF
	for <lttng-dev@archiver.kernel.org>; Tue, 13 Oct 2020 06:48:27 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E1DB20714
	for <lttng-dev@archiver.kernel.org>; Tue, 13 Oct 2020 06:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="Ll4R8W3A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E1DB20714
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4C9R2c3h11z10rP;
	Tue, 13 Oct 2020 02:48:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1602571705;
	bh=xMxQGQe/YOQtx8aoylCpDAm3Ot8bL3vuNfMmT56gjxI=;
	h=To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Ll4R8W3ATcLDjbG5BOtzn5pVQvEO9gxD6oknGrBj1gCrodEWuMeAbHA/RgHkAZGVH
	 2D0hKbAe5cVgxvvH+omdwZSS1KhSgmsA/c63BmseDFRyCw+9gBuGrl+tONhGFy7R2K
	 TcGSvQYy38r2fm8xnIr8wyHI0etxqx9CQ33EiiVSIzTxokN34JX4bG/kZ4LXOGKzR4
	 FOd29qyAY2o/R0LXSC7n+aBRru+31/Ddn9VG7QP9z2EMR38aeybWeCmu8IYjGRfYmU
	 a5jTsoN7BDph+NnOes36I8QBCTcqzPSVDNa/pKaMMPftDhtoZcQ1yESibZH5wDMQZN
	 kuYrVpfV7odqg==
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com
 [68.232.156.101])
 by lists.lttng.org (Postfix) with ESMTPS id 4C9R2Z2d3Wz10gR
 for <lttng-dev@lists.lttng.org>; Tue, 13 Oct 2020 02:48:22 -0400 (EDT)
IronPort-SDR: GMgEp8IuVTvW7qEmjqQ8RZZhhVPY1OI5aDPi42WlUTobDSE30MquKTgiEC1Y28sR+oBBrpM9W1
 v47+LBm9Iy2taaJpeVefOZsksFuZb0ELGznOndv4V2qzL8ojyqKgy3a/K9PpEbgAgp9Y+UvtES
 gyJ0IYmk7kMJWxxi5ZNzEuDi+KqoMR5p/l3ejF+TCkgySCIOJuROTzToZQpTnd+N7gXom/WWpl
 GteyZmIq7pPmSCGHDweHaJ0R+CtQEYbqt0dU9JU6zwV4WffDjglACyyzEERD8mHi+9zdGyjqC5
 Kuk=
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="19474759"
X-IronPort-AV: E=Sophos;i="5.77,369,1596466800"; d="scan'208";a="19474759"
Received: from mail-he1eur04lp2052.outbound.protection.outlook.com (HELO
 EUR04-HE1-obe.outbound.protection.outlook.com) ([104.47.13.52])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2020 15:47:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arniSeiIKDq/eYhWNly7CpHCnP1h3J806fKj+T/IJNYeL2g6on0Wg68fHbAqYIkKMd8UPpLy7M0V45RUVDWdfR5y0WmMVVGQ8sRr8ledWSD64xzoJf/ihGg5A5KX40x3liWKHQ7fOm8F8etIbOOS9PzIhFafV8VPEfKEkqUB9Y1WgOhCbDim09kHFKrksRsk4Yn/gSC5QdixkwpiqwUf6WyuDkgL7WnpwKKO0cWNe6C/yPSwKpeMQcZvhOGOj/YaVq4BkTUlPfyRvop+x8X6mBkoTsL1rWhkVYKknJsAIkeUTxp7RVPf77XELjeRmLxe3Afq09zIVxAIvUxqi9AOCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boOX09ByFimYlYGqC0+qcD37gXItv3wgLkG9dHg0VW8=;
 b=WVgsyCiKg6+WJkUKmpuHuRcXGZMojUyhMAYbXfMeQB8XgQWmeKPBwjFJVt9pacTXCrIkerDDm8PUKZS5y3/mNAECqGLz7v+x8Be5LQnjib+3gEtA2r0hi8+0v/G/LxQ8IJUfCE/fvk4bSG3ZOUNby2vMjkaJCOQAzY0jclP7JHKig7hHIDUVsqwt8AgBeU6AR01+KPnWxWnWt3RKm8bFhcmfTdZISuzggMXWz+Pt3rCSSCcHP+TkkblmzSd1vHTcrsVe2v8LofUS8R8yfxg6Yr8oqmwn2SggNjFW9YCW/HAsndRJ8hyDdQHxE8f1THhQJFpRBTpPGdKDY2IcuPk23Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from DB8P191MB1016.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:163::14)
 by DB8P191MB1128.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:14a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 13 Oct
 2020 06:47:08 +0000
Received: from DB8P191MB1016.EURP191.PROD.OUTLOOK.COM
 ([fe80::384d:2fb7:c1d0:bd47]) by DB8P191MB1016.EURP191.PROD.OUTLOOK.COM
 ([fe80::384d:2fb7:c1d0:bd47%5]) with mapi id 15.20.3455.030; Tue, 13 Oct 2020
 06:47:08 +0000
To: "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>
CC: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: [lttng-dev] Deleted files held open by LTTng
Thread-Index: AdagdWz1nQMxavrbS9eYaI0jR/YKaBWGyxUKFVpJy6A=
Date: Tue, 13 Oct 2020 06:47:08 +0000
Message-ID: <DB8P191MB10162024A94A720E02C3EC399D040@DB8P191MB1016.EURP191.PROD.OUTLOOK.COM>
References: <DB8P191MB1016B09FD65AF6B091A78C729D070@DB8P191MB1016.EURP191.PROD.OUTLOOK.COM>
 <67256246.16573.1602508668109.JavaMail.zimbra@efficios.com>
In-Reply-To: <67256246.16573.1602508668109.JavaMail.zimbra@efficios.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.8.157.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23ae7582-cbe5-441f-7bd4-08d86f43ce61
x-ms-traffictypediagnostic: DB8P191MB1128:
x-microsoft-antispam-prvs: <DB8P191MB1128F87FF898930C1DDF82039D040@DB8P191MB1128.EURP191.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m+2Z2C5ZbSCNW8YGtNwRwPl1AOoHmoctFf5rUdHqOuaWoiB9lW8KLHE6PQXkH/DiRiCqQLUp+nkH2rXOIskxhr0bH9BWVh+AX7pwTYvyBefWQEs9YLpwOAmoq4bL+oOIi4hI6rvywsKDsBf4/3uwX4pN+5ZMCjtG6Y6WwiaWGqBEmvXeVcoq7bMLZba8tWU0fWIi87KZiB2WF3NX13TFTe3vjgLucr1Z+T2rcqp7t0k9lTa2gbsb/AR1frj/cZ8eAlqUCikL85J7VBhYY7T39JYianVCZV823k6iFmgdxJRkWU13sOqjBQ+Om4Ff+LEHCi41UVmp00+o+gkVF/a68xnCExLA3B2AobWdKguWt/CbhuiVTX8ai9b4webkE+eE+U5eHRQk/P5FzpuYPuqWh4xe0iHDwBt/fAzi2zBNQ+F84TdWhrwzWOSMndVu8iyf+HR+gKqKMsrdbq84XA66IwM9COoO8e28YeKAae1zDUo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8P191MB1016.EURP191.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39850400004)(346002)(136003)(376002)(966005)(478600001)(71200400001)(8676002)(8936002)(85182001)(52536014)(83380400001)(66574015)(9686003)(4326008)(76116006)(83080400001)(66946007)(66476007)(2906002)(66446008)(64756008)(66556008)(55016002)(6506007)(6916009)(5660300002)(33656002)(7696005)(316002)(186003)(26005)(85202003)(86362001)(777600001)(18886065003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 0mO0M0E7pie/x72pAYn6JpRs+qXS9mL2c6IVkCGSm7fRDv2ihiK5G9kEH2Rn6J9pVxSlcYOyAufRZ9oNdyl0rxTQtdVSlntZucBm0vKrdUH8kzAfoa7u8eQq2PLdNJdLrsd4uynjeM/s5oASkf0OTFJu/3hzbKnTDUojF+Na4PoLbrAPrACLN1vXw9E6Fz5drwkTl1DgMsxgh0F5Z5tdk9gkYgsCUdic8On7Yniuw80Pfjv3gExLoGHfR7ryoTjhETpT1B4P4Q2HV2fmFNjK/EjFAtuQ9nQ46ylJW/YBkq1Vg8X2Qk7rZFY2rFeII82moweZdXqmermVgk8evWaJHt5HlN73QwDmhuo9sMEjsG7JK4T6U/mlvi353P8aVcwaO4Yx9VGi5iV+MmRiqnK3haQHEAKdnAO4gZ5quHFeRR7biYTk6KxWS4nSzzWHT3+VgyBM3z9kY0ZF2T+ngE8QhwGYBjpHfnP8LIGCp6RcWsBcdvNdXockUb6sP/UQYgR7d1IFqgSX7NV8Ju6GbpOfKkXVrtOUcOtjO4MRwNpIu2UqgS2NImchFhAMf7d+L0GZQChyMCBNonPNvDWtmf4/zecVKa23UtRI2f7C6Rf5gA6d3FZHs5HNeb2LsgyTbiBnHWTIcTOAuGLzUszaaRS6OQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8P191MB1016.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ae7582-cbe5-441f-7bd4-08d86f43ce61
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2020 06:47:08.7100 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3LJEctDhrpK6Nfks3sm5d7iBxsk6v2pPxW9Jxe1LzJg3ztuujbm3k9nbnDk72Z2vMnx5PhryyLmBi4AM5mM0arC1B/zQWcmoNUKYW71xeMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P191MB1128
Subject: Re: [lttng-dev] Deleted files held open by LTTng
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

Pj4gSGkgYWxsLA0KPj4gDQo+PiBJIGhhdmUgcmVjZW50bHkgc3RhcnRlZCB1c2luZyBMVFRuZyBh
bmQgc3R1bWJsZWQgdXBvbiB0aGUgZmFjdCwgdGhhdA0KPj4gTFRUbmcgaXMga2VlcGluZyBhIGxv
dCBvZiBvcGVuIGZpbGUgcG9pbnRlcnMgdG8gYSBzaW5nbGUgZGVsZXRlZCBmaWxlLg0KPj4gDQo+
PiBTcGVjaWZpY2FsbHkgdGhlIHByb2Nlc3MgdGhhdCBob2xkcyB0aGVzZSBvcGVuIGlzIHRoZSBs
dHRuZy1jb25zdW1lcmQgYW5kIGl0cw0KPj4gdGhyZWFkcy4gVGhlIGZpbGUgdGhhdCBpcyBoZWxk
IG9wZW4sIGJ1dCBpcyBkZWxldGVkIGlzDQo+PiAvZGV2L3NobS91c3Qtc2htLWNvbnN1bWVyLSR7
UElEfSB3aXRoIHRoZSBQSUQgb2YgdGhlIGx0dG5nLWNvbXN1bWVyZC4gVGhlDQo+PiBudW1iZXIg
b2Ygb3BlbiBmaWxlIGRlc2NyaXB0b3JzIGlzIGRlcGVuZGVudCBvbiB0aGUgbnVtYmVyIG9mIENQ
VXMgdGhlDQo+PiBzeXN0ZW0gaGFzIGFuZCByZXN1bHRzIHRvIDE2ICsgKCNDUFVzICogMTYpLiBJ
cyB0aGlzIGJlaGF2aW9yIGV4cGVjdGVkPw0KPj4gDQo+PiAjIGxzb2YgfCBncmVwIGx0dG5nIHwg
Z3JlcCBERUwNCj4+IGx0dG5nLWNvbiAgMjI4MCAgICAgICAgICAgICByb290ICBERUwgICAgICAg
UkVHICAgICAgICAgICAgICAgMCwxOA0KPj4gMTExMjgNCj4+ICAgICAgICAvZGV2L3NobS91c3Qt
c2htLWNvbnN1bWVyLTIyODANCj4+IGx0dG5nLWNvbiAgMjI4MCAgICAgICAgICAgICByb290ICBE
RUwgICAgICAgUkVHICAgICAgICAgICAgICAgMCwxOA0KPj4gMTExMjcNCj4+ICAgICAgICAvZGV2
L3NobS91c3Qtc2htLWNvbnN1bWVyLTIyODANCj4+IGx0dG5nLWNvbiAgMjI4MCAgICAgICAgICAg
ICByb290ICBERUwgICAgICAgUkVHICAgICAgICAgICAgICAgMCwxOA0KPj4gMTExMjYNCj4+ICAg
ICAgICAvZGV2L3NobS91c3Qtc2htLWNvbnN1bWVyLTIyODANCj4+IFsuLi5dDQo+PiANCj4+IEkg
aGF2ZSB0ZXN0ZWQgdGhpcyBvbiBhIFhlbi1Eb20wIHN5c3RlbSBydW5uaW5nIFNMRVMgMTIgU1A1
IGFuZCBvbiBhDQo+PiBTTEVTMTIgU1A1IHdpdGhvdXQgWGVuLg0KPiANCj4gWWVzLCBpdCB3b3Jr
cyBleGFjdGx5IGFzIGRlc2lnbmVkLiBUaGUgaW5vZGVzIHRvIGVhY2ggb2YgdGhvc2UgZmlsZXMg
c3RheQ0KPiBhbGxvY2F0ZWQgYXMgYWxvbmcgYXMgdGhlcmUgaXMgYXQgbGVhc3Qgb25lIGZpbGUg
ZGVzY3JpcHRvciByZWZlcmVuY2luZyB0aGVtLg0KPiBXZSB1c2UgdGhpcyBzY2hlbWUgdG8gZmFj
aWxpdGF0ZSBjbGVhbmluZyB1cCB3aGVuIHRoZSBjb25zdW1lciBkYWVtb24gaXMNCj4ga2lsbGVk
IChpbmNsdWRpbmcgd2l0aCBTSUdLSUxMKSBzbyBpdCBkb2VzIG5vdCBsZWF2ZSBzdGFsZSBmaWxl
cyBoYW5naW5nDQo+IGFyb3VuZC4NCj4gDQo+IA0KPiBOb3RlIHRoYXQgb24gTGludXgsIGFuZCBz
dGFydGluZyBmcm9tIExpbnV4IGtlcm5lbCAzLjE3LCB3ZSBjb3VsZCBpbnN0ZWFkDQo+IHVzZSB0
aGUgbWVtZmRfY3JlYXRlIHN5c3RlbSBjYWxsIHRvIGNyZWF0ZSB0aG9zZSBzaGFyZWQgbWFwcGlu
Z3MsIHdoaWNoIEFGQUlVDQo+IHdvdWxkIHJlbW92ZSB0aGUgbmVlZCBmb3IgdW5saW5raW5nIHRo
ZSBzaG0gZmlsZXMgYWZ0ZXIgdGhlaXIgY3JlYXRpb24uDQo+IEhvd2V2ZXIsIGNvbnNpZGVyaW5n
IHRoYXQgTFRUbmctdG9vbHMgYW5kIExUVG5nLVVTVCBhbHNvIHdvcmtzIG9uIG9sZGVyIExpbnV4
DQo+IGtlcm5lbHMsIGFuZCBvbiBCU0RzLCB1c2luZyB0aGUgUE9TSVggc2htIHN0aWxsIGFwcGVh
cnMgdG8gYmUgYXBwcm9wcmlhdGUuID4NCj4NCj4gT24gdGhlIHJlYXNvbiBmb3IgaGF2aW5nIG9u
ZSBzaG0gZmlsZSBwZXIgY3B1IChwZXIgY2hhbm5lbC9wZXIgdWlkL3BlciBzZXNzaW9uKToNCj4g
aGF2aW5nIG9uZSBmaWxlIHBlciBjcHUgaXMgbWFpbmx5IGRvbmUgdG8gZmFjaWxpdGF0ZSBOVU1B
LWxvY2FsIG1lbW9yeSBhbGxvY2F0aW9uLg0KPiBUaGF0IGJlaW5nIHNhaWQsIEkgd29uZGVyIGlm
IGFzIGEgZnV0dXJlIGltcHJvdmVtZW50IHdlIGNvdWxkIGNvbWJpbmUgYWxsIHBlci1jcHUNCj4g
YnVmZmVycyBpbnRvIGEgc2luZ2xlIHNobSBmaWxlLCBhbmQgaXNzdWUgbnVtYV9zZXRfcHJlZmVy
cmVkIHBpZWNld2lzZSB3aGVuDQo+IG1tYXBwaW5nIHJlZ2lvbnMgb2YgdGhlIGZpbGVzLiBUaGlz
IHdvdWxkIGxlc3NlbiB0aGUgbnVtYmVyIG9mIGZpbGUgZGVzY3JpcHRvcnMNCj4gbmVlZGVkIGJ5
IGEgc2lnbmlmaWNhbnQgYW1vdW50LiBJIHN1c3BlY3QgaXQgd291bGQgd29yaywgYnV0IHdlJ2Qg
bmVlZCB0byBkbyBzb21lDQo+IHByb3RvdHlwaW5nIHRvIHZhbGlkYXRlIHRoaXMgYXBwcm9hY2gg
Zmlyc3QuDQo+DQo+IFRoYW5rcywNCj4NCj4gTWF0aGlldQ0KPg0KDQpUaGFuayB5b3UgZm9yIHlv
dXIgZXhwbGFuYXRpb24uIFRoaXMgaGVscHMgYSBsb3QgaW4gdW5kZXJzdGFuZGluZy4NCg0KQmVz
dCB3aXNoZXMsDQpOaWxzIETDtnJpbmcNCg0KPj4gDQo+PiBCZXN0IHJlZ2FyZHMsDQo+PiBOaWxz
IETDtnJpbmcNCj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fDQo+PiBsdHRuZy1kZXYgbWFpbGluZyBsaXN0DQo+PiBsdHRuZy1kZXZAbGlzdHMubHR0bmcu
b3JnDQo+PiBodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8v
bHR0bmctZGV2DQo+DQo+IC0tIA0KPiBNYXRoaWV1IERlc25veWVycw0KPiBFZmZpY2lPUyBJbmMu
DQo+IGh0dHA6Ly93d3cuZWZmaWNpb3MuY29tDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0
cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3Rp
bmZvL2x0dG5nLWRldgo=
