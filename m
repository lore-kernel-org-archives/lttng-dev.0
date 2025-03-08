Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F9FC282EC
	for <lttng-dev@archiver.kernel.org>; Mon, 10 Mar 2025 14:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1741616344;
	bh=40vA7GLwgTWif0ISCGVnJqYblIsEEPz4oSxD3X0bviE=;
	h=Date:To:Subject:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=gM2ZKz1gyssDCVgLKUpKwh8AePj4/nXikSd5YfkWzoC08qo1EOmYUJWiqxUuh8On5
	 9Qksqe0Dxd1znicO4xFIWIVRw7Uh+DcYa+cGYEN+N67rJI8ItUo2XbYF/ruGS65zi7
	 tqoBb8DSkglsPrXen/NrXX34LpoWlEtxL8RVHKjrEfLS+4puEpFtvoVnBwUupLks5g
	 YqwFOUrljPjjf0l+KaPGlALpnZxMOphmZfQMZHbWRwO5feYBLC1o/R2TIDgG3blUrj
	 s75yCHhCzO/8ubKTuQj1ulfsLLYwwjrGPmszgiOeZN0GMH8FL7qPDbe6JwgTdTuRbi
	 jYKw5lB3I69IA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4ZBJt02HG2z1l7M;
	Mon, 10 Mar 2025 10:19:04 -0400 (EDT)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
 by lists.lttng.org (Postfix) with ESMTP id 4Z8yHr4JsRz1040
 for <lttng-dev@lists.lttng.org>; Sat,  8 Mar 2025 04:18:16 -0500 (EST)
Received: from fangkaihit$163.com ( [39.144.124.17] ) by
 ajax-webmail-wmsvr-40-105 (Coremail) ; Sat, 8 Mar 2025 17:18:08 +0800 (CST)
X-Originating-IP: [39.144.124.17]
Date: Sat, 8 Mar 2025 17:18:08 +0800 (CST)
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Subject: Re:Re: need help for avoiding system calls while using URCU
 (Userspace RCU)
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <7d25653c-5082-4632-8bc8-a387d41760e4@efficios.com>
References: <5bfbaea6.79f9.19560340335.Coremail.fangkaihit@163.com>
 <ab5ea7b4-abd6-430e-bc2c-52762654301a@efficios.com>
 <7d25653c-5082-4632-8bc8-a387d41760e4@efficios.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <217d2435.2b02.195750c31f0.Coremail.fangkaihit@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: aSgvCgAXPJdQC8xndpd4AA--.9544W
X-CM-SenderInfo: 5idqwypdlkx3i6rwjhhfrp/1tbiXRAIIGfKF26IWwACsg
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Mailman-Approved-At: Mon, 10 Mar 2025 10:19:03 -0400
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
From: =?utf-8?b?5pa56ZS0IHZpYSBsdHRuZy1kZXY=?= <lttng-dev@lists.lttng.org>
Reply-To: =?UTF-8?B?5pa56ZS0?= <fangkaihit@163.com>
Cc: lttng-dev@lists.lttng.org
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

