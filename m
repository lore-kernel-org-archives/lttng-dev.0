Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D093C4345F
	for <lttng-dev@archiver.kernel.org>; Thu, 25 Apr 2024 03:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1714015707;
	bh=tIarDfbj2hFv5IoZHN4ZpcZ6M11L7IhzA8ExHCwLwNE=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=LVxmIrofVfkcDi1DBxq/I7nE6iCtzNv0Zq8an1X3T014pw0vb8fmYQUrt8hcQ0Wha
	 FjsttNo93Dpq4ulWl5csvqrwj5IA8KxPsvVM1VI7v/Q3VVAMLZytCIRGnYYOVT/gPt
	 a2U0FIcRAoaUQUguUe1RdfZ/rwSXPSgTEEqUO8JdNpnaX2GHj0FvSkFfFMZhM27EgC
	 W8PhEdO6H6dUbAYKwT8dlbWZ3fF7Yszp1KToHYPXvXGFTUn0YaewedxZ0WDt861pp/
	 zGMzbHsxz2T534E33fqu3+kawIJKylaxBLvGUsNOmRdbXC0pGliMH3Sj4NAcapA+42
	 XtkSZxeyyiNng==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4VQ1XW00plz2jj2;
	Wed, 24 Apr 2024 23:28:26 -0400 (EDT)
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
 by lists.lttng.org (Postfix) with ESMTPS id 4VQ1XV0prQz2jcg
 for <lttng-dev@lists.lttng.org>; Wed, 24 Apr 2024 23:28:26 -0400 (EDT)
X-IronPort-AV: E=Sophos;i="6.07,228,1708387200"; 
 d="scan'208,217";a="392322404"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
 by smtp-border-fw-6001.iad6.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 03:28:24 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:46373]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.234:2525]
 with esmtp (Farcaster)
 id 09fffb74-9955-402a-9f89-d58056f9fc6a; Thu, 25 Apr 2024 03:28:23 +0000 (UTC)
X-Farcaster-Flow-ID: 09fffb74-9955-402a-9f89-d58056f9fc6a
Received: from EX19D003ANC004.ant.amazon.com (10.37.240.207) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 25 Apr 2024 03:28:23 +0000
Received: from EX19D003ANC001.ant.amazon.com (10.37.240.216) by
 EX19D003ANC004.ant.amazon.com (10.37.240.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Thu, 25 Apr 2024 03:28:22 +0000
Received: from EX19D003ANC001.ant.amazon.com ([fe80::ed4e:7258:fa8c:17e8]) by
 EX19D003ANC001.ant.amazon.com ([fe80::ed4e:7258:fa8c:17e8%5]) with
 mapi id 15.02.1258.028; Thu, 25 Apr 2024 03:28:22 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: [babeltrace2]about python self-defined plugin loading
Thread-Index: AQHalsCI/TKHXb5QNEKHKCHW1+CDTg==
Date: Thu, 25 Apr 2024 03:28:21 +0000
Message-ID: <03304ae9731e474db911b8ef6703cf69@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.106.101.48]
MIME-Version: 1.0
Subject: [lttng-dev] [babeltrace2]about python self-defined plugin loading
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: "Wu, Yannan via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "Wu, Yannan" <yannanwu@amazon.com>
Content-Type: multipart/mixed; boundary="===============8576296018487312060=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============8576296018487312060==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_03304ae9731e474db911b8ef6703cf69amazoncom_"

