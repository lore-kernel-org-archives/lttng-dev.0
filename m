From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
Subject: Re: [Qemu-devel] [PATCH 0/6] hypertrace: Lightweight
	guest-to-QEMU trace channel
Date: Tue, 06 Sep 2016 10:54:46 +0200
Message-ID: <8737ldpfvt.fsf__17577.5601914667$1473152116$gmane$org@fimbulvetr.bsc.es>
References: <147041636348.2523.2954972609232949598.stgit@fimbulvetr.bsc.es>
 <20160818105424.GD4850@stefanha-x1.localdomain>
 <8737lypajh.fsf@fimbulvetr.bsc.es>
 <20160823155430.GB3948@stefanha-x1.localdomain>
 <87lgzm4g5p.fsf@fimbulvetr.bsc.es>
 <20160829134502.GA26282@stefanha-x1.localdomain>
 <87a8fvjtw5.fsf@fimbulvetr.bsc.es> <20160905145916.GI24656@redhat.com>
 <8760qaryhp.fsf@fimbulvetr.bsc.es> <20160905185930.GP24656@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from roura.ac.upc.es (roura.ac.upc.es [147.83.33.10])
 by evm-lttng-1.efficios.com (Postfix) with ESMTP id 6181BA3113
 for <lttng-dev@lists.lttng.org>; Tue,  6 Sep 2016 08:55:35 +0000 (UTC)
In-Reply-To: <20160905185930.GP24656@redhat.com> (Daniel P. Berrange's message
 of "Mon, 5 Sep 2016 19:59:30 +0100")
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Steven Rostedt <rostedt@goodmis.org>, Luiz Capitulino <lcapitulino@redhat.com>, lttng-dev@lists.lttng.org, Masami Hiramatsu <mhiramat@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: lttng-dev@lists.lttng.org

