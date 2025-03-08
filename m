Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9335DC282EC
	for <lttng-dev@archiver.kernel.org>; Mon, 10 Mar 2025 14:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1741616350;
	bh=NjE26wcJWk0exLN6HQmdARNnQE9Zsgq7PT7gcbM/gw4=;
	h=Date:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=zCR05iyJ6Z8jkht9JFj8FQEhk8PXiQMXrSx7PL9KQQnxA23yXrjX0xrNV3ZPKeSGl
	 7vaS7jTu12gMsOCMrV+UhluZyf+qSN1eLZgwlMyqUyweTBNsnIAZIrm7dMWpQrpKmY
	 M+9zcU4UIekDTmxgsxk4bjwufYtyn4edYqKCgOlk7YstP2jJ8fWNYVeUL+8ZyKe5f/
	 Yl1iQjukgbu8UCIDbB5COdISEqwVokuMKLuDR2W6kd5Z02fLSUQMuyeKkjADEBIP48
	 k65VerizrAvLnsBlxOjZoH4Ka+xXT1AQMcCKXxCqOUkEnD4zP0MXo44YeTLvdHNY1A
	 WwoyOxcpJSIaw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4ZBJt65p8Xz1l6w;
	Mon, 10 Mar 2025 10:19:10 -0400 (EDT)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
 by lists.lttng.org (Postfix) with ESMTP id 4Z93H469dzz11sZ
 for <lttng-dev@lists.lttng.org>; Sat,  8 Mar 2025 08:02:56 -0500 (EST)
Received: from fangkaihit$163.com ( [39.144.124.17] ) by
 ajax-webmail-wmsvr-40-105 (Coremail) ; Sat, 8 Mar 2025 17:16:46 +0800 (CST)
X-Originating-IP: [39.144.124.17]
Date: Sat, 8 Mar 2025 17:16:46 +0800 (CST)
To: "Kienan Stewart" <kstewart@efficios.com>
Cc: lttng-dev@lists.lttng.org
Subject: Re:Re: need help for avoiding system calls while using URCU
 (Userspace RCU)
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <ab5ea7b4-abd6-430e-bc2c-52762654301a@efficios.com>
References: <5bfbaea6.79f9.19560340335.Coremail.fangkaihit@163.com>
 <ab5ea7b4-abd6-430e-bc2c-52762654301a@efficios.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <6e8d366.2ae1.195750af232.Coremail.fangkaihit@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: aSgvCgB3n5r+CsxnPJd4AA--.9190W
X-CM-SenderInfo: 5idqwypdlkx3i6rwjhhfrp/1tbiXRAIIGfKF26IWwABsj
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
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

ZGVhciBraWVuYW48YnIvPlRoYW5rIHlvdSBmb3IgeW91ciBndWlkYW5jZSwgSSd2ZSBmb3VuZCBE
S0RQJ3MgVVJDVSBzdWNjZXNzZnVsbHkgYXZvaWRzIHN5c3RlbSBjYWxscy4gR3JhdGVmdWwgZm9y
IHlvdXIgc3VwcG9ydCE8YnIvPkJlc3QgcmVnYXJkcyw8YnIvPmZhbmdrYWkKQXQgMjAyNS0wMy0w
NyAwMDoxNzozNCwgIktpZW5hbiBTdGV3YXJ0IiA8a3N0ZXdhcnRAZWZmaWNpb3MuY29tPiB3cm90
ZToKPkhpIOaWuemUtCwNCj4NCj5PbiAzLzQvMjUgMzowOSBBTSwg5pa56ZS0IHZpYSBsdHRuZy1k
ZXYgd3JvdGU6DQo+DQo+PiBJIGhhdmUgcmVmZXJlbmNlZCB5b3VyIHByb2plY3QsIFVSQ1UgKFVz
ZXJzcGFjZSBSQ1UpLCBvbiBHaXRIdWIsIHdoaWNoIGlzIGJhc2VkIG9uIHRoZSBRU0JSIG1vZGVs
LiBIb3dldmVyLCBJIA0KPm5vdGljZWQgdGhhdCB3aGVuIHVzaW5nIGl0IGluIHVzZXIgbW9kZSwg
aXQgbWFrZXMgc3lzdGVtIGNhbGxzIHRvIGVudGVyIA0KPnRoZSBrZXJuZWwuIENvdWxkIHlvdSBw
bGVhc2UgcHJvdmlkZSBndWlkYW5jZSBvbiBob3cgdG8gYWRkcmVzcyB0aGlzIGlzc3VlPw0KPg0K
PkFyZSB0aGVyZSBzcGVjaWZpYyBwYXJ0cyBvZiB0aGUgQVBJIHRoYXQgeW91IG5lZWQgdG8gYmUg
dXNlci1zcGFjZSBvbmx5Pw0KPg0KPiA+IEkgYWltIHRvIGFjaGlldmUgYSBwdXJlIHVzZXItbW9k
ZSBpbXBsZW1lbnRhdGlvbi4gU3BlY2lmaWNhbGx5LCBJIA0KPndvdWxkIGFwcHJlY2lhdGUgYW55
IGluc2lnaHRzIG9yIHN1Z2dlc3Rpb25zIG9uIGF2b2lkaW5nIHN5c3RlbSBjYWxscyANCj53aGls
ZSBzdGlsbCBtYWludGFpbmluZyB0aGUgZnVuY3Rpb25hbGl0eSBvZiB0aGUgUVNCUiBtb2RlbCBp
biB1c2VyIA0KPnNwYWNlLiBUaGFuayB5b3UgdmVyeSBtdWNoIGZvciB5b3VyIHRpbWUgYW5kIGFz
c2lzdGFuY2UuDQo+DQo+Q3VycmVudGx5IHRoZSBsb2NraW5nIGlzIGRvbmUgdXNpbmcgZnV0ZXhz
LCB3aGljaCBhcmUgc3lzdGVtIGNhbGxzLiANCj5UaG9zZSBjb3VsZCBwb3RlbnRpYWxseSBiZSBy
ZXBsYWNlZCB3aXRoIGEgcG9sbC9yZXRyeSBzeXN0ZW0gZWl0aGVyIGluIGEgDQo+ZGlmZmVyZW50
IGZsYXZvdXIgb2YgVVJDVSBvciBhdCBidWlsZC10aW1lLg0KPg0KPnRoYW5rcywNCj5raWVuYW4N
Cg==
