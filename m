From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: High memory consumption issue on RCU side
Date: Sat, 24 Sep 2016 08:22:01 -0700
Message-ID: <20160924152201.GS14933__40382.7122333043$1474740800$gmane$org@linux.vnet.ibm.com>
References: <CAO6Ho0cLZc0x3RBfHd=qh_XZ+PPPMkaG_GaGGiT5=6MhsreR+Q@mail.gmail.com>
 <1073011756.31148.1474667940258.JavaMail.zimbra@efficios.com>
 <CAO6Ho0enRfpF+vMpd55=0hZ44eCCtABghZssj0wzsd5K8-q-wQ@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 0855FA2053
 for <lttng-dev@lists.lttng.org>; Sat, 24 Sep 2016 18:13:57 +0000 (UTC)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8OFHcTg088200
 for <lttng-dev@lists.lttng.org>; Sat, 24 Sep 2016 11:22:05 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25nnnwv65t-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Sat, 24 Sep 2016 11:22:05 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <lttng-dev@lists.lttng.org> from <paulmck@linux.vnet.ibm.com>;
 Sat, 24 Sep 2016 09:22:04 -0600
Content-Disposition: inline
In-Reply-To: <CAO6Ho0enRfpF+vMpd55=0hZ44eCCtABghZssj0wzsd5K8-q-wQ@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Evgeniy Ivanov <lolkaantimat@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

