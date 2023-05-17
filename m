Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0E8C77B7F
	for <lttng-dev@archiver.kernel.org>; Wed, 17 May 2023 17:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1684343870;
	bh=fUoVKmvwhotUexo3Cn1PDWlVnOj0n0oEJb6Yxm3MbyU=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=wZtuRq1DurBbdN8FsUjivjo0fArKEqBkl5Wmu/SsRQTSmaoScR9CK2Dt4SD5hNYah
	 M2wMsOQBB+VTu0KGsmf7d5DYZY6MKwyfUJiR2Crgyboeh36bwHK4Cco1CAovbQVfpq
	 RmpSR2VuNiEB7WSR2j7wabapZjrVH2WLWElvvyNN47dHj+ZH1URDPlgTEIkScKDSlQ
	 z06x/mI6B/Np5UTN+t+FOVVWfCUOBK9jZWrPCYnWD4IBefcJgce78R2mrhtmgQEr9C
	 kXRW1PpsLF36cBSRj0kSUFcmVNtkthVPIQL2f+cYGTJ7ssWvSEYfQVyp2HuZWpxooA
	 fRZO91bvaCmgA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QM0DF75knz1FlQ;
	Wed, 17 May 2023 13:17:49 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QM0DD463Vz1Fp4
 for <lttng-dev@lists.lttng.org>; Wed, 17 May 2023 13:17:48 -0400 (EDT)
Received: from [172.16.0.135] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QM0DC4GTJz12fj;
 Wed, 17 May 2023 13:17:47 -0400 (EDT)
Message-ID: <d1b67475-cddb-4759-5a96-e9f3b2e52553@efficios.com>
Date: Wed, 17 May 2023 13:17:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Brian Hutchinson <b.hutchman@gmail.com>
Cc: lttng-dev@lists.lttng.org, Olivier Dion <odion@efficios.com>
References: <CAFZh4h8C5ZVHGWsBW2iaVYi56t=SsmuiSGZPLf0KpQO9LwfeMQ@mail.gmail.com>
 <2d953bd2-6544-3357-1424-fa44731e2bf5@efficios.com>
 <CAFZh4h-Jf4eTNpPEh9=kBRXBN3JxBa_2BCBtRx0EfV_MaHZm1g@mail.gmail.com>
In-Reply-To: <CAFZh4h-Jf4eTNpPEh9=kBRXBN3JxBa_2BCBtRx0EfV_MaHZm1g@mail.gmail.com>
Subject: Re: [lttng-dev] Trying to understand use of lttng enable-event
 --kernel --userspace-probe=
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

