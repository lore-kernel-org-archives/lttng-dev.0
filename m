From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
Subject: Re: [Qemu-devel] [PATCH 0/6] hypertrace: Lightweight
	guest-to-QEMU trace channel
Date: Thu, 18 Aug 2016 12:22:18 +0200
Message-ID: <87wpjeqsv9.fsf__43330.134850885$1471515764$gmane$org@fimbulvetr.bsc.es>
References: <147041636348.2523.2954972609232949598.stgit@fimbulvetr.bsc.es>
 <20160818094720.GA4850@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from roura.ac.upc.es (roura.ac.upc.edu [147.83.33.10])
 by evm-lttng-1.efficios.com (Postfix) with ESMTP id 7EB9DA03A3
 for <lttng-dev@lists.lttng.org>; Thu, 18 Aug 2016 10:22:37 +0000 (UTC)
In-Reply-To: <20160818094720.GA4850@stefanha-x1.localdomain> (Stefan
 Hajnoczi's message of "Thu, 18 Aug 2016 10:47:20 +0100")
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Steven Rostedt <rostedt@goodmis.org>, Luiz Capitulino <lcapitulino@redhat.com>, lttng-dev@lists.lttng.org, Masami Hiramatsu <mhiramat@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: lttng-dev@lists.lttng.org

U3RlZmFuIEhham5vY3ppIHdyaXRlczoKCj4gT24gRnJpLCBBdWcgMDUsIDIwMTYgYXQgMDY6NTk6
MjNQTSArMDIwMCwgTGx1w61zIFZpbGFub3ZhIHdyb3RlOgo+PiBUaGUgaHlwZXJ0cmFjZSBjaGFu
bmVsIGFsbG93cyBndWVzdCBjb2RlIHRvIGVtaXQgZXZlbnRzIGluIFFFTVUgKHRoZSBob3N0KSB1
c2luZwo+PiBpdHMgdHJhY2luZyBpbmZyYXN0cnVjdHVyZSAoc2VlICJkb2NzL3RyYWNlLnR4dCIp
LiBUaGlzIHdvcmtzIGluIGJvdGggJ3N5c3RlbScKPj4gYW5kICd1c2VyJyBtb2Rlcy4gVGhhdCBp
cywgaHlwZXJ0cmFjZSBpcyB0byB0cmFjaW5nLCB3aGF0IGh5cGVyY2FsbHMgYXJlIHRvCj4+IHN5
c3RlbSBjYWxscy4KPj4gCj4+IFlvdSBjYW4gdXNlIHRoaXMgdG8gZW1pdCBhbiBldmVudCBvbiBi
b3RoIGd1ZXN0IGFuZCBRRU1VIChob3N0KSB0cmFjZXMgdG8gZWFzaWx5Cj4+IHN5bmNocm9uaXpl
IG9yIGNvcnJlbGF0ZSB0aGVtLiBZb3UgY291bGQgYWxzbyBtb2RpZnkgeW91IGd1ZXN0J3MgdHJh
Y2luZyBzeXN0ZW0KPj4gdG8gZW1pdCBhbGwgZXZlbnRzIHRocm91Z2ggdGhlIGh5cGVydHJhY2Ug
Y2hhbm5lbCwgcHJvdmlkaW5nIGEgdW5pZmllZCBhbmQgZnVsbHkKPj4gc3luY2hyb25pemVkIHRy
YWNlIGxvZy4gQW5vdGhlciB1c2UgY2FzZSBpcyB0aW1pbmcgdGhlIHBlcmZvcm1hbmNlIG9mIGd1
ZXN0IGNvZGUKPj4gd2hlbiBvcHRpbWl6aW5nIFRDRyAoUUVNVSB0cmFjZXMgaGF2ZSBhIHRpbWVz
dGFtcCkuCj4+IAo+PiBTZWUgZmlyc3QgY29tbWl0IGZvciBhIGZ1bGwgZGVzY3JpcHRpb24uCj4+
IAo+PiBTaWduZWQtb2ZmLWJ5OiBMbHXDrXMgVmlsYW5vdmEgPHZpbGFub3ZhQGFjLnVwYy5lZHU+
Cj4+IC0tLQoKPiBDQ2luZyBTdGV2ZW4gUm9zdGVkdCwgTWFzYW1pIEhpcmFtYXRzdSwgTHVpeiBD
YXBpdHVsaW5vLCBhbmQgTFRUbmcgZm9sa3MKPiB3aG8gaGF2ZSBhbGwgbG9va2VkIGludG8gaG9z
dC9ndWVzdCB0cmFjaW5nIHNvbHV0aW9ucy4KWy4uLl0KCk9oLCBJIHdhc24ndCBhd2FyZSBvZiB0
aGF0LiBJJ20gY2VydGFpbmx5IGludGVyZXN0ZWQgaW4gY29sbGFib3JhdGluZy4KCgpDaGVlcnMs
CiAgTGx1aXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8v
bGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
