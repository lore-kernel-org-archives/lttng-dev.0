Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18ADAC4345F
	for <lttng-dev@archiver.kernel.org>; Wed, 24 Apr 2024 16:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1713975013;
	bh=pxPldUm4bP7839bvpi2P3gGUx7A6klQmwyDiczaAKdQ=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=qcn7NNt/nHKY50tLdLZvYRWa+Wtjia+/B6GFe+vaAGKyh0S04f8VrXyGOEW8DZqJt
	 Hmx044Tm3tGG/sUvh9oCPpc4PFtJorfZP0rKe6HDNA+/Ms/tYk/K6irRQch9ZEin4W
	 Daih8Zg3sfyD9W/X6J5EdEyIg39GjZUMs7kF9Rggmp9SUhVT7AtKxAb0i54jDIhVvv
	 linIQMuRuEQqI9ZkmtfZvWPtPWtuE5XJjJHK1qyGNxIWg4LMYTFMNkq9N66OLgn2/C
	 VkBCgkEqmfIyIEVfBddQrZ+i6NbVfPGCv+XWuual3kcqk9ty371LMtEweT1HxdrkJB
	 hC8d8Jy8hDokw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4VPkTw1qRjz2jR9;
	Wed, 24 Apr 2024 12:10:12 -0400 (EDT)
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com
 [99.78.197.219])
 by lists.lttng.org (Postfix) with ESMTPS id 4VPXrj6hVkz2hv4
 for <lttng-dev@lists.lttng.org>; Wed, 24 Apr 2024 04:55:49 -0400 (EDT)
X-IronPort-AV: E=Sophos;i="6.07,225,1708387200"; d="scan'208,217";a="84127183"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
 by smtp-border-fw-80008.pdx80.corp.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 08:55:45 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:28102]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.30.134:2525]
 with esmtp (Farcaster)
 id 5441e1b7-3813-4aa9-af88-f084103370b6; Wed, 24 Apr 2024 08:55:45 +0000 (UTC)
X-Farcaster-Flow-ID: 5441e1b7-3813-4aa9-af88-f084103370b6
Received: from EX19D003ANC004.ant.amazon.com (10.37.240.207) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 24 Apr 2024 08:55:38 +0000
Received: from EX19D003ANC001.ant.amazon.com (10.37.240.216) by
 EX19D003ANC004.ant.amazon.com (10.37.240.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Wed, 24 Apr 2024 08:55:37 +0000
Received: from EX19D003ANC001.ant.amazon.com ([fe80::ed4e:7258:fa8c:17e8]) by
 EX19D003ANC001.ant.amazon.com ([fe80::ed4e:7258:fa8c:17e8%5]) with
 mapi id 15.02.1258.028; Wed, 24 Apr 2024 08:55:37 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: [Babeltrace 2] Make use of self constructed python plugin
Thread-Index: AQHaliSRE2S+0FEifEO22hBlP7zoqw==
Date: Wed, 24 Apr 2024 08:55:37 +0000
Message-ID: <f1dfd5e8c8c3489abe83c815e1f4cf86@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.106.101.47]
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 24 Apr 2024 12:10:11 -0400
Subject: [lttng-dev] [Babeltrace 2] Make use of self constructed python
 plugin
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
Content-Type: multipart/mixed; boundary="===============1111709299094715778=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============1111709299094715778==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_f1dfd5e8c8c3489abe83c815e1f4cf86amazoncom_"

