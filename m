Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 908A8CE7A88
	for <lttng-dev@archiver.kernel.org>; Sat, 23 Sep 2023 06:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1695449073;
	bh=Pybj8HzYIvGTJZwbDCftC8n5pVeiz7YZMeQ/+IuD6RM=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=LcnyENTCFXizlNbP0SKBaaSlwOlEnSOCEsCfUJxayMED5zxjQ/43sQV1A2oH9bxS0
	 gEiN9ykUbXP3xxA+sK1kPTKPqYyg5UbRD4BCVzh52RXlJSjZaPFOoT3VHhHMrgQXmv
	 7a/llmMZPdKTrBisIW0DtH0o17bg/SerY6LuK7WgEzm3WinkD4CRoL0vLZVWWWkNdB
	 iCB/vpyzBtkVApcjWjrx9hsqPj00iBStKrCpYI7853thOfAtFSOYgMpSzQ5s+Y7Mc9
	 gz+KntbEcaGu+IlX8J0LOpxiU5pxLStRIyvayE4faZmEF/oMu3BvUxE+zjJLWX6EpK
	 YSXhrNHsK/p7Q==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Rsz9r2Q2zz2bqs;
	Sat, 23 Sep 2023 02:04:32 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4Rsz9q0GY8z2bqq
 for <lttng-dev@lists.lttng.org>; Sat, 23 Sep 2023 02:04:30 -0400 (EDT)
Received: from [IPV6:2a02:8012:ce1:0:3816:3a3f:d1e1:d01d] (unknown
 [IPv6:2a02:8012:ce1:0:3816:3a3f:d1e1:d01d])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4Rsz9n6Z9jz1R3s;
 Sat, 23 Sep 2023 02:04:29 -0400 (EDT)
Message-ID: <d071966a-a737-43f1-0387-f113d26bd4d2@efficios.com>
Date: Sat, 23 Sep 2023 07:03:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To: Olivier Dion <odion@efficios.com>, =?UTF-8?B?T25kxZllaiBTdXLDvQ==?=
 <ondrej@sury.org>, lttng-dev <lttng-dev@lists.lttng.org>
References: <FA4E40F7-C16C-4872-9829-0643AA974B30@sury.org>
 <878r8zgtvr.fsf@laura>
In-Reply-To: <878r8zgtvr.fsf@laura>
Subject: Re: [lttng-dev] TSAN build broken on master branch
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

T24gOS8yMS8yMyAyMToyMSwgT2xpdmllciBEaW9uIHZpYSBsdHRuZy1kZXYgd3JvdGU6Cj4gT24g
VGh1LCAyMSBTZXAgMjAyMywgT25kxZllaiBTdXLDvSB2aWEgbHR0bmctZGV2IDxsdHRuZy1kZXZA
bGlzdHMubHR0bmcub3JnPiB3cm90ZToKPiBbLi4uXQo+PiBJdCBmYWlscyB3aXRoOgo+Pgo+PiBy
Y3VsZmhhc2guYzoxMTg5OjI6IGVycm9yOiBhZGRyZXNzIGFyZ3VtZW50IHRvIGF0b21pYyBvcGVy
YXRpb24gbXVzdCBiZSBhIHBvaW50ZXIgdG8gaW50ZWdlciAoJ3R5cGVvZiAobm9kZV9uZXh0KScg
KGFrYSAnc3RydWN0IGNkc19sZmh0X25vZGUgKionKSBpbnZhbGlkKQo+PiAgICAgICAgICB1YXRv
bWljX29yX21vKG5vZGVfbmV4dCwgUkVNT1ZFRF9GTEFHLCBDTU1fUkVMRUFTRSk7Cj4+ICAgICAg
ICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgo+
PiAuLi9pbmNsdWRlL3VyY3UvdWF0b21pYy9idWlsdGlucy1nZW5lcmljLmg6MTIzOjEwOiBub3Rl
OiBleHBhbmRlZCBmcm9tIG1hY3JvICd1YXRvbWljX29yX21vJwo+PiAgICAgICAgICAgICAgICAg
ICh2b2lkKSBfX2F0b21pY19vcl9mZXRjaChjbW1fY2FzdF92b2xhdGlsZShhZGRyKSwgbWFzaywg
XAo+PiAgICAgICAgICAgICAgICAgICAgICAgICBeICAgICAgICAgICAgICAgICB+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fgo+PiByY3VsZmhhc2guYzoxNDQwOjM6IGVycm9yOiBhZGRyZXNzIGFyZ3Vt
ZW50IHRvIGF0b21pYyBvcGVyYXRpb24gbXVzdCBiZSBhIHBvaW50ZXIgdG8gaW50ZWdlciAoJ3R5
cGVvZiAoZmluaV9idWNrZXRfbmV4dCknIChha2EgJ3N0cnVjdCBjZHNfbGZodF9ub2RlICoqJykg
aW52YWxpZCkKPj4gICAgICAgICAgICAgICAgICB1YXRvbWljX29yKGZpbmlfYnVja2V0X25leHQs
IFJFTU9WRURfRkxBRyk7Cj4+ICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+Cj4+IC4uL2luY2x1ZGUvdXJjdS91YXRvbWljL2J1aWx0aW5z
LWdlbmVyaWMuaDoxMzA6Mjogbm90ZTogZXhwYW5kZWQgZnJvbSBtYWNybyAndWF0b21pY19vcicK
Pj4gICAgICAgICAgdWF0b21pY19vcl9tbyhhZGRyLCBtYXNrLCBDTU1fUkVMQVhFRCkKPj4gICAg
ICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KPj4gLi4vaW5jbHVk
ZS91cmN1L3VhdG9taWMvYnVpbHRpbnMtZ2VuZXJpYy5oOjEyMzoxMDogbm90ZTogZXhwYW5kZWQg
ZnJvbSBtYWNybyAndWF0b21pY19vcl9tbycKPj4gICAgICAgICAgICAgICAgICAodm9pZCkgX19h
dG9taWNfb3JfZmV0Y2goY21tX2Nhc3Rfdm9sYXRpbGUoYWRkciksIG1hc2ssIFwKPj4gICAgICAg
ICAgICAgICAgICAgICAgICAgXiAgICAgICAgICAgICAgICAgfn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn4KPiAKPiBFaCBJIHRob3VnaHQgd2UgZml4ZWQgdGhhdC4gIENsYW5nIGlzIHZlcnkgc3RyaWN0
IGFib3V0IHRoZXNlIHRoaW5ncy4KPiAKPiBZb3UgY2FuIGFwcGx5IHRoZSBmb2xsb3dpbmcKPiA8
aHR0cHM6Ly9yZXZpZXcubHR0bmcub3JnL2MvdXNlcnNwYWNlLXJjdS8rLzEwOTExLzE+LiAgVGhh
dCBvdWdodCB0byBmaXgKPiB0aGUgaXNzdWUgdW50aWwgd2UgbWVyZ2UgdGhlIHBhdGNoLgoKRml4
IG1lcmdlZCBpbnRvIGxpYnVyY3UgbWFzdGVyLCB0aGFua3MhCgpNYXRoaWV1Cgo+ICAgCgotLSAK
TWF0aGlldSBEZXNub3llcnMKRWZmaWNpT1MgSW5jLgpodHRwczovL3d3dy5lZmZpY2lvcy5jb20K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRl
diBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0
dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
