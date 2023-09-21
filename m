Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA25AE7D0A7
	for <lttng-dev@archiver.kernel.org>; Thu, 21 Sep 2023 20:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1695327683;
	bh=Ne/7RtoeEPrk/BjEZTfpKXeNLbASjrU3rIGgDkBbtac=;
	h=To:In-Reply-To:References:Date:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=f1g6fEplUGgEolH5opmx8zsa2UKo8WdzIfZYtPm0RjFtJXhL/f7CnTplULv++ROp3
	 rAvhSPCUDfne+iWeqIcm7NnQXhpQBlPb9IyoA3TeqEr/WZf+MZvOuo63ToDlt7xeVW
	 ppvXXenDoikQRNCKicrQyOgN2I0IiFlC7ESQ4+sRkTbg0JLJXFch1lZwBw/2EFh1/M
	 FYwTEMJ1Lgaph2SaCgwQaVnqURtVRNNozVutVbAKI+YVecV+OxTNLxzIeiMc/z6u5D
	 Ri/TmASPx64lLMAQnkTcCiuL3MEQBTfkRFMkU9Z2XSTcFDrqO5Q5keap4XGqXDcHXr
	 OKjgCk3IERXpA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Rs6HQ6HfJz2Zr6;
	Thu, 21 Sep 2023 16:21:22 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4Rs6HM6GTxz2b5Z
 for <lttng-dev@lists.lttng.org>; Thu, 21 Sep 2023 16:21:19 -0400 (EDT)
Received: from localhost (modemcable094.169-200-24.mc.videotron.ca
 [24.200.169.94])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4Rs6HF0SSyz1Qcs;
 Thu, 21 Sep 2023 16:21:13 -0400 (EDT)
To: =?utf-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@sury.org>, lttng-dev
 <lttng-dev@lists.lttng.org>
In-Reply-To: <FA4E40F7-C16C-4872-9829-0643AA974B30@sury.org>
Organization: EfficiOS
References: <FA4E40F7-C16C-4872-9829-0643AA974B30@sury.org>
Date: Thu, 21 Sep 2023 16:21:12 -0400
Message-ID: <878r8zgtvr.fsf@laura>
MIME-Version: 1.0
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
From: Olivier Dion via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Olivier Dion <odion@efficios.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

T24gVGh1LCAyMSBTZXAgMjAyMywgT25kxZllaiBTdXLDvSB2aWEgbHR0bmctZGV2IDxsdHRuZy1k
ZXZAbGlzdHMubHR0bmcub3JnPiB3cm90ZToKWy4uLl0KPiBJdCBmYWlscyB3aXRoOgo+Cj4gcmN1
bGZoYXNoLmM6MTE4OToyOiBlcnJvcjogYWRkcmVzcyBhcmd1bWVudCB0byBhdG9taWMgb3BlcmF0
aW9uIG11c3QgYmUgYSBwb2ludGVyIHRvIGludGVnZXIgKCd0eXBlb2YgKG5vZGVfbmV4dCknIChh
a2EgJ3N0cnVjdCBjZHNfbGZodF9ub2RlICoqJykgaW52YWxpZCkKPiAgICAgICAgIHVhdG9taWNf
b3JfbW8obm9kZV9uZXh0LCBSRU1PVkVEX0ZMQUcsIENNTV9SRUxFQVNFKTsKPiAgICAgICAgIF5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgo+IC4uL2lu
Y2x1ZGUvdXJjdS91YXRvbWljL2J1aWx0aW5zLWdlbmVyaWMuaDoxMjM6MTA6IG5vdGU6IGV4cGFu
ZGVkIGZyb20gbWFjcm8gJ3VhdG9taWNfb3JfbW8nCj4gICAgICAgICAgICAgICAgICh2b2lkKSBf
X2F0b21pY19vcl9mZXRjaChjbW1fY2FzdF92b2xhdGlsZShhZGRyKSwgbWFzaywgXAo+ICAgICAg
ICAgICAgICAgICAgICAgICAgXiAgICAgICAgICAgICAgICAgfn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn4KPiByY3VsZmhhc2guYzoxNDQwOjM6IGVycm9yOiBhZGRyZXNzIGFyZ3VtZW50IHRvIGF0b21p
YyBvcGVyYXRpb24gbXVzdCBiZSBhIHBvaW50ZXIgdG8gaW50ZWdlciAoJ3R5cGVvZiAoZmluaV9i
dWNrZXRfbmV4dCknIChha2EgJ3N0cnVjdCBjZHNfbGZodF9ub2RlICoqJykgaW52YWxpZCkKPiAg
ICAgICAgICAgICAgICAgdWF0b21pY19vcihmaW5pX2J1Y2tldF9uZXh0LCBSRU1PVkVEX0ZMQUcp
Owo+ICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn4KPiAuLi9pbmNsdWRlL3VyY3UvdWF0b21pYy9idWlsdGlucy1nZW5lcmljLmg6MTMwOjI6
IG5vdGU6IGV4cGFuZGVkIGZyb20gbWFjcm8gJ3VhdG9taWNfb3InCj4gICAgICAgICB1YXRvbWlj
X29yX21vKGFkZHIsIG1hc2ssIENNTV9SRUxBWEVEKQo+ICAgICAgICAgXn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KPiAuLi9pbmNsdWRlL3VyY3UvdWF0b21pYy9idWlsdGlu
cy1nZW5lcmljLmg6MTIzOjEwOiBub3RlOiBleHBhbmRlZCBmcm9tIG1hY3JvICd1YXRvbWljX29y
X21vJwo+ICAgICAgICAgICAgICAgICAodm9pZCkgX19hdG9taWNfb3JfZmV0Y2goY21tX2Nhc3Rf
dm9sYXRpbGUoYWRkciksIG1hc2ssIFwKPiAgICAgICAgICAgICAgICAgICAgICAgIF4gICAgICAg
ICAgICAgICAgIH5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CgpFaCBJIHRob3VnaHQgd2UgZml4ZWQg
dGhhdC4gIENsYW5nIGlzIHZlcnkgc3RyaWN0IGFib3V0IHRoZXNlIHRoaW5ncy4KCllvdSBjYW4g
YXBwbHkgdGhlIGZvbGxvd2luZwo8aHR0cHM6Ly9yZXZpZXcubHR0bmcub3JnL2MvdXNlcnNwYWNl
LXJjdS8rLzEwOTExLzE+LiAgVGhhdCBvdWdodCB0byBmaXgKdGhlIGlzc3VlIHVudGlsIHdlIG1l
cmdlIHRoZSBwYXRjaC4KIAotLSAKT2xpdmllciBEaW9uCkVmZmljaU9TIEluYy4KaHR0cHM6Ly93
d3cuZWZmaWNpb3MuY29tCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcK
aHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRl
dgo=
