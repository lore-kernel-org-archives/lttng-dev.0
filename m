Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E687C7EE25
	for <lttng-dev@archiver.kernel.org>; Fri,  9 Jun 2023 17:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1686331263;
	bh=beB6+z56erc80o6aDPJwW6ufleWFREjqXbLzY32P714=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=cys1M6aMsE2oClxzpw/JOtDycYGlofl3EI8NdGYWRuxhP82l7Ce5aP8zBEF0oF2a/
	 rIrYmlVc+wVnpYixEcOSRr1E5XvGUoFMYhdjt3RWAiTNdv8P1kOGh/y21QLD3Tj97E
	 rT8Epr9OF7YdMhLVJWjwWtnk8U4GkAXXQYYun6mi9HTYj4ikHk84UCP78WGo7p1mA8
	 agmdEeVBdNpNcBPo8DyfFSj4sM8H9CQ5jFRQ/WxRtaTGkaajsvFePtCaCzDlZb2eb5
	 RQK7lqmGVUmIr9wodl/rWK1PIPLryRmrCha/5CKEP0miYpuFmiYcBSRlOiPrJUSa5S
	 sz6huqlIaoyTg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Qd7CL1SP5z1ds8;
	Fri,  9 Jun 2023 13:21:02 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4Qd7CG4x7hz1ds0
 for <lttng-dev@lists.lttng.org>; Fri,  9 Jun 2023 13:20:58 -0400 (EDT)
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4Qd7C25Hp3z173L;
 Fri,  9 Jun 2023 13:20:46 -0400 (EDT)
Message-ID: <ea7e251e-2514-8f81-28e5-3c78317581c6@efficios.com>
Date: Fri, 9 Jun 2023 13:20:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: tracecompass-dev@eclipse.org, lwn@lwn.net,
 lttng-dev <lttng-dev@lists.lttng.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, linuxtools-dev@eclipse.org,
 Diamon discuss <diamon-discuss@lists.linuxfoundation.org>,
 linux-trace-users <linux-trace-users@vger.kernel.org>
Subject: [lttng-dev] Tracing Summit - Last year's 2022 talk recordings are
 available online!
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

SGVsbG8gYWxsLAoKVGhlIHJlY29yZGluZ3MgZm9yIGxhc3QgeWVhcuKAmXMgMjAyMiBUcmFjaW5n
IFN1bW1pdCB0YWxrcyB3ZXJlIGp1c3QKcG9zdGVkIHRvIHRoZSBEaWFNb24gV29ya2dyb3VwIGNo
YW5uZWwhCgoyMDIyIFRyYWNpbmcgU3VtbWl0IFRhbGtzOgpodHRwczovL3d3dy55b3V0dWJlLmNv
bS9wbGF5bGlzdD9saXN0PVBMdW80RTQ3cDVfN1lidnlCcFNIaC13TzNLVVZRODFCUVIKCklmIHlv
dSBkaWQgbm90IGdldCB0aGUgY2hhbmNlIHRvIGF0dGVuZCBsYXN0IHllYXIsIHdlIGludml0ZSB5
b3UgdG8gdGFrZQphIGxvb2sgYXQgdGhlIGRpdmVyc2UgdHJhY2luZyB0YWxrcyB0aGF0IGluY2x1
ZGVkIGVCUEYgYW5kIFBlcmZldHRvCmRldmVsb3BtZW50cyBhcyB3ZWxsIGFzIHVwZGF0ZXMgZm9y
IHRoZSBjb3JlIExpbnV4IGtlcm5lbCB0cmFjZXJzLgoKClRoaXMgeWVhciwgd2XigJlyZSBsb29r
aW5nIGZvcndhcmQgdG8gaGVhcmluZyBhYm91dCB5b3VyIG5ldyB0cmFjaW5nCmRldmVsb3BtZW50
cyBhbmQgY2hhbGxlbmdpbmcgdXNlIGNhc2VzIGF0IHRoZSAyMDIzIFRyYWNpbmcgU3VtbWl0ISBJ
Zgp5b3XigJlyZSBpbnRlcmVzdGVkIGluIGV4Y2hhbmdpbmcgaWRlYXMgd2l0aCBleHBlcnRzIGlu
IHN0YXRlLW9mLXRoZS1hcnQKdHJhY2luZywgd2UgaW52aXRlIHlvdSB0byBzdWJtaXQgYSB0YWxr
IHByb3Bvc2FsIHNvb24gYXMgdGhlIGRlYWRsaW5lIGlzCmNvbWluZyB1cCBuZXh0IHdlZWsgKEp1
bmUgMTZ0aCkuCgpZb3UgY2FuIHN1Ym1pdCB5b3VyIDIwMjMgVHJhY2luZyBTdW1taXQgdGFsayBh
YnN0cmFjdCBoZXJlOgpodHRwczovL2NmcC50cmFjaW5nc3VtbWl0Lm9yZy90czIwMjMvY2ZwCgpC
ZXN0IHJlZ2FyZHMsCgpNYXRoaWV1CgotLS0tCgpUaGUgMjAyMyBUcmFjaW5nIFN1bW1pdCB3aWxs
IGJlIGhlbGQgaW4gQmlsYmFvLCBTcGFpbiBvbiBTZXB0ZW1iZXIgMTd0aAphbmQgMTh0aCwgYXQg
dGhlIEV1c2thbGR1bmEgQ29uZmVyZW5jZSBDZW50cmUsIGNvLWxvY2F0ZWQgd2l0aCBPcGVuClNv
dXJjZSBTdW1taXQgRXVyb3BlLgoKVG8gcmVnaXN0ZXIsIHlvdSBjYW4gaW5jbHVkZSB0aGUgVHJh
Y2luZyBTdW1taXQgYXMgYW4gYWRkLW9uIHRvIHlvdXIKT3BlbiBTb3VyY2UgU3VtbWl0IHRpY2tl
dCBvciB1c2UgdGhlc2UgbGlua3MgdG8gcmVnaXN0ZXIgc29sZWx5IGZvciB0aGUKVHJhY2luZyBT
dW1taXQ6IGh0dHBzOi8vY3ZlbnQubWUvR24wbmtSIChpbi1wZXJzb24sIDgwJCksCmh0dHBzOi8v
Y3ZlbnQubWUveHl3eWxYICh2aXJ0dWFsKS4KCkZvciBtb3JlIGluZm86IGh0dHBzOi8vdHJhY2lu
Z3N1bW1pdC5vcmcvCgpUaGUgMjAyMyBUcmFjaW5nIFN1bW1pdCBpcyBzcG9uc29yZWQgYnkgRWZm
aWNpT1MgYW5kIG9yZ2FuaXplZCBieSBFcmljYQpCdWdkZW4gKEVmZmljaU9TKSwgT2xpdmllciBE
aW9uIChFZmZpY2lPUyksIGFuZCBNYXRoaWV1IERlc25veWVycwooRWZmaWNpT1MpIG9uIGJlaGFs
ZiBvZiB0aGUgTGludXggRm91bmRhdGlvbiBEaWFnbm9zdGljIGFuZCBNb25pdG9yaW5nCldvcmtn
cm91cC4KCi0tIApNYXRoaWV1IERlc25veWVycwpFZmZpY2lPUyBJbmMuCmh0dHBzOi8vd3d3LmVm
ZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6
Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
