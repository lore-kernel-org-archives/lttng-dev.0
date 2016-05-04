From: Michael Jeanson <mjeanson@efficios.com>
Subject: Re: [PATCH babeltrace] Fix: Static build on OS X
Date: Wed, 4 May 2016 17:13:29 +0000 (UTC)
Message-ID: <777725965.874.1462382009885.JavaMail.zimbra__36106.0556759641$1462382031$gmane$org@efficios.com>
References: <1462373695-15432-1-git-send-email-mjeanson@efficios.com>
 <1502003478.731.1462377440298.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 1440EA1F19
 for <lttng-dev@lists.lttng.org>; Wed,  4 May 2016 17:13:33 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id D2E7834024F
 for <lttng-dev@lists.lttng.org>; Wed,  4 May 2016 17:13:32 +0000 (UTC)
In-Reply-To: <1502003478.731.1462377440298.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

LS0tLS0gT24gTWF5IDQsIDIwMTYsIGF0IDExOjU3IEFNLCBNYXRoaWV1IERlc25veWVycyBtYXRo
aWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20gd3JvdGU6Cgo+IC0tLS0tIE9uIE1heSA0LCAyMDE2
LCBhdCAxMDo1NCBBTSwgTWljaGFlbCBKZWFuc29uIG1qZWFuc29uQGVmZmljaW9zLmNvbSB3cm90
ZToKPiAKPj4gVGhlIE9TIFggbGlua2VyIGZhaWxzIHRvIHJlc29sdmUgY29tbW9uIHN5bWJvbHMg
aW4gYSBzdGF0aWMKPj4gbGlicmFyeSBmb3Igc29tZSB1bmV4cGxhaW5lZCByZWFzb24uIEluaXRp
YWxpemluZyB0aGUgdmFyaWFibGVzCj4+IHRvIHplcm8gbWFrZXMgdGhlIHN5bWJvbCBiZWNvbWUg
dW5pbml0aWFsaXplZCBkYXRhIGFuZCBmaXhlcwo+PiB0aGUgbGlua2luZy4KPiAKPiBXZSBkb24n
dCBpbml0aWFsaXplIHN0YXRpYy9nbG9iYWwgdmFyaWFibGVzIHRvIDAvTlVMTCBldmVyIGluIG91
cgo+IGNvZGluZyBzdHlsZSwgcHJlc3VtaW5nIHRoZXkgYXJlIHplcm9lZCAoc2ltaWxhcmx5IHRv
IHRoZSBrZXJuZWwKPiBjb2Rpbmcgc3R5bGUpLgo+IAo+IFdoeSBzaG91bGQgd2UgZGl2ZXJnZSBm
cm9tIHRoaXMgY29kaW5nIHN0eWxlIGluIHRoaXMgc3BlY2lmaWMgaW5zdGFuY2UgPwoKSSdtIG9w
ZW4gdG8gYSBiZXR0ZXIgc29sdXRpb24gYnV0IGFmdGVyIGNvbnN1bHRpbmcgd2l0aCBKw6lyw6lt
aWUgYW5kIFBoaWxpcHBlIGl0J3MKdGhlIGJlc3Qgd2UgY2FtZSB1cCB3aXRoIHRvIGZpeCBzdGF0
aWMgY29tcGlsYXRpb24gb24gT1MgWC4KCj4gV2h5IG5vdCBlbHNld2hlcmUgPwoKU2VlbXMgdG8g
YmUgcmVsYXRlZCB0byBhbiBvYmplY3QgZmlsZSB0aGF0IGNvbnRhaW5zICJjb21tb24iIHN5bWJv
bHMgYW5kIG5vIG90aGVyCmRpcmVjdGx5IHJlZmVyZW5jZWQgc3ltYm9scyBvdGhlciB0aGFuIGEg
Y29uc3RydWN0b3Igd2hpY2ggaGFwcGVucyBvbmx5IHdpdGggCmxpYi9iYWJlbHRyYWNlLm8gaW4g
dGhlIGN1cnJlbnQgdHJlZS4KCj4gCj4gVGhhbmtzLAo+IAo+IE1hdGhpZXUKPgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBs
aXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dp
LWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
