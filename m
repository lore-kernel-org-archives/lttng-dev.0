Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17AF9C433F5
	for <lttng-dev@archiver.kernel.org>; Thu, 20 Jan 2022 16:00:01 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4JfnJv57hrzL0n;
	Thu, 20 Jan 2022 10:59:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1642694400;
	bh=/njmP0VIQiyAe+8GtjP+xWNgPhNb4XFbR5BxSaIyCck=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Kyta8pIaVc2sFSzO58lRa4zxy+27b1DMJmardV32Ad/kmOpIRUiuFObGM9LiV6V9T
	 qM8HCvSRZ1M/IG06DooDa8CJbYczx6kgtMF0CDsI5aFUSMxThdcDerA18AI8dkoG5x
	 g0CLOStmu0FyTXZkAKQHzeQvJ1suMM3P6aBUYQQQKrcX9iOrnll91MMzUcGxhjx527
	 p9XlCQXt/Hd/WVzdq+ny1BA8qrH5q4c2b8prtsnlDBQYW/5Efd5OrJvnYy/V4LUn/h
	 RxliNQQeW4G3Y59iXvlHG3Uqp0lLAODucA+yklUqkHq2OgQXklGFQBw+9XeliAw7XI
	 HgQmh4VlIO7kA==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4JfnJt3MPlzKZW
 for <lttng-dev@lists.lttng.org>; Thu, 20 Jan 2022 10:59:58 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id DABED323A29
 for <lttng-dev@lists.lttng.org>; Thu, 20 Jan 2022 10:59:52 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id LoZhH9T2pVn2; Thu, 20 Jan 2022 10:59:52 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 7A716323A28;
 Thu, 20 Jan 2022 10:59:52 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 7A716323A28
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 3Hq6fsLVxKem; Thu, 20 Jan 2022 10:59:52 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 70A48323A26;
 Thu, 20 Jan 2022 10:59:52 -0500 (EST)
Date: Thu, 20 Jan 2022 10:59:52 -0500 (EST)
To: =?utf-8?B?5byg5paH6b6Z?= <zhangwenlong@loongson.cn>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <945744448.62503.1642694392338.JavaMail.zimbra@efficios.com>
In-Reply-To: <22bf2d37.1dde.17e75a7aeb1.Coremail.zhangwenlong@loongson.cn>
References: <22bf2d37.1dde.17e75a7aeb1.Coremail.zhangwenlong@loongson.cn>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4180 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4177)
Thread-Topic: Add support for the LOONGARCH architecture
Thread-Index: u7zYmNhIniYAn2olfpK8XdG8JX8c9Q==
Subject: Re: [lttng-dev] Add support for the LOONGARCH architecture
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.35
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