--_000_03304ae9731e474db911b8ef6703cf69amazoncom_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksIFRoZXJlLA0KDQpJIGFtIHRyeWluZyB0byBjb25zdHJ1Y3QgYSBjdXN0b21pemVkIGZpbHRl
ciBhbmQgc2luayBiYXNlZCBvbiBiYWJlbHRyYWNlMiBweXRob24gYmluZGluZy4gSG93ZXZlciwg
bmV0aGVyIG1pbmUgcGx1Z2luIG5vciB0aGUgcGx1Z2lucyBzYW1wbGUgSSBjb3VsZCBmaW5kIG9u
IHRoZSBpbnRlcm5ldCBhbGwgZG9udCB3b3JrLg0KDQpGb3IgZXhhbXBsZSwgaHR0cHM6Ly9naXRo
dWIuY29tL3NpbWFyay9iYWJlbHRyYWNlLWZ1bi1wbHVnaW5zL3RyZWUvbWFzdGVyL215LWZpcnN0
LWNvbXBvbmVudHMNCg0KSSBqdXN0IGRvd25sb2FkZWQgdGhlIHB5IGZpbGUgYW5kIHJ1biB0aGUg
ZXhhY3QgY29tbWFuZCwgaXQgZmFpbGVkLiBUaGUgbG9nIGlzIGFzIGZvbGxvd2luZzoNCg0KYmFi
ZWx0cmFjZTIgLS1wbHVnaW4tcGF0aCAuIC1jIHNvdXJjZS5kZW1vLk15Rmlyc3RTb3VyY2UgLWMg
c2luay5kZW1vLk15Rmlyc3RTaW5rDQowNC0yNCAxNjo1MjowNC4zNDkgOTE5ODA1IDkxOTgwNSBF
IENMSSBhZGRfZGVzY3JpcHRvcl90b19jb21wb25lbnRfZGVzY3JpcHRvcl9zZXRAYmFiZWx0cmFj
ZTIuYzoxNzIwIENhbm5vdCBmaW5kIGNvbXBvbmVudCBjbGFzczogcGx1Z2luLW5hbWU9ImRlbW8i
LCBjb21wLWNscy1uYW1lPSJNeUZpcnN0U291cmNlIiwgY29tcC1jbHMtdHlwZT0xDQowNC0yNCAx
Njo1MjowNC4zNDkgOTE5ODA1IDkxOTgwNSBFIENMSSBjbWRfcnVuX2N0eF9pbml0QGJhYmVsdHJh
Y2UyLmM6MTg4MiBDYW5ub3QgZmluZCBhbiBvcGVyYXRpdmUgbWVzc2FnZSBpbnRlcmNoYW5nZSBw
cm90b2NvbCB2ZXJzaW9uIHRvIHVzZSB0byBjcmVhdGUgdGhlIGBydW5gIGNvbW1hbmQncyBncmFw
aDogc3RhdHVzPUVSUk9SDQowNC0yNCAxNjo1MjowNC4zNDkgOTE5ODA1IDkxOTgwNSBFIENMSSBj
bWRfcnVuQGJhYmVsdHJhY2UyLmM6MjQ2NSBDYW5ub3QgaW5pdGlhbGl6ZSB0aGUgY29tbWFuZCdz
IGNvbnRleHQuDQoNCkVSUk9SOiAgICBbQmFiZWx0cmFjZSBDTEldIChiYWJlbHRyYWNlMi5jOjI0
NjUpDQogIENhbm5vdCBpbml0aWFsaXplIHRoZSBjb21tYW5kJ3MgY29udGV4dC4NCkNBVVNFRCBC
WSBbQmFiZWx0cmFjZSBDTEldIChiYWJlbHRyYWNlMi5jOjE4ODIpDQogIENhbm5vdCBmaW5kIGFu
IG9wZXJhdGl2ZSBtZXNzYWdlIGludGVyY2hhbmdlIHByb3RvY29sIHZlcnNpb24gdG8gdXNlIHRv
IGNyZWF0ZSB0aGUgYHJ1bmAgY29tbWFuZCdzIGdyYXBoOiBzdGF0dXM9RVJST1INCkNBVVNFRCBC
WSBbQmFiZWx0cmFjZSBDTEldIChiYWJlbHRyYWNlMi5jOjE3MjApDQogIENhbm5vdCBmaW5kIGNv
bXBvbmVudCBjbGFzczogcGx1Z2luLW5hbWU9ImRlbW8iLCBjb21wLWNscy1uYW1lPSJNeUZpcnN0
U291cmNlIiwgY29tcC1jbHMtdHlwZT0xDQoNCmJhYmVsdHJhY2UyIC0tdmVyc2lvbg0KQmFiZWx0
cmFjZSAyLjAuNyAiQW1xdWkiIFt2Mi4wLjYtMS1nODI1YTBlZDZkXQ0KDQpBbXF1aSAoL8mSbWt3
acuQLykgaXMgYSB0b3duIGluIGVhc3Rlcm4gUXXDqWJlYywgQ2FuYWRhLCBhdCB0aGUgYmFzZSBv
ZiB0aGUgR2FzcMOpIHBlbmluc3VsYSBpbiBCYXMtU2FpbnQtTGF1cmVudC4gTG9jYXRlZCBhdCB0
aGUNCmNvbmZsdWVuY2Ugb2YgdGhlIEh1bXF1aSBhbmQgTWF0YXDDqWRpYSBSaXZlcnMsIGl0cyBw
cm94aW1pdHkgdG8gd29vZGxhbmRzIG1ha2VzIGl0IGEgZ3JlYXQgZGVzdGluYXRpb24gZm9yIG91
dGRvb3IgYWN0aXZpdGllcyBzdWNoIGFzDQpjYW1waW5nLCBoaWtpbmcsIGFuZCBtb3VudGFpbiBi
aWtpbmcuDQp5YW5uYW53dUB1ZTkxZTk2ZjI5NTFiNWM6fi90cmVlcy9sdHRuZ190ZXN0X3J1biQN
Cg0KSXMgdGhlIGNsaSBjaGFuZ2VkIG9yIHNvbWV0aGluZz8gSG93IGNhbiBJIG1ha2UgaXQgcmln
aHQ/DQoNCkJlc2lkZXMsIGlzIGl0IHBvc3NpYmxlIHdlIGNyZWF0ZSBhIHBpcGVsaW5lIGluIHB5
dGhvbiBhbmQgbWFrZSB1c2UgdGhlIHRoZSBweXRob24gZHJhZnRlZCBwbHVnaW4/IENhbiB5b3Ug
YWR2aXNlIG1lIGhvdz8NCg0KQW1hbmRhDQoNCg==

