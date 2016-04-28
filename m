From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Question about lock in synchronize_rcu
	implementation of URCU
Date: Wed, 27 Apr 2016 21:23:27 -0700
Message-ID: <20160428042327.GP4967__35713.1425910213$1461817402$gmane$org@linux.vnet.ibm.com>
References: <CAAKbDrfmcqEE7_6p_J0DPVO85yDGJ0GCbi5k9Lm19g4VaLgOWw@mail.gmail.com>
 <20160428020803.GN4967@linux.vnet.ibm.com>
 <CAAKbDrfRMKzu6brHG=pfm0mu_Oy1afVZ94zDCiN7Y0w5o+SMZQ@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 07FFCA32E6
 for <lttng-dev@lists.lttng.org>; Thu, 28 Apr 2016 04:22:54 +0000 (UTC)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <lttng-dev@lists.lttng.org> from <paulmck@linux.vnet.ibm.com>;
 Wed, 27 Apr 2016 22:22:53 -0600
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 93A143E40060
 for <lttng-dev@lists.lttng.org>; Wed, 27 Apr 2016 22:22:50 -0600 (MDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3S4MoJP33489120
 for <lttng-dev@lists.lttng.org>; Thu, 28 Apr 2016 04:22:50 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3S4MnHx003296
 for <lttng-dev@lists.lttng.org>; Thu, 28 Apr 2016 00:22:49 -0400
Content-Disposition: inline
In-Reply-To: <CAAKbDrfRMKzu6brHG=pfm0mu_Oy1afVZ94zDCiN7Y0w5o+SMZQ@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Yuxin Ren <ryx@gwmail.gwu.edu>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

VHJ5IGJ1aWxkaW5nIHdpdGhvdXQgaXQgYW5kIHNlZSB3aGF0IGhhcHBlbnMgd2hlbiB5b3UgcnVu
IHRoZSB0ZXN0cy4KCk1pZ2h0IHdlbGwgYmUgdGhhdCBpdCBpcyB1bm5lY2Vzc2FyeSwgYnV0IEkg
d2lsbCBkZWZlciB0byBNYXRoaWV1Cm9uIHRoYXQgcG9pbnQuCgoJCQkJCQkJVGhhbngsIFBhdWwK
Ck9uIFdlZCwgQXByIDI3LCAyMDE2IGF0IDEwOjE4OjA0UE0gLTA0MDAsIFl1eGluIFJlbiB3cm90
ZToKPiBBcyB0aGV5IGRvbid0IGN1cnJlbnRseSBwZXJmb3JtIGdyYWNlIHBlcmlvZCwgd2h5IGRv
IHdlIHVzZSB0aGUgcmN1X2dwX2xvY2s/Cj4gCj4gVGhhbmsgeW91Lgo+IFl1eGluCj4gCj4gT24g
V2VkLCBBcHIgMjcsIDIwMTYgYXQgMTA6MDggUE0sIFBhdWwgRS4gTWNLZW5uZXkKPiA8cGF1bG1j
a0BsaW51eC52bmV0LmlibS5jb20+IHdyb3RlOgo+ID4gT24gV2VkLCBBcHIgMjcsIDIwMTYgYXQg
MDk6MzQ6MTZQTSAtMDQwMCwgWXV4aW4gUmVuIHdyb3RlOgo+ID4+IEhpLAo+ID4+Cj4gPj4gSSBh
bSBsZWFybmluZyB0aGUgVVJDVSBjb2RlLgo+ID4+Cj4gPj4gV2h5IGRvIHdlIG5lZWQgcmN1X2dw
X2xvY2sgaW4gc3luY2hyb25pemVfcmN1Pwo+ID4+IGh0dHBzOi8vZ2l0aHViLmNvbS91cmN1L3Vz
ZXJzcGFjZS1yY3UvYmxvYi9tYXN0ZXIvdXJjdS5jI0w0MDEKPiA+Pgo+ID4+IEluIHRoZSBjb21t
ZW50LCBpdCBzYXlzIHRoaXMgbG9jayBlbnN1cmVzIG11dHVhbCBleGNsdXNpb24gYmV0d2Vlbgo+
ID4+IHRocmVhZHMgY2FsbGluZyBzeW5jaHJvbml6ZV9yY3UoKS4KPiA+PiBCdXQgb25seSB0aGUg
Zmlyc3QgdGhyZWFkIGFkZGVkIHRvIHdhaXRlciBxdWV1ZSBjYW4gcHJvY2VlZCB0byBkZXRlY3QK
PiA+PiBncmFjZSBwZXJpb2QuCj4gPj4gSG93IGNhbiBtdWx0aXBsZSB0aHJlYWRzIGN1cnJlbnRs
eSBwZXJmb3JtIHRoZSBncmFjZSB0aHJlYWQ/Cj4gPgo+ID4gVGhleSBkb24ndCBjb25jdXJyZW50
bHkgcGVyZm9ybSBncmFjZSBwZXJpb2RzLCBhbmQgaXQgd291bGQgYmUgd2FzdGVmdWwKPiA+IGZv
ciB0aGVtIHRvIGRvIHNvLiAgSW5zdGVhZCwgdGhlIGZpcnN0IG9uZSBwZXJmb3JtcyB0aGUgZ3Jh
Y2UgcGVyaW9kLAo+ID4gYW5kIGFsbCB0aGF0IHdlcmUgd2FpdGluZyBhdCB0aGUgdGltZSBpdCBz
dGFydGVkIGdldCB0aGUgYmVuZWZpdCBvZiB0aGF0Cj4gPiBzYW1lIGdyYWNlIHBlcmlvZC4KPiA+
Cj4gPiBBbnkgdGhhdCBhcnJpdmVkIGFmdGVyIHRoZSBmaXJzdCBncmFjZSBwZXJpb2QgcGVyZm9y
bXMgdGhlIGZpcnN0Cj4gPiBncmFjZSBwZXJpb2QgYXJlIHNlcnZlZCBieSB3aGljaGV2ZXIgb2Yg
dGhlbSBwZXJmb3JtcyB0aGUgc2Vjb25kCj4gPiBncmFjZSBwZXJpb2QuCj4gPgo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBUaGFueCwg
UGF1bAo+ID4KPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRw
czovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
