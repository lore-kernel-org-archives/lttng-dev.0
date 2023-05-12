Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C959C77B7F
	for <lttng-dev@archiver.kernel.org>; Fri, 12 May 2023 13:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1683898479;
	bh=g/SYoExgsbzYu1FKxjlU7CwY+5FB6/hQBh1fielVON0=;
	h=Date:To:References:Cc:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=tjkBpbT6SuMObOFgvvemiM9BVb3o33fHxUdpXAhzoTEvi4FbImYcjcpJLA5Sgcrjx
	 P77qznojpEqe+hCqtH9Jss7tXrmf0Tf2js25adHaDp6hR67bwxEohENKpYqnhBS2K6
	 e3JJKjExWerwKY/turX1H7KL5BqTJUeGsRUOx2q0PnH7C/9VGZqUNHbkH2510W0dhR
	 aRyq7WtLKnnftnN1HCEj4ECFMuY74Y0TviBAskUccidd/2vHqRLwTQpB3PQVyKLJBT
	 Kwaxav0617m0Viy6W18UO5/t9UdPHQzQEUeuwtNIny1cSih+0vF+IBgZTIc9pSNxIf
	 P19v9BXnk19Lw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QHqW2411MzSy1;
	Fri, 12 May 2023 09:34:38 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QHqVz3YmszT1f
 for <lttng-dev@lists.lttng.org>; Fri, 12 May 2023 09:34:25 -0400 (EDT)
Received: from [172.16.0.99] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QHqVf4yGDz12d2;
 Fri, 12 May 2023 09:34:18 -0400 (EDT)
Message-ID: <ff477fe6-3d65-5845-cfb7-ea8092508e8a@efficios.com>
Date: Fri, 12 May 2023 09:34:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Brian Hutchinson <b.hutchman@gmail.com>
References: <CAFZh4h-Xsf7HGZ6A57BpuWH7CzogwV6D25vg05dOq30_MfxE0A@mail.gmail.com>
 <CAFZh4h8awEpJgAcygRY=1f7A2qK91b31HBnLBPvvueuRnquOjQ@mail.gmail.com>
 <41fa4914-b519-9ff9-3659-7e4cf2d41904@efficios.com>
 <91d1c0ca-af15-2972-da1e-8f07a148158b@efficios.com>
 <CAFZh4h9M0eA1SpHhfquoyrqtwRhHV54f0O4hCkkiojwUmPTC9Q@mail.gmail.com>
 <fdbcfbd9-742d-dc61-3667-48a00130d6aa@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
In-Reply-To: <fdbcfbd9-742d-dc61-3667-48a00130d6aa@efficios.com>
Subject: Re: [lttng-dev] I'm still getting empty ust traces using tracef
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

W2FkZGluZyBiYWNrIHRoZSBtYWlsaW5nIGxpc3RdCgpPbiAyMDIzLTA1LTEyIDA5OjMzLCBNYXRo
aWV1IERlc25veWVycyB3cm90ZToKPiBPbiAyMDIzLTA1LTEyIDAwOjEwLCBCcmlhbiBIdXRjaGlu
c29uIHdyb3RlOgo+PiBIbW0sIEkgbWlzc2VkIHRoaXMgZWFybGllciBzb21laG93Lgo+Pgo+PiBT
bywgSSdtIG5vdCB0aGUgZ3JlYXRlc3QgYXQgdXBkYXRpbmcgT0UgYW5kIFlvY3RvIHJlY2lwZXMu
wqAgSSdtCj4+IGN1cnJlbnRseSB1c2luZyB0aGlzIHJlY2lwZToKPj4gaHR0cDovL2NnaXQub3Bl
bmVtYmVkZGVkLm9yZy9vcGVuZW1iZWRkZWQtY29yZS90cmVlL21ldGEvcmVjaXBlcy1rZXJuZWwv
bHR0bmcvbHR0bmctdXN0XzIuMTMuNS5iYj9oPW1hc3Rlcgo+Pgo+PiAuLi4gYW5kIGl0IGxvb2tz
IGxpa2UgdGhlIGNvbW1pdCB5b3UgYXJlIHRhbGtpbmcgYWJvdXQgaXMgbmV3ZXIuCj4+Cj4+IEkg
YWx3YXlzIHRoaW5rLCBvaCwgSSdsbCBqdXN0IHVwZGF0ZSB0aGUgc291cmNlIFVSSSBpbiB0aGUg
cmVjaXBlIGJ1dAo+PiBpdCdzIG5ldmVyIHRoYXQgc2ltcGxlIC4uLiBhbmQgdGhlcmUgYXJlIHBh
dGNoZXMgaW4gdGhlIHJlY2lwZSBldGMuCj4+Cj4+IEkndmUgZ290IGEgc2RrIChleHRlcm5hbCB0
b29sY2hhaW4pIGJ1aWx0IGZvciBteSBlbWJlZGRlZCBwbGF0Zm9ybS4KPj4gV291bGQgaXQgYmUg
dG9vIGhhcmQgdG8ganVzdCBkb3dubG9hZCBzdGFibGUtMi4xMyBvZiBldmVyeXRoaW5nIGFuZAo+
PiBjcm9zcyBjb21waWxlIGl0IG91dHNpZGUgb2YgWW9jdG8/Cj4+Cj4+IFdoYXQgZG8geW91IHN1
Z2dlc3Q/Cj4+Cj4+IEFuZCBkbyBJIG5lZWQgdG8gZG8gYW55dGhpbmcgYmVzaWRlcyBqdXN0IGdl
dCAyLjEzIHN0YWJsZSB3b3JraW5nP8KgIEkKPj4gd2FzIGtpbmQgb2YgY29uZnVzZWQgaWYgSSBu
ZWVkIHRvIHB1dCBhICNkZWZpbmUKPj4gTFRUTkdfVFJBQ0VQT0lOVF9ERUZJTkUgc29tZXdoZXJl
IGluIG15IGNvZGUuwqAgSSdtIG5vdCB1c2luZyBhCj4+IHRyYWNlcG9pbnQgcHJvdmlkZXIgcGFj
a2FnZXMgYXQgdGhpcyBwb2ludAo+IAo+IEhpIEJyaWFuLAo+IAo+IFlvdSBtaWdodCB3YW50IHRv
IHByb3ZpZGUgYSB0cmltbWVkLWRvd24gcmVwcm9kdWNlciBvZiB5b3VyIGlzc3VlOiAKPiBleGFt
cGxlIC5jIGNvbXBpbGUgdW5pdCBpbnN0cnVtZW50ZWQgd2l0aCB0cmFjZXBvaW50cywgZXhhbXBs
ZSAuYyAKPiBjb21waWxlIHVuaXQgY29udGFpbmluZyB0aGUgdHJhY2Vwb2ludCBwcm9iZXMsIGFu
ZCB0aGUgbG9nIG9mIHRoZSAKPiBjb25zb2xlIHdoZW4gdGhpcyBhcHBsaWNhdGlvbiBpcyBydW4g
d2l0aCBMVFROR19VU1RfREVCVUc9MS4KPiAKCgo+IFRoYW5rcywKPiAKPiBNYXRoaWV1Cj4gCgot
LSAKTWF0aGlldSBEZXNub3llcnMKRWZmaWNpT1MgSW5jLgpodHRwczovL3d3dy5lZmZpY2lvcy5j
b20KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5n
LWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3Rz
Lmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
