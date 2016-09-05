From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
Subject: Re: [Qemu-devel] [PATCH 0/6] hypertrace: Lightweight
	guest-to-QEMU trace channel
Date: Mon, 05 Sep 2016 16:37:01 +0200
Message-ID: <87y436mn02.fsf__11232.1135275581$1473086565$gmane$org@fimbulvetr.bsc.es>
References: <147041636348.2523.2954972609232949598.stgit@fimbulvetr.bsc.es>
 <20160818105424.GD4850@stefanha-x1.localdomain>
 <8737lypajh.fsf@fimbulvetr.bsc.es>
 <20160823155430.GB3948@stefanha-x1.localdomain>
 <87lgzm4g5p.fsf@fimbulvetr.bsc.es>
 <20160829134502.GA26282@stefanha-x1.localdomain>
 <87a8fvjtw5.fsf@fimbulvetr.bsc.es>
 <20160831163547.GD18281@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from roura.ac.upc.es (roura.ac.upc.es [147.83.33.10])
 by evm-lttng-1.efficios.com (Postfix) with ESMTP id AB1CAA3AC6
 for <lttng-dev@lists.lttng.org>; Mon,  5 Sep 2016 14:42:59 +0000 (UTC)
In-Reply-To: <20160831163547.GD18281@stefanha-x1.localdomain> (Stefan
 Hajnoczi's message of "Wed, 31 Aug 2016 12:35:47 -0400")
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Steven Rostedt <rostedt@goodmis.org>, Luiz Capitulino <lcapitulino@redhat.com>, lttng-dev@lists.lttng.org, Masami Hiramatsu <mhiramat@kernel.org>
List-Id: lttng-dev@lists.lttng.org

U3RlZmFuIEhham5vY3ppIHdyaXRlczoKCj4gT24gTW9uLCBBdWcgMjksIDIwMTYgYXQgMDg6NDY6
MDJQTSArMDIwMCwgTGx1w61zIFZpbGFub3ZhIHdyb3RlOgo+PiA+PiBBbHNvLCBJJ20gc3RpbGwg
bm90IHN1cmUgaG93IHRvIGludGVyYWN0IHdpdGggUUVNVSdzIG1vbml0b3IgaW50ZXJmYWNlIGZy
b20KPj4gPj4gd2l0aGluIHRoZSBwcm9iZSBjb2RlIChwcm9iZXMgZXhlY3V0ZSBpbiBrZXJuZWwg
bW9kZSwgaW5jbHVkaW5nICJndXJ1IG1vZGUiCj4+ID4+IGNvZGUpLgo+PiAKPj4gPiBXaGVuIFN5
c3RlbVRhcCBpcyB1c2VkIHRoZSBRRU1VIG1vbml0b3IgaW50ZXJmYWNlIGRvZXMgbm90aGluZy4K
Pj4gCj4+IFRoYXQncyBub3Qgd2hhdCBJJ3ZlIGV4cGVyaWVuY2VkLiBJIHdhcyBhYmxlIHRvIHVz
ZSBhIHN0YXAgc2NyaXB0IHRvIGNoYW5nZSB0aGUKPj4gdHJhY2luZyBzdGF0ZSBvZiBldmVudHM6
Cj4+IAo+PiAjIS91c3IvYmluL2VudiBzdGFwCj4+IAo+PiAlewo+PiAjaW5jbHVkZSA8L2hvbWUv
bGx1aXMvUHJvamVjdHMvcWVtdS1kYmktdGVzdC90ZXN0Lmg+Cj4+ICV9Cj4+IAo+PiBmdW5jdGlv
biBldmVudDpsb25nKGNwdTpsb25nLCBhZGRyOmxvbmcsIGluZm86bG9uZykKPj4gJXsKPj4gY2hh
ciAqYXJndls0XSA9IHsiL2Jpbi9zaCIsICItYyIsICJlY2hvICd0cmFjZS1ldmVudCAqIG9mZicg
fCB0ZWxuZXQgbG9jYWxob3N0IDEyMzQiLCBOVUxMfTsKPj4gY2FsbF91c2VybW9kZWhlbHBlcihh
cmd2WzBdLCBhcmd2LCBOVUxMLCBVTUhfV0FJVF9FWEVDKTsKPj4gU1RBUF9SRVRVUk4oMCk7Cj4+
ICV9Cj4+IAo+PiBwcm9iZSBiZWdpbiB7Cj4+IHByaW50ZigiaGVsbG9cbiIpCj4+IH0KPj4gcHJv
YmUgcHJvY2VzcygiLi9pbnN0YWxsL3ZhbmlsbGEvYmluL3FlbXUtc3lzdGVtLWkzODYiKS5tYXJr
KCJndWVzdF9tZW1fYmVmb3JlX2V4ZWMiKQo+PiB7Cj4+IHByaW50ZigiJXggJWQgJWRcbiIsICRh
cmcxLCAkYXJnMiwgJGFyZzMpCj4+IGV2ZW50KCRhcmcxLCAkYXJnMiwgJGFyZzMpCj4+IGV4aXQo
KQo+PiB9Cj4+IAo+PiBUaGUgb25seSBjYXZlYXQgaXMgdGhhdCB5b3UgbXVzdCBwYXNzIHRoZSAi
LWciIGFyZ3VtZW50IHRvIHN0YXAuCj4+IAo+PiBBbHNvLCBmb3Igc29tZSByZWFzb24gdGhlIHBy
aW50ZiBpbiB0aGUgcHJvYmUgYWx3YXlzIHByaW50cyB6ZXJvcywgbm8gbWF0dGVyCj4+IHdoYXQg
dGhlIGFjdHVhbCBldmVudCByZWNlaXZlcyAoSSd2ZSBkZWJ1Z2dlZCBRRU1VIGRvd24gdG8gdGhl
IGNhbGwgdG8gdGhlCj4+IGF1dG8tZ2VuZXJhdGVkIHN0YXAgZnVuY3Rpb25zKS4gQ291bGQgdGhp
cyBiZSBhbiBlcnJvciBpbiBzeXN0ZW10YXA/Cgo+IEl0J3Mgc3RyYW5nZSB0aGF0IGFyZ3VtZW50
cyBkbyBub3QgaGF2ZSB2YWxpZCB2YWx1ZXMuICBEZWJ1Z2dpbmcgdGhlCj4gc3RhcCBmdW5jdGlv
bnMgaXMgdGhlIG5leHQgc3RlcCBpZiB5b3Ugd2FudCB0byBmaWd1cmUgb3V0IHdoYXQgaGFwcGVu
ZWQuCj4gSSd2ZSBuZXZlciBoYWQgdGhpcyBpc3N1ZSBiZWZvcmUgc28gbWF5YmUgc29tZXRoaW5n
IHdpdGggRGViaWFuCj4gU3lzdGVtVGFwIHVzZXJzcGFjZSBwcm9iZXMgaXMgYnJva2VuLgoKSSBh
bHJlYWR5IGRlYnVnZ2VkIGl0LCB0byB0aGUgcG9pbnQgd2hlcmUgUUVNVSBleGVjdXRlcyB0aGUg
dHJhcCBpbmplY3RlZCBieQpzeXN0ZW10YXAsIGFuZCB0aGUgcmVnaXN0ZXIgdmFsdWVzIHRoYXQg
d2VyZSBzdXBwb3NlZCB0byBob2xkIHRoZSBhcmd1bWVudHMgYXJlCmNvcnJlY3QuCgpJIHN1cHBv
c2UgdGhhdCBpZiB5b3UgZXhlY3V0ZSB0aGUgc3RhcCBzY3JpcHQgSSBwYXN0ZWQgaXQgd2lsbCBz
aG93IHRoZSBwcm9wZXIKdmFsdWVzLiBUaGVuIGl0J3MgZGVmaW5pdGVseSBhIHByb2JsZW0gd2l0
aCBEZWJpYW4ncyB1c2Vyc3BhY2UgcHJvYmVzLgoKClRoYW5rcywKICBMbHVpcwpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBs
aXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dp
LWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
