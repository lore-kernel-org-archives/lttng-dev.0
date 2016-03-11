From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: real time Userspace RCU
Date: Fri, 11 Mar 2016 03:45:07 -0800
Message-ID: <20160311114507.GQ3452__33613.7266167954$1457696776$gmane$org@linux.vnet.ibm.com>
References: <CAAKbDrcMU2rgStU1uFFg1Syk-B4ZOU2R7aC0On946gCXJ5DnMg@mail.gmail.com>
 <1138868550.112232059.1457635938477.JavaMail.zimbra@polymtl.ca>
 <CAAKbDrdac6jYEu4kjNq8kzCxQkdxJGBHN2+fFCh9wOiotoSYiw@mail.gmail.com>
 <1899542687.22326.1457643185957.JavaMail.zimbra@efficios.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id E5D71A07B5
 for <lttng-dev@lists.lttng.org>; Fri, 11 Mar 2016 11:45:44 +0000 (UTC)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <lttng-dev@lists.lttng.org> from <paulmck@linux.vnet.ibm.com>;
 Fri, 11 Mar 2016 04:45:43 -0700
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id B931A1FF001F
 for <lttng-dev@lists.lttng.org>; Fri, 11 Mar 2016 04:33:17 -0700 (MST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2BBj8ME31785114
 for <lttng-dev@lists.lttng.org>; Fri, 11 Mar 2016 11:45:08 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2BBj7O0008671
 for <lttng-dev@lists.lttng.org>; Fri, 11 Mar 2016 06:45:07 -0500
Content-Disposition: inline
In-Reply-To: <1899542687.22326.1457643185957.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

T24gVGh1LCBNYXIgMTAsIDIwMTYgYXQgMDg6NTM6MDVQTSArMDAwMCwgTWF0aGlldSBEZXNub3ll
cnMgd3JvdGU6Cj4gLS0tLS0gT24gTWFyIDEwLCAyMDE2LCBhdCAzOjMzIFBNLCBZdXhpbiBSZW4g
cnl4QGd3bWFpbC5nd3UuZWR1IHdyb3RlOgo+IAo+ID4gVGhhbmsgeW91IGZvciB5b3VyIHJlcGx5
Lgo+ID4gCj4gPiBJIHdhbnQgdG8gZ2VuZXJhbGx5IHVuZGVyc3RhbmQgaG93IHRvIGFwcGx5IHVy
Y3UgdG8gcmVhbCB0aW1lIHN5c3RlbXMuCj4gPiBJIGtub3cgcmVhbCB0aW1lIHN5c3RlbSBmb2N1
cyBvbiBwcmVkaWN0YWJpbGl0eSBvbiBib3RoIHRpbWluZyBhbmQKPiA+IG1lbW9yeSBjb25zdW1w
dGlvbi4KPiA+IFNvIGhvdyBkb2VzIHJlYWwgdGltZSB1cmN1IHN1cHBvcnQgcHJlZGljdGFiaWxp
dHk/Cj4gPiBDb3VsZCB5b3UgcHJvdmlkZSBtZSBzb21lIHBhcGVycywgZG9jdW1lbnRzIG9yIGFu
eSBtYXRlcmlhbHMgYWJvdXQgYW55Cj4gPiBhc3BlY3Qgb2YgcmVhbCB0aW1lIHVyY3U/Cj4gCj4g
QWRkaW5nIFBhdWwgRS4gTWNLZW5uZXkgaW4gQ0MsIHdobyBtYXkgaGF2ZSBzb21lIHRob3VnaHRz
IG9uIHRoaXMKPiB0b3BpYy4KClVSQ1UgZG9lcyB0aW1pbmcgcXVpdGUgd2VsbCwgZ2l2ZW4gdGhh
dCB0aGUgcmVhZC1zaWRlIHByaW1pdGl2ZXMgZWFjaApleGVjdXRlIGEgZml4ZWQgc2VxdWVuY2Ug
b2YgaW5zdHJ1Y3Rpb25zLiAgVXBkYXRlcyB1c2luZyBjYWxsX3JjdSgpCmNhbiBiZSB1c2VkIHRv
IG1pbmltaXplIHVwZGF0ZS1zaWRlIGxhdGVuY3ksIGJ1dCBpZiB5b3UgbmVlZCB0byBib3VuZApt
ZW1vcnkgb3ZlcmhlYWQsIHRoZSBiZXN0IHdheSB0byBkbyB0aGF0IGlzIHRvIG1ha2Ugc3VyZSB0
aGF0IHVwZGF0ZXMKYXJlIG5vdCBvbiB0aGUgY3JpdGljYWwgcGF0aCwgYW5kIHRoZW4gdXNlIHN5
bmNocm9uaXplX3JjdSgpIGluc3RlYWQKb2YgY2FsbF9yY3UoKS4gIEluIHRoYXQgY2FzZSwgdGhl
IHRvdGFsIGFtb3VudCBvZiBtZW1vcnkgd2FpdGluZyBmb3IKcmVjbGFtYXRpb24gaXMgYm91bmRl
ZCBieSB0aGUgbWF4aW11bSBzaXplIG9mIGFuIFJDVS1wcm90ZWN0ZWQgbWVtb3J5CmJsb2NrIHRp
bWVzIHRoZSBudW1iZXIgb2YgdGhyZWFkcy4KClNvIGNhbiB5b3UgZGVzaWduIHlvdXIgYXBwbGlj
YXRpb24gc28gdGhhdCB1cGRhdGVzIGFyZSBvZmYgdGhlIGNyaXRpY2FsCnBhdGg/ICBJZiBzbywg
eW91IGNhbiBnZXQgYm90aCBib3VuZGVkIHJlYWQtc2lkZSBhY2Nlc3NlcyBhbmQgYm91bmRlZApt
ZW1vcnkgZm9vdHByaW50LgoKVGhpcyBvZiBjb3Vyc2UgYXNzdW1lcyB0aGF0IHlvdXIgZGF0YSBz
dHJ1Y3R1cmVzIGFyZSBzaW1wbGUgZW5vdWdoCnRoYXQgcmVhZGVycyBkb24ndCBuZWVkIHRvIHVz
ZSByZXRyeSB0ZWNobmlxdWVzLgoKVGhlIGZvbGxvd2luZyBpbmZvIG1pZ2h0IGJlIGhlbHBmdWw6
CgpodHRwOi8vd3d3Mi5yZHJvcC5jb20vdXNlcnMvcGF1bG1jay9yZWFsdGltZS9wYXBlci9EZXRT
eW5jUkNVLjIwMDkuMDguMThhLnBkZgpodHRwOi8vd3d3Mi5yZHJvcC5jb20vdXNlcnMvcGF1bG1j
ay9yZWFsdGltZS9wYXBlci9EZXRTeW5jUkNVLjIwMDkuMDkuMjlhLnBkZgoKaHR0cDovL3d3dzIu
cmRyb3AuY29tL3VzZXJzL3BhdWxtY2svcmVhbHRpbWUvcGFwZXIvUlRMV1MyMDEyb2NjY1JULjIw
MTIuMTAuMTllLnBkZgoKSXQgYWxzbyBkZXBlbmRzIG9uIHlvdXIgdGltZWZyYW1lLiAgTWljcm9z
ZWNvbmRzPyAgTGlmZSBpcyBoYXJkLgpNaWxsaXNlY29uZHM/ICBDYXJlIGlzIHJlcXVpcmVkLCBi
dXQgeW91IGhhdmUgYSBmYWlyIGFtb3VudCBvZiBmcmVlZG9tLgpTZWNvbmRzPyAgTGlmZSBpcyBu
b3Qgc28gaGFyZC4gIFVubGVzcyB5b3UgbmVlZCB0byBkbyB0d28gc2Vjb25kcyBvZgpjb21wdXRh
dGlvbiBpbiBvbmUgc2Vjb25kIG9yIHNvbWUgc3VjaC4gIDstKQoKCQkJCQkJCVRoYW54LCBQYXVs
Cgo+IFRoYW5rcywKPiAKPiBNYXRoaWV1Cj4gCj4gPiAKPiA+IFRoYW5rcyBhZ2FpbiEKPiA+IAo+
ID4gT24gVGh1LCBNYXIgMTAsIDIwMTYgYXQgMTo1MiBQTSwgTWljaGVsIERhZ2VuYWlzCj4gPiA8
bWljaGVsLmRhZ2VuYWlzQHBvbHltdGwuY2E+IHdyb3RlOgo+ID4+IFJlYWwtdGltZSBhbmQgZW1i
ZWRkZWQgc3lzdGVtcyBpcyBhbiBpbXBvcnRhbnQgY3VycmVudCBmb2N1cyBmb3IgdGhlIExUVG5n
Cj4gPj4gdG9vbGNoYWluIHJlc2VhcmNoLiBEbyB5b3UgaGF2ZSBzcGVjaWZpYyBuZWVkcyBmb3Ig
dXNlcnNwYWNlIFJDVT8KPiA+Pgo+ID4+IC0tLS0tIE1haWwgb3JpZ2luYWwgLS0tLS0KPiA+Pj4g
SGksCj4gPj4+Cj4gPj4+ICBJcyB0aGVyZSBhbnkgd29yayBvciByZXNlYXJjaCBhYm91dCBVc2Vy
c3BhY2UgUkNVIG9uIHJlYWwgdGltZSBvcgo+ID4+PiBlbWJlZGRlZCBzeXN0ZW1zPwo+ID4+PiBB
bnkgaW5mb3JtYXRpb24gaXMgd2VsY29tZS4KPiA+Pj4KPiA+Pj4gVGhhbmtzIGEgbG90IQo+ID4+
PiBZdXhpbgo+ID4+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwo+ID4+PiBsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cj4gPj4+IGx0dG5nLWRldkBsaXN0cy5s
dHRuZy5vcmcKPiA+Pj4gaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xp
c3RpbmZvL2x0dG5nLWRldgo+ID4+Pgo+ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KPiA+IGx0dG5nLWRldiBtYWlsaW5nIGxpc3QKPiA+IGx0dG5nLWRl
dkBsaXN0cy5sdHRuZy5vcmcKPiA+IGh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFp
bG1hbi9saXN0aW5mby9sdHRuZy1kZXYKPiAKPiAtLSAKPiBNYXRoaWV1IERlc25veWVycwo+IEVm
ZmljaU9TIEluYy4KPiBodHRwOi8vd3d3LmVmZmljaW9zLmNvbQo+IAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdAps
dHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4v
bWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
