Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79015C05027
	for <lttng-dev@archiver.kernel.org>; Mon,  6 Feb 2023 16:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1675701532;
	bh=ZjG6A2yVWmapjkpUCT9jrZ2/pv+YiEeHWwe2pvMGGu4=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=e7NL9n38WPClixYOxlNDChPYTffNNwGgeV9MjopadNEoEXxenKScueR9ZzgJFKg9M
	 mSBYkH5ip7XZjMbW7Ax1KqOvFg8iZ3ZdcTeq7j6Fyyhw+MJ/CSgh6+n5U91536lf2s
	 haQtp5DYzgvHj2yP1K0QYn3CSxZy6DaVY2dHWanRjTyHsFtCJeaiqBvt83Qh/JWq5g
	 aK5poM5FMCgQmJpaUSLIPh1umxobcTdblzXdFJDwky9SgYwbL/NboC7Y3D0/zVI3rC
	 m72GHgv+peN0BvlPsKmzx5O0S1On8AQGeWKbbP94y9msYQzy3P4HdrKS0Cn7pr1PmF
	 V+clxW3AJNrpw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4P9X5S1tD6z1YsP;
	Mon,  6 Feb 2023 11:38:52 -0500 (EST)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4P9X5P3Hb6z1YsL
 for <lttng-dev@lists.lttng.org>; Mon,  6 Feb 2023 11:38:49 -0500 (EST)
Received: from [10.1.0.205] (192-222-188-97.qc.cable.ebox.net [192.222.188.97])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4P9X5N6pCRzl2F;
 Mon,  6 Feb 2023 11:38:48 -0500 (EST)
Message-ID: <0a2ea00d-5ff6-ba0a-cb99-0e1d2625cfd4@efficios.com>
Date: Mon, 6 Feb 2023 11:39:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To: "Beckius, Mikael" <mikael.beckius@windriver.com>,
 "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
References: <PH0PR11MB490408B49130B7C9CB661E1A92D39@PH0PR11MB4904.namprd11.prod.outlook.com>
 <46f36a1a-c748-773b-8f6d-d481c9c8ad1b@efficios.com>
 <e525c864-a2ee-ef34-b7fd-1c114e70b081@efficios.com>
 <d1eb23d9-269f-85ea-0b7a-a3b779ffa843@efficios.com>
 <ea3518a5-e539-1616-432c-b7fe7fcada2f@efficios.com>
 <PH0PR11MB49043811E60B4E2AE3C58EBD92DA9@PH0PR11MB4904.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB49043811E60B4E2AE3C58EBD92DA9@PH0PR11MB4904.namprd11.prod.outlook.com>
Subject: Re: [lttng-dev] lttng-consumerd crash on aarch64 due to x86 arch
 specific optimization
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

SGkgTWlja2UsCgpJIGRpZCB0d2Vha3MgdG8gbWFrZSB0aGUgY29kZSBDKysgY29tcGF0aWJsZSBl
dmVuIHRob3VnaCBpdCdzIGN1cnJlbnRseSAKb25seSBidWlsdCBpbiBDLiBJdCBtYWtlcyBpdCBt
b3JlIGZ1dHVyZS1wcm9vZi4KCkkndmUgbWVyZ2VkIHRoZSByZXN1bHRpbmcgcGF0Y2ggaW50byBs
dHRuZy11c3QgCm1hc3Rlci9zdGFibGUtMi4xMy9zdGFibGUtMi4xMi4gVGhhbmtzIGZvciB0ZXN0
aW5nICEKCk1hdGhpZXUKCk9uIDIwMjMtMDItMDYgMTE6MTUsIEJlY2tpdXMsIE1pa2FlbCB3cm90
ZToKPiBIZWxsbyBNYXRoaWV1IQo+IAo+IEkgYWRkZWQgeW91ciBsYXRlc3QgaW1wbGVtZW50YXRp
b24gdG8gbXkgdGVzdCBhbmQgaXQgc2VlbXMgdG8gcGVyZm9ybSB3ZWxsIG9uIGJvdGggYXJtIGFu
ZCBhcm02NC4gU2luY2UgdGhlIHRlc3Qgd2FzIHdyaXR0ZW4gaW4gQysrIEkgaGFkIHRvIG1ha2Ug
YSBzbWFsbCBjaGFuZ2UgdG8gdGhlIGNhc3QgaW4gb3JkZXIgZm9yIHRoZSB0ZXN0IHRvIGNvbXBp
bGUuCj4gCj4gTWlja2UKPiAKPj4gLS0tLS1VcnNwcnVuZ2xpZ3QgbWVkZGVsYW5kZS0tLS0tCj4+
IEZyw6VuOiBNYXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29t
Pgo+PiBTa2lja2F0OiBkZW4gMiBmZWJydWFyaSAyMDIzIDE3OjI2Cj4+IFRpbGw6IEJlY2tpdXMs
IE1pa2FlbCA8bWlrYWVsLmJlY2tpdXNAd2luZHJpdmVyLmNvbT47IGx0dG5nLQo+PiBkZXZAbGlz
dHMubHR0bmcub3JnCj4+IMOEbW5lOiBSZTogW2x0dG5nLWRldl0gbHR0bmctY29uc3VtZXJkIGNy
YXNoIG9uIGFhcmNoNjQgZHVlIHRvIHg4NiBhcmNoCj4+IHNwZWNpZmljIG9wdGltaXphdGlvbgo+
Pgo+PiBDQVVUSU9OOiBUaGlzIGVtYWlsIGNvbWVzIGZyb20gYSBub24gV2luZCBSaXZlciBlbWFp
bCBhY2NvdW50IQo+PiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxl
c3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZAo+PiBrbm93IHRoZSBjb250ZW50IGlzIHNh
ZmUuCj4+Cj4+IEhpICBNaWthZWwsCj4+Cj4+IEkganVzdCB0cmllZCBhbm90aGVyIGFwcHJvYWNo
IHRvIGZpeCB0aGlzIGlzc3VlLCBzZWU6Cj4+Cj4+IGh0dHBzOi8vcmV2aWV3Lmx0dG5nLm9yZy9j
L2x0dG5nLXVzdC8rLzk0MTMgRml4OiB1c2UgdW5hbGlnbmVkIHBvaW50ZXIKPj4gYWNjZXNzZXMg
Zm9yIGx0dG5nX2lubGluZV9tZW1jcHkKPj4KPj4gSXQgaXMgbGVzcyBpbnRydXNpdmUgdGhhbiBv
dGhlciBhcHByb2FjaGVzLCBhbmQgZG9lcyBub3QgY2hhbmdlIHRoZSBnZW5lcmF0ZWQKPj4gY29k
ZSBvbiB0aGUKPj4gbW9zdCByZWxldmFudCBhcmNoaXRlY3R1cmVzLgo+Pgo+PiBGZWVkYmFjayBp
cyB3ZWxjb21lLAo+Pgo+PiBUaGFua3MsCj4+Cj4+IE1hdGhpZXUKPj4KPj4KPj4gLS0KPj4gTWF0
aGlldSBEZXNub3llcnMKPj4gRWZmaWNpT1MgSW5jLgo+PiBodHRwczovL3d3dy5lZmZpY2lvcy5j
b20KPiAKCi0tIApNYXRoaWV1IERlc25veWVycwpFZmZpY2lPUyBJbmMuCmh0dHBzOi8vd3d3LmVm
ZmljaW9zLmNvbQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBz
Oi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
