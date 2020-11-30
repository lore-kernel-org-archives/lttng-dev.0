Return-Path: <SRS0=mbMi=FE=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A6FC64E7B
	for <lttng-dev@archiver.kernel.org>; Mon, 30 Nov 2020 14:24:50 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F88D2084C
	for <lttng-dev@archiver.kernel.org>; Mon, 30 Nov 2020 14:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="mr6FGDOA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F88D2084C
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Cl6v24vp0z1Qwm;
	Mon, 30 Nov 2020 09:24:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1606746287;
	bh=fcXCdseRh/1fqDhnMTdk1UPg72r9Vaz+xvjTb3PIn+g=;
	h=Date:To:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=mr6FGDOAGe8MBnQUQGHuMxkA3XxON9xRClDdI22lsOMrTEJnx9dA1uyPYU1wdNBOn
	 Ru8SHW7VJ5SQKxm5SJSNX8cBKuss9kzmrcunUYoi3FG2SDvQ4ry2E84trnC/6zH8Rx
	 RuOVsUIlgC3nYYg+0yZgNTMkCY5zoEgT0usBjcvkJbYGFWPpX1VDC0daG/8Veluo+J
	 LbP9Y3BJKOmt/b8cahhPXf3qFarqLFDLQ3SqbR1tPxsR8c0RsTnc205eD3XtVB6QUF
	 9vQBqC3lxPg3HANNbRUqUzJYkls3MAonNn6UpYFAdmW7cJKZYuj93ezosmAfvfUb1S
	 X17p850Iu6wBg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4Cl6v14ZSpz1Qyc
 for <lttng-dev@lists.lttng.org>; Mon, 30 Nov 2020 09:24:45 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5F0302E7199;
 Mon, 30 Nov 2020 09:24:39 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id DVQdJiIrhxUA; Mon, 30 Nov 2020 09:24:39 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id EB1B82E7198;
 Mon, 30 Nov 2020 09:24:38 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com EB1B82E7198
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 0591n7wRCfys; Mon, 30 Nov 2020 09:24:38 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id DC8742E70A8;
 Mon, 30 Nov 2020 09:24:38 -0500 (EST)
Date: Mon, 30 Nov 2020 09:24:38 -0500 (EST)
To: =?utf-8?B?54aK5q+T5Y2O?= <xiongyuhua@zju.edu.cn>
Message-ID: <1970789645.67635.1606746278786.JavaMail.zimbra@efficios.com>
In-Reply-To: <2cade259.4f3f.1760d9d1b84.Coremail.xiongyuhua@zju.edu.cn>
References: <40a80cf.2b99.176086d97b1.Coremail.xiongyuhua@zju.edu.cn>
 <20201127140548.GB3947@joraj-alpa>
 <25e54ac4.4261.1760a553e88.Coremail.xiongyuhua@zju.edu.cn>
 <828264314.65604.1606493063962.JavaMail.zimbra@efficios.com>
 <2cade259.4f3f.1760d9d1b84.Coremail.xiongyuhua@zju.edu.cn>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3975 (ZimbraWebClient - FF83 (Linux)/8.8.15_GA_3975)
Thread-Topic: Some confusion about cpu usage of the lttng-consumerd process
Thread-Index: kQyIG0g8sE1DsImWJtzGcb+yTIWRrw==
Subject: Re: [lttng-dev] Some confusion about cpu usage of the
 lttng-consumerd process
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

