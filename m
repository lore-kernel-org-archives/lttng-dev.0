Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99418C46467
	for <lttng-dev@archiver.kernel.org>; Mon, 16 Jan 2023 15:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1673883501;
	bh=4k1zegJNMrWdjoNf25Zs6E8ui2tgPdq8Q+XQcaIljPg=;
	h=Date:To:Cc:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=Q+RaMU8RBWM2tq8AjCrg4jj/vHnarl6bvbX0Vawzd1GaSe8SuMzQ6FzY5UZVcGzQb
	 vHxB0idmHJwA6X4HVm7Q0/+PwW9N2t05rD0BvnW8I+7jdZNdZtCs4i8g6F/RK/4JWE
	 B4Q9IiTirmGgwNW3cTsT3UZBB573jwbrQACXClc0FNrhGPYN17ZKBPdqzlKK7N5m1J
	 xD39SxHNwZ8SxpPEA2vkFZ8H8fUuSKrkB063dilAjGHwyeO5TMocX6xll4RMwyWY0R
	 fQqJEjiLTvULZrbUccH0tOkwmK5dJFDsJkn0RZWp8tEFsQw0fjDVUhFApD0ZYktVNv
	 RP16EmQYshn/A==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4NwblJ4PQWz1RYp;
	Mon, 16 Jan 2023 10:38:20 -0500 (EST)
Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
 by lists.lttng.org (Postfix) with ESMTP id 4NwRmr6RYxz1RVS
 for <lttng-dev@lists.lttng.org>; Mon, 16 Jan 2023 04:39:08 -0500 (EST)
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
 by smtpfb2-g21.free.fr (Postfix) with ESMTP id F11474280F6
 for <lttng-dev@lists.lttng.org>; Mon, 16 Jan 2023 10:39:06 +0100 (CET)
Received: from zimbra43-e7.priv.proxad.net (unknown [172.20.243.193])
 by smtp2-g21.free.fr (Postfix) with ESMTP id 9B1E32003FC;
 Mon, 16 Jan 2023 10:38:28 +0100 (CET)
Date: Mon, 16 Jan 2023 10:38:28 +0100 (CET)
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
Message-ID: <1512260626.80256142.1673861908243.JavaMail.root@zimbra43-e7.priv.proxad.net>
In-Reply-To: <79319a2d-0898-0243-1572-26e476cac681@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [185.105.31.250]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Win)/7.2.0-GA2598)
X-Authenticated-User: chafraysse@free.fr
X-Mailman-Approved-At: Mon, 16 Jan 2023 10:38:19 -0500
Subject: Re: [lttng-dev] LTTng UST structure support
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
From: chafraysse--- via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: chafraysse@free.fr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

