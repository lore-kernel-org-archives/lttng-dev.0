From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
Subject: Re: [Qemu-devel] [PATCH 0/6] hypertrace: Lightweight
	guest-to-QEMU trace channel
Date: Mon, 05 Sep 2016 20:29:54 +0200
Message-ID: <8760qaryhp.fsf__30419.5337616422$1473100215$gmane$org@fimbulvetr.bsc.es>
References: <147041636348.2523.2954972609232949598.stgit@fimbulvetr.bsc.es>
 <20160818105424.GD4850@stefanha-x1.localdomain>
 <8737lypajh.fsf@fimbulvetr.bsc.es>
 <20160823155430.GB3948@stefanha-x1.localdomain>
 <87lgzm4g5p.fsf@fimbulvetr.bsc.es>
 <20160829134502.GA26282@stefanha-x1.localdomain>
 <87a8fvjtw5.fsf@fimbulvetr.bsc.es> <20160905145916.GI24656@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from roura.ac.upc.es (roura.ac.upc.edu [147.83.33.10])
 by evm-lttng-1.efficios.com (Postfix) with ESMTP id 2A9BAA3AD8
 for <lttng-dev@lists.lttng.org>; Mon,  5 Sep 2016 18:30:41 +0000 (UTC)
In-Reply-To: <20160905145916.GI24656@redhat.com> (Daniel P. Berrange's message
 of "Mon, 5 Sep 2016 15:59:16 +0100")
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

RGFuaWVsIFAgQmVycmFuZ2Ugd3JpdGVzOgoKPiBPbiBNb24sIEF1ZyAyOSwgMjAxNiBhdCAwODo0
NjowMlBNICswMjAwLCBMbHXDrXMgVmlsYW5vdmEgd3JvdGU6Cj4+IFN0ZWZhbiBIYWpub2N6aSB3
cml0ZXM6Cj4+IAo+PiA+IFdoZW4gU3lzdGVtVGFwIGlzIHVzZWQgdGhlIFFFTVUgbW9uaXRvciBp
bnRlcmZhY2UgZG9lcyBub3RoaW5nLgo+PiAKPj4gVGhhdCdzIG5vdCB3aGF0IEkndmUgZXhwZXJp
ZW5jZWQuIEkgd2FzIGFibGUgdG8gdXNlIGEgc3RhcCBzY3JpcHQgdG8gY2hhbmdlIHRoZQo+PiB0
cmFjaW5nIHN0YXRlIG9mIGV2ZW50czoKPj4gCj4+ICMhL3Vzci9iaW4vZW52IHN0YXAKPj4gCj4+
ICV7Cj4+ICNpbmNsdWRlIDwvaG9tZS9sbHVpcy9Qcm9qZWN0cy9xZW11LWRiaS10ZXN0L3Rlc3Qu
aD4KPj4gJX0KPj4gCj4+IGZ1bmN0aW9uIGV2ZW50OmxvbmcoY3B1OmxvbmcsIGFkZHI6bG9uZywg
aW5mbzpsb25nKQo+PiAlewo+PiBjaGFyICphcmd2WzRdID0geyIvYmluL3NoIiwgIi1jIiwgImVj
aG8gJ3RyYWNlLWV2ZW50ICogb2ZmJyB8IHRlbG5ldCBsb2NhbGhvc3QgMTIzNCIsIE5VTEx9Owo+
PiBjYWxsX3VzZXJtb2RlaGVscGVyKGFyZ3ZbMF0sIGFyZ3YsIE5VTEwsIFVNSF9XQUlUX0VYRUMp
Owo+PiBTVEFQX1JFVFVSTigwKTsKPj4gJX0KCj4gSSBkb24ndCBrbm93IHdoYXQgeW91J3JlIHRy
eWluZyB0byBhY2hpZXZlIGhlcmUuICBUaGUgdHJhY2UtZXZlbnQgc3RhdGUsCj4gYXMgY2hhbmdl
ZC92aWV3ZWQgdmlhIFFFTVUgbW9uaXRvciwgaXMgaXJyZWxldmFudCB0byB0aGUgZHRyYWNlIChz
eXN0ZW10YXApCj4gYmFja2VuZC4gZHRyYWNlIGFuZCBsdHQtdXN0IGFyZSBib3RoIGZ1bGx5IGR5
bmFtaWMgdHJhY2UgZXZlbnQgYmFja2VuZHMsCj4gc28gdGhlIFFFTVUgZXZlbnQgc3RhdGUgaGFz
IG5vIGVmZmVjdCBvbiB0aGVtLiBUaGUgcHJvYmUgcG9pbnRzIGluIHRoZQo+IGJpbmFyeSBhcmUg
ZHluYW1pY2FsbHkgZW5hYmxlZCAvIGRpc2FibGVkIGJ5IHRoZSBkdHJhY2UgcnVudGltZS4gaWUg
ZHRyYWNlCj4gd2lsbCBhdXRvbWF0aWNhbGx5IGVuYWJsZSBhbiBldmVudCBpZiB5b3Ugd3JpdGUg
YSBkdHJhY2Ugc2NyaXB0IHRoYXQgdXNlcwo+IHRoZSBldmVudC4KClNvcnJ5LCBJIGRpZCBub3Qg
cHJvcGVybHkgZXhwbGFpbiB0aGUgdXNlIGNhc2UuIFRoaXMgaXMgYW4gZXhhbXBsZSBvZiB1c2lu
ZwpRRU1VJ3MgdHJhY2luZyBpbmZyYXN0cnVjdHVyZSB0byBjb250cm9sIGl0c2VsZi4gSGVyZSBJ
J20gdXNpbmcgdGhlICJsb2ciCmJhY2tlbmQgdG8gdHJhY2UgZXZlbnRzIHRvIGRpc2ssIGFuZCB0
aGUgImR0cmFjZSIgYmFja2VuZCAoc3lzdGVtdGFwKSB0byBjb250cm9sCnRoZSB0cmFjaW5nIHN0
YXRlIG9mIHN1Y2ggZXZlbnRzLgoKVGhlIGd1ZXN0IGNvZGUgaXMgc29tZXRoaW5nIGxpa2U6Cgog
IC8vIHNvbWUgZ3Vlc3QgY29kZSBleGVjdXRlZCAqd2l0aG91dCogdHJhY2luZyBlbmFibGVkCgog
IGludm9rZV9oeXBlcnRyYWNlX2V2ZW50KCk7IC8vIHN0YXAgd2lsbCBlbmFibGUgc29tZSBldmVu
dHMgaGVyZQoKICAvLyBzb21lIGd1ZXN0IGNvZGUgZXhlY3V0ZWQgKndpdGgqIHRyYWNpbmcgZW5h
YmxlZAoKICBpbnZva2VfaHlwZXJ0cmFjZV9ldmVudCgpOyAvLyBzdGFwIHdpbGwgZGlzYWJsZSBz
b21lIGV2ZW50cyBoZXJlCgogIC8vIHNvbWUgZ3Vlc3QgY29kZSBleGVjdXRlZCAqd2l0aG91dCog
dHJhY2luZyBlbmFibGVkCgpTbyB3ZSBjYW4gdXNlIGl0IHRvIG1hcmsgcmVnaW9ucyBvZiBpbnRl
cmVzdCBmb3IgdHJhY2luZy4KCgpDaGVlcnMsCiAgTGx1aXMKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1k
ZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1h
bi9saXN0aW5mby9sdHRuZy1kZXYK
