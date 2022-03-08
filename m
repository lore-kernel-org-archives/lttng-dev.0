Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5837BC433EF
	for <lttng-dev@archiver.kernel.org>; Tue,  8 Mar 2022 15:17:27 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4KCf854LvHz9Xg;
	Tue,  8 Mar 2022 10:17:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1646752646;
	bh=pr2F8BvqH2mcDrX2Wn0/kxiMYpVQ4sDxEQyorg2ROLI=;
	h=Date:To:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=CXhkQbbrkyY3AD1waYvw1baoFg54w9NvoH/z3RLZ6qZlGXfa+fjwbPCBx5JKzP7gf
	 cg4PLigQpsz2GdBQu9mGB6XwGlzenP4t8Hu01pbA37zXjpHGDH6/+3chM6O9acmOSl
	 b4RLdUS5B75xijzAHnC7Kd32OjL2tvtX6Z2TeixWK6CULdK+3v05ggoRUeLz9fllgU
	 ypFV2zCIOImqjvM+N32KHGfzaYZpf9MCINs+Y8DtZBmCkSNXJ+kx0Ch168imQXQdzY
	 OcpCqP8P2AY4gurqbFcg5+4k2QX4oeX6EA4Dtplzx7Z3uoRV+tm7CGPfQ4rnpCg4bs
	 IA9IS71JBoHwQ==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4KCf84095cz9mS
 for <lttng-dev@lists.lttng.org>; Tue,  8 Mar 2022 10:17:23 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id A8967366B5D;
 Tue,  8 Mar 2022 10:17:17 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id RH6hECehrt3d; Tue,  8 Mar 2022 10:17:17 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 40023366E1B;
 Tue,  8 Mar 2022 10:17:17 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 40023366E1B
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id l6CrdzGnOZKO; Tue,  8 Mar 2022 10:17:17 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 2DEDF36697C;
 Tue,  8 Mar 2022 10:17:17 -0500 (EST)
Date: Tue, 8 Mar 2022 10:17:17 -0500 (EST)
To: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Message-ID: <2119663162.129405.1646752637020.JavaMail.zimbra@efficios.com>
In-Reply-To: <26341add-b962-4027-8c5e-28d940e8f4dc.zhenyu.ren@aliyun.com>
References: <e706d6c8-edea-4f26-a9e2-4a66f067204e.zhenyu.ren@aliyun.com>
 <cbf6b471-85d1-46f5-b10b-2a643b79433c.zhenyu.ren@aliyun.com>
 <c0e023fd-bd52-4125-9e50-c096167386ff.zhenyu.ren@aliyun.com>
 <20220225142111.GC1861057@x>
 <26341add-b962-4027-8c5e-28d940e8f4dc.zhenyu.ren@aliyun.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF97 (Linux)/8.8.15_GA_4232)
Thread-Topic: =?utf-8?B?5Zue5aSN77yaIOWbnuWkje+8miDlm57lpI3vvJo=?= shm leak in
 traced application?
Thread-Index: opMUkyXR6PT06+Ne2vxDcF3tMcJPPg==
Subject: Re: [lttng-dev] 
 =?utf-8?b?5Zue5aSN77yaIOWbnuWkje+8miDlm57lpI3vvJog?=
 =?utf-8?q?shm_leak_in_traced_application=3F?=
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

