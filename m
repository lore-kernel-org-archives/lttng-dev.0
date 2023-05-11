Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B42C77B7F
	for <lttng-dev@archiver.kernel.org>; Thu, 11 May 2023 18:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1683828811;
	bh=/JIJQCfmGLmC49ebWOm/e5hB43ohtl7AuG2btmnpYyk=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=CsLxeRuXAh4eUMnHyT49+QpGJvlFBiM8K//8W3s4CyPc0R+GyRDc8uQyoGi+nUZen
	 BpiGY4TNDx4OU3BSnhy98sZQM1dOVvCZfFNoi+KnqznCzNep9HA9+b2lUineseYJxq
	 PI3GXuT5HfV6CYCdd76W4bOE8FU8cqrOukjnw3zPmzfORoglVlpro5dQvJUncDXzGz
	 Ga7RqzHAB2K0xkcia7h0mme1Ju7JzekYEvPrhmaI/pYC/4YCnJnOjZiJfSDph45SGZ
	 FWVCtiLVdUCTPNCFWD79mxHZ2v78PSMDwqremsL2K2Z3MgI0gZpDyIWa7lppSNrss8
	 nXCXf9/J7iXjA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QHKlG3khYzSx2;
	Thu, 11 May 2023 14:13:30 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QHKlD5HPBzSwy
 for <lttng-dev@lists.lttng.org>; Thu, 11 May 2023 14:13:28 -0400 (EDT)
Received: from [172.16.0.99] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QHKkc0Mk2z12TN;
 Thu, 11 May 2023 14:12:56 -0400 (EDT)
Message-ID: <41fa4914-b519-9ff9-3659-7e4cf2d41904@efficios.com>
Date: Thu, 11 May 2023 14:13:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Brian Hutchinson <b.hutchman@gmail.com>, lttng-dev@lists.lttng.org
References: <CAFZh4h-Xsf7HGZ6A57BpuWH7CzogwV6D25vg05dOq30_MfxE0A@mail.gmail.com>
 <CAFZh4h8awEpJgAcygRY=1f7A2qK91b31HBnLBPvvueuRnquOjQ@mail.gmail.com>
In-Reply-To: <CAFZh4h8awEpJgAcygRY=1f7A2qK91b31HBnLBPvvueuRnquOjQ@mail.gmail.com>
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

