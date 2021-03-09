Return-Path: <SRS0=0DGv=IH=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE32C43331
	for <lttng-dev@archiver.kernel.org>; Tue,  9 Mar 2021 14:49:23 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FC8364F62
	for <lttng-dev@archiver.kernel.org>; Tue,  9 Mar 2021 14:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC8364F62
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Dvylh442hzFDr;
	Tue,  9 Mar 2021 09:49:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1615301361;
	bh=CGvMgOJys4DPSUmeWS5IDdl9YlihwCN975rE8I5fd8k=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=lQgmzBFoaRH9dxob5MLbHxUQnprklJFEfX/BG/k2IHAwXcUykTyvR6+0oN0/thCDM
	 KxL/z5X70I2SMdTD5iE1vCzqa3jOpZ+QyoU/NN/w3tW0MQBLYL7P2D4kJZeu45sf+6
	 NUVqoDJPWDV2RNX91P5SHK6rHS48Gj1xUEKSZNCGXkM4ak893BtwAAAK2nI5hthH9a
	 cCzDIiNpyBcMgCIkS1uiTf93zOWe3XNDqHN3uFRNd/hyvLIJ5tcf02trVNg9LK//fO
	 ovaf+5MU86ZhmJEhSRx8oqZz+AXXQWSoZAcosDLZ65gZf+uENXP6+PUGmYaTikyjUr
	 MBQoWddJq4FUQ==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4Dvylg5FKkzFCK
 for <lttng-dev@lists.lttng.org>; Tue,  9 Mar 2021 09:49:19 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 1DEBE2788E4;
 Tue,  9 Mar 2021 09:49:13 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 5__KuO8l016C; Tue,  9 Mar 2021 09:49:12 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 3AADF27887D;
 Tue,  9 Mar 2021 09:49:12 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3AADF27887D
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id pYnMxIwT0_aA; Tue,  9 Mar 2021 09:49:12 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 2F7312787FD;
 Tue,  9 Mar 2021 09:49:12 -0500 (EST)
Date: Tue, 9 Mar 2021 09:49:12 -0500 (EST)
To: Francis Deslauriers <francis.deslauriers@efficios.com>
Cc: Awais Belal <awais_belal@mentor.com>, lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <324604657.2268.1615301352176.JavaMail.zimbra@efficios.com>
In-Reply-To: <a320badd-11ec-a937-ffdb-5ca1e0efcc38@efficios.com>
References: <f02c9dd6-b95c-19be-a7b0-cca3efda149c@mentor.com>
 <a320badd-11ec-a937-ffdb-5ca1e0efcc38@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF86 (Linux)/8.8.15_GA_4007)
Thread-Topic: lttng-modules: block: invalid/unknown value for rwbs field
Thread-Index: sXx7d/jJppwG7c60TPmOKsnKwicvvA==
Subject: Re: [lttng-dev] lttng-modules: block: invalid/unknown value for
 rwbs field
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