T24gMjAyMy0wNS0xNyAxMjozNywgQnJpYW4gSHV0Y2hpbnNvbiB3cm90ZToKPiBPbiBXZWQsIE1h
eSAxNywgMjAyMyBhdCAxMjowOOKAr1BNIE1hdGhpZXUgRGVzbm95ZXJzCj4gPG1hdGhpZXUuZGVz
bm95ZXJzQGVmZmljaW9zLmNvbT4gd3JvdGU6Cj4+Cj4+IE9uIDIwMjMtMDUtMTYgMjI6MTEsIEJy
aWFuIEh1dGNoaW5zb24gdmlhIGx0dG5nLWRldiB3cm90ZToKPj4+IEhpLAo+Pj4KPj4+IEknbSB0
cnlpbmcgdG8gZmlndXJlIG91dCBob3cgdG8gdXNlIHVwcm9iZXMgd2l0aCBsdHRuZy4KPj4+Cj4+
PiBJIGNhbid0IHVzZSBhIG5vcm1hbCB1cHJvYmUgZm9yIGEgbGluZSBudW1iZXIganVzdCB1c2lu
ZyB0aGUgYWRkcmVzcyBJCj4+PiB3YW50IHRvIHByb2JlIG9idGFpbmVkIGZyb20gb2JqZHVtcD8g
IEFzIGluOgo+Pj4KPj4+IGVjaG8gJ3AgL3Vzci9sb2NhbC9iaW4vbXlfYXBwOjB4MmMzYTgnID4+
Cj4+PiAvc3lzL2tlcm5lbC9kZWJ1Zy90cmFjaW5nL3Vwcm9iZV9ldmVudHMKPj4+Cj4+PiAuLi4g
d2hpY2ggaXNuJ3QgYSBmdW5jdGlvbiBlbnRyeSwgaXQncyBqdXN0IGEgbGluZSBvZiBjb2RlIEkg
d2FudCB0byBwcm9iZSBvbi4KPj4+Cj4+PiBUaGlzIGxpbmsgc2F5cyBpdCBoYXMgdG8gYmUgZWxm
IG9yIHNkdDoKPj4+IGh0dHBzOi8vbHR0bmcub3JnL21hbi8xL2x0dG5nLWVuYWJsZS1ldmVudC92
Mi4xMS8jZG9jLW9wdC0tdXNlcnNwYWNlLXByb2JlCj4+Pgo+Pj4gU28gY2FuIEkgbm90IHByb2Jl
IG9uIGp1c3QgYSBsaW5lIG9mIGNvZGUgYnkgc3BlY2lmeWluZyBhbiBhZGRyZXNzPz8/Cj4+Pgo+
Pj4gSXQgZG9lc24ndCBsb29rIGxpa2UgdGhlc2UgbWV0aG9kcyBhYm92ZSB3aWxsIGRvIHdoYXQg
SSdtIHdhbnRpbmcgdG8KPj4+IGRvLiAgSSd2ZSB0cmllZCB0byBmaW5kIGV4YW1wbGVzIG9mIHVz
aW5nIGVuYWJsZS1ldmVudCAtLWtlcm5lbAo+Pj4gLS11c2Vyc3BhY2UtcHJvYmU9IGJ1dCB0aGVy
ZSBkb2Vzbid0IGFwcGVhciB0byBiZSBtYW55Lgo+Pj4KPj4KPj4gVGhlcmUgYXJlIGV4YW1wbGVz
IGhlcmU6Cj4+Cj4+IGh0dHBzOi8vbHR0bmcub3JnL2RvY3MvdjIuMTMvI2RvYy1lbmFibGluZy1k
aXNhYmxpbmctZXZlbnRzCj4+Cj4+IEluZGVlZCBpbnNlcnRpbmcgYSBsdHRuZy1tb2R1bGVzIHVw
cm9iZSB3aXRoaW4gZnVuY3Rpb25zIGlzIG5vdAo+PiBzdXBwb3J0ZWQgYXQgdGhlIG1vbWVudCwg
bWFpbmx5IGJlY2F1c2Ugd2UgcHJlZmVyIHRvIGVyciB0b3dhcmRzIHNhZmV0eQo+PiBhbmQgZG9u
J3QgaGF2ZSB0aGUgdmFsaWRhdGlvbiBpbiBwbGFjZSB0byBwcmV2ZW50IGNvcnJ1cHRpbmcgdGhl
Cj4+IHByb2dyYW0ncyBpbnN0cnVjdGlvbnMgaWYgYW4gZW5kIHVzZXIgd291bGQgdHJ5IHRvIGlu
c2VydCBhIHVwcm9iZSBhdCBhbgo+PiBhZGRyZXNzIHdoaWNoIGlzIG5vdCBhbiBpbnN0cnVjdGlv
biBib3VuZGFyeS4KPiAKPiBIbW0sIHdhcyByZWFsbHkgaG9waW5nIHRvIGJlIGFibGUgdG8gZG8g
ZHluYW1pYyB0cmFjaW5nIHdpdGhvdXQgaGF2aW5nCj4gdG8gbW9kaWZ5IGNvZGUuCgp1cHJvYmVz
IHdpdGggdGhlIHByb3BlciB2YWxpZGF0aW9ucyBhYm91dCBpbnN0cnVjdGlvbiBib3VuZGFyaWVz
IHdvdWxkIApldmVudHVhbGx5IHByb3ZpZGUgdGhpcy4gQW5vdGhlciBhcHByb2FjaCB3ZSB3YW50
IHRvIGludmVzdCB0aW1lIGluIGlzIAp0byBpbnRlZ3JhdGUgbGlicGF0Y2ggZnJvbSBPbGl2aWVy
IERpb24gaW50byBsdHRuZy11c3QuIFRoaXMgd291bGQgCnByb3ZpZGUgZHluYW1pYyBpbnN0cnVt
ZW50YXRpb24gd2l0aCB0aGUgcGVyZm9ybWFuY2Ugb2YgYSBwdXJlbHkgCnVzZXJzcGFjZSB0cmFj
ZXIuCgpCdXQgdGhvc2UgYXJlIGFsbCB0aGluZ3MgdGhhdCB3ZXJlIG5ldmVyIHByaW9yaXRpemVk
IGJ5IGFueSBvZiBvdXIgCmN1c3RvbWVycywgc28gdGhleSBwcm9ncmVzcyBhdCBhICJiYWNrIGJ1
cm5lciIgcGFjZS4KCj4gCj4gSSBndWVzcyBpZiBJIGFkZCBhIGZ1bmN0aW9uIGNhbGwgdG8gYSBk
ZWJ1ZyBzdGF0ZW1lbnQgb3Igc29tZXRoaW5nIGF0Cj4gdGhlIHBvaW50IEkgd2FudCB0byBwcm9i
ZSB0aGVuIEkgY291bGQgdXNlIHRoZSBlbGYgZXhhbXBsZS4KClllcy4KCj4gCj4+Cj4+IFNvIHdl
IG9ubHkgc3VwcG9ydCBpbnNlcnRpbmcgdXByb2JlIG9uIGZ1bmN0aW9ucyBhbmQgU0RUIHByb2Jl
cyBhdAo+PiB0aGUgbW9tZW50Lgo+IAo+IEkndmUgaGVhcmQgb2Ygc3lzdGVtIHRhcCBidXQgbmV2
ZXIgdXNlZCBpdC4gIFdpbGwgaGF2ZSB0byBsb29rIGludG8gdGhhdC4KPiAKPiBJIHJlYWxseSB3
YW50IHRvIGdldCBsdHRuZy11c3Qgd29ya2luZyBidXQgSSdtIGdldHRpbmcgcHVzaGJhY2sgb24g
dGhlCj4gdGltZSBJJ20gc3BlbmRpbmcgdHJ5aW5nIHRvIGdldCBpdCB0byB3b3JrIC4uLiBhbmQg
d291bGQgcmVhbGx5IGxpa2UKPiB0byBkZW1vbnN0cmF0ZSBzb21ldGhpbmcgKHdhcyBob3Bpbmcg
a2VybmVsIGV2ZW50cyBhbmQgdXByb2JlcykKPiBxdWlja2x5IHRvIGFuIGF1ZGllbmNlIHRoYXQg
a25vd3Mgbm90aGluZyBhYm91dCBsdHRuZyBvciBmdWxsIHN0YWNrCj4gdHJhY2luZyB0byBnYWlu
ICJidXkgaW4iIGZvciB0aGUgZWZmb3J0LgoKVW5kZXJzdG9vZC4KClRoZSBtYWluIHRoaW5nIHdl
IGFyZSBtaXNzaW5nIHRvIGhlbHAgeW91IG9uIHRoZSBVU1QgZnJvbnQgaXMgYSBjb25zb2xlIAps
b2cgb2YgdGhlIF9hcHBsaWNhdGlvbl8gd2l0aCBMVFROR19VU1RfREVCVUc9MS4gSSBzdXNwZWN0
IGl0IGlzIG5vdCAKY29sbGVjdGVkIGluIHlvdXIgdGVzdHMuCgpUaGFua3MsCgpNYXRoaWV1CgoK
PiAKPiBZb3Uga25vdywgdGhvc2UgcGVza3kgdGhpbmdzIGNhbGxlZCBzY2hlZHVsZXMuCj4gCj4g
VGhhbmtzLAo+IAo+IEJyaWFuCj4gCj4+Cj4+IFRoYW5rcywKPj4KPj4gTWF0aGlldQo+Pgo+Pgo+
Pj4gVGhhbmtzLAo+Pj4KPj4+IEJyaWFuCj4+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwo+Pj4gbHR0bmctZGV2IG1haWxpbmcgbGlzdAo+Pj4gbHR0bmct
ZGV2QGxpc3RzLmx0dG5nLm9yZwo+Pj4gaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9t
YWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo+Pgo+PiAtLQo+PiBNYXRoaWV1IERlc25veWVycwo+
PiBFZmZpY2lPUyBJbmMuCj4+IGh0dHBzOi8vd3d3LmVmZmljaW9zLmNvbQo+PgoKLS0gCk1hdGhp
ZXUgRGVzbm95ZXJzCkVmZmljaU9TIEluYy4KaHR0cHM6Ly93d3cuZWZmaWNpb3MuY29tCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFp
bGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5v
cmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