T24gMjAyMy0wNS0xMSAxMjozNiwgQnJpYW4gSHV0Y2hpbnNvbiB2aWEgbHR0bmctZGV2IHdyb3Rl
Ogo+IC4uLiBtb3JlIGJhY2tncm91bmQuICBJJ3ZlIGFsd2F5cyB1c2VkIGx0dCBpbiB0aGUga2Vy
bmVsIHNvIEkgZG9uJ3QKPiBoYXZlIG11Y2ggZXhwZXJpZW5jZSB3aXRoIHRoZSB1c2VyIHNpZGUg
b2YgaXQgYW5kIGVzcGVjaWFsbHkKPiBtdWx0aS10aHJlYWRlZCwgbXVsdGktY29yZSBzbyBJJ20g
cHJvYmFibHkgbWlzc2luZyBzb21lIGZ1bmRhbWVudGFsCj4gY29uY2VwdHMgdGhhdCBJIG5lZWQg
dG8gdW5kZXJzdGFuZC4KCldoaWNoIGFyZSB0aGUgZXhhY3QgdmVyc2lvbnMgb2YgTFRUbmctVVNU
IGFuZCBMVFRuZy1Ub29scyB5b3UgYXJlIHVzaW5nIApub3cgPyAoMi4xMy5OIG9yIHdoaWNoIGdp
dCBjb21taXQgPykKClRoYW5rcywKCk1hdGhpZXUKCj4gCj4gUmVnYXJkcywKPiAKPiBCcmlhbgo+
IAo+IE9uIFRodSwgTWF5IDExLCAyMDIzIGF0IDExOjUz4oCvQU0gQnJpYW4gSHV0Y2hpbnNvbiA8
Yi5odXRjaG1hbkBnbWFpbC5jb20+IHdyb3RlOgo+Pgo+PiBIaSwKPj4KPj4gSSBwb3N0ZWQgYSB3
aGlsZSBhZ28gKHRocmVhZCAtIFVzaW5nIGx0dG5nIDIuMTEgYW5kIFVTVCBkb2Vzbid0IGFwcGVh
cgo+PiB0byB3b3JrIC0gZ2V0dGluZyBlbXB0eSB0cmFjZSBmaWxlcykgYWJvdXQgdGhpcyBwcm9i
bGVtIEknbSBoYXZpbmcKPj4gd2l0aCBnZXR0aW5nIGVtcHR5IHRyYWNlIGxvZ3MuCj4+Cj4+IEkn
dmUgc2luY2UgdXBncmFkZWQgdG8gbHR0bmcgdjIuMTMgYW5kIHdoaWxlIEkgY2FuIGRvIGEgc2lt
cGxlIGhlbGxvCj4+IHdvcmxkIHByb2dyYW0gd2l0aCB0cmFjZWYgYW5kIGdldCBldmVudHMgaW4g
dGhlIGxvZyBmaWxlcywgbXkgbW9yZQo+PiBjb21wbGljYXRlZCBsYXJnZSBtdWx0aS10aHJlYWRl
ZCBhcHAgSSdtIHRyeWluZyB0byBkZWJ1ZyBpcyBzdGlsbAo+PiBnZXR0aW5nIGVtcHR5IGxvZyBm
aWxlIHRyYWNlcy4KPj4KPj4gSSBjYW4gbGlzdCB0aGUgdXNlciBzcGFjZSBldmVudHMgaW4gbXkg
YXBwLgo+Pgo+PiBOZXh0IEkgZG86Cj4+Cj4+IGx0dG5nIGVuYWJsZS1ldmVudCAtLXVzZXJzcGFj
ZSAnbHR0bmdfdXN0X3RyYWNlZjoqJwo+Pgo+PiAuLi4gdG8gZW5hYmxlIHRoZSBldmVudHMsIHN0
YXJ0IGx0dG5nLCBzdGFydCBteSBhcHAsIC4uLi4gYW5kIEkgZ2V0IGEKPj4gdHJhY2UgZGlyZWN0
b3J5IHN0cnVjdHVyZSB0aGF0J3MgZW1wdHkuCj4+Cj4+IEkgZmVlbCBsaWtlIEkndmUgcmVhZCBl
dmVyeSB0aHJlYWQgaW4gdGhlIGFyY2hpdmVzIGFib3V0IHBlb3BsZSBoYXZpbmcKPj4gdGhlIHNh
bWUgcHJvYmxlbS4KPj4KPj4gSSBkaWQgdHJ5IHVzaW5nIExEX1BSRUxPQUQgd2l0aCB2YXJpb3Vz
IGxpYnMgdGhpbmtpbmcgdGhhdCB3YXMgdGhlCj4+IHByb2JsZW0gYnV0IHNvIGZhciBJJ20gc3Rp
bGwgZ2V0dGluZyBlbXB0eSB0cmFjZXMuCj4+Cj4+IFNvIGZhciBJJ3ZlIHRyaWVkOgo+Pgo+PiBM
RF9QUkVMT0FEPWxpYmx0dG5nLXVzdC1saWJjLXdyYXBwZXIuc28uMTpsaWJsdHRuZy11c3QtcHRo
cmVhZC13cmFwcGVyLnNvLjE6bGlibHR0bmctdXN0LWRsLnNvLjE6bGlibHR0bmctdXN0LWZvcmsu
c28uMTpsaWJsdHRuZy11c3QtZmQuc28uMQo+PiAvdXNyL2xvY2FsL2Jpbi9teV9hcHAKPj4KPj4g
SSBndWVzcyBvbmUgcXVlc3Rpb24gSSBoYXZlIGlzIGhvdyBkbyBJIGRldGVybWluZSB3aGljaCAi
aGVscGVyIGxpYnMiCj4+IEkgbmVlZCB0byBwcmVsb2FkPwo+Pgo+PiBUaGUgYXBwbGljYXRpb24g
SSdtIHdvcmtpbmcgb24gaXMgbWFkZSB1cCBvZiBhIGJ1bmNoIG9mIHNtYWxsZXIgc3RhdGljCj4+
IGxpYnMgbGlua2VkIHRvZ2V0aGVyIGludG8gb25lIGJpZyBleGVjdXRhYmxlIGFuZCB0aGF0IGlz
IGxpbmtlZCB3aXRoCj4+IC1sbHR0bmctdXN0IGFuZCAtbGRsLgo+Pgo+PiBJJ20gcHJldHR5IHN0
dWNrIGF0IHRoZSBtb21lbnQuICBBbnlvbmUgaGF2ZSBhbnkgd2lzZG9tIG9uIHdoYXQgSQo+PiBt
aWdodCBiZSBkb2luZyB3cm9uZyBvciBob3cgSSBjYW4gdGVsbCB3aHkgSSdtIG5vdCBnZXR0aW5n
IGV2ZW50cyBpbgo+PiB0aGUgbG9ncz8KPj4KPj4gVGhhbmtzLAo+Pgo+PiBCcmlhbgo+IF9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gbHR0bmctZGV2IG1h
aWxpbmcgbGlzdAo+IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKPiBodHRwczovL2xpc3RzLmx0
dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2CgotLSAKTWF0aGlldSBE
ZXNub3llcnMKRWZmaWNpT1MgSW5jLgpodHRwczovL3d3dy5lZmZpY2lvcy5jb20KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5n
IGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9j
Z2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
