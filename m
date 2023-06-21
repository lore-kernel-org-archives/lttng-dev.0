Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C432EB64D7
	for <lttng-dev@archiver.kernel.org>; Wed, 21 Jun 2023 20:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1687378895;
	bh=qN27AMbI+O8wUHgzAtwm8UGuK0hDnWXNwy3y6b88CMk=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=jXG6YjTqjGt8/rHsiw6YfZHjHjT2Mj/EHfTcBFPD6HwSk3oyXzRKCOglSI6hK4sYl
	 BhXSohzXU5zWVC54E8vEKQbPYLxlTaiVfM2CnbVNy40tSvx7nCNI0YY836s6TlfBGp
	 Z4yRUOVib7KPqNNUp+YMuldhfnReCFk7HSih29b2OqPjHG4faN1dcZ4P8CON25cNTh
	 bvYsUseFlJ4bi549hovbYJL+JbFwAvdObsb7aDJrZPa35RggMvz+4VhF/0Wzegk/uu
	 rp8TXHu4rjaIkXTEHA+7dX8A6zGvur1C1eMp1L1arktIWEOaIvRVZuJnskPDEUGZ9q
	 PtwU2Q0lqCCnA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QmZf62n9kz203c;
	Wed, 21 Jun 2023 16:21:34 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QmZf26qqpz203b
 for <lttng-dev@lists.lttng.org>; Wed, 21 Jun 2023 16:21:30 -0400 (EDT)
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QmZf10fkjz199l;
 Wed, 21 Jun 2023 16:21:29 -0400 (EDT)
Message-ID: <6938a214-8858-6805-f508-924ef3bdc17f@efficios.com>
Date: Wed, 21 Jun 2023 16:21:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: Brian Hutchinson <b.hutchman@gmail.com>
Cc: lttng-dev@lists.lttng.org
References: <CAFZh4h-Xsf7HGZ6A57BpuWH7CzogwV6D25vg05dOq30_MfxE0A@mail.gmail.com>
 <CAFZh4h8awEpJgAcygRY=1f7A2qK91b31HBnLBPvvueuRnquOjQ@mail.gmail.com>
 <41fa4914-b519-9ff9-3659-7e4cf2d41904@efficios.com>
 <91d1c0ca-af15-2972-da1e-8f07a148158b@efficios.com>
 <CAFZh4h-MPXsqHETtYGv2LqMgvt_me33eGSU-UhhZQxmjMEUTig@mail.gmail.com>
In-Reply-To: <CAFZh4h-MPXsqHETtYGv2LqMgvt_me33eGSU-UhhZQxmjMEUTig@mail.gmail.com>
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

