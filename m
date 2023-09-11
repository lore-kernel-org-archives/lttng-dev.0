Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F73CEE7FF4
	for <lttng-dev@archiver.kernel.org>; Mon, 11 Sep 2023 15:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1694447486;
	bh=CS62QNoumbxLXaAm7ZmVHMhN/Spqd8VNFnUSPBMPddQ=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=qB+Ha+BXnCP5r/uUm10MTWZg14k1OAAIBf3+GXxOCAF80jD2DD46G6vV4hhHsliJm
	 NIYhQ39zI2UzDj5twcMoQEPCousrQxOfdFHclOyo1Ls9AwEi2HiQB0chY9H+X9I07r
	 lDHwSLMiOBgsrsbCNSKHQyvQBKs/5MetKymq0NDMPE7vDH7uV9KjCXcVpUamwlCD/z
	 z5o708lG2fkNWCV1/KnScPbkhZa5wmRtx6gNmq7awPPSCCbtoGY1ZVYsP6AZIHM/5Q
	 w58UAuJ8wMIj9kLKhwoDeZ3rAuefAtCUSnf+YTJmduBoujnudSw122H3WWIE14vkNM
	 1aquWBa2HJteQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4RkrmY19cQz2XRC;
	Mon, 11 Sep 2023 11:51:25 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4RkrmT6Y0Kz2XT8
 for <lttng-dev@lists.lttng.org>; Mon, 11 Sep 2023 11:51:21 -0400 (EDT)
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown
 [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4RkrmS04Fkz1PNG;
 Mon, 11 Sep 2023 11:51:19 -0400 (EDT)
Message-ID: <9fad646e-46bf-9229-81cb-93a237db2922@efficios.com>
Date: Mon, 11 Sep 2023 11:52:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To: "Mousa, Anas" <anasmous@amazon.com>, "Yitschak, Yehuda"
 <yehuday@amazon.com>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
References: <6e06b605ec9f446da5dc8948c8621518@amazon.com>
 <63288a1f-59b4-80f9-2a26-bc252ce9cd1f@efficios.com>
 <900fe19a-5642-9124-4d83-0716e0d11a22@efficios.com>
 <bb2ccac8e296450c96d0863937fc8db8@amazon.com>
 <fb397173-040c-9370-c6c7-3c7b1535becb@efficios.com>
 <618d035e059840d3a32b75633aa378f5@amazon.com>
 <e658fc7033fd4a268dc9890093de6807@amazon.com>
In-Reply-To: <e658fc7033fd4a268dc9890093de6807@amazon.com>
Subject: Re: [lttng-dev] Profiling LTTng tracepoint latency on different arm
 platforms
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

T24gOS8xMC8yMyAxMDoxOCwgTW91c2EsIEFuYXMgd3JvdGU6Cj4gSGV5IE1hdGhpZXUsCgpIaSBB
bmFzLAoKPiAKPiBXZSBzZWUgdGhhdCB1cG9uIHJlY29yZGluZyBhIHRyYWNlcG9pbnQsIHRoZXJl
IGFyZSBtdWx0aXBsZSBzdGFnZXMgb2YgCj4gcmVzZXJ2ZS1jb21taXQtd3JpdGUsIHdoZXJlIGF0
b21pY3MgYW5kIHNoYXJlZCBtZW1vcnkgYWNjZXNzZXMgdGFrZSB1cCBhIGJpZyBwYXJ0IG9mIHRo
ZSAKPiByZWNvcmRpbmcgdGltZSwKPiAKPiB3ZSdyZSB3b25kZXJpbmcsIGlzIHRoZXJlIGEgImxp
Z2h0LW1vZGUiIG9mIHJlY29yZGluZyBhIHRyYWNlcG9pbnQgCj4gaW52b2x2aW5nIGxlc3MgbG9n
aWMgb3IKPiAKPiBhIG1vZGUgd2hpY2ggY2FuIHBvdGVudGlhbGx5IGhhdmUgbG93ZXIgbGF0ZW5j
eT8KCkkndmUgYmVlbiB3b3JraW5nIG9uIHRoZSByc2VxKDIpIHN5c3RlbSBjYWxsIGZvciBhIGZl
dyB5ZWFycyBub3csIGFuZCAKdGhpcyBpcyBpbnRlbmRlZCB0byBoZWxwIHJlZHVjZSB0aGUgY29z
dCBvZiBsdHRuZy11c3QncyByaW5nIGJ1ZmZlciAKYXRvbWljcyBvbiB0aGUgdHJhY2luZyBmYXN0
LXBhdGguIFRoZSByb2FkIGFoZWFkIHRoZXJlIGlzIGludGVncmF0aW9uIG9mIApyc2VxIHdpdGgg
bHR0bmctdXN0LCB3aGljaCBkaWQgbm90IHNob3cgdXAgb24gb3VyIGN1c3RvbWVyIGZlYXR1cmUg
CnJlcXVpcmVtZW50cyByYWRhciB5ZXQuCgpJbiB0ZXJtcyBvZiBsb2dpYyBpbnZvbHZlZCBpbiB0
aGUgbHR0bmctdXN0IHRyYWNlcG9pbnRzLCBJIGhvcGUgdGhhdCBteSAKY3VycmVudCB3b3JrIG9u
ICJsaWJzaWRlIiB3aWxsIGhlbHAgc3RlZXIgYXdheSBmcm9tIHRyYWNlcG9pbnQgcHJvdmlkZXJz
IApiYXNlZCBvbiBtYWNyb3MgYW5kIGdlbmVyYXRlZCBjb2RlLCByZXBsYWNpbmcgdGhpcyBieSBh
biBlZmZpY2llbnQgCmJ5dGVjb2RlIGludGVycHJldGVyLiBUaGlzIHNob3VsZCBhbGxvdyBtZSB0
byBpbmxpbmUgbWFueSBvZiB0aGUgY2FsbHMgCnRoYXQgYXJlIGN1cnJlbnRseSBuZWVkZWQgYmV0
d2VlbiB0aGUgdHJhY2Vwb2ludCBwcm9iZSBwcm92aWRlciBhbmQgdGhlIApsdHRuZy11c3Qgcmlu
ZyBidWZmZXIuIEFnYWluLCB0aGlzIGlzIGFuIGFyZWEgd2hlcmUgSSB0aGluayB3ZSBjYW4gaGF2
ZSAKZ3JlYXQgc3BlZWQgaW1wcm92ZW1lbnRzLCBidXQgaXQgZGlkIG5vdCBzaG93IHVwIG9uIG91
ciBjdXN0b21lcidzIApmZWF0dXJlIHJlcXVpcmVtZW50IHJhZGFyIHlldC4KCj4gQWxzbywgYXJl
IHRoZXJlIGFueSByZWNlbnTCoGRvY3MgdG8gc2hhcmUgcmVnYXJkaW5nwqB0cmFjZXBvaW50IGxh
dGVuY3k/CgpUaGVyZSBpcyBhIFBvbHl0ZWNobmlxdWUgc3R1ZGVudCB3aG8gZXh0ZW5zaXZlbHkg
YW5hbHl6ZWQgdGhpcyByZWNlbnRseS4gCk1pY2hlbCwgZG8geW91IGhhdmUgYSBwb2ludGVyIHRv
IGhpcyB3b3JrID8KClRoYW5rcywKCk1hdGhpZXUKCi0tIApNYXRoaWV1IERlc25veWVycwpFZmZp
Y2lPUyBJbmMuCmh0dHBzOi8vd3d3LmVmZmljaW9zLmNvbQoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1k
ZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1h
bi9saXN0aW5mby9sdHRuZy1kZXYK
