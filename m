Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE94AC433EF
	for <lttng-dev@archiver.kernel.org>; Tue,  8 Mar 2022 18:31:49 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4KCkSN0M5mz9SX;
	Tue,  8 Mar 2022 13:31:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1646764308;
	bh=Vo36y9NITEREKaeVi/QgeMiYhA+5xTPLNNxw1N2u6SM=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=U4x48tPDNk9+WAsAjoilvcYbvVVY5PwDxQb//cWqK6PsEUBAvzZQ1Ep8OiwCLwaA5
	 c5CrYmf/4VFwUN5HUGEUTeAqxgF9cxas1TbDDIbTjaI0Ltll+DvTvpc7kvBYcn652y
	 MYlFpXYj6HRQVC4bKMKk7ptzPCnhLR7ILY8vX8fgG9ipOXB2FP1RrZsBgPKyulHMoQ
	 8kDqSid5wAcCgmhw+Kcp7TdhyG77coXsswD/ptssWE1Jdbzd9nYq2GXvSL+78bLnPj
	 uMvqZVJZTBInLLa/lpqqCimTeh2y6Nn7fRL69BpYgQENbr4jyaj3ZFGDeulneyya7+
	 /F9V11djp2+sg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4KCkSK521Mz9YL
 for <lttng-dev@lists.lttng.org>; Tue,  8 Mar 2022 13:31:45 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 2971C3895F2;
 Tue,  8 Mar 2022 13:31:39 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id lcS4FV1r49t5; Tue,  8 Mar 2022 13:31:38 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 884B23896F6;
 Tue,  8 Mar 2022 13:31:38 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 884B23896F6
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id n3GC8pp4EMW3; Tue,  8 Mar 2022 13:31:38 -0500 (EST)
Received: from x (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
 by mail.efficios.com (Postfix) with ESMTPSA id 5A1A83898F1;
 Tue,  8 Mar 2022 13:31:37 -0500 (EST)
Date: Tue, 8 Mar 2022 13:31:35 -0500
To: =?utf-8?B?54aK5q+T5Y2O?= <xiongyuhua@zju.edu.cn>
Message-ID: <20220308183135.GC3070796@x>
References: <662b3839.f16c8.17f6a594d6d.Coremail.xiongyuhua@zju.edu.cn>
 <38621111.130383.1646757541668.JavaMail.zimbra@efficios.com>
 <69d69d7c.eb4d6.17f6a919e20.Coremail.xiongyuhua@zju.edu.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <69d69d7c.eb4d6.17f6a919e20.Coremail.xiongyuhua@zju.edu.cn>
Subject: Re: [lttng-dev] In lttng-live mode,
 if the printing speed cannot keep up with the generation speed of
 the parsed ctf data, where will the data be stored?
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
From: Jonathan Rajotte-Julien via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, ychen@northwestern.edu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

T24gV2VkLCBNYXIgMDksIDIwMjIgYXQgMDE6MjY6NDJBTSArMDgwMCwg54aK5q+T5Y2OIHdyb3Rl
Ogo+IElmIGZvciBzb21lIHJlYXNvbiAoZm9yIGV4YW1wbGUsIGhlcmUgbXkgc29ja2V0IHNlbmQg
ZnVuY3Rpb24gaW4gcHJpbnRfbWVzc2FnZQo+IGlzIGJsb2NrZWQgYW5kIHRoZSBCYWJlbHRyYWNl
MiBtYXkgYmUgc3VzcGVuZGVkKSwgdGhlIHNwZWVkIG9mIHRoZSByZWFkZXIKPiAoYmFiZWx0cmFj
ZTIpIGNhbm5vdCBrZWVwIHVwIHdpdGggdGhlIHNwZWVkIG9mIHRoZQo+IHByb2R1Y2VyKGx0dG5n
L2x0dG5nLWNvbnN1bWVyZCksIGNhbiB0aGUgc2l6ZSBvZiB0aGlzIGJ1ZmZlcigibHR0bmctcmVs
YXlkIiApCj4gYmUgc2V0PyBIb3cgbXVjaCBkYXRhIGNhbiBpdCBzdG9yZe+8nwoKVW5sZXNzIHlv
dSBhcmUgdXNpbmcgLS10cmFjZWZpbGUtc2l6ZSBhbmQgLS10cmFjZWZpbGUtY291bnQgKG1hbiBs
dHRuZy1lbmFibGUtY2hhbm5lbCksIHRoZSBsaW1pdCBoZXJlIGlzCnRoZSBiYWNraW5nIGZpbGVz
eXN0ZW0gb2YgdGhlIGhvc3QgcnVubmluZyBsdHRuZy1yZWxheWQuCgpJIHN1Z2dlc3QgdGhhdCB5
b3UgaGF2ZSBhIGxvb2sgYXQgdGhlIG92ZXJhbGwgYXJjaGl0ZWN0dXJlIG9mIGx0dG5nIGJlZm9y
ZSBnb2luZwpmdXJ0aGVyIFsxXS4KClsxXSBodHRwczovL2x0dG5nLm9yZy9kb2NzL3YyLjEzLyNk
b2MtcGx1bWJpbmcKCkNoZWVycwoKPiAKPiBMb29raW5nIGZvcndhcmQgdG8geW91ciByZXBsee+8
gQo+IAo+IHRoeAo+IAo+IFl1aHVhCj4gCj4gCj4gCj4gCj4gLS0tLS3ljp/lp4vpgq7ku7YtLS0t
LQo+IOWPkeS7tuS6ujoiSm9uYXRoYW4gUmFqb3R0ZS1KdWxpZW4iIDxqb25hdGhhbi5yYWpvdHRl
LWp1bGllbkBlZmZpY2lvcy5jb20+Cj4g5Y+R6YCB5pe26Ze0OjIwMjItMDMtMDkgMDA6Mzk6MDEg
KOaYn+acn+S4iSkKPiDmlLbku7bkuro6ICLnhormr5PljY4iIDx4aW9uZ3l1aHVhQHpqdS5lZHUu
Y24+Cj4g5oqE6YCBOiBsdHRuZy1kZXYgPGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmc+LCAiTWF0
aGlldSBEZXNub3llcnMiIDxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+LCB5Y2hlbkBu
b3J0aHdlc3Rlcm4uZWR1Cj4g5Li76aKYOiBSZTogSW4gbHR0bmctbGl2ZSBtb2RlLCBpZiB0aGUg
cHJpbnRpbmcgc3BlZWQgY2Fubm90IGtlZXAgdXAgd2l0aCB0aGUgZ2VuZXJhdGlvbiBzcGVlZCBv
ZiB0aGUgcGFyc2VkIGN0ZiBkYXRhLCB3aGVyZSB3aWxsIHRoZSBkYXRhIGJlIHN0b3JlZD8KPiAK
PiAKPiBIaQo+IAo+IAo+IEkgd29uZGVyIGlmIG15IHNvY2tldCByZWN2IGZ1bmN0aW9uIGlzIGJs
b2NrZWQgb24gdGhlIG90aGVyIGVuZCwgY2F1c2luZyB0aGUgc29ja2V0IHNlbmQgZnVuY3Rpb24g
dG8gYmxvY2sgaW4gcHJpbnRfbWVzc2FnZSBmdW5jdGlvbiBpbiBiYWJlbHRyYWNlMjtvciB3aGVu
IHByaW50aW5nIHRvIHRoZSBjb25zb2xlLCB0aGUgcHJpbnRpbmcgc3BlZWQgY2FuJ3Qga2VlcCB1
cCB3aXRoIHRoZSBwYXJzZWQgQ1RGIGRhdGEgZ2VuZXJhdGlvbiBzcGVlZCBhbmQgdGhlIHByaW50
IGJ1ZmZlciBpcyBhbHNvIGZ1bGwuCj4gCj4gSW4gdGhpcyBjYXNlLCBob3cgd2lsbCBCYWJlbHRy
YWNlMiBoYW5kbGUgdGhlIHBhcnNlZCBDVEYgZGF0YSB0aGF0IGhhcyBub3QgYmVlbiBzZW50IHll
dCwgc3RvcmUgdGhlbSBpbiBhIGJ1ZmZlciwgYSBxdWV1ZSBvciBqdXN0IGRpc2NhcmQgdGhlbT8g
T3Igd291bGQgdGhlIGJsb2NraW5nIGRpcmVjdGx5IGNhdXNlIExUVG5nIHRvIGRpc2NhcmQgdGhl
IG9yaWdpbmFsIENURiBkYXRhIGF0IHRoZSByaW5nIGJ1ZmZlciBiZWZvcmUgTFRUbmcgQ29uc3Vt
ZXIgZGFlbW9uPwo+IAo+IAo+IAo+IE5vdCBzdXJlIEkgdW5kZXJzdGFuZCB5b3VyIHNldHVwIGJ1
dCB3aGVuIHVzaW5nIGx0dG5nLWxpdmUsIHlvdSBhcmUgZWZmZWN0aXZlbHkgcmVhZGluZyBmcm9t
IHRoZSBkYXRhIHRoYXQgbHR0bmctcmVsYXlkIGlzIGNvbGxlY3RpbmcsIHBpZWNlIGJ5IHBpZWNl
Lgo+IFRoZSBwcm9kdWNpbmcgc2lkZSBpcyBub3QgYWZmZWN0ZWQgYnkgdGhlIHNwZWVkIGF0IHdo
aWNoIHRoZSByZWFkZXIgKGJhYmVsdHJhY2UyKSBjb25zdW1lIGRhdGEgZnJvbSBsdHRuZy1yZWxh
eWQgdXNpbmcgdGhlIGx0dG5nLWxpdmUgcHJvdG9jb2wuCj4gVGhlcmUgbWlnaHQgYmUgc29tZSBj
b3JuZXIgY2FzZSBoZXJlIGFuZCB0aGVyZSBidXQgZm9yIG1vc3QgYmFzZSB1c2FnZSBvZiB0aGUg
ImxpdmUiIGZlYXR1cmUgcmVhZGVyIChiYWJlbHRyYWNlMikgYW5kIHByb2R1Y2VyKGx0dG5nL2x0
dG5nLWNvbnN1bWVyZCkKPiBhcmUgImRlY291cGxlZCIuIFlvdSBjYW4gY29uc2lkZXIgdGhlICJs
dHRuZy1yZWxheWQiIChhbmQgdGhlIHRyYWNlIG9uIHRoZSBmaWxlc3lzdGVtKSBhcyB0aGUgImJ1
ZmZlciIgaGVyZS4KCi0tIApKb25hdGhhbiBSYWpvdHRlLUp1bGllbgpFZmZpY2lPUwpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGlu
ZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcv
Y2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