--_000_03304ae9731e474db911b8ef6703cf69amazoncom_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyIgc3R5bGU9
ImRpc3BsYXk6bm9uZTsiPjwhLS0gUCB7bWFyZ2luLXRvcDowO21hcmdpbi1ib3R0b206MDt9IC0t
Pjwvc3R5bGU+DQo8L2hlYWQ+DQo8Ym9keSBkaXI9Imx0ciI+DQo8ZGl2IGlkPSJkaXZ0YWdkZWZh
dWx0d3JhcHBlciIgc3R5bGU9ImZvbnQtc2l6ZToxMnB0O2NvbG9yOiMwMDAwMDA7Zm9udC1mYW1p
bHk6Q2FsaWJyaSxIZWx2ZXRpY2Esc2Fucy1zZXJpZjsiIGRpcj0ibHRyIj4NCjxwPjwvcD4NCjxk
aXY+DQo8ZGl2IGRpcj0ibHRyIj4NCjxkaXYgaWQ9InhfZGl2dGFnZGVmYXVsdHdyYXBwZXIiIGRp
cj0ibHRyIiBzdHlsZT0iZm9udC1zaXplOiAxMnB0OyBjb2xvcjogcmdiKDAsIDAsIDApOyBmb250
LWZhbWlseTogQ2FsaWJyaSwgSGVsdmV0aWNhLCBzYW5zLXNlcmlmLCBzZXJpZiwgJnF1b3Q7RW1v
amlGb250JnF1b3Q7OyI+DQo8cD5IaSwgVGhlcmUsPC9wPg0KPHA+SSBhbSB0cnlpbmcgdG8gY29u
c3RydWN0IGEgY3VzdG9taXplZCBmaWx0ZXIgYW5kIHNpbmsgYmFzZWQgb24gYmFiZWx0cmFjZTIg
cHl0aG9uIGJpbmRpbmcuIEhvd2V2ZXIsIG5ldGhlciBtaW5lIHBsdWdpbiBub3IgdGhlIHBsdWdp
bnMgc2FtcGxlIEkgY291bGQgZmluZCBvbiB0aGUgaW50ZXJuZXQgYWxsIGRvbnQgd29yay48L3A+
DQo8cD5Gb3IgZXhhbXBsZSwgPGEgaHJlZj0iaHR0cHM6Ly9naXRodWIuY29tL3NpbWFyay9iYWJl
bHRyYWNlLWZ1bi1wbHVnaW5zL3RyZWUvbWFzdGVyL215LWZpcnN0LWNvbXBvbmVudHMiIHRhcmdl
dD0iX2JsYW5rIiByZWw9Im5vb3BlbmVyIG5vcmVmZXJyZXIiIGNsYXNzPSJ4X09XQUF1dG9MaW5r
IiBpZD0iTFBsbmsxOTcxNzciIHByZXZpZXdyZW1vdmVkPSJ0cnVlIj4NCmh0dHBzOi8vZ2l0aHVi
LmNvbS9zaW1hcmsvYmFiZWx0cmFjZS1mdW4tcGx1Z2lucy90cmVlL21hc3Rlci9teS1maXJzdC1j
b21wb25lbnRzPC9hPjwvcD4NCjxwPkkganVzdCBkb3dubG9hZGVkIHRoZSBweSBmaWxlIGFuZCBy
dW4gdGhlIGV4YWN0IGNvbW1hbmQsIGl0IGZhaWxlZC4gVGhlIGxvZyBpcyBhcyBmb2xsb3dpbmc6
PGJyPg0KPC9wPg0KPGRpdj48YnI+DQo8L2Rpdj4NCjxkaXY+YmFiZWx0cmFjZTIgLS1wbHVnaW4t
cGF0aCAuIC1jIHNvdXJjZS5kZW1vLk15Rmlyc3RTb3VyY2UgLWMgc2luay5kZW1vLk15Rmlyc3RT
aW5rPGJyPg0KMDQtMjQgMTY6NTI6MDQuMzQ5IDkxOTgwNSA5MTk4MDUgRSBDTEkgYWRkX2Rlc2Ny
aXB0b3JfdG9fY29tcG9uZW50X2Rlc2NyaXB0b3Jfc2V0QGJhYmVsdHJhY2UyLmM6MTcyMCBDYW5u
b3QgZmluZCBjb21wb25lbnQgY2xhc3M6IHBsdWdpbi1uYW1lPSZxdW90O2RlbW8mcXVvdDssIGNv
bXAtY2xzLW5hbWU9JnF1b3Q7TXlGaXJzdFNvdXJjZSZxdW90OywgY29tcC1jbHMtdHlwZT0xPGJy
Pg0KMDQtMjQgMTY6NTI6MDQuMzQ5IDkxOTgwNSA5MTk4MDUgRSBDTEkgY21kX3J1bl9jdHhfaW5p
dEBiYWJlbHRyYWNlMi5jOjE4ODIgQ2Fubm90IGZpbmQgYW4gb3BlcmF0aXZlIG1lc3NhZ2UgaW50
ZXJjaGFuZ2UgcHJvdG9jb2wgdmVyc2lvbiB0byB1c2UgdG8gY3JlYXRlIHRoZSBgcnVuYCBjb21t
YW5kJ3MgZ3JhcGg6IHN0YXR1cz1FUlJPUjxicj4NCjA0LTI0IDE2OjUyOjA0LjM0OSA5MTk4MDUg
OTE5ODA1IEUgQ0xJIGNtZF9ydW5AYmFiZWx0cmFjZTIuYzoyNDY1IENhbm5vdCBpbml0aWFsaXpl
IHRoZSBjb21tYW5kJ3MgY29udGV4dC48YnI+DQo8YnI+DQpFUlJPUjombmJzcDsmbmJzcDsmbmJz
cDsgW0JhYmVsdHJhY2UgQ0xJXSAoYmFiZWx0cmFjZTIuYzoyNDY1KTxicj4NCiZuYnNwOyBDYW5u
b3QgaW5pdGlhbGl6ZSB0aGUgY29tbWFuZCdzIGNvbnRleHQuPGJyPg0KQ0FVU0VEIEJZIFtCYWJl
bHRyYWNlIENMSV0gKGJhYmVsdHJhY2UyLmM6MTg4Mik8YnI+DQombmJzcDsgQ2Fubm90IGZpbmQg
YW4gb3BlcmF0aXZlIG1lc3NhZ2UgaW50ZXJjaGFuZ2UgcHJvdG9jb2wgdmVyc2lvbiB0byB1c2Ug
dG8gY3JlYXRlIHRoZSBgcnVuYCBjb21tYW5kJ3MgZ3JhcGg6IHN0YXR1cz1FUlJPUjxicj4NCkNB
VVNFRCBCWSBbQmFiZWx0cmFjZSBDTEldIChiYWJlbHRyYWNlMi5jOjE3MjApPGJyPg0KJm5ic3A7
IENhbm5vdCBmaW5kIGNvbXBvbmVudCBjbGFzczogcGx1Z2luLW5hbWU9JnF1b3Q7ZGVtbyZxdW90
OywgY29tcC1jbHMtbmFtZT0mcXVvdDtNeUZpcnN0U291cmNlJnF1b3Q7LCBjb21wLWNscy10eXBl
PTE8YnI+DQo8L2Rpdj4NCjxkaXY+PGJyPg0KPC9kaXY+DQo8ZGl2PmJhYmVsdHJhY2UyIC0tdmVy
c2lvbjxicj4NCkJhYmVsdHJhY2UgMi4wLjcgJnF1b3Q7QW1xdWkmcXVvdDsgW3YyLjAuNi0xLWc4
MjVhMGVkNmRdPGJyPg0KPGJyPg0KQW1xdWkgKC/Jkm1rd2nLkC8pIGlzIGEgdG93biBpbiBlYXN0
ZXJuIFF1w6liZWMsIENhbmFkYSwgYXQgdGhlIGJhc2Ugb2YgdGhlIEdhc3DDqSBwZW5pbnN1bGEg
aW4gQmFzLVNhaW50LUxhdXJlbnQuIExvY2F0ZWQgYXQgdGhlPGJyPg0KY29uZmx1ZW5jZSBvZiB0
aGUgSHVtcXVpIGFuZCBNYXRhcMOpZGlhIFJpdmVycywgaXRzIHByb3hpbWl0eSB0byB3b29kbGFu
ZHMgbWFrZXMgaXQgYSBncmVhdCBkZXN0aW5hdGlvbiBmb3Igb3V0ZG9vciBhY3Rpdml0aWVzIHN1
Y2ggYXM8YnI+DQpjYW1waW5nLCBoaWtpbmcsIGFuZCBtb3VudGFpbiBiaWtpbmcuPGJyPg0KeWFu
bmFud3VAdWU5MWU5NmYyOTUxYjVjOn4vdHJlZXMvbHR0bmdfdGVzdF9ydW4kIDxicj4NCjxicj4N
CjwvZGl2Pg0KSXMgdGhlIGNsaSBjaGFuZ2VkIG9yIHNvbWV0aGluZz8gSG93IGNhbiBJIG1ha2Ug
aXQgcmlnaHQ/DQo8cD48L3A+DQo8cD5CZXNpZGVzLCBpcyBpdCBwb3NzaWJsZSB3ZSBjcmVhdGUg
YSBwaXBlbGluZSBpbiBweXRob24gYW5kIG1ha2UgdXNlIHRoZSB0aGUgcHl0aG9uIGRyYWZ0ZWQg
cGx1Z2luPyBDYW4geW91IGFkdmlzZSBtZSBob3c/PGJyPg0KPC9wPg0KPHA+QW1hbmRhPGJyPg0K
PC9wPg0KPC9kaXY+DQo8L2Rpdj4NCjwvZGl2Pg0KPHNwYW4gY2xhc3M9IlBlcnNvbmFQYW5lTGF1
bmNoZXIiPg0KPGRpdiBjbGFzcz0iX3BlX2QgX3BlXzYyIiBhcmlhLWV4cGFuZGVkPSJmYWxzZSIg
dGFiaW5kZXg9Ii0xIiBhcmlhLWhhc3BvcHVwPSJmYWxzZSI+DQo8L2Rpdj4NCjwvc3Bhbj48YnI+
DQo8cD48L3A+DQo8L2Rpdj4NCjwvYm9keT4NCjwvaHRtbD4NCg==

--_000_03304ae9731e474db911b8ef6703cf69amazoncom_--

--===============8576296018487312060==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8576296018487312060==--
