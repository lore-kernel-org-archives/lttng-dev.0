Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E7CEB64DD
	for <lttng-dev@archiver.kernel.org>; Wed, 12 Jul 2023 19:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1689190554;
	bh=vYuPOtztEm2kGdkpNzxii3W91Zpz+f3LD4Nj7v+NbLU=;
	h=Date:To:References:Cc:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=o/aXTfbDM/ireLeN32Brl7XaoQImKA6NNTwJbPOh3SIeyikJcq58GpSslqxWXKRaA
	 uVZ3VAV1Jv5SOtWZOEgwV45PBCty8GNy0QAmznI0XCn03H08Sr2miwg6/qeYOAqt/7
	 jGUn98oKYSUS4WiNqUf0UvZjUO8BuUuEhk4uqpAsnnqs7rHELHT2zLGDbwpj3MXDEC
	 qHnkG5Zj1sfOau0+8X7a9tvRsLoPpkhX1QhcS8qA57tNIgY+3OR6Mq1MXzL6xBDII/
	 KIWT5GSRPOgG4ZH7QCBTQVKuAvF9UbM1c535iXeaz5/kWiULsvEuGfOzXAekJmplvK
	 7pRI/+KhVFKRg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4R1Sdk14BQz295S;
	Wed, 12 Jul 2023 15:35:54 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4R1Sdj30Wlz29DR
 for <lttng-dev@lists.lttng.org>; Wed, 12 Jul 2023 15:35:53 -0400 (EDT)
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4R1Sdh0cxSz1HM7;
 Wed, 12 Jul 2023 15:35:52 -0400 (EDT)
Message-ID: <ebcf5f74-347a-e94f-bc27-6f9f05fc3125@efficios.com>
Date: Wed, 12 Jul 2023 15:36:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: "Uttormark, Mike" <mike.uttormark@hpe.com>
References: <SJ0PR84MB2037002FA2B1C3C0C093E6959136A@SJ0PR84MB2037.NAMPRD84.PROD.OUTLOOK.COM>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
In-Reply-To: <SJ0PR84MB2037002FA2B1C3C0C093E6959136A@SJ0PR84MB2037.NAMPRD84.PROD.OUTLOOK.COM>
Subject: Re: [lttng-dev] Status of the RCU Red Black Tree
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

T24gNy8xMi8yMyAxNDo0NCwgVXR0b3JtYXJrLCBNaWtlIHZpYSBsdHRuZy1kZXYgd3JvdGU6Cj4g
V2hhdCBiZWNhbWUgb2YgdGhlIHJlZC1ibGFjayB0cmVlIGVmZm9ydD/CoCBJIHNlZSBpdCBpbiB0
aGUgZ2l0IHJlcG8sIDEwIAo+IHllYXJzIG9sZC7CoCBJdCBuZXZlciBtYWRlIGl0IG9udG8gbWFz
dGVyLgo+IAo+IFdoYXQgd291bGQgaXQgdGFrZSB0byBnZXQgaXQgb250byBtYXN0ZXIgYW5kIGlu
dG8gYSByZWxlYXNlIGJyYW5jaD8KCkhpIE1pa2UsCgpUaGVyZSBhcmUgYSBmZXcgdGhpbmdzIHRo
YXQgYXJlIGluIHRoZSB3YXkgb2YgbWVyZ2luZyBpdCBpbnRvIGEgbGlidXJjdQpyZWxlYXNlLCBu
YW1lbHk6CgoqIEFuIGVuZCB1c2VyIHdpdGggYSBjbGVhcmx5IGRlZmluZWQgdXNlLWNhc2UgdG8g
YWxsb3cgZGVmaW5pbmcgYSBzb2xpZAogICBBUEksCgoqIFZhbGlkYXRpb24gdGhhdCB0aG9zZSB1
c2UtY2FzZXMgYXJlIG5vdCBiZXR0ZXIgY292ZXJlZCBieSBzb21lCiAgIHZhcmlhdGlvbiBvZiBt
eSBSQ1UgSnVkeSBBcnJheSBwcm90b3R5cGUgaW5zdGVhZCwgcmVmLjoKCiAgIGh0dHBzOi8vZ2l0
aHViLmNvbS91cmN1L3VzZXJzcGFjZS1yY3UvdHJlZS91cmN1L3JjdWphLXNpbXBsZS1pbnQKCiog
TW9yZSB0ZXN0aW5nLCBib3RoIHdpdGhpbiB0aGUgbGlidXJjdSBwcm9qZWN0IGFuZCBpbiB0ZXJt
cyBvZiB1c2Ugb2YKICAgdGhlIEFQSSBmcm9tIGFuIGFwcGxpY2F0aW9uIHBlcnNwZWN0aXZlLAoK
KiBGdW5kaW5nIGZvciBhbGwgdGhhdCB3b3JrLCBhbGxvd2luZyB1cyB0byBwcmlvcml0aXplIHRo
aXMgZWZmb3J0IHdpdGgKICAgcmVzcGVjdCB0byBvdXIgdmFyaW91cyBvdGhlciBwcm9qZWN0cy4K
ClRoYW5rcyBmb3IgeW91ciBpbnRlcmVzdCBpbiB0aGUgbGlidXJjdSBSZWQtQmxhY2sgVHJlZSBw
cm90b3R5cGUhIFBsZWFzZQpkb24ndCBoZXNpdGF0ZSB0byByZWFjaCBvdXQgdG8gRWZmaWNpT1Mg
aWYgSFBFIHdvdWxkIGxpa2UgdG8gZXhwbG9yZQpzdXBwb3J0aW5nIHRoaXMgcHJvamVjdC4KCk1h
dGhpZXUKCi0tIApNYXRoaWV1IERlc25veWVycwpFZmZpY2lPUyBJbmMuCmh0dHBzOi8vd3d3LmVm
ZmljaW9zLmNvbQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBz
Oi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