SGkgTWF0aGlldSwKClRoYW5rcyBmb3IgeW91ciByZXBseSA6KQpJJ2xsIHN0aWNrIHRvIGJ0MiBt
b2R1bGVzIGluIHRoZSBtZWFudGltZSB0aGVuCkknbGwgYWxyZWFkeSBiZSBzYXZpbmcgYSB0b24g
b2YgdGltZSB3aXRoIHRob3NlIGFuZCB0aGUgQ1RGIHNwZWMgd2hpY2ggaXMgZ3JlYXQgIQoKQmVz
dCByZWdhcmRzLAoKQ2hhcmxlcwoKLS0tLS0gTWFpbCBvcmlnaW5hbCAtLS0tLQpEZTogIk1hdGhp
ZXUgRGVzbm95ZXJzIiA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPgrDgDogY2hhZnJh
eXNzZUBmcmVlLmZyLCBsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCkVudm95w6k6IEpldWRpIDEy
IEphbnZpZXIgMjAyMyAyMToxMDo1NwpPYmpldDogUmU6IFtsdHRuZy1kZXZdIExUVG5nIFVTVCBz
dHJ1Y3R1cmUgc3VwcG9ydAoKT24gMjAyMy0wMS0wOSAwOTowMiwgY2hhZnJheXNzZS0tLSB2aWEg
bHR0bmctZGV2IHdyb3RlOgo+IEhpLAo+IAo+IEknbSBsb29raW5nIGZvciBhIENURiB3cml0ZXIg
dG8gc2VyaWFsaXplIGluc3RydW1lbnRhdGlvbnMgaW4gYW4gCj4gZW1iZWRkZWQgTGludXgvUnVz
dCBmcmFtZXdvcmsKPiBMVFRuZyBVU1QgbG9va2VkIGxpa2UgYSB2ZXJ5IHN0cm9uZyBvcHRpb24s
IGJ1dCBJIHdhbnQgdG8gc2VyaWFsaXplIAo+IHN0cnVjdHVyZXMgYXMgQ1RGIGNvbXBvdW5kIHR5
cGUgc3RydWN0dXJlcyBhbmQgSSBkaWQgbm90IHNlZSB0aG9zZSAKPiBzdXBwb3J0ZWQgaW4gdGhl
IGRvYyBvciBhcGkKClRoaXMgaXMgY29ycmVjdC4gSSBhbSBjdXJyZW50bHkgd29ya2luZyBvbiBh
IG5ldyBwcm9qZWN0IGNhbGxlZCAKImxpYnNpZGUiIChzZWUgaHR0cHM6Ly9naXQuZWZmaWNpb3Mu
Y29tLz9wPWxpYnNpZGUuZ2l0O2E9c3VtbWFyeSkgd2hpY2ggCmZlYXR1cmVzIHN1cHBvcnQgZm9y
IGNvbXBvdW5kIHR5cGVzLgoKSG93ZXZlciwgd2Ugc3RpbGwgbmVlZCB0byBkbyB0aGUgaGVhdnkt
bGlmdGluZyBpbXBsZW1lbnRhdGlvbiB3b3JrIG9mIAppbnRlZ3JhdGluZyB0aGlzIHdpdGggTFRU
bmctVVNULiBUaGlzIGlzIHRoZSBwbGFuIHRvd2FyZHMgc3VwcG9ydGluZyAKY29tcG91bmQgdHlw
ZXMgaW4gTFRUbmctVVNULgoKPiBJJ2QgbG92ZSB0byBoYXZlIGNvbmZpcm1hdGlvbiB0aGF0IEkg
ZGlkIG5vdCBqdXN0IG1pc3Mgc29tZXRoaW5nIDopCj4gSWYgTFRUbmcgVVNUIGlzIG91dCBmb3Ig
bWUgSSB3aWxsIHByb2JhYmx5IHRyeSB0byB1c2UgdGhlIGN0Zi13cml0ZXIgCj4gbW9kdWxlIG9m
IGJhYmVsdHJhY2UgMiBpbnN0ZWFkCgpGb3Igbm93IHRoZSBjdGYtd3JpdGVyIG1vZHVsZXMgb2Yg
YnQyIHdvdWxkIGJlIGFuIGFsdGVybmF0aXZlIHRvIApjb25zaWRlciwgYnV0IHJlbWVtYmVyIHRo
YXQgaXQgaXMgbm90IGRlc2lnbmVkIGZvciBsb3ctaW1wYWN0IHRyYWNpbmcgCnN1Y2ggYXMgbHR0
bmctdXN0LiBTbyBpdCBkZXBlbmRzIG9uIGhvdyBtdWNoIHRyYWNlciBvdmVyaGVhZC9ydW50aW1l
IAppbXBhY3QgeW91IGNhbiBhZmZvcmQgaW4geW91ciB1c2UtY2FzZS4KClRoYW5rcywKCk1hdGhp
ZXUKCj4gCj4gQmVzdCByZWdhcmRzLAo+IAo+IENoYXJsZXMKPiBfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGx0dG5nLWRldiBtYWlsaW5nIGxpc3QKPiBs
dHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCj4gaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJp
bi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgoKLS0gCk1hdGhpZXUgRGVzbm95ZXJzCkVmZmlj
aU9TIEluYy4KaHR0cHM6Ly93d3cuZWZmaWNpb3MuY29tCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRl
dkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFu
L2xpc3RpbmZvL2x0dG5nLWRldgo=