--_000_f1dfd5e8c8c3489abe83c815e1f4cf86amazoncom_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksIFRoZXJlLA0KDQpJIGFtIHRyeWluZyB0byBjb25zdHJ1Y3QgYSBjdXN0b21pemVkIGZpbHRl
ciBhbmQgc2luayBiYXNlZCBvbiBiYWJlbHRyYWNlMiBweXRob24gYmluZGluZy4gSG93ZXZlciwg
bmV0aGVyIG1pbmUgcGx1Z2luIG5vciB0aGUgbGltaXRlZCBwbHVnaW5zIHNhbXBsZSBJIGNvdWxk
IGZpbmQgb24gdGhlIGludGVybmV0IGFsbCBkb250IHdvcmsuDQoNCkZvciBleGFtcGxlLCBodHRw
czovL2dpdGh1Yi5jb20vc2ltYXJrL2JhYmVsdHJhY2UtZnVuLXBsdWdpbnMvdHJlZS9tYXN0ZXIv
bXktZmlyc3QtY29tcG9uZW50cw0KDQpJIGp1c3QgZG93bmxvYWRlZCB0aGUgcHkgZmlsZSBhbmQg
cnVuIHRoZSBleGFjdCBjb21tYW5kLCBpdCBmYWlsZWQuIFRoZSBsb2cgaXMgYXMgZm9sbG93aW5n
Og0KDQp5YW5uYW53dUB1ZTkxZTk2ZjI5NTFiNWM6fi90cmVlcy9sdHRuZ190ZXN0X3J1biQgYmFi
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
U291cmNlIiwgY29tcC1jbHMtdHlwZT0xDQp5YW5uYW53dUB1ZTkxZTk2ZjI5NTFiNWM6fi90cmVl
cy9sdHRuZ190ZXN0X3J1biQgYmFiZWx0cmFjZTIgLS12ZXJzaW9uDQpCYWJlbHRyYWNlIDIuMC43
ICJBbXF1aSIgW3YyLjAuNi0xLWc4MjVhMGVkNmRdDQoNCkFtcXVpICgvyZJta3dpy5AvKSBpcyBh
IHRvd24gaW4gZWFzdGVybiBRdcOpYmVjLCBDYW5hZGEsIGF0IHRoZSBiYXNlIG9mIHRoZSBHYXNw
w6kgcGVuaW5zdWxhIGluIEJhcy1TYWludC1MYXVyZW50LiBMb2NhdGVkIGF0IHRoZQ0KY29uZmx1
ZW5jZSBvZiB0aGUgSHVtcXVpIGFuZCBNYXRhcMOpZGlhIFJpdmVycywgaXRzIHByb3hpbWl0eSB0
byB3b29kbGFuZHMgbWFrZXMgaXQgYSBncmVhdCBkZXN0aW5hdGlvbiBmb3Igb3V0ZG9vciBhY3Rp
dml0aWVzIHN1Y2ggYXMNCmNhbXBpbmcsIGhpa2luZywgYW5kIG1vdW50YWluIGJpa2luZy4NCnlh
bm5hbnd1QHVlOTFlOTZmMjk1MWI1Yzp+L3RyZWVzL2x0dG5nX3Rlc3RfcnVuJA0KDQpJcyB0aGUg
Y2xpIGNoYW5nZWQgb3Igc29tZXRoaW5nPyBIb3cgY2FuIEkgbWFrZSBpdCByaWdodD8NCg0KQmVz
aWRlcywgaXMgaXQgcG9zc2libGUgd2UgY3JlYXRlIGEgcGlwZWxpbmUgaW4gcHl0aG9uIGFuZCBt
YWtlIHVzZSB0aGUgdGhlIHB5dGhvbiBkcmFmdGVkIHBsdWdpbj8gQ2FuIHlvdSBhZHZpc2UgbWUg
aG93Pw0KDQpBbWFuZGENCg==

