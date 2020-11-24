Return-Path: <SRS0=lmbG=E6=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF686C2D0E4
	for <lttng-dev@archiver.kernel.org>; Tue, 24 Nov 2020 22:02:03 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C295E206FB
	for <lttng-dev@archiver.kernel.org>; Tue, 24 Nov 2020 22:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="OBLZG8C/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C295E206FB
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4CgdKM5fcVz1NkW;
	Tue, 24 Nov 2020 17:01:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1606255320;
	bh=3hKVXYZkE1JUtziIIxjo/X0yYHYVRerz7MR+/nU1Jto=;
	h=To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=OBLZG8C/pBZyMBmF/ViZEKKl/xKZuJmy+WUQ1zHOKQ4kbxP51NBpj52BVcPNlYJTg
	 a+8cvSmhkwJsbMLqHT+hFKUY26oMo3Rv5hsexypDX2aTKNwhcxp3Yr/sh8QmAEplkQ
	 z8Ax2hWzcBvhNSs0lZ0lW6GO0QF6F6x8Dg2sqyMtv91nuwktekCaVzNpT5sOfn3Dqb
	 Ye7C+S2/nPQx3vLxPxbKqedVndxT5biEIyPxhNdmlc42I3rFK3aZkZ0FkGPBLvllMT
	 1v7FC04leZ3OXjMS+Kf0yjGIk+GFN940G9zvLwSOCDc3PVNKf/8C6sUnxQVVZ9H4iz
	 gMKSSYiLqrbZA==
Received: from mx0a-0014fe01.pphosted.com (mx0b-0014fe01.pphosted.com
 [208.86.201.212])
 by lists.lttng.org (Postfix) with ESMTPS id 4CgdKK4rF7z1N5d
 for <lttng-dev@lists.lttng.org>; Tue, 24 Nov 2020 17:01:57 -0500 (EST)
Received: from pps.filterd (m0000621.ppops.net [127.0.0.1])
 by mx0b-0014fe01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 0AOLvrKO020040; Tue, 24 Nov 2020 15:01:50 -0700
Received: from mail.ballaerospace.com ([162.18.172.11])
 by mx0b-0014fe01.pphosted.com with ESMTP id 35193fr7b8-3
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT);
 Tue, 24 Nov 2020 15:01:50 -0700