ZGVhciBNYXRoaWV1PGJyLz4gIFRoYW5rIHlvdSBmb3IgeW91ciBndWlkYW5jZSwgSSd2ZSBmb3Vu
ZCBES0RQJ3MgVVJDVSBzdWNjZXNzZnVsbHkgYXZvaWRzIHN5c3RlbSBjYWxscy4gR3JhdGVmdWwg
Zm9yIHlvdXIgc3VwcG9ydCE8YnIvPkJlc3QgcmVnYXJkcyw8YnIvPmZhbmdrYWkKQXQgMjAyNS0w
My0wNyAwMDo1ODoyMSwgIk1hdGhpZXUgRGVzbm95ZXJzIiA8bWF0aGlldS5kZXNub3llcnNAZWZm
aWNpb3MuY29tPiB3cm90ZToKPk9uIDIwMjUtMDMtMDYgMTE6MTcsIEtpZW5hbiBTdGV3YXJ0IHZp
YSBsdHRuZy1kZXYgd3JvdGU6DQo+PiBIaSDmlrnplLQsDQo+PiANCj4+IE9uIDMvNC8yNSAzOjA5
IEFNLCDmlrnplLQgdmlhIGx0dG5nLWRldiB3cm90ZToNCj4+IA0KPj4+IEkgaGF2ZSByZWZlcmVu
Y2VkIHlvdXIgcHJvamVjdCwgVVJDVSAoVXNlcnNwYWNlIFJDVSksIG9uIEdpdEh1Yiwgd2hpY2gg
DQo+Pj4gaXMgYmFzZWQgb24gdGhlIFFTQlIgbW9kZWwuIEhvd2V2ZXIsIEkgDQo+PiBub3RpY2Vk
IHRoYXQgd2hlbiB1c2luZyBpdCBpbiB1c2VyIG1vZGUsIGl0IG1ha2VzIHN5c3RlbSBjYWxscyB0
byBlbnRlciANCj4+IHRoZSBrZXJuZWwuIENvdWxkIHlvdSBwbGVhc2UgcHJvdmlkZSBndWlkYW5j
ZSBvbiBob3cgdG8gYWRkcmVzcyB0aGlzIGlzc3VlPw0KPj4gDQo+PiBBcmUgdGhlcmUgc3BlY2lm
aWMgcGFydHMgb2YgdGhlIEFQSSB0aGF0IHlvdSBuZWVkIHRvIGJlIHVzZXItc3BhY2Ugb25seT8N
Cj4+IA0KPj4gID4gSSBhaW0gdG8gYWNoaWV2ZSBhIHB1cmUgdXNlci1tb2RlIGltcGxlbWVudGF0
aW9uLiBTcGVjaWZpY2FsbHksIEkgDQo+PiB3b3VsZCBhcHByZWNpYXRlIGFueSBpbnNpZ2h0cyBv
ciBzdWdnZXN0aW9ucyBvbiBhdm9pZGluZyBzeXN0ZW0gY2FsbHMgDQo+PiB3aGlsZSBzdGlsbCBt
YWludGFpbmluZyB0aGUgZnVuY3Rpb25hbGl0eSBvZiB0aGUgUVNCUiBtb2RlbCBpbiB1c2VyIA0K
Pj4gc3BhY2UuIFRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHlvdXIgdGltZSBhbmQgYXNzaXN0YW5j
ZS4NCj4+IA0KPj4gQ3VycmVudGx5IHRoZSBsb2NraW5nIGlzIGRvbmUgdXNpbmcgZnV0ZXhzLCB3
aGljaCBhcmUgc3lzdGVtIGNhbGxzLiANCj4NCj5DbGFyaWZpY2F0aW9uOiB0aGUgd2FpdC93YWtl
dXAgYmV0d2VlbiByZWFkLXNpZGUgYW5kIHN5bmNocm9uaXplIGlzIGRvbmUNCj51c2luZyB0aGUg
ZnV0ZXggc3lzdGVtIGNhbGwuIFRoZXJlIGlzIG5vIGxvY2tpbmcgb24gdGhlIHJlYWQtc2lkZQ0K
PnBlci1zZS4NCj4NCj5UaGFua3MsDQo+DQo+TWF0aGlldQ0KPg0KPj4gVGhvc2UgY291bGQgcG90
ZW50aWFsbHkgYmUgcmVwbGFjZWQgd2l0aCBhIHBvbGwvcmV0cnkgc3lzdGVtIGVpdGhlciBpbiBh
IA0KPj4gZGlmZmVyZW50IGZsYXZvdXIgb2YgVVJDVSBvciBhdCBidWlsZC10aW1lLg0KPj4gDQo+
PiB0aGFua3MsDQo+PiBraWVuYW4NCj4NCj4NCj4tLSANCj5NYXRoaWV1IERlc25veWVycw0KPkVm
ZmljaU9TIEluYy4NCj5odHRwczovL3d3dy5lZmZpY2lvcy5jb20NCg==