T24gNi8yMC8yMyAxODowMiwgQnJpYW4gSHV0Y2hpbnNvbiB3cm90ZToKPiBPbiBUaHUsIE1heSAx
MSwgMjAyMyBhdCAyOjE04oCvUE0gTWF0aGlldSBEZXNub3llcnMKPiA8bWF0aGlldS5kZXNub3ll
cnNAZWZmaWNpb3MuY29tPiB3cm90ZToKPj4KPj4gT24gMjAyMy0wNS0xMSAxNDoxMywgTWF0aGll
dSBEZXNub3llcnMgdmlhIGx0dG5nLWRldiB3cm90ZToKPj4+IE9uIDIwMjMtMDUtMTEgMTI6MzYs
IEJyaWFuIEh1dGNoaW5zb24gdmlhIGx0dG5nLWRldiB3cm90ZToKPj4+PiAuLi4gbW9yZSBiYWNr
Z3JvdW5kLiAgSSd2ZSBhbHdheXMgdXNlZCBsdHQgaW4gdGhlIGtlcm5lbCBzbyBJIGRvbid0Cj4+
Pj4gaGF2ZSBtdWNoIGV4cGVyaWVuY2Ugd2l0aCB0aGUgdXNlciBzaWRlIG9mIGl0IGFuZCBlc3Bl
Y2lhbGx5Cj4+Pj4gbXVsdGktdGhyZWFkZWQsIG11bHRpLWNvcmUgc28gSSdtIHByb2JhYmx5IG1p
c3Npbmcgc29tZSBmdW5kYW1lbnRhbAo+Pj4+IGNvbmNlcHRzIHRoYXQgSSBuZWVkIHRvIHVuZGVy
c3RhbmQuCj4+Pgo+Pj4gV2hpY2ggYXJlIHRoZSBleGFjdCB2ZXJzaW9ucyBvZiBMVFRuZy1VU1Qg
YW5kIExUVG5nLVRvb2xzIHlvdSBhcmUgdXNpbmcKPj4+IG5vdyA/ICgyLjEzLk4gb3Igd2hpY2gg
Z2l0IGNvbW1pdCA/KQo+Pj4KPj4KPj4gQWxzbywgY2FuIHlvdSB0cnkgdXNpbmcgbHR0bmctdXN0
IHN0YWJsZS0yLjEzIGJyYW5jaCwgd2hpY2ggaW5jbHVkZXMgdGhlIGZvbGxvd2luZyBjb21taXQg
Pwo+Pgo+PiBjb21taXQgYmUyY2E4YjU2M2JhYjgxYmUxNWNiY2U3YjlmNTI0MjIzNjlmNzlmNwo+
PiBBdXRob3I6IE1hdGhpZXUgRGVzbm95ZXJzIDxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5j
b20+Cj4+IERhdGU6ICAgVHVlIEZlYiAyMSAxNDoyOTo0OSAyMDIzIC0wNTAwCj4+Cj4+ICAgICAg
IEZpeDogUmVldmFsdWF0ZSBMVFROR19VU1RfVFJBQ0VQT0lOVF9ERUZJTkUgZWFjaCB0aW1lIHRy
YWNlcG9pbnQuaCBpcyBpbmNsdWRlZAo+Pgo+PiAgICAgICBGaXggaXNzdWVzIHdpdGggbWlzc2lu
ZyBzeW1ib2xzIGluIHVzZS1jYXNlcyB3aGVyZSB0cmFjZWYuaCBpcyBpbmNsdWRlZAo+PiAgICAg
ICBiZWZvcmUgZGVmaW5pbmcgTFRUTkdfVVNUX1RSQUNFUE9JTlRfREVGSU5FLCBlLmcuOgo+Pgo+
PiAgICAgICAgI2luY2x1ZGUgPGx0dG5nL3RyYWNlZi5oPgo+PiAgICAgICAgI2RlZmluZSBMVFRO
R19VU1RfVFJBQ0VQT0lOVF9ERUZJTkUKPj4gICAgICAgICNpbmNsdWRlIDxwcm92aWRlci5oPgo+
Pgo+PiAgICAgICBJdCBpcyBjYXVzZWQgYnkgdGhlIGZhY3QgdGhhdCB0cmFjZWYuaCBpbmNsdWRl
cyB0cmFjZXBvaW50LmggaW4gYQo+PiAgICAgICBjb250ZXh0IHdoaWNoIGhhcyBMVFROR19VU1Rf
VFJBQ0VQT0lOVF9ERUZJTkUgdW5kZWZpbmVkLCBhbmQgdGhpcyBpcyBub3QKPj4gICAgICAgcmUt
ZXZhbHVhdGVkIGZvciB0aGUgZm9sbG93aW5nIGluY2x1ZGVzLgo+Pgo+PiAgICAgICBGaXggdGhp
cyBieSBsaWZ0aW5nIHRoZSBkZWZpbml0aW9uIGNvZGUgaW4gdHJhY2Vwb2ludC5oIG91dHNpZGUg
b2YgdGhlCj4+ICAgICAgIGhlYWRlciBpbmNsdWRlIGd1YXJkcywgYW5kICN1bmRlZiB0aGUgb2xk
IExUVE5HX1VTVF9fREVGSU5FX1RSQUNFUE9JTlQKPj4gICAgICAgYmVmb3JlIHJlLWRlZmluaW5n
IGl0IHRvIGl0cyBuZXcgc2VtYW50aWMuIFVzZSBhIG5ldwo+PiAgICAgICBfTFRUTkdfVVNUX1RS
QUNFUE9JTlRfREVGSU5FX09OQ0UgaW5jbHVkZSBndWFyZCB3aXRoaW4gdGhlCj4+ICAgICAgIExU
VE5HX1VTVF9UUkFDRVBPSU5UX0RFRklORSBkZWZpbmVkIGNhc2UgdG8gZW5zdXJlIHN5bWJvbHMg
YXJlIG5vdAo+PiAgICAgICBkdXBsaWNhdGVkLgo+Pgo+PiAgICAgICBTaWduZWQtb2ZmLWJ5OiBN
YXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPgo+PiAgICAg
ICBDaGFuZ2UtSWQ6IEkwZWY3MjA0MzUwMDNhN2NhMGJmY2YyOWQ3YmYyNzg2NmM1ZmY4Njc4Cj4+
Cj4gCj4gSSBhcHBsaWVkIHRoaXMgcGF0Y2ggYW5kIGlmIEkgdXNlICJ0cmFjZWYiIHR5cGUgY2Fs
bHMgaW4gb3VyCj4gYXBwbGljYXRpb24gdGhhdCBpcyBtYWRlIHVwIG9mIGEgYnVuY2ggb2Ygc3Rh
dGljIGxpYnMgLi4uIHRoZSBVU1QKPiB0cmFjZSBjYWxscyB3b3JrLiAgSSB2ZXJpZmllZCB0aGF0
IHRyYWNlcyB0aGF0IHdlcmUgY2FsbGVkIGZyb20KPiBzZXZlcmFsIGRpZmZlcmVudCBzdGF0aWMg
bGlicyBhbGwgd29ya2VkLgo+IAo+IEJ1dCBhcyBzb29uIGFzIEkgaW5jbHVkZSBhICJ0cmFjZXBv
aW50IiBzdHlsZSB0cmFjZXBvaW50ICh0aGF0IHVzZXMKPiB0cmFjZSBwcm92aWRlciBpbmNsdWRl
IGZpbGVzIGV0Yy4pIHRoZW4gZG9pbmcgYSAibHR0bmcgbGlzdCAtdSIKPiByZXR1cm5zICJOb25l
IiBmb3IgVVNUIGV2ZW50cy4KPiAKPiBJcyB0aGVyZSBzb21lIGtpbmQgb2YgcnVsZSB0aGF0IHNh
eXMgYSBmaWxlIGNhbid0IHVzZSBib3RoIHRyYWNlZiBhbmQKPiB0cmFjZXBvaW50IGNhbGxzPyAg
SXMgdGhlcmUgc29tZXRoaW5nIHNwZWNpYWwgeW91IGhhdmUgdG8gZG8gdG8gdXNlCj4gdHJhY2Vm
IGFuZCB0cmFjZXBvaW50cyBpbiBzYW1lIGZpbGU/ICBEb2luZyBzbyBhcHBlYXJzIHRvIGhhdmUg
YnJva2VuCj4gZXZlcnl0aGluZy4KCkl0IHNob3VsZCBqdXN0IHdvcmsuCgpDYW4geW91IHByb3Zp
ZGUgYSBtaW5pbWFsIGV4YW1wbGUgb2YgdGhlIGNvbXBpbGUgdW5pdCBoYXZpbmcgdGhpcwppc3N1
ZSA/CgpBbHNvIHlvdSBtZW50aW9uICJzdGF0aWMgbGlicyIuIE1ha2Ugc3VyZSB5b3UgZG8gKm5v
dCogZGVmaW5lIAoiTFRUTkdfVVNUX1RSQUNFUE9JTlRfUFJPQkVfRFlOQU1JQ19MSU5LQUdFIiBp
biB0aGlzIGNhc2UuIFNlZSB0aGUgCmx0dG5nLXVzdCgzKSBtYW4gcGFnZSBmb3IgZGV0YWlscyAo
c2VjdGlvbiAiU3RhdGljYWxseSBsaW5raW5nIHRoZSAKdHJhY2Vwb2ludCBwcm92aWRlciIpLgoK
VGhhbmtzLAoKTWF0aGlldQoKLS0gCk1hdGhpZXUgRGVzbm95ZXJzCkVmZmljaU9TIEluYy4KaHR0
cHM6Ly93d3cuZWZmaWNpb3MuY29tCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRu
Zy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0
dG5nLWRldgo=
