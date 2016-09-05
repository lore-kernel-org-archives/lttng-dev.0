From: "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/6] hypertrace: Lightweight
 guest-to-QEMU trace channel
Date: Mon, 5 Sep 2016 19:59:30 +0100
Message-ID: <20160905185930.GP24656__19908.1878680319$1473101994$gmane$org@redhat.com>
References: <147041636348.2523.2954972609232949598.stgit@fimbulvetr.bsc.es>
 <20160818105424.GD4850@stefanha-x1.localdomain>
 <8737lypajh.fsf@fimbulvetr.bsc.es>
 <20160823155430.GB3948@stefanha-x1.localdomain>
 <87lgzm4g5p.fsf@fimbulvetr.bsc.es>
 <20160829134502.GA26282@stefanha-x1.localdomain>
 <87a8fvjtw5.fsf@fimbulvetr.bsc.es>
 <20160905145916.GI24656@redhat.com>
 <8760qaryhp.fsf@fimbulvetr.bsc.es>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 5BFE8A3AD8
 for <lttng-dev@lists.lttng.org>; Mon,  5 Sep 2016 19:00:15 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <8760qaryhp.fsf@fimbulvetr.bsc.es>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Stefan Hajnoczi <stefanha@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Steven Rostedt <rostedt@goodmis.org>, Luiz Capitulino <lcapitulino@redhat.com>, lttng-dev@lists.lttng.org, Masami Hiramatsu <mhiramat@kernel.org>
List-Id: lttng-dev@lists.lttng.org

