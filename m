Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20CE9C6FD20
	for <lttng-dev@archiver.kernel.org>; Tue, 21 Mar 2023 20:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1679430411;
	bh=QxQxC7JAnTDVoIEjyMNi1yjicdRop5rC1TBP6rIfs5w=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=X/6ayF2bYBWrgI2REpDfsQ/ESblBCdb+7AklxY/jk8wgxk6O+c+OtQ3YJUdw8rCwv
	 aZCwFZikCzsG94fGSD0JtnJOHqvs8D72qJNW0taZQLcVGA/K5MqJ3JZstIwXqFM5gu
	 3YCrPZiHM1RfFV/K0puy5RmhkOQdD+tHcf7ycqWjlhF2Xdk9dOf4eWUfDm66KZw8Da
	 dJwZV4yo9Vrw03zMYwjVzscDkp1F8Df+kD3gen85MeMLdjefECt6IsiQJP5VosWbAN
	 WHa0hO3G2x0681mYblpEE6NJxVHTSkMlV7IkSAVXY0WKAZgsfIC67YWQ2KSAIJL9Ni
	 Zhdwqsjxr7E+A==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Ph36f4BYTz2Gtd;
	Tue, 21 Mar 2023 16:26:50 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4Ph36c6TXlz2Gtb
 for <lttng-dev@lists.lttng.org>; Tue, 21 Mar 2023 16:26:48 -0400 (EDT)
Received: from [172.16.0.188] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4Ph36223lPzs9q;
 Tue, 21 Mar 2023 16:26:18 -0400 (EDT)
Message-ID: <86858b96-5b88-7e1c-2be2-6157e864c8db@efficios.com>
Date: Tue, 21 Mar 2023 16:26:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: Duncan Sands <baldrick@free.fr>, lttng-dev@lists.lttng.org
References: <20230317213755.455957-1-ondrej@sury.org>
 <20230317213755.455957-3-ondrej@sury.org>
 <6d73ed33-f3fc-2459-a7e9-142b8908ad4f@efficios.com>
 <dbe6e604-6ae9-1790-718f-bc69686442d1@free.fr>
In-Reply-To: <dbe6e604-6ae9-1790-718f-bc69686442d1@free.fr>
Subject: Re: [lttng-dev] [PATCH 2/7] Use gcc __atomic builtis for
 <urcu/uatomic.h> implementation
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

T24gMjAyMy0wMy0yMCAxNTozOCwgRHVuY2FuIFNhbmRzIHZpYSBsdHRuZy1kZXYgd3JvdGU6Cj4g
SGkgTWF0aGlldSwKPiAKPj4gV2hpbGUgT0sgZm9yIHRoZSBnZW5lcmFsIGNhc2UsIEkgd291bGQg
cmVjb21tZW5kIHRoYXQgd2UgaW1tZWRpYXRlbHkgCj4+IGltcGxlbWVudCBzb21ldGhpbmcgbW9y
ZSBlZmZpY2llbnQgb24geDg2IDMyLzY0IHdoaWNoIHRha2VzIGludG8gCj4+IGFjY291bnQgdGhh
dCBfX0FUT01JQ19BQ1FfUkVMIGF0b21pYyBvcGVyYXRpb25zIGFyZSBpbXBsZW1lbnRlZCB3aXRo
IAo+PiBMT0NLIHByZWZpeGVkIGF0b21pYyBvcHMsIHdoaWNoIGltcGx5IHRoZSBiYXJyaWVyIGFs
cmVhZHksIGxlYXZpbmcgdGhlIAo+PiBiZWZvcmUvYWZ0ZXJfdWF0b21pY18qKCkgYXMgbm8tb3Bz
Lgo+IAo+IG1heWJlIGZpcnN0IGNoZWNrIHdoZXRoZXIgdGhlIEdDQyBvcHRpbWl6ZXJzIG1lcmdl
IHRoZW0uwqAgSSBiZWxpZXZlIHNvbWUgCj4gb3B0aW1pemF0aW9ucyBvZiBhdG9taWMgcHJpbWl0
aXZlcyBhcmUgYWxsb3dlZCBhbmQgaW1wbGVtZW50ZWQsIGJ1dCBJIAo+IGNvdWxkbid0IHNheSB3
aGljaCBvbmVzLgo+IAo+IEJlc3Qgd2lzaGVzLCBEdW5jYW4uCgpUZXN0ZWQgb24gZ29kYm9sdC5v
cmcgd2l0aDoKCmludCBhOwoKdm9pZCBmY3Qodm9pZCkKewogICAgICh2b2lkKSBfX2F0b21pY19h
ZGRfZmV0Y2goJmEsIDEsIF9fQVRPTUlDX1JFTEFYRUQpOwogICAgIF9fYXRvbWljX3RocmVhZF9m
ZW5jZShfX0FUT01JQ19TRVFfQ1NUKTsKfQoKeDg2LTY0IGdjYyAxMi4yIC1PMiAtc3RkPWMxMToK
CmZjdDoKICAgICAgICAgbG9jayBhZGQgICAgICAgIERXT1JEIFBUUiBhW3JpcF0sIDEKICAgICAg
ICAgbG9jayBvciBRV09SRCBQVFIgW3JzcF0sIDAKICAgICAgICAgcmV0CmE6CiAgICAgICAgIC56
ZXJvICAgNAoKeDg2LTY0IGNsYW5nIDE2LjAuMCAtTzIgLXN0ZD1jMTE6CgpmY3Q6ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIyBAZmN0CiAgICAgICAgIGxvY2sgICAgICAgICAg
ICBpbmMgICAgIGR3b3JkIHB0ciBbcmlwICsgYV0KICAgICAgICAgbWZlbmNlCiAgICAgICAgIHJl
dAphOgogICAgICAgICAubG9uZyAgIDAKClNvIG5vbmUgb2YgZ2NjL2NsYW5nIG9wdGltaXplIHRo
aXMgdG9kYXksIGhlbmNlIHRoZSBuZWVkIGZvciBhbiAKeDg2LXNwZWNpZmljIGltcGxlbWVudGF0
aW9uLgoKVGhhbmtzLAoKTWF0aGlldQoKCi0tIApNYXRoaWV1IERlc25veWVycwpFZmZpY2lPUyBJ
bmMuCmh0dHBzOi8vd3d3LmVmZmljaW9zLmNvbQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlz
dHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0
aW5mby9sdHRuZy1kZXYK