SnVzdCBhZGRpbmcgdG8gRnJhbmNpcycgZXhwbGFuYXRpb24gKGFuZCBmb2xsb3dpbmcgdXAgb24g
QXdhaXMnIHF1ZXN0aW9ucyBvbiBJUkMpOgp0aGUgcmVhc29uIHRoZSBgcHJpbnQtZW51bS1mbGFn
c2Agb3B0aW9uIGlzIG5vdCB0aGUgZGVmYXVsdCBpcyBmb3VuZCBoZXJlIFsxXS4KCnRsO2RyOiBi
aXR3aXNlIGVudW1lcmF0aW9ucyBhcmUgbm90IGRlZmluZWQgaW4gQ1RGIDEuOCBhbmQgd2lsbCBs
aWtlbHkgYmUKcGFydCBvZiBDVEYgMi4wLgoKQWxzbywgdGhpcyBvcHRpb24gaXMgb25seSBhdmFp
bGFibGUgaW4gbWFzdGVyIGZvciB0aGUgbW9tZW50IGFuZCB3aWxsIGJlIHBhcnQKb2YgYSBmdXR1
cmUgMi4xIHJlbGVhc2UuCgpUaGFua3MsCkrDqXLDqW1pZQoKWzFdIGh0dHBzOi8vcmV2aWV3Lmx0
dG5nLm9yZy9jL2JhYmVsdHJhY2UvKy8zMDQ1LzMxI21lc3NhZ2UtYzc3MDliNDQzMWFkNzIwOTYy
ZmU5YjgwODgwYmM2ODlmMjk0YzRhOQoKLS0tLS0gT3JpZ2luYWwgTWVzc2FnZSAtLS0tLQpGcm9t
OiAibHR0bmctZGV2IiA8bHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZz4KVG86ICJBd2FpcyBCZWxh
bCIgPGF3YWlzX2JlbGFsQG1lbnRvci5jb20+LCAibHR0bmctZGV2IiA8bHR0bmctZGV2QGxpc3Rz
Lmx0dG5nLm9yZz4KU2VudDogVHVlc2RheSwgTWFyY2ggOSwgMjAyMSA5OjM0OjA5IEFNClN1Ympl
Y3Q6IFJlOiBbbHR0bmctZGV2XSBsdHRuZy1tb2R1bGVzOiBibG9jazogaW52YWxpZC91bmtub3du
IHZhbHVlIGZvciByd2JzIGZpZWxkCgpIaSwKCllvdSBzZWUgdGhpcyAiVW5rbm93biB2YWx1ZSAz
MyIgYmVjYXVzZSB0aGVyZSBhcmUgbm8gbGFiZWwgd2l0aCB0aGUgCnZhbHVlIDMzIGluIHRoZSAi
YmxvY2tfcnFfdHlwZSIgZW51bWVyYXRpb24uCgpNb3JlIHNwZWNpZmljYWxseSwgeW91IHNlZSB0
aGUgdmFsdWUgIjMzIiBiZWNhdXNlIGl0J3MgdGhlIHJlc3VsdCBvZiB0d28gCk9SLWVkIGJpdGZs
YWdzIChSV0JTX0ZMQUdfV1JJVEUgfCBSV0JTX0ZMQUdfU1lOQykuCgpUaGUgdHlwZSBvZiB0aGUg
InJ3YnMiIGZpZWxkIGluIHRoZSBldmVudCB3YXMgY2hhbmdlZCBmcm9tIGludGVnZXIgdG8gCmVu
dW0gaW4gdGhhdCBjb21taXQgWzBdLiBUaGF0IGNoYW5nZSB3YXMgbWFkZSB0byBhbGxvdyB0cmFj
ZSByZWFkZXJzIHRvIApwcmludCBPUi1lZCB2YWx1ZXMgbW9yZSBuaWNlbHkgaGF2ZSBhbGwgdGhl
eSBuZWVkIHRvIGRvIGl0LiBJbiBmYWN0LCAKYmFiZWx0cmFjZTIgaW1wbGVtZW50cyBzdWNoIGZl
YXR1cmUgYW5kIHlvdSBjYW4gdHJ5IGl0IHdpdGggdGhlIApmb2xsb3dpbmcgY29tbWFuZDoKCiQg
YmFiZWx0cmFjZTIgLWMgc2luay50ZXh0LnByZXR0eSAtcCBwcmludC1lbnVtLWZsYWdzPXRydWUg
PHBhdGgtdG8tdHJhY2U+CgpBbmQgd291bGQgcHJpbnQgdGhhdCBmaWVsZCBhcyBzdWNoOiAoICJS
V0JTX0ZMQUdfV1JJVEUiIHwgCiJSV0JTX0ZMQUdfU1lOQyIgOiBjb250YWluZXIgPSAzMyApCgpJ
IGJlbGlldmUgdGhpcyBmZWF0dXJlIGlzIHR1cm4gb2ZmIGluIEJhYmVsdHJhY2UyIGJ5IGRlZmF1
bHQgdG8gYmUgCmJhY2t3YXJkIGNvbXBhdGlibGUgd2l0aCBCYWJlbHRyYWNlIDEuNS4KCkl0J3Mg
aW1wb3J0YW50IHRvIG5vdGUgdGhhdCBiZWZvcmUgdGhhdCBjaGFuZ2UgaW4gdGhlIGtlcm5lbCB0
cmFjZXIgCkJhYmVsdHJhY2Ugd291bGQgaGF2ZSBzaW1wbHkgcHJpbnRlZCAicndicyA9IDMzIiBz
byB5b3UncmUgbm90IGxvc2luZyAKYW55IGluZm9ybWF0aW9uIGhlcmUuCgpTbywgdHJ5IGl0IG91
dCB3aXRoIEJhYmVsdHJhY2UyLCBpdCBzaG91bGQgd29yayBhcyB5b3UgZXhwZWN0LgoKCkNoZWVy
cywKCkZyYW5jaXMKClswXSAKaHR0cHM6Ly9naXRodWIuY29tL2x0dG5nL2x0dG5nLW1vZHVsZXMv
Y29tbWl0LzIzNjM0NTE1ZTcyNzFjOGM4NTk0YWQ4N2E2Njg1MjMyZDRlZmYyOTcKCgpPbiAzLzkv
MjEgODoxMCBBTSwgQXdhaXMgQmVsYWwgdmlhIGx0dG5nLWRldiB3cm90ZToKPgo+IEhpLAo+Cj4g
SSBhbSB1c2luZyBsdHRuZy1tb2R1bGVzIDIuMTIuNSB3aXRoIGEgNS40LjkzIGtlcm5lbCBvbiBh
biBhYXJjaDY0IAo+IHRhcmdldC4gQWZ0ZXIgY3JlYXRpbmcgYSBzZXNzaW9uIEkgcnVuCj4KPiAq
bHR0bmcgZW5hYmxlLWV2ZW50IC1rIGJsb2NrKioKPgo+IHRvIGVuYWJsZSBhbGwgdGhlIGJsb2Nr
XyBrZXJuZWwgZXZlbnRzIGJ1dCB3aGVuIEkgcnVuIGJhYmVsdHJhY2Ugb24gCj4gdGhlIGdlbmVy
YXRlZCB0cmFjZXMgSSBnZXQgYSBoYW5kZnVsIG9mCj4KPiAqW3dhcm5pbmddIFVua25vd24gdmFs
dWUgMzMgaW4gZW51bS4KPiAuLi4KPiAuLi4KPiAqCj4KPiB3aXRoIGRpZmZlcmVudCB2YWx1ZXMg
aW4gcGxhY2Ugb2YgMzMuIFRoaXMgZG9lcyBub3QgaGFwcGVuIHdpdGggYW55IAo+IG90aGVyIGtl
cm5lbCBldmVudCB0eXBlCj4KPiAqQmFiZWxUcmFjZSBUcmFjZSBWaWV3ZXIgYW5kIENvbnZlcnRl
ciAxLjUuOCoKPgo+IEFsc28gaWYgSSB0cnkgdG8gZG8gYSAnbHR0bmcgdmlldycgb24gdGhpcyBz
ZXNzaW9uIEkgY2FuIGlkZW50aWZ5IHRoYXQgCj4gdGhpcyBoYXMgc29tZXRoaW5nIHRvIGRvIHdp
dGggdGhlIHJ3YnMgZmllbGQgYXMgSSBnZXQKPgo+ICpbMTQ6MDM6NDIuNjQ5NzE5NzUwXSAoKzAu
MDAwMDA1NzUwKSBpbXg4cXhwbWVrIGJsb2NrX2Jpb19yZW1hcDogeyAKPiBjcHVfaWQgPSAzIH0s
IHsgZGV2ID0gMTg3Njk1MjAwLCBzZWN0b3IgPSAyNDYwMDgwLCBucl9zZWN0b3IgPSA4LCByd2Jz
IAo+ID0gKCA8dW5rbm93bj4gOiBjb250YWluZXIgPSAzMyApLCBvbGRfZGV2ID0gMTg3Njk1MjAz
LCBvbGRfc2VjdG9yID0gCj4gMjEwNTc3NiB9Cj4gWzE0OjAzOjQyLjY0OTcyMjEyNV0gKCswLjAw
MDAwMjM3NSkgaW14OHF4cG1layBibG9ja19iaW9fcXVldWU6IHsgCj4gY3B1X2lkID0gMyB9LCB7
IGRldiA9IDE4NzY5NTIwMCwgc2VjdG9yID0gMjQ2MDA4MCwgbnJfc2VjdG9yID0gOCwgcndicyAK
PiA9ICggPHVua25vd24+IDogY29udGFpbmVyID0gMzMgKSwgdGlkID0gNDI4LCBjb21tID0gImpi
ZDIvbW1jYmxrMXAzLSIgfQo+IFsxNDowMzo0Mi42NDk3MjUwMDBdICgrMC4wMDAwMDI4NzUpIGlt
eDhxeHBtZWsgYmxvY2tfYmlvX2JhY2ttZXJnZTogeyAKPiBjcHVfaWQgPSAzIH0sIHsgZGV2ID0g
MTg3Njk1MjAwLCBzZWN0b3IgPSAyNDYwMDgwLCBucl9zZWN0b3IgPSA4LCByd2JzIAo+ID0gKCA8
dW5rbm93bj4gOiBjb250YWluZXIgPSAzMyApLCB0aWQgPSA0MjgsIGNvbW0gPSAiamJkMi9tbWNi
bGsxcDMtIiB9Cj4gLi4uCj4gLi4uKgo+Cj4gSSBiZWxpZXZlIDx1bmtub3duPiBpbiB0aGUgbG9n
IHBvaW50cyB0byBhIHN5bXB0b20/IFdoaWxlIGZvciB0aGUgCj4gZXZlbnRzL2NvbnRhaW5lciBp
ZCB0aGF0IGRvIG5vdCBnZW5lcmF0ZSB0aGlzIHdhcm5pbmcgSSBoYXZlIGluIHRoZSAKPiBzYW1l
IHRyYWNlCj4KPiAqWzE0OjAzOjQ0LjY5NzU3MjM3NV0gKCsyLjAzNjk0MzUwMCkgaW14OHF4cG1l
ayBibG9ja19iaW9fcmVtYXA6IHsgCj4gY3B1X2lkID0gMCB9LCB7IGRldiA9IDE4NzY5NTIwMCwg
c2VjdG9yID0gOTM4MjAzMiwgbnJfc2VjdG9yID0gOCwgcndicyAKPiA9ICggIlJXQlNfRkxBR19X
UklURSIgOiBjb250YWluZXIgPSAxICksIG9sZF9kZXYgPSAxODc2OTUyMDYsIAo+IG9sZF9zZWN0
b3IgPSAyNzg2NzIgfQo+IFsxNDowMzo0NC42OTc1ODQzNzVdICgrMC4wMDAwMTIwMDApIGlteDhx
eHBtZWsgYmxvY2tfYmlvX3F1ZXVlOiB7IAo+IGNwdV9pZCA9IDAgfSwgeyBkZXYgPSAxODc2OTUy
MDAsIHNlY3RvciA9IDkzODIwMzIsIG5yX3NlY3RvciA9IDgsIHJ3YnMgCj4gPSAoICJSV0JTX0ZM
QUdfV1JJVEUiIDogY29udGFpbmVyID0gMSApLCB0aWQgPSAxNjA5LCBjb21tID0gCj4gImt3b3Jr
ZXIvdTg6MCIgfQo+IFsxNDowMzo0NC42OTc2MDQyNTBdICgrMC4wMDAwMTk4NzUpIGlteDhxeHBt
ZWsgYmxvY2tfZ2V0cnE6IHsgY3B1X2lkID0gCj4gMCB9LCB7IGRldiA9IDE4NzY5NTIwMCwgc2Vj
dG9yID0gOTM4MjAzMiwgbnJfc2VjdG9yID0gOCwgcndicyA9ICggCj4gIlJXQlNfRkxBR19XUklU
RSIgOiBjb250YWluZXIgPSAxICksIHRpZCA9IDE2MDksIGNvbW0gPSAia3dvcmtlci91ODowIiB9
Kgo+Cj4gVGhlIGludGVyZXN0aW5nIHRoaW5nIHRvIG5vdGUgd2l0aCB0aGUgd29ya2luZyBldmVu
dHMgaXMgdGhhdCBhbGwgb2YgCj4gdGhlbSBoYXZlICJSV0JTX0ZMQUdfV1JJVEUiIGFuZCBubyBv
dGhlciB0eXBlcyBmcm9tIAo+IGh0dHBzOi8vZ2l0aHViLmNvbS9sdHRuZy9sdHRuZy1tb2R1bGVz
L2Jsb2Ivc3RhYmxlLTIuMTIvaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUvYmxv
Y2suaCNMMzkgCj4gd2hpY2ggSSB3b3VsZCBleHBlY3QgdG8gc2VlLgo+Cj4gSSBhbSBsb3N0IGZv
ciBoaW50cyBhcyB0byB3aGF0IEkgbmVlZCB0byBsb29rIHVwLi4uIGFueSBoZWxwIHdvdWxkIGJl
IAo+IGhpZ2hseSBhcHByZWNpYXRlZC4KPgo+IC0tIAo+IEJSLAo+IEF3YWlzCj4KPiBfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGx0dG5nLWRldiBtYWls
aW5nIGxpc3QKPiBsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCj4gaHR0cHM6Ly9saXN0cy5sdHRu
Zy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0
dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9t
YWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5s
dHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZv
L2x0dG5nLWRldgo=