T24gU2F0LCBTZXAgMjQsIDIwMTYgYXQgMTA6NDI6MjRBTSArMDMwMCwgRXZnZW5peSBJdmFub3Yg
d3JvdGU6Cj4gSGkgTWF0aGlldSwKPiAKPiBPbiBTYXQsIFNlcCAyNCwgMjAxNiBhdCAxMjo1OSBB
TSwgTWF0aGlldSBEZXNub3llcnMKPiA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPiB3
cm90ZToKPiA+IC0tLS0tIE9uIFNlcCAyMiwgMjAxNiwgYXQgMzoxNCBQTSwgRXZnZW5peSBJdmFu
b3YgbG9sa2FhbnRpbWF0QGdtYWlsLmNvbSB3cm90ZToKPiA+Cj4gPj4gSGkgYWxsLAo+ID4+Cj4g
Pj4gSSdtIGludmVzdGlnYXRpbmcgaGlnaCBtZW1vcnkgdXNhZ2Ugb2YgbXkgcHJvZ3JhbTogUlNT
IHZhcmllcyBiZXR3ZWVuCj4gPj4gZXhlY3V0aW9ucyBpbiByYW5nZSAyMC01MCBHQiwgdGhvdWdo
IGl0IHNob3VsZCBiZSBkZXRlcm1lbmlzdGljLiBJJ3ZlCj4gPj4gZm91bmQgdGhhdCBhbGwgdGhl
IG1lbW9yeSBpcyBhbGxvY2F0ZWQgaW4gdGhpcyBzdGFjazoKPiA+Pgo+ID4+IEFsbG9jYXRlZCAx
NzY3Mzc4MTI0OCBieXRlcyBpbiA1NTYgYWxsb2NhdGlvbnMKPiA+PiAgICAgICAgY2RzX2xmaHRf
YWxsb2NfYnVja2V0X3RhYmxlMyAgICAgZnJvbSBsaWJ1cmN1LWNkcy5zby4yLjAuMAo+ID4+ICAg
ICAgICBfZG9fY2RzX2xmaHRfcmVzaXplICAgICAgZnJvbSBsaWJ1cmN1LWNkcy5zby4yLjAuMAo+
ID4+ICAgICAgICBkb19yZXNpemVfY2IgICAgICAgICAgICAgZnJvbSBsaWJ1cmN1LWNkcy5zby4y
LjAuMAo+ID4+ICAgICAgICBjYWxsX3JjdV90aHJlYWQgICAgICAgICAgZnJvbSBsaWJ1cmN1LXFz
YnIuc28uMi4wLjAKPiA+PiAgICAgICAgc3RhcnRfdGhyZWFkICAgICAgICAgICAgIGZyb20gbGli
cHRocmVhZC0yLjEyLnNvCj4gPj4gICAgICAgIGNsb25lICAgICAgICAgICAgICAgICAgICBmcm9t
IGxpYmMtMi4xMi5zbwo+ID4+Cj4gPj4gQWNjb3JkaW5nIHBzdGFjayBpdCBzaG91bGQgYmUgcXVp
ZXNjZW50IHN0YXRlLiAgQ2FsbCB0aHJlYWQgd2FpdHMgb24gc3lzY2FsbDoKPiA+PiBzeXNjYWxs
Cj4gPj4gY2FsbF9yY3VfdGhyZWFkCj4gPj4gc3RhcnRfdGhyZWFkCj4gPj4gY2xvbmUKPiA+Pgo+
ID4+IFdlIHVzZSB1cmN1LTAuOC43LCBvbmx5IHJjdWxmaGFzaCAoUVNCUikuIElzIGl0IHNvbWUg
a2luZCBvZiBsZWFrIGluCj4gPj4gUkNVIG9yIGFueSBjaGFuY2UgSSBtaXN1c2UgaXQ/IFdoYXQg
d291bGQgeW91IHJlY29tbWVuZCB0bwo+ID4+IHRyb3VibGVzaG9vdCB0aGUgc2l0dWF0aW9uPwo+
ID4KPiA+IHVyY3UtcXNiciBpcyB0aGUgZmFzdGVzdCBmbGF2b3Igb2YgdXJjdSwgYnV0IGl0IGlz
IHJhdGhlciB0cmlja3kgdG8gdXNlIHdlbGwuCj4gPiBNYWtlIHN1cmUgdGhhdDoKPiA+Cj4gPiAt
IEVhY2ggcmVnaXN0ZXJlZCB0aHJlYWQgcGVyaW9kaWNhbGx5IHJlYWNoIGEgcXVpZXNjZW50IHN0
YXRlLCBieToKPiA+ICAgLSBJbnZva2luZyByY3VfcXVpZXNjZW50X3N0YXRlIHBlcmlvZGljYWxs
eSwgYW5kCj4gPiAgIC0gTWFraW5nIHN1cmUgdG8gc3Vycm91bmQgYW55IGJsb2NraW5nIGZvciBy
ZWxhdGl2ZWx5IGxhcmdlIGFtb3VudCBvZgo+ID4gICAgIHRpbWUgYnkgcmN1X3RocmVhZF9vZmZs
aW5lKCkvcmN1X3RocmVhZF9vbmxpbmUoKS4KPiA+Cj4gPiBJbiB1cmN1LXFzYnIsIHRoZSAiZGVm
YXVsdCIgc3RhdGUgb2YgdGhyZWFkcyBpcyB0byBiZSB3aXRoaW4gYSBSQ1UgcmVhZC1zaWRlLgo+
ID4gVGhlcmVmb3JlLCBpZiB5b3Ugb21pdCBhbnkgb2YgdGhlIHR3byBhZHZpY2UgYWJvdmUsIHlv
dSBlbmQgdXAgaW4gYSBzaXR1YXRpb24KPiA+IHdoZXJlIGdyYWNlIHBlcmlvZHMgbmV2ZXIgY29t
cGxldGUsIGFuZCB0aGVyZWZvcmUgbm8gY2FsbF9yY3UoKSBjYWxsYmFja3MgY2FuCj4gPiBiZSBw
cm9jZXNzZWQuIFRoaXMgZWZmZWN0aXZlbHkgYWN0cyBsaWtlIGEgYmlnIG1lbW9yeSBsZWFrLgo+
IAo+IEl0IHdhcyB0aGUgb3JpZ2luYWwgYXNzdW1wdGlvbiwgYnV0IGluIG1lbW9yeSBzdGFja3Mg
SSBkb24ndCBzZWUgc3VjaAo+IGFsbG9jYXRpb25zIGZvciBteSBkYXRhLiBJbnN0ZWFkIGh1Z2Ug
YWxsb2NhdGlvbnMgaGFwcGVuIHJpZ2h0IGluCj4gY2FsbF9yY3VfdGhyZWFkLiBNZW1vcnkgZm9v
dHByaW50IGZvciBteSBhcHAgaXMgYWJvdXQgMjAgR0IsIGVyYXNpbmcKPiBSQ1UgZGF0YSBpcyBh
IHJhcmUgb3BlcmF0aW9uLCBzbyBhbG1vc3QgMjAgR0IgaW4gcmN1IHRocmVhZCBsb29rcwo+IHN1
c3BlY2lvcy4gSSdsbCB0cnkgdG8gbm90IGVyYXNlIGFueSBSQ1UgcHJvdGVjdGVkIGRhdGEgYW5k
IHJlcHJvZHVjZQo+IHRoZSBpc3N1ZSAoY29tcGxpY2F0ZWQgdGhpbmcgaXMgdGhhdCB1bmRlciBt
ZW1vcnkgdHJhY2VyIGl0IGhhcHBlbnMKPiBub3Qgc28gb2Z0ZW4pLgoKSW50ZXJlc3RpbmcuICBU
cnlpbmcgdG8gZmlndXJlIG91dCB3aHkgeW91ciBjYWxsX3JjdV90aHJlYWQoKSB3b3VsZApldmVy
IGFsbG9jYXRlIG1lbW9yeS4KCkFoISAgRG8geW91ciBSQ1UgY2FsbGJhY2tzIGFsbG9jYXRlIG1l
bW9yeT8KCgkJCQkJCQlUaGFueCwgUGF1bAoKPiA+IEhvcGluZyB0aGlzIGhlbHBzLAo+ID4KPiA+
IFRoYW5rcywKPiA+Cj4gPiBNYXRoaWV1Cj4gPgo+ID4KPiA+IC0tCj4gPiBNYXRoaWV1IERlc25v
eWVycwo+ID4gRWZmaWNpT1MgSW5jLgo+ID4gaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KPiAKPiAK
PiAKPiAtLSAKPiBDaGVlcnMsCj4gRXZnZW5peQo+IAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZA
bGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9s
aXN0aW5mby9sdHRuZy1kZXYK