Received: from ex2016-co-03.AERO.BALL.COM (10.72.9.80) by
 ex2016-co-02.AERO.BALL.com (10.72.9.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.1.1466.3; Tue, 24 Nov 2020 15:01:23 -0700
Received: from ex2016-co-03.AERO.BALL.COM ([fe80::a55a:f7d9:c791:da55]) by
 ex2016-co-03.AERO.BALL.com ([fe80::a55a:f7d9:c791:da55%12]) with mapi id
 15.01.1466.003; Tue, 24 Nov 2020 15:01:23 -0700
To: 'Michael Jeanson' <mjeanson@efficios.com>, 'Jonathan Rajotte-Julien'
 <jonathan.rajotte-julien@efficios.com>
CC: "'lttng-dev@lists.lttng.org'" <lttng-dev@lists.lttng.org>
Thread-Topic: [lttng-dev] [EXTERNAL] Re: lttng 2.12 install
Thread-Index: AQHWwqqE6VomYVttM0+0qYLwucuFWanX0niw
Date: Tue, 24 Nov 2020 22:01:23 +0000
Message-ID: <d594dcfa82bb405b82c70911025eb133@ball.com>
References: <326539938460471c975e791ce6b1c775@ball.com>
 <20201120184746.GF8709@joraj-alpa>
 <8602eba582ba4806b5bf307cceef521d@ball.com>
 <20201124202138.GA769862@joraj-alpa>
 <aefcb4673adb4b3980bb0612a81f8d87@ball.com>
 <aad4e816-2ff5-5f8b-fe56-108b17fcaf47@efficios.com>
In-Reply-To: <aad4e816-2ff5-5f8b-fe56-108b17fcaf47@efficios.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcandlYmVyMVxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLTk2YjEwNjBhLTJlYTAtMTFlYi04MGQ4LTAwNTA1NmJiMzk0Y1xhbWUtdGVzdFw5NmIxMDYwYy0yZWEwLTExZWItODBkOC0wMDUwNTZiYjM5NGNib2R5LnR4dCIgc3o9IjIzMDYiIHQ9IjEzMjUwNzI4ODgzMzI4MDk4NiIgaD0ib3B0VFpFb2FONk9qbVNFOHV3SW1kbkFLVWZjPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
x-originating-ip: [10.72.63.11]
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-24_09:2020-11-24,
 2020-11-24 signatures=0
Subject: Re: [lttng-dev] [EXTERNAL] Re: lttng 2.12 install
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
From: "Weber, John via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "Weber, John" <jweber1@ball.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

T2ssIHNvIHN0aWxsIHNhbWUgc2l0dWF0aW9uIGhvd2V2ZXIgaXQgYXBwZWFycyB0aGF0IHRoZSBt
YWtlIHByb2dyYW0gaXMgYWJsZSB0byB1c2UgdGhlIGRldnRvb2xzZXQgZ2NjIGJ1dCBJIHN0aWxs
IGdldCB0aGUgZXJyb3IuIE15IHdvcmsgZW52aXJvbm1lbnQgaXMgY2xhc3NpZmllZCBob3dldmVy
LCB0aGlzIHN5c3RlbSBoYXMgYWxyZWFkeSBiZWVuIHVwZGF0ZWQuIElmIEkgdHJ5IHRvIHVwIG9y
IGRvd24gd2l0aCB2ZXJzaW9uaW5nIEkgYW0gc3VyZSB0byBoYXZlIGEgZGVwZW5kZW5jeSBuaWdo
dG1hcmUuIEknbSBub3Qgc3VyZSB3aGF0IHRvIGRvIGF0IHRoaXMgcG9pbnQuIEkgZ3Vlc3MgSSdt
IGtpbmQgb2YgY29uZnVzZWQgb3ZlciB0aGlzIHdob2xlIGlzc3VlIG9mIGluc3RhbGxpbmcgeW91
ciBzb2Z0d2FyZS4gSSdtIHJ1bm5pbmcgY2VudG9zIDcuOCB3aGljaCBpcyByZWNlbnQuIFdoeSBp
c27igJl0IG15IGN1cnJlbnQgdmVyc2lvbiBvZiBnY2MgZ29vZCBlbm91Z2g/IElzIGx0dG5nIDIu
MTIgc28gbmV3IGl0IG9ubHkgd29ya3Mgb24gbGludXggbmV3ZXIgdGhhbiA3Ljg/Pz8gc29ycnkg
anVzdCBub3Qgc3VyZSB3aHkgdGhpcyBwcm9ibGVtIGV2ZW4gZXhpc3RzIGF0IHRoaXMgcG9pbnQu
IERvZXMgMi4xMiBvbmx5IHdvcmsgb24gbGludXggdmVyc2lvbiA4Kz8gV291bGQgYW4gb2xkZXIg
dmVyc2lvbiBvZiBsdHRuZyBiZSBldmVuIHdvcmsgaXQ/IEkgbWVhbiB0aGUgc29mdHdhcmUgdGhh
dCBJIGluc3RhbGwgZm9yIG91ciBlbnZpcm9ubWVudCBpcyBhcyBuZXcgYXMgcG9zc2libGUuIEkg
c3VwcG9ydCBhIHRlYW0gb2YgYWVyb3NwYWNlIHNvZnR3YXJlIGRldmVsb3BlcnMuIE1heWJlIHRo
aXMganVzdCBpc27igJl0IGFuIG9wdGlvbiBhbmQgbWF5YmUgd2Ugc2hvdWxkIGxvb2sgYXQgc29t
ZXRoaW5nIGVsc2UuIEkgYWxzbyBoYXZlIHZlcnNpb24gMi40IGJ1dCB0aGF0IHNlZW1zIHRvIGJl
IHRvIG9sZCBpbiBjb21wYXJpc29uIHRvIHRoZSBvdGhlciBzb2Z0d2FyZSB3ZSB1c2UuIFRob3Vn
aHRzPw0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpKb2huIFdlYmVyDQpCYWxsIEFl
cm9zcGFjZQ0KSVRTIE5EIFN5c3RlbSBBZG1pbmlzdHJhdG9yIA0KMTAgTG9uZ3MgUGVhayBEci4s
IEJyb29tZmllbGQsIENPIDgwMDIxDQpDOiAzMDMtODA3LTM2MDggICBQOiAzMDMtMjM0LTIxMDMN
CkU6IGp3ZWJlcjFAYmFsbC5jb20NCsKgDQrCoA0KDQrCoA0KDQrCoA0KDQotLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KRnJvbTogTWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZpY2lvcy5j
b20+IA0KU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMjQsIDIwMjAgMjo0MSBQTQ0KVG86IFdlYmVy
LCBKb2huIDxqd2ViZXIxQGJhbGwuY29tPjsgJ0pvbmF0aGFuIFJham90dGUtSnVsaWVuJyA8am9u
YXRoYW4ucmFqb3R0ZS1qdWxpZW5AZWZmaWNpb3MuY29tPg0KQ2M6ICdsdHRuZy1kZXZAbGlzdHMu
bHR0bmcub3JnJyA8bHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZz4NClN1YmplY3Q6IFJlOiBbbHR0
bmctZGV2XSBbRVhURVJOQUxdIFJlOiBsdHRuZyAyLjEyIGluc3RhbGwNCg0KT24gMjAyMC0xMS0y
NCAxNiBoIDAyLCBXZWJlciwgSm9obiB2aWEgbHR0bmctZGV2IHdyb3RlOg0KPiBPaywgaXQgSSBn
ZXQgd2hhdCB5b3UncmUgc2F5aW5nIHRoZW4gSSBhbSBtb2RpZnlpbmcgbWFrZSBvbiB0aGUgDQo+
IGNvbW1hbmQgbGluZSB3aGlsZSBydW5uaW5nIG1ha2U/IFN0aWxsIHRoZSBzYW1lIHByb2JsZW0u
IEkgZG9uJ3QgdGhpbmsgDQo+IGl0IGlzIHVzaW5nIHRoZSBnY2MgSSBhbSBzcGVjaWZ5aW5nIGFz
IGl0IGNvbnRpbnVlcyB0byBsb29rIGluOiANCj4gL3Vzci9zcmMva2VybmVscy8zLjEwLjAtMTEy
Ny4xOS4xLmVsNy54ODZfNjQvDQo+IEFuZCBJIHN1c3BlY3QgaXQgaXMgc3RpbGwgc2VlaW5nIHRo
ZSBPUyB2ZXJzaW9uIG9mIGdjYyAoNC44LjUpIGluc3RlYWQgb2YgdGhlIDYuMy4xIHByb3ZpZGVk
IGJ5IGRldnRvb2xzZXQtNi4NCj4gRG8geW91IGhhdmUgc29tZSBwaXh5IGR1c3Q/Pw0KDQpSdW5u
aW5nIHRoaXMgd2lsbCBnZXQgeW91IHZlcmJvc2Ugb3V0cHV0IHdoaWxlIGJ1aWxkaW5nIHdoaWNo
IHNob3VsZCBoZWxwIHlvdSBkZXRlcm1pbmUgd2hpY2ggY29tcGlsZXIgYW5kIG90aGVyIHRvb2xz
IGFyZSB1c2VkIDoNCg0KICAgbWFrZSBDQz0iL29wdC9yaC9kZXZ0b29sc2V0LTYvcm9vdC9iaW4v
Z2NjIiBWPTENCg0KClRoaXMgbWVzc2FnZSBhbmQgYW55IGVuY2xvc3VyZXMgYXJlIGludGVuZGVk
IG9ubHkgZm9yIHRoZSBhZGRyZXNzZWUuICBQbGVhc2UgCm5vdGlmeSB0aGUgc2VuZGVyIGJ5IGVt
YWlsIGlmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQuICBJZiB5b3UgYXJlIApu
b3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgeW91IG1heSBub3QgdXNlLCBjb3B5LCBkaXNjbG9z
ZSwgb3IgZGlzdHJpYnV0ZSB0aGlzIAptZXNzYWdlIG9yIGl0cyBjb250ZW50cyBvciBlbmNsb3N1
cmVzIHRvIGFueSBvdGhlciBwZXJzb24gYW5kIGFueSBzdWNoIGFjdGlvbnMgCm1heSBiZSB1bmxh
d2Z1bC4gIEJhbGwgcmVzZXJ2ZXMgdGhlIHJpZ2h0IHRvIG1vbml0b3IgYW5kIHJldmlldyBhbGwg
bWVzc2FnZXMgCmFuZCBlbmNsb3N1cmVzIHNlbnQgdG8gb3IgZnJvbSB0aGlzIGVtYWlsIGFkZHJl
c3MuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5n
LWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3Rz
Lmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