LS0tLS0gT24gSmFuIDE5LCAyMDIyLCBhdCAxMTowMyBQTSwgbHR0bmctZGV2IGx0dG5nLWRldkBs
aXN0cy5sdHRuZy5vcmcgd3JvdGU6Cgo+IEhlbGxvLCBJJ20gZXhjaXRlZCB0byBjb250cmlidXRl
IHRvIHVzZXJzcGFjZS1yY3UsIEkgYWRkZWQgbG9vbmdhcmNoCj4gYXJjaGl0ZWN0dXJlIGZvciB1
c2Vyc3BhY2UtcmN177yIIFRoZSBwYXRjaCBmaWxlIGlzCj4gMDAwMS1BZGQtc3VwcG9ydC1mb3It
dGhlLUxPT05HQVJDSC1hcmNoaXRlY3R1cmUucGF0Y2ggKQoKPiBJIGhhdmUgY29tcGlsZWQgYW5k
IHZlcmlmaWVkIGxvY2FsbHkgKHRoZSBidWlsZCBsb2cgaXMgYnVpbGRfbG9nLnR4dCApLGFuZCB0
aGVuCj4gaSBydW5lZCBtYWtlIGNoZWNr77yIIHRoZSBtYWtlIGNoZWNrIGxvZyBpcyBtYWtlX2No
ZWNrX2xvZy50eHQg77yJ77yMIG1ha2UKPiByZWd0ZXN077yIdGhlIG1ha2UgcmVndGVzdCBsb2cg
aXMgbWFrZV9yZWd0ZXN0X2xvZy50eHQg77yJIO+8jCBtYWtlIHNob3J0X2JlbmNoICh0aGUKPiBt
YWtlIHNob3J0X2JlbmNoIGxvZyBpcyBtYWtlX3Nob3J0X2JlbmNoX2xvZy50eHQgKSxtYWtlIGxv
bmdfYmVuY2godGhlIG1ha2UKPiBsb25nX2JlbmNoIGxvZyBpcyBtYWtlX2xvbmdfYmVuY2hfbG9n
LnR4dCApCgpUaGlzIGlzIGdyZWF0LCB0aGFua3MgIQoKQnkgdGhlIHdheSwgaXMgdGhlcmUgYW55
IHdheSBFZmZpY2lPUyBjb3VsZCBhZGQgdHdvIGxvb25nYXJjaCB0ZXN0IGJvYXJkcyBpbnRvCm91
ciB0ZXN0IHJhY2sgZm9yIGF1dG9tYXRlZCBDSSB0ZXN0aW5nID8gU2VlIGh0dHBzOi8vY2kubHR0
bmcub3JnCgpXZSB0eXBpY2FsbHkgZGVwbG95IGF0IGxlYXN0IHR3byBib2FyZHMgZm9yIGVhY2gg
Z2l2ZW4gYXJjaGl0ZWN0dXJlIGZvciByZWR1bmRhbmN5CmFuZCBhdmFpbGFiaWxpdHkgZm9yIGJv
dGggQ0kgYW5kIGRldmVsb3BtZW50IHVzZS4KClRoaXMgd291bGQgaGVscCBlbnN1cmluZyB3ZSBj
YXRjaCBsaWJ1cmN1IHJlZ3Jlc3Npb25zIGluIHRoZSBsb29uZ2FyY2ggYXJjaGl0ZWN0dXJlCmlu
IHRoZSBmdXR1cmUuCgpUaGFua3MsCgpNYXRoaWV1CgoKPiDmnKzpgq7ku7blj4rlhbbpmYTku7bl
kKvmnInpvpnoiq/kuK3np5HnmoTllYbkuJrnp5jlr4bkv6Hmga/vvIzku4XpmZDkuo7lj5HpgIHn
u5nkuIrpnaLlnLDlnYDkuK3liJflh7rnmoTkuKrkurrmiJbnvqTnu4TjgILnpoHmraLku7vkvZXl
hbbku5bkurrku6Xku7vkvZXlvaLlvI/kvb/nlKjvvIjljIXmi6zkvYbkuI3pmZDkuo7lhajpg6jm
iJbpg6gKPiDliIblnLDms4TpnLLjgIHlpI3liLbmiJbmlaPlj5HvvInmnKzpgq7ku7blj4rlhbbp
mYTku7bkuK3nmoTkv6Hmga/jgILlpoLmnpzmgqjplJnmlLbmnKzpgq7ku7bvvIzor7fmgqjnq4vl
jbPnlLXor53miJbpgq7ku7bpgJrnn6Xlj5Hku7bkurrlubbliKDpmaTmnKzpgq7ku7bjgIIKPiBU
aGlzIGVtYWlsIGFuZCBpdHMgYXR0YWNobWVudHMgY29udGFpbiBjb25maWRlbnRpYWwgaW5mb3Jt
YXRpb24gZnJvbSBMb29uZ3Nvbgo+IFRlY2hub2xvZ3kgLCB3aGljaCBpcyBpbnRlbmRlZCBvbmx5
IGZvciB0aGUgcGVyc29uIG9yIGVudGl0eSB3aG9zZSBhZGRyZXNzIGlzCj4gbGlzdGVkIGFib3Zl
LiBBbnkgdXNlIG9mIHRoZSBpbmZvcm1hdGlvbiBjb250YWluZWQgaGVyZWluIGluIGFueSB3YXkK
PiAoaW5jbHVkaW5nLCBidXQgbm90IGxpbWl0ZWQgdG8sIHRvdGFsIG9yIHBhcnRpYWwgZGlzY2xv
c3VyZSwgcmVwcm9kdWN0aW9uIG9yCj4gZGlzc2VtaW5hdGlvbikgYnkgcGVyc29ucyBvdGhlciB0
aGFuIHRoZSBpbnRlbmRlZCByZWNpcGllbnQocykgaXMgcHJvaGliaXRlZC4KPiBJZiB5b3UgcmVj
ZWl2ZSB0aGlzIGVtYWlsIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgYnkgcGhv
bmUgb3IgZW1haWwKPiBpbW1lZGlhdGVseSBhbmQgZGVsZXRlIGl0Lgo+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gbHR0bmctZGV2IG1haWxpbmcgbGlz
dAo+IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKPiBodHRwczovL2xpc3RzLmx0dG5nLm9yZy9j
Z2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Ci0tIApNYXRoaWV1IERlc25veWVycwpF
ZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmct
ZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxt
YW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