CgotLS0tLSBPbiBNYXIgOCwgMjAyMiwgYXQgMTI6MTggQU0sIGx0dG5nLWRldiBsdHRuZy1kZXZA
bGlzdHMubHR0bmcub3JnIHdyb3RlOgoKPiBIaSwKPiBJbiBzaG1fb2JqZWN0X3RhYmxlX2FwcGVu
ZF9zaG0oKS9hbGxvY19zaG0oKe+8jCB3aHkgbm90IGNhbGxpbmcgRkRfQ0xPRVhFQyBmY250bCgp
Cj4gdG8gc2htZmRzPyBJIGd1ZXNzIHRoaXMgb21pc3Npb24gbGVhZHMgdG8gc2htIGZkcyBsZWFr
LgoKVGhvc2UgZmlsZSBkZXNjcmlwdG9ycyBhcmUgY3JlYXRlZCB3aGVuIHJlY2VpdmVkIGJ5IHVz
dGNvbW1fcmVjdl9mZHNfdW5peF9zb2NrLCBhbmQKaW1tZWRpYXRlbHkgYWZ0ZXIgY3JlYXRpb24g
dGhleSBhcmUgc2V0IGFzIEZEX0NMT0VYRUMuCgpXZSBzaG91bGQgY29udGludWUgdGhpcyBkaXNj
dXNzaW9uIGluIHRoZSBidWcgdHJhY2tlciBhcyBzdWdnZXN0ZWQgYnkgSm9uYXRoYW4uCkl0IHdv
dWxkIGdyZWF0bHkgaGVscCBpZiB5b3UgY2FuIHByb3ZpZGUgYSBzbWFsbCByZXByb2R1Y2VyLgoK
VGhhbmtzLAoKTWF0aGlldQoKCj4gVGhhbmtzCj4gemhlbnl1LnJlbgoKPj4gLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4+
IOWPkeS7tuS6uu+8mkpvbmF0aGFuIFJham90dGUtSnVsaWVuIDxqb25hdGhhbi5yYWpvdHRlLWp1
bGllbkBlZmZpY2lvcy5jb20+Cj4+IOWPkemAgeaXtumXtO+8mjIwMjLlubQy5pyIMjXml6Uo5pif
5pyf5LqUKSAyMjozMQo+PiDmlLbku7bkurrvvJp6aGVueXUucmVuIDx6aGVueXUucmVuQGFsaXl1
bi5jb20+Cj4+IOaKhCDpgIHvvJpsdHRuZy1kZXYgPGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmc+
Cj4+IOS4uyDpopjvvJpSZTogW2x0dG5nLWRldl0g5Zue5aSN77yaIOWbnuWkje+8miBzaG0gbGVh
ayBpbiB0cmFjZWQgYXBwbGljYXRpb24/Cgo+PiBIaSB6aGVueXUucmVuLAoKPj4gUGxlYXNlIG9w
ZW4gYSBidWcgb24gb3VyIGJ1ZyB0cmFja2VyIGFuZCBwcm92aWRlIGEgcmVwcm9kdWNlciBhZ2Fp
bnN0IHRoZSBsYXRlc3QKPj4gc3RhYmxlIHZlcnNpb24gKDIuMTMueCkuCgo+PiBodHRwczovL2J1
Z3MubHR0bmcub3JnLwoKPj4gUGxlYXNlIGZvbGxvdyB0aGUgZ3VpZGVsaW5lczogaHR0cHM6Ly9i
dWdzLmx0dG5nLm9yZy8jQnVnLXJlcG9ydGluZy1ndWlkZWxpbmVzCgo+PiBDaGVlcnMKCj4+IE9u
IEZyaSwgRmViIDI1LCAyMDIyIGF0IDEyOjQ3OjM0UE0gKzA4MDAsIHpoZW55dS5yZW4gdmlhIGx0
dG5nLWRldiB3cm90ZToKPj4gPiBIaSwgbHR0bmctZGV2IHRlYW0KPj4+IFdoZW4gbHR0bmctc2Vz
c2lvbmQgZXhpdHMsIHRoZSB1c3QgYXBwbGljYXRpb25zIHNob3VsZCBjYWxsCj4+PiBsdHRuZ191
c3Rfb2JqZF90YWJsZV9vd25lcl9jbGVhbnVwKCkgYW5kIGNsZWFuIHVwIGFsbCBzaG0gcmVzb3Vy
Y2UodW5tYXAgYW5kCj4+PiBjbG9zZSkuIEhvd2VydmVyIEkgZG8gZmluZCB0aGF0IHRoZSB1c3Qg
YXBwbGljYXRpb25zIGtlZXAgb3BlbmluZyAiYWxsIiBvZiB0aGUKPj4gPiBzaG0gZmRzKCIvZGV2
L3NobS91c3Qtc2htLWNvbnN1bWVyLTgxMTMyIChkZWxldGVkKSIpIGFuZCBkbyBOT1QgZnJlZSBz
aG0uCj4+PiBJZiB3ZSBydW4gbHR0bmctc2Vzc2lvbmQgYWdhaW4sIHVzdCBhcHBsaWNhdGlvbnMg
Y2FuIGdldCBhIG5ldyBwaWVjZSBvZiBzaG0gYW5kCj4+PiBhIG5ldyBsaXN0IG9mIHNobSBmZHMg
c28gZG91YmxlIHNobSB1c2FnZXMuIFRoZW4gaWYgd2Uga2lsbCBsdHRuZy1zZXNzaW9uZCwKPj4+
IHdoYXQgdGhlIG1vc3RsaWtlbHkgaGFwcGVuZWQgaXMgdXN0IGFwcGxpY2F0aW9ucyBjbG9zZSB0
aGUgbmV3IGxpc3Qgb2Ygc2htIGZkcwo+Pj4gYW5kIGZyZWUgbmV3IHNobSByZXNvdXJjZSBidXQg
a2VlcGluZyBvbGQgc2htIHN0aWxsLiBJbiBvdGhlciB3b3JkLCB3ZSBjYW4gbm90Cj4+ID4gZnJl
ZSB0aGlzIHBpZWNlIG9mIHNobSB1bmxlc3Mgd2Uga2lsbGluZyB1c3QgYXBwbGljYXRpb25zISEh
Cj4+PiBTbyBJcyB0aGVyZSBhbnkgcG9zc2lsYmUgdGhhdCB1c3QgYXBwbGljYXRpb25zIGZhaWxl
ZCBjYWxsaW5nCj4+PiBsdHRuZ191c3Rfb2JqZF90YWJsZV9vd25lcl9jbGVhbnVwKCk/IERvIHlv
dSBoYXZlIGV2ZXIgc2VlIHRoaXMgcHJvYmxlbT8gRG8geW91Cj4+PiBoYXZlIGFueSBhZHZpY2Ug
dG8gZnJlZSB0aGUgc2htIHdpdGhvdXQga2lsbGxpbmcgdXN0IGFwcGxpY2F0aW9ucyhJIHRyaWVk
IHRvCj4+ID4gZGlnIGludG8ga2VybmVsIHNobV9vcGVuIGFuZCAvZGV2L3NobSwgYnV0IG5vdCBm
b3VuZCBhbnkgaWRlYXMpPwoKPj4gPiBUaGFua3MgaW4gYWR2YW5jZQo+PiA+IHpoZW55dS5yZW4K
CgoKPj4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KPj4gPiDlj5Hku7bkurrvvJp6aGVueXUucmVuIHZpYSBsdHRuZy1k
ZXYgPGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmc+Cj4+ID4g5Y+R6YCB5pe26Ze077yaMjAyMuW5
tDLmnIgyM+aXpSjmmJ/mnJ/kuIkpIDIzOjA5Cj4+ID4g5pS25Lu25Lq677yabHR0bmctZGV2IDxs
dHRuZy1kZXZAbGlzdHMubHR0bmcub3JnPgo+PiA+IOS4uyDpopjvvJpbbHR0bmctZGV2XSDlm57l
pI3vvJogc2htIGxlYWsgaW4gdHJhY2VkIGFwcGxpY2F0aW9uPwoKPj4+ID4iSSBmb3VuZCB0aGVz
ZSBpdGVtcyBhbHNvIGV4aXN0IGluIGEgdHJhY2VkIGFwcGxpY2F0aW9uIHdoaWNoIGlzIGEgbG9u
Zy10aW1lCj4+ID4gPnJ1bm5pbmcgZGFlbW9uIgo+PiA+IEV2ZW4gaWYgbHR0bmctc2Vzc2lvbmQg
aGFzIGJlZW4ga2lsbGVkISEKCj4+ID4gVGhhbmtzCj4+ID4gemhlbnl1LnJlbgo+PiA+IC0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQo+PiA+IOWPkeS7tuS6uu+8mnpoZW55dS5yZW4gdmlhIGx0dG5nLWRldiA8bHR0bmctZGV2
QGxpc3RzLmx0dG5nLm9yZz4KPj4gPiDlj5HpgIHml7bpl7TvvJoyMDIy5bm0MuaciDIz5pelKOaY
n+acn+S4iSkgMjI6NDQKPj4gPiDmlLbku7bkurrvvJpsdHRuZy1kZXYgPGx0dG5nLWRldkBsaXN0
cy5sdHRuZy5vcmc+Cj4+ID4g5Li7IOmimO+8mltsdHRuZy1kZXZdIHNobSBsZWFrIGluIHRyYWNl
ZCBhcHBsaWNhdGlvbj8KCj4+ID4gSGksCj4+PiBUaGVyZSBhcmUgbWFueSBpdGVtcyBzdWNoIGFz
ICIvZGV2L3NobS91c3Qtc2htLWNvbnN1bWVyLTgxMTMyIChkZWxldGVkKSIgZXhpc3QKPj4+IGlu
IGx0dG5nLXNlc3Npb25kIGZkIHNwYWNlcy4gSSBrbm93IGl0IGlzIHRoZSByZXN1bHQgb2Ygc2ht
X29wZW4oKSBhbmQKPj4gPiBzaG1fdW5sbmlrKCkgaW4gY3JlYXRlX3Bvc2l4X3NobSgpLgo+Pj4g
SG93ZXZlciwgdG9kYXksIEkgZm91bmQgdGhlc2UgaXRlbXMgYWxzbyBleGlzdCBpbiBhIHRyYWNl
ZCBhcHBsaWNhdGlvbiB3aGljaCBpcwo+Pj4gYSBsb25nLXRpbWUgcnVubmluZyBkYWVtb24uIFRo
ZSBtb3N0IGltcG9ydGFudCB0aGluZyBJIGZvdW5kIGlzIHRoYXQgdGhlcmUKPj4gPiBzZWVtcyBu
byByZWxpYWJsZSB3YXkgdG8gcmVsZWFzZSBzaGFyZSBtZW1vcnkuCj4+PiBJIHRyaWVkIHRvIGtp
bGwgbHR0bmctc2Vzc2lvbmQgYnV0IG5vdCBhbHdheXMgcmVsZWFzZSBzaGFyZSBtZW1vcnkuIFNv
bWV0aW1lcyBJCj4+PiBuZWVkIHRvIGtpbGwgdGhlIHRyYWNlZCBhcHBsaWNhdGlvbiB0byBmcmVl
IHNoYXJlIG1lbW9yeS4uLi5CdXQgaXQgaXMgbm90IGEKPj4gPiBnb29kIGlkZWEgdG8ga2lsbCB0
aGVzZSBhcHBsaWNhdGlvbnMuCj4+ID4gTXkgcXVlc3Rpb25zIGFyZToKPj4+IDEuIElzIHRoZXJl
IGFueSB3YXkgdG8gcmVsZWFzZSBzaGFyZSBtZW1vcnkgd2l0aG91dCBraWxsaW5nIGFueSB0cmFj
ZWQKPj4gPiBhcHBsaWNhdGlvbj8KPj4+IDIuIElzIGl0IG5vcm1hbCB0aGF0IG1hbnkgaXRlbXMg
c3VjaCBhcyAiL2Rldi9zaG0vdXN0LXNobS1jb25zdW1lci04MTEzMgo+PiA+IChkZWxldGVkKSIg
ZXhpc3QgaW4gdGhlIHRyYWNlZCBhcHBsaWNhdGlvbj8KCj4+ID4gVGhhbmtzCj4+ID4gemhlbnl1
LnJlbgoKCgo+PiA+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCj4+ID4gbHR0bmctZGV2IG1haWxpbmcgbGlzdAo+PiA+IGx0dG5nLWRldkBsaXN0cy5sdHRu
Zy5vcmcKPj4gPiBodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGlu
Zm8vbHR0bmctZGV2Cgo+PiAtLQo+PiBKb25hdGhhbiBSYWpvdHRlLUp1bGllbgo+PiBFZmZpY2lP
Uwo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gbHR0
bmctZGV2IG1haWxpbmcgbGlzdAo+IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKPiBodHRwczov
L2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Ci0tIApN
YXRoaWV1IERlc25veWVycwpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBt
YWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5n
Lm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