RGFuaWVsIFAgQmVycmFuZ2Ugd3JpdGVzOgoKPiBPbiBNb24sIFNlcCAwNSwgMjAxNiBhdCAwODoy
OTo1NFBNICswMjAwLCBMbHXDrXMgVmlsYW5vdmEgd3JvdGU6Cj4+IERhbmllbCBQIEJlcnJhbmdl
IHdyaXRlczoKPj4gCj4+ID4gT24gTW9uLCBBdWcgMjksIDIwMTYgYXQgMDg6NDY6MDJQTSArMDIw
MCwgTGx1w61zIFZpbGFub3ZhIHdyb3RlOgo+PiA+PiBTdGVmYW4gSGFqbm9jemkgd3JpdGVzOgo+
PiA+PiAKPj4gPj4gPiBXaGVuIFN5c3RlbVRhcCBpcyB1c2VkIHRoZSBRRU1VIG1vbml0b3IgaW50
ZXJmYWNlIGRvZXMgbm90aGluZy4KPj4gPj4gCj4+ID4+IFRoYXQncyBub3Qgd2hhdCBJJ3ZlIGV4
cGVyaWVuY2VkLiBJIHdhcyBhYmxlIHRvIHVzZSBhIHN0YXAgc2NyaXB0IHRvIGNoYW5nZSB0aGUK
Pj4gPj4gdHJhY2luZyBzdGF0ZSBvZiBldmVudHM6Cj4+ID4+IAo+PiA+PiAjIS91c3IvYmluL2Vu
diBzdGFwCj4+ID4+IAo+PiA+PiAlewo+PiA+PiAjaW5jbHVkZSA8L2hvbWUvbGx1aXMvUHJvamVj
dHMvcWVtdS1kYmktdGVzdC90ZXN0Lmg+Cj4+ID4+ICV9Cj4+ID4+IAo+PiA+PiBmdW5jdGlvbiBl
dmVudDpsb25nKGNwdTpsb25nLCBhZGRyOmxvbmcsIGluZm86bG9uZykKPj4gPj4gJXsKPj4gPj4g
Y2hhciAqYXJndls0XSA9IHsiL2Jpbi9zaCIsICItYyIsICJlY2hvICd0cmFjZS1ldmVudCAqIG9m
ZicgfCB0ZWxuZXQgbG9jYWxob3N0IDEyMzQiLCBOVUxMfTsKPj4gPj4gY2FsbF91c2VybW9kZWhl
bHBlcihhcmd2WzBdLCBhcmd2LCBOVUxMLCBVTUhfV0FJVF9FWEVDKTsKPj4gPj4gU1RBUF9SRVRV
Uk4oMCk7Cj4+ID4+ICV9Cj4+IAo+PiA+IEkgZG9uJ3Qga25vdyB3aGF0IHlvdSdyZSB0cnlpbmcg
dG8gYWNoaWV2ZSBoZXJlLiAgVGhlIHRyYWNlLWV2ZW50IHN0YXRlLAo+PiA+IGFzIGNoYW5nZWQv
dmlld2VkIHZpYSBRRU1VIG1vbml0b3IsIGlzIGlycmVsZXZhbnQgdG8gdGhlIGR0cmFjZSAoc3lz
dGVtdGFwKQo+PiA+IGJhY2tlbmQuIGR0cmFjZSBhbmQgbHR0LXVzdCBhcmUgYm90aCBmdWxseSBk
eW5hbWljIHRyYWNlIGV2ZW50IGJhY2tlbmRzLAo+PiA+IHNvIHRoZSBRRU1VIGV2ZW50IHN0YXRl
IGhhcyBubyBlZmZlY3Qgb24gdGhlbS4gVGhlIHByb2JlIHBvaW50cyBpbiB0aGUKPj4gPiBiaW5h
cnkgYXJlIGR5bmFtaWNhbGx5IGVuYWJsZWQgLyBkaXNhYmxlZCBieSB0aGUgZHRyYWNlIHJ1bnRp
bWUuIGllIGR0cmFjZQo+PiA+IHdpbGwgYXV0b21hdGljYWxseSBlbmFibGUgYW4gZXZlbnQgaWYg
eW91IHdyaXRlIGEgZHRyYWNlIHNjcmlwdCB0aGF0IHVzZXMKPj4gPiB0aGUgZXZlbnQuCj4+IAo+
PiBTb3JyeSwgSSBkaWQgbm90IHByb3Blcmx5IGV4cGxhaW4gdGhlIHVzZSBjYXNlLiBUaGlzIGlz
IGFuIGV4YW1wbGUgb2YgdXNpbmcKPj4gUUVNVSdzIHRyYWNpbmcgaW5mcmFzdHJ1Y3R1cmUgdG8g
Y29udHJvbCBpdHNlbGYuIEhlcmUgSSdtIHVzaW5nIHRoZSAibG9nIgo+PiBiYWNrZW5kIHRvIHRy
YWNlIGV2ZW50cyB0byBkaXNrLCBhbmQgdGhlICJkdHJhY2UiIGJhY2tlbmQgKHN5c3RlbXRhcCkg
dG8gY29udHJvbAo+PiB0aGUgdHJhY2luZyBzdGF0ZSBvZiBzdWNoIGV2ZW50cy4KCj4gQWgsIEkg
c2VlLiBJIGd1ZXNzIEknZCBwZXJzb25hbGx5IGp1c3QgaGF2ZSBzeXN0ZW10YXAvZHRyYWNlIGRp
cmVjdGx5IGVtaXQKPiB0aGUgZGF0YSB0byBiZSByZWNvcmRlZCwgYW5kIGF2b2lkIHRoZSBsb2cg
YmFja2VuZCBlbnRpcmVseS4KCkJhY2tlbmRzIHdpdGggYSBidWZmZXJlZCBvdXRwdXQgc3RyZWFt
IGxpa2UgInNpbXBsZSIgc2hvdWxkIGJlIGZhc3RlciB0aGFuCiJkdHJhY2UiLCB3aGljaCBBRkFJ
SyBpbmplY3RzIGEgc29mdHdhcmUgdHJhcC4gQWxzbywgeW91IGNhbiB0YWtlIGFkdmFudGFnZSBv
ZgpleGlzdGluZyBRRU1VIGluZnJhc3RydWN0dXJlIHRvIGNvbnRyb2wgdGhlIHRyYWNpbmcgb2Yg
ZXZlbnRzLCBpbnN0ZWFkIG9mCmltcGxlbWVudGluZyB5b3VyIG93biBvbiBlYWNoIHNjcmlwdC4K
CkNoZWVycywKICBMbHVpcwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcK
aHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRl
dgo=