LS0tLS0gT24gTm92IDI4LCAyMDIwLCBhdCAxOjQ5IEFNLCDnhormr5PljY4geGlvbmd5dWh1YUB6
anUuZWR1LmNuIHdyb3RlOgoKPiBIaSwKCj4gSSBwdXQgbXkgdGVzdCBzY3JpcHRzIGluIHRoZSBh
dHRhY2htZW50LgoKPiBZb3UgY2FuIGp1c3QgcnVuIHRoZSBzY3JpcHQgZGlyZWN0bHksIGNyZWF0
ZSB0aGUgdHJhY2Ugc2Vzc2lvbiB3aXRoIHRoZSAiLS1saXZlIgo+IG9wdGlvbiBvbiB0aGUgOGNv
cmUgc2VydmVyLAoKPiB0aGVuIHlvdSB3aWxsIGZpbmQgdGhlIGNwdSB1c2FnZSBvZiB0aGUgbHR0
bmctY29uc3VtZXJkIHByb2Nlc3MgcmVhY2hlZCAxMCUgb3IKPiBtb3JlLgoKPiBBYm91dCB0aGUg
c3RyZWFtaW5nIG1vZGUgb2YgbHR0bmcsSSBkaWQgdGhlIHRlc3QgYmVmb3JlLCBpdCB3b3JrZWQg
d2VsbC4KCj4gV2hlbiBJIGNyZWF0ZSB0aGUgdHJhY2Ugc2Vzc2lvbiB3aXRoICJsdHRuZyBjcmVh
dGUgbXktc2Vzc2lvbgo+IC0tb3V0cHV0PS90bXAvbXkta2VybmVsLXRyYWNlIiwgb3Igd2l0aCAi
bHR0bmcgY3JlYXRlIG15LXNlc3Npb24KPiAtLXNldC11cmw9bmV0Oi8vaXAiLAoKPiB0aGUgbnVt
YmVyIG9mIENQVSBzZWVtcyBub3QgYWZmZWN0IHRoZSBjcHUgdXNhZ2Ugd2l0aCBsdHRuZy1jb25z
dW1lcmQuCgo+IEl0IHNlZW1zIHRoYXQgb25seSBsaXZlLW1vZGUgd2lsbCBiZSBhZmZlY3RlZC4K
ClRoZSBvdmVyaGVhZCBvZiBjb25zdW1lciBkYWVtb24gaW4gbGl2ZSBtb2RlIHdpbGwgaW5jcmVh
c2Ugd2l0aCB0aGUgbnVtYmVyCm9mIGNwdXMgb24gdGhlIHN5c3RlbS4gVGhpcyBpcyBleHBlY3Rl
ZC4KClRoZXJlIGlzIG9uZSBrbm9iIHlvdSBjYW4gdHJ5IHRvIGNvbmZpZ3VyZSB0byBhZGFwdCB0
aGUgYW1vdW50IG9mIG92ZXJoZWFkCmNhdXNlZCBieSB0aGUgbGl2ZSB0aW1lciBpbiB0aGUgY29u
c3VtZXIgZGFlbW9uOiBsdHRuZyBjcmVhdGUgLS1saXZlPU5OTgp3aGVyZSBOTk4gaXMgdGhlIGxp
dmUgdGltZXIgcGVyaW9kIGluIG1pY3Jvc2Vjb25kcy4gVGhlIGRlZmF1bHQgaXMgMTAwMDAwMHVz
CigxIHNlY29uZCkuIFRyeSBjaGFuZ2luZyB0aGlzIHZhbHVlIHRvIHNvbWV0aGluZyBsYXJnZXIg
YW5kIHlvdSB3aWxsCnByb2JhYmx5IG5vdGljZSB0aGF0IGl0IGxlc3NlbiB0aGUgY29uc3VtZXIg
ZGFlbW9uIG92ZXJoZWFkLgoKU2hpcHBpbmcgdHJhY2UgZGF0YSB3aXRoIHJlbGF0aXZlbHkgbG93
IGxhdGVuY3kgc28gaXQgY2FuIGJlIGltbWVkaWF0ZWx5CnJlYWQgYWRkcyBvdmVyaGVhZCwgYW5k
IGl0IGluY3JlYXNlcyB3aXRoIHRoZSBudW1iZXIgb2YgY3B1cyBpbiB0aGUgc3lzdGVtCmJlY2F1
c2UgdGhlcmUgYXJlIHRoZW4gbW9yZSBwZXItY3B1IGJ1ZmZlcnMgdG8gZmx1c2guCgpOb3RlIHRo
YXQgeW91ciBpbnN0cnVtZW50YXRpb24gYWxzbyB0YXJnZXRzIHVucmVsYXRlZCBrZXJuZWwgYW5k
IHVzZXItc3BhY2UKZXhlY3V0aW9uLCBzbyB3aGF0ZXZlciBpcyBleGVjdXRlZCBpbiB0aGUgYmFj
a2dyb3VuZCBhbHNvIGdldHMgdHJhY2VkLiBBbmQKdGhpcyBnZW5lcmF0ZSB0cmFjZSBkYXRhIHRy
YWZmaWMgb24gZWFjaCBjcHUuIEhhdmluZyBldmVuIGp1c3QgYSBiaXQgb2YKdHJhY2UgZGF0YSB0
byBzZW5kIG91dCBpbiBsaXZlIG1vZGUgY2FuIHZlcnkgbXVjaCBleHBsYWluIHRoZSBvdmVyaGVh
ZCB5b3UKb2JzZXJ2ZSB3aXRoIHRoZSBsdHRuZyBjb25zdW1lciBkYWVtb24uCgpJZiB5b3UgY2Fy
ZSB0aGF0IG11Y2ggYWJvdXQgb3ZlcmhlYWQgb2YgdGhlIGNvbnN1bWVyIGRhZW1vbiwgZG9uJ3Qg
dXNlIGxpdmUKbW9kZSwgYW5kIHVzZSB0aGUgYWx0ZXJuYXRpdmVzIHdlIGRpc2N1c3NlZCBlYXJs
aWVyIGluc3RlYWQsIHN1Y2ggYXMgdGhlCnNlc3Npb24gcm90YXRpb24gbW9kZSwgaWYgeW91IG5l
ZWQgdG8gY29uc3VtZSB0aGUgdHJhY2UgZGF0YSB3aGlsZSBpdCBpcwpwcm9kdWNlZC4KClRoYW5r
cywKCk1hdGhpZXUKCi0tIApNYXRoaWV1IERlc25veWVycwpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93
d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpo
dHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2
Cg==
