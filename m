Return-Path: <SRS0=ItRG=GP=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F7DC433DB
	for <lttng-dev@archiver.kernel.org>; Tue, 12 Jan 2021 18:51:28 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4764422C9F
	for <lttng-dev@archiver.kernel.org>; Tue, 12 Jan 2021 18:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4764422C9F
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4DFfms2z7qzQCn;
	Tue, 12 Jan 2021 13:51:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1610477485;
	bh=9Ok65GL0o8yoePdcSiLu2yWeJMaZCdBfhpWv4TLOhIM=;
	h=To:Cc:References:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=QuhqLjoYBSCfefVCg66OX9/89O+hxmtFe1KL2qAzhNnroTWOZqOLy5FrHGt2NXhCm
	 u6iLVhg9Qhjy9siaI4c9k3tGddSOThh1tZBpniZYA5H10K3h+ISBWBPR+dHxKkq0xN
	 +T6WzrQZL/y5dZ8A10B23bdGvq3Quu4VcaMBAsRjLSv/2TGFHT41Y7p26MHr5mWLzS
	 PK1OIl8CfOB30TT4Yhqlt6LSdaI6GuJX3BKRUcM93fXz0G0AcDOVz+P+YUQD4PjHMj
	 hyHv5HFq6ZlnCdoCZZpqjpspIGOYnT9EEdcbDWj+INamC4XL/kmRSJEOPvNmkucquq
	 LDAT8Thrzts1A==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4DFfmr37CNzQCl
 for <lttng-dev@lists.lttng.org>; Tue, 12 Jan 2021 13:51:24 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 19AF027BC2F
 for <lttng-dev@lists.lttng.org>; Tue, 12 Jan 2021 13:51:24 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id tn1cDqIPmXLN; Tue, 12 Jan 2021 13:51:23 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id D9A0327BC28;
 Tue, 12 Jan 2021 13:51:23 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D9A0327BC28
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id fQP6iyuFgFFe; Tue, 12 Jan 2021 13:51:23 -0500 (EST)
Received: from [10.10.0.241] (96-127-212-112.qc.cable.ebox.net
 [96.127.212.112])
 by mail.efficios.com (Postfix) with ESMTPSA id AC2D827BC27;
 Tue, 12 Jan 2021 13:51:23 -0500 (EST)
To: Mohammad Kavousi <kavousi@u.northwestern.edu>
Cc: lttng-dev@lists.lttng.org, Yan Chen <ychen@northwestern.edu>,
 Xutong Chen <XutongChen2021@u.northwestern.edu>
References: <CAK7B4KePHyJFCwAczqcqz+05Ts8AVm0Xh9f4hwSBKaVhQLz8cw@mail.gmail.com>
 <977d5fa1-ff33-f99e-5be9-7c53ff6adfc4@efficios.com>
 <CAK7B4KfwwC6UbuBTzJSqTHiyuDxgjAPRryYYq7vLRJSWs=2W0g@mail.gmail.com>
 <f13d262c-560a-849e-c3f2-0c0d6e67e27b@efficios.com>
 <CAK7B4Kc9bED7q9_6HsCqLT1dhJEjjNY93cspZ7Nb_Ztpn+=ERg@mail.gmail.com>
Message-ID: <869ac606-375e-b15c-9eec-6501865b5c52@efficios.com>
Date: Tue, 12 Jan 2021 13:51:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAK7B4Kc9bED7q9_6HsCqLT1dhJEjjNY93cspZ7Nb_Ztpn+=ERg@mail.gmail.com>
Content-Language: en-US
Subject: Re: [lttng-dev] LTTng Support for Mount Namespace
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
From: Michael Jeanson via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Michael Jeanson <mjeanson@efficios.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

T24gMjAyMS0wMS0xMiAxMiBoIDI5LCBNb2hhbW1hZCBLYXZvdXNpIHdyb3RlOgo+IFRoYW5rcyBh
Z2FpbiBmb3IgeW91ciByZXBseSwKPiAKPiBUbyBiZSBzcGVjaWZpYywgSSBkaWQgZXhhY3RseSB0
aGlzOgo+IAo+IC0gSW5zdGFsbCBsaW51eCBzb3VyY2UgY29kZSwgdGhlbiBjb3B5IHRoZSBtZW50
aW9uZWQgZmlsZSB0byB0aGUgZm9sZGVyIAo+IHVzaW5nOsKgY3AgCj4gL3Vzci9zcmMvbGludXgt
aGVhZGVycy01LjQuMC01OS9mcy9tb3VudC5owqAvbGliL21vZHVsZXMvJCh1bmFtZSAtcikvYnVp
bGQKClRoZSBwYXRoIHRvIHRoZSBoZWFkZXIgaGFzIHRvIHN0YXkgdGhlIHNhbWUsIHNvIHlvdSB3
b3VsZCBuZWVkIHRvIGNvcHkgCml0IHRvICcvbGliL21vZHVsZXMvJCh1bmFtZSAtcikvYnVpbGQv
ZnMnLgoKVGhlIHJlc3Qgb2YgdGhlIHN0ZXBzIHNlZW0gZmluZS4KCk9uZSB0aGluZyB5b3UgY2Fu
IGRvIGlmIGl0IHN0aWxsIGRvZXNuJ3Qgd29yaywgaXMgbW9kaWZ5ICdNYWtlZmlsZScgYW5kIAon
S2J1aWxkLmNvbW1vbicgaW4gdGhlIGx0dG5nLW1vZHVsZXMgc291cmNlIGRpcmVjdG9yeSBhbmQg
cmVtb3ZlIHRoZSAKY29uZGl0aW9ucyBvbiAnbW50X25zX2RlcCcuIFRoYXQgd291bGQgbWFrZSB0
aGUgYnVpbGQgZmFpbCB3aGVuIAonZnMvbW91bnQuaCcgaXNuJ3QgZm91bmQgYW5kIG1heSBoZWxw
IHlvdSBmaW5kIHRoZSBjYXVzZS4KCj4gCj4gLSBSdW4gc3VkbyBka21zIGF1dG9pbnN0YWxsIChJ
IGFsc28gZGlkIHJlYm9vdCkKPiAKPiAtIENyZWF0ZSB0aGUgc2Vzc2lvbiBhbmQgYXR0ZW1wdCB0
byBhZGQgdGhlIGNvbnRleHQKPiAKPiBIb3dldmVyLCBJJ20gZ2V0dGluZyB0aGUgc2FtZSBlcnJv
ci4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmct
ZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMu
bHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