T24gTW9uLCBTZXAgMDUsIDIwMTYgYXQgMDg6Mjk6NTRQTSArMDIwMCwgTGx1w61zIFZpbGFub3Zh
IHdyb3RlOgo+IERhbmllbCBQIEJlcnJhbmdlIHdyaXRlczoKPiAKPiA+IE9uIE1vbiwgQXVnIDI5
LCAyMDE2IGF0IDA4OjQ2OjAyUE0gKzAyMDAsIExsdcOtcyBWaWxhbm92YSB3cm90ZToKPiA+PiBT
dGVmYW4gSGFqbm9jemkgd3JpdGVzOgo+ID4+IAo+ID4+ID4gV2hlbiBTeXN0ZW1UYXAgaXMgdXNl
ZCB0aGUgUUVNVSBtb25pdG9yIGludGVyZmFjZSBkb2VzIG5vdGhpbmcuCj4gPj4gCj4gPj4gVGhh
dCdzIG5vdCB3aGF0IEkndmUgZXhwZXJpZW5jZWQuIEkgd2FzIGFibGUgdG8gdXNlIGEgc3RhcCBz
Y3JpcHQgdG8gY2hhbmdlIHRoZQo+ID4+IHRyYWNpbmcgc3RhdGUgb2YgZXZlbnRzOgo+ID4+IAo+
ID4+ICMhL3Vzci9iaW4vZW52IHN0YXAKPiA+PiAKPiA+PiAlewo+ID4+ICNpbmNsdWRlIDwvaG9t
ZS9sbHVpcy9Qcm9qZWN0cy9xZW11LWRiaS10ZXN0L3Rlc3QuaD4KPiA+PiAlfQo+ID4+IAo+ID4+
IGZ1bmN0aW9uIGV2ZW50OmxvbmcoY3B1OmxvbmcsIGFkZHI6bG9uZywgaW5mbzpsb25nKQo+ID4+
ICV7Cj4gPj4gY2hhciAqYXJndls0XSA9IHsiL2Jpbi9zaCIsICItYyIsICJlY2hvICd0cmFjZS1l
dmVudCAqIG9mZicgfCB0ZWxuZXQgbG9jYWxob3N0IDEyMzQiLCBOVUxMfTsKPiA+PiBjYWxsX3Vz
ZXJtb2RlaGVscGVyKGFyZ3ZbMF0sIGFyZ3YsIE5VTEwsIFVNSF9XQUlUX0VYRUMpOwo+ID4+IFNU
QVBfUkVUVVJOKDApOwo+ID4+ICV9Cj4gCj4gPiBJIGRvbid0IGtub3cgd2hhdCB5b3UncmUgdHJ5
aW5nIHRvIGFjaGlldmUgaGVyZS4gIFRoZSB0cmFjZS1ldmVudCBzdGF0ZSwKPiA+IGFzIGNoYW5n
ZWQvdmlld2VkIHZpYSBRRU1VIG1vbml0b3IsIGlzIGlycmVsZXZhbnQgdG8gdGhlIGR0cmFjZSAo
c3lzdGVtdGFwKQo+ID4gYmFja2VuZC4gZHRyYWNlIGFuZCBsdHQtdXN0IGFyZSBib3RoIGZ1bGx5
IGR5bmFtaWMgdHJhY2UgZXZlbnQgYmFja2VuZHMsCj4gPiBzbyB0aGUgUUVNVSBldmVudCBzdGF0
ZSBoYXMgbm8gZWZmZWN0IG9uIHRoZW0uIFRoZSBwcm9iZSBwb2ludHMgaW4gdGhlCj4gPiBiaW5h
cnkgYXJlIGR5bmFtaWNhbGx5IGVuYWJsZWQgLyBkaXNhYmxlZCBieSB0aGUgZHRyYWNlIHJ1bnRp
bWUuIGllIGR0cmFjZQo+ID4gd2lsbCBhdXRvbWF0aWNhbGx5IGVuYWJsZSBhbiBldmVudCBpZiB5
b3Ugd3JpdGUgYSBkdHJhY2Ugc2NyaXB0IHRoYXQgdXNlcwo+ID4gdGhlIGV2ZW50Lgo+IAo+IFNv
cnJ5LCBJIGRpZCBub3QgcHJvcGVybHkgZXhwbGFpbiB0aGUgdXNlIGNhc2UuIFRoaXMgaXMgYW4g
ZXhhbXBsZSBvZiB1c2luZwo+IFFFTVUncyB0cmFjaW5nIGluZnJhc3RydWN0dXJlIHRvIGNvbnRy
b2wgaXRzZWxmLiBIZXJlIEknbSB1c2luZyB0aGUgImxvZyIKPiBiYWNrZW5kIHRvIHRyYWNlIGV2
ZW50cyB0byBkaXNrLCBhbmQgdGhlICJkdHJhY2UiIGJhY2tlbmQgKHN5c3RlbXRhcCkgdG8gY29u
dHJvbAo+IHRoZSB0cmFjaW5nIHN0YXRlIG9mIHN1Y2ggZXZlbnRzLgoKQWgsIEkgc2VlLiBJIGd1
ZXNzIEknZCBwZXJzb25hbGx5IGp1c3QgaGF2ZSBzeXN0ZW10YXAvZHRyYWNlIGRpcmVjdGx5IGVt
aXQKdGhlIGRhdGEgdG8gYmUgcmVjb3JkZWQsIGFuZCBhdm9pZCB0aGUgbG9nIGJhY2tlbmQgZW50
aXJlbHkuCgpSZWdhcmRzLApEYW5pZWwKLS0gCnw6IGh0dHA6Ly9iZXJyYW5nZS5jb20gICAgICAt
by0gICAgaHR0cDovL3d3dy5mbGlja3IuY29tL3Bob3Rvcy9kYmVycmFuZ2UvIDp8Cnw6IGh0dHA6
Ly9saWJ2aXJ0Lm9yZyAgICAgICAgICAgICAgLW8tICAgICAgICAgICAgIGh0dHA6Ly92aXJ0LW1h
bmFnZXIub3JnIDp8Cnw6IGh0dHA6Ly9hdXRvYnVpbGQub3JnICAgICAgIC1vLSAgICAgICAgIGh0
dHA6Ly9zZWFyY2guY3Bhbi5vcmcvfmRhbmJlcnIvIDp8Cnw6IGh0dHA6Ly9lbnRhbmdsZS1waG90
by5vcmcgICAgICAgLW8tICAgICAgIGh0dHA6Ly9saXZlLmdub21lLm9yZy9ndGstdm5jIDp8Cl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBt
YWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5n
Lm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