--_000_f1dfd5e8c8c3489abe83c815e1f4cf86amazoncom_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyIgc3R5bGU9
ImRpc3BsYXk6bm9uZTsiPjwhLS0gUCB7bWFyZ2luLXRvcDowO21hcmdpbi1ib3R0b206MDt9IC0t
Pjwvc3R5bGU+DQo8L2hlYWQ+DQo8Ym9keSBkaXI9Imx0ciI+DQo8ZGl2IGlkPSJkaXZ0YWdkZWZh
dWx0d3JhcHBlciIgc3R5bGU9ImZvbnQtc2l6ZToxMnB0O2NvbG9yOiMwMDAwMDA7Zm9udC1mYW1p
bHk6Q2FsaWJyaSxIZWx2ZXRpY2Esc2Fucy1zZXJpZjsiIGRpcj0ibHRyIj4NCjxwPkhpLCBUaGVy
ZSw8L3A+DQo8cD5JIGFtIHRyeWluZyB0byBjb25zdHJ1Y3QgYSBjdXN0b21pemVkIGZpbHRlciBh
bmQgc2luayBiYXNlZCBvbiBiYWJlbHRyYWNlMiBweXRob24gYmluZGluZy4gSG93ZXZlciwgbmV0
aGVyIG1pbmUgcGx1Z2luIG5vciB0aGUgbGltaXRlZCBwbHVnaW5zIHNhbXBsZSBJIGNvdWxkIGZp
bmQgb24gdGhlIGludGVybmV0IGFsbCBkb250IHdvcmsuPC9wPg0KPHA+Rm9yIGV4YW1wbGUsIDxh
IGhyZWY9Imh0dHBzOi8vZ2l0aHViLmNvbS9zaW1hcmsvYmFiZWx0cmFjZS1mdW4tcGx1Z2lucy90
cmVlL21hc3Rlci9teS1maXJzdC1jb21wb25lbnRzIiBjbGFzcz0iT1dBQXV0b0xpbmsiIGlkPSJM
UGxuazE5NzE3NyI+DQpodHRwczovL2dpdGh1Yi5jb20vc2ltYXJrL2JhYmVsdHJhY2UtZnVuLXBs
dWdpbnMvdHJlZS9tYXN0ZXIvbXktZmlyc3QtY29tcG9uZW50czwvYT48L3A+DQo8cD5JIGp1c3Qg
ZG93bmxvYWRlZCB0aGUgcHkgZmlsZSBhbmQgcnVuIHRoZSBleGFjdCBjb21tYW5kLCBpdCBmYWls
ZWQuIFRoZSBsb2cgaXMgYXMgZm9sbG93aW5nOjxicj4NCjwvcD4NCjxkaXY+PGJyPg0KPC9kaXY+
DQo8ZGl2Pnlhbm5hbnd1QHVlOTFlOTZmMjk1MWI1Yzp+L3RyZWVzL2x0dG5nX3Rlc3RfcnVuJCBi
YWJlbHRyYWNlMiAtLXBsdWdpbi1wYXRoIC4gLWMgc291cmNlLmRlbW8uTXlGaXJzdFNvdXJjZSAt
YyBzaW5rLmRlbW8uTXlGaXJzdFNpbms8YnI+DQowNC0yNCAxNjo1MjowNC4zNDkgOTE5ODA1IDkx
OTgwNSBFIENMSSBhZGRfZGVzY3JpcHRvcl90b19jb21wb25lbnRfZGVzY3JpcHRvcl9zZXRAYmFi
ZWx0cmFjZTIuYzoxNzIwIENhbm5vdCBmaW5kIGNvbXBvbmVudCBjbGFzczogcGx1Z2luLW5hbWU9
JnF1b3Q7ZGVtbyZxdW90OywgY29tcC1jbHMtbmFtZT0mcXVvdDtNeUZpcnN0U291cmNlJnF1b3Q7
LCBjb21wLWNscy10eXBlPTE8YnI+DQowNC0yNCAxNjo1MjowNC4zNDkgOTE5ODA1IDkxOTgwNSBF
IENMSSBjbWRfcnVuX2N0eF9pbml0QGJhYmVsdHJhY2UyLmM6MTg4MiBDYW5ub3QgZmluZCBhbiBv
cGVyYXRpdmUgbWVzc2FnZSBpbnRlcmNoYW5nZSBwcm90b2NvbCB2ZXJzaW9uIHRvIHVzZSB0byBj
cmVhdGUgdGhlIGBydW5gIGNvbW1hbmQncyBncmFwaDogc3RhdHVzPUVSUk9SPGJyPg0KMDQtMjQg
MTY6NTI6MDQuMzQ5IDkxOTgwNSA5MTk4MDUgRSBDTEkgY21kX3J1bkBiYWJlbHRyYWNlMi5jOjI0
NjUgQ2Fubm90IGluaXRpYWxpemUgdGhlIGNvbW1hbmQncyBjb250ZXh0Ljxicj4NCjxicj4NCkVS
Uk9SOiZuYnNwOyZuYnNwOyZuYnNwOyBbQmFiZWx0cmFjZSBDTEldIChiYWJlbHRyYWNlMi5jOjI0
NjUpPGJyPg0KJm5ic3A7IENhbm5vdCBpbml0aWFsaXplIHRoZSBjb21tYW5kJ3MgY29udGV4dC48
YnI+DQpDQVVTRUQgQlkgW0JhYmVsdHJhY2UgQ0xJXSAoYmFiZWx0cmFjZTIuYzoxODgyKTxicj4N
CiZuYnNwOyBDYW5ub3QgZmluZCBhbiBvcGVyYXRpdmUgbWVzc2FnZSBpbnRlcmNoYW5nZSBwcm90
b2NvbCB2ZXJzaW9uIHRvIHVzZSB0byBjcmVhdGUgdGhlIGBydW5gIGNvbW1hbmQncyBncmFwaDog
c3RhdHVzPUVSUk9SPGJyPg0KQ0FVU0VEIEJZIFtCYWJlbHRyYWNlIENMSV0gKGJhYmVsdHJhY2Uy
LmM6MTcyMCk8YnI+DQombmJzcDsgQ2Fubm90IGZpbmQgY29tcG9uZW50IGNsYXNzOiBwbHVnaW4t
bmFtZT0mcXVvdDtkZW1vJnF1b3Q7LCBjb21wLWNscy1uYW1lPSZxdW90O015Rmlyc3RTb3VyY2Um
cXVvdDssIGNvbXAtY2xzLXR5cGU9MTxicj4NCnlhbm5hbnd1QHVlOTFlOTZmMjk1MWI1Yzp+L3Ry
ZWVzL2x0dG5nX3Rlc3RfcnVuJCBiYWJlbHRyYWNlMiAtLXZlcnNpb248YnI+DQpCYWJlbHRyYWNl
IDIuMC43ICZxdW90O0FtcXVpJnF1b3Q7IFt2Mi4wLjYtMS1nODI1YTBlZDZkXTxicj4NCjxicj4N
CkFtcXVpICgvyZJta3dpy5AvKSBpcyBhIHRvd24gaW4gZWFzdGVybiBRdcOpYmVjLCBDYW5hZGEs
IGF0IHRoZSBiYXNlIG9mIHRoZSBHYXNww6kgcGVuaW5zdWxhIGluIEJhcy1TYWludC1MYXVyZW50
LiBMb2NhdGVkIGF0IHRoZTxicj4NCmNvbmZsdWVuY2Ugb2YgdGhlIEh1bXF1aSBhbmQgTWF0YXDD
qWRpYSBSaXZlcnMsIGl0cyBwcm94aW1pdHkgdG8gd29vZGxhbmRzIG1ha2VzIGl0IGEgZ3JlYXQg
ZGVzdGluYXRpb24gZm9yIG91dGRvb3IgYWN0aXZpdGllcyBzdWNoIGFzPGJyPg0KY2FtcGluZywg
aGlraW5nLCBhbmQgbW91bnRhaW4gYmlraW5nLjxicj4NCnlhbm5hbnd1QHVlOTFlOTZmMjk1MWI1
Yzp+L3RyZWVzL2x0dG5nX3Rlc3RfcnVuJCA8YnI+DQo8YnI+DQo8L2Rpdj4NCklzIHRoZSBjbGkg
Y2hhbmdlZCBvciBzb21ldGhpbmc/IEhvdyBjYW4gSSBtYWtlIGl0IHJpZ2h0Pw0KPHA+PC9wPg0K
PHA+QmVzaWRlcywgaXMgaXQgcG9zc2libGUgd2UgY3JlYXRlIGEgcGlwZWxpbmUgaW4gcHl0aG9u
IGFuZCBtYWtlIHVzZSB0aGUgdGhlIHB5dGhvbiBkcmFmdGVkIHBsdWdpbj8gQ2FuIHlvdSBhZHZp
c2UgbWUgaG93Pzxicj4NCjwvcD4NCjxwPkFtYW5kYTxicj4NCjwvcD4NCjwvZGl2Pg0KPC9ib2R5
Pg0KPC9odG1sPg0K

--_000_f1dfd5e8c8c3489abe83c815e1f4cf86amazoncom_--

--===============1111709299094715778==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1111709299094715778==--
