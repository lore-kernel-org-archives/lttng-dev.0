From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
Subject: Re: [Qemu-devel] [PATCH 0/6] hypertrace: Lightweight
	guest-to-QEMU trace channel
Date: Wed, 24 Aug 2016 12:25:54 +0200
Message-ID: <87lgzm4g5p.fsf__30452.6418484331$1472034377$gmane$org@fimbulvetr.bsc.es>
References: <147041636348.2523.2954972609232949598.stgit@fimbulvetr.bsc.es>
 <20160818105424.GD4850@stefanha-x1.localdomain>
 <8737lypajh.fsf@fimbulvetr.bsc.es>
 <20160823155430.GB3948@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from roura.ac.upc.es (roura.ac.upc.edu [147.83.33.10])
 by evm-lttng-1.efficios.com (Postfix) with ESMTP id B6BAAA3BEC
 for <lttng-dev@lists.lttng.org>; Wed, 24 Aug 2016 10:26:20 +0000 (UTC)
In-Reply-To: <20160823155430.GB3948@stefanha-x1.localdomain> (Stefan
 Hajnoczi's message of "Tue, 23 Aug 2016 11:54:30 -0400")
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

U3RlZmFuIEhham5vY3ppIHdyaXRlczoKCj4gT24gU3VuLCBBdWcgMjEsIDIwMTYgYXQgMDI6MzI6
MzRQTSArMDIwMCwgTGx1w61zIFZpbGFub3ZhIHdyb3RlOgo+PiBVbmZvcnR1bnRlbHksIEkndmUg
YmVlbiB1bmFibGUgdG8gdG8gbWFrZSBkdHJhY2UgcmVjb2duaXNlIFFFTVUncyBldmVudHMgKEkn
bQo+PiBvbmx5IGFibGUgdG8gc2VlIHRoZSBob3N0IGtlcm5lbCBldmVudHMpLiBJZiBzb21lb25l
IHdpdGggbW9yZSBleHBlcmllbmNlIG9uIGl0Cj4+IGNhbiBoZWxwIG1lIHVzZSBkdHJhY2Ugd2l0
aCBRRU1VJ3MgZXZlbnRzLCBJJ2xsIGFsc28gYWRkIHRoZSBzdXBwb3J0aW5nIGxpYnJhcnkKPj4g
dG8gbGV0IGR0cmFjZSBkbyB0aGUgY2FsbG91dCB0byBRRU1VJ3MgbW9pdG9yIGludGVyZmFjZSBh
bmQgY29udHJvbCB0aGUgZXZlbnRzLAo+PiBhbmQgYWRkIGEgcHJwZXJseSB1c2VmdWwgZXhhbXBs
ZSBvZiB0aGF0IG9uIHRoZSBoeXBlcnRyYWNlIGRvY3MgKHdoaWNoIHdhcyBteQo+PiBvcmlnaW5h
bCBpbnRlbnRpb24pLgoKPiBXaGljaCAiZHRyYWNlIiBhbmQgaG9zdCBPUyBhcmUgeW91IHVzaW5n
PwoKPiBRRU1VIGJ1aWxkcyB3aXRoIHN0YXRpYyB1c2VyLXNwYWNlIHByb2Jlcy4gIFlvdSBuZWVk
IHRvIHRlbGwgRFRyYWNlIG9yCj4gU3lzdGVtVGFwIHRvIGVuYWJsZSB0aG9zZSBwcm9iZXMgaW4g
b3JkZXIgdG8gcmVjb3JkIHRyYWNlIGRhdGEuCgpJJ20gdXNpbmcgZGViaWFuIG9uIGEgNC42LjAt
MS1hbWQ2NCBrZXJuZWwgd2l0aCBzeXN0ZW10YXAgMy4wLjYuCgpJIGp1c3QgZ2F2ZSBpdCBhbm90
aGVyIHRyeSwgYW5kIHdvcmtzIGlmIEkgdXNlIHByb2JlcyBsaWtlOgoKICBwcm9jZXNzKCI8Ymlu
YXJ5LXBhdGg+IikubWFyaygiPGV2ZW50LW5hbWU+IikKCmFsdGhvdWdoIHRoZXkgZG9uJ3Qgc2Vl
bSB0byBhcHBlYXIgb24gInN0YXAgLWwiIG9yIGFueXRoaW5nIGxpa2UgdGhhdCAoSSBjYW5ub3QK
ZmluZCBhICJxZW11IiBwcm92aWRlcikuIEJ1dCBJJ20gc3RpbGwgdW5hYmxlIHRvIHByaW50IHRo
ZSBldmVudCB2YWx1ZXMuIFRoaXM6CgogIHByb2JlIHByb2Nlc3MoIi4vaW5zdGFsbC92YW5pbGxh
L2Jpbi9xZW11LXN5c3RlbS1pMzg2IikubWFyaygiZ3Vlc3RfbWVtX2JlZm9yZV9leGVjIikKICB7
CiAgICAgIHByaW50ZigiJXAgJWx4ICVkXG4iLCAkYXJnMSwgJGFyZzIsICRhcmczKQogIH0KCmFs
d2F5cyBwcmludHMgIjB4MCAweDAgMCIsIHdoaWNoIGlzIGNsZWFybHkgd3JvbmcgKG90aGVyIGJh
Y2tlbmQgb24gdGhlIHNhbWUKYnVpbGQgcHJpbnQgdGhlIGNvcnJlY3QgdmFsdWVzKS4KCkFsc28s
IEknbSBzdGlsbCBub3Qgc3VyZSBob3cgdG8gaW50ZXJhY3Qgd2l0aCBRRU1VJ3MgbW9uaXRvciBp
bnRlcmZhY2UgZnJvbQp3aXRoaW4gdGhlIHByb2JlIGNvZGUgKHByb2JlcyBleGVjdXRlIGluIGtl
cm5lbCBtb2RlLCBpbmNsdWRpbmcgImd1cnUgbW9kZSIKY29kZSkuCgpJZiBhbnlib2R5IGNhbiBz
aGVkIHNvbWUgbGlrZSBpbnRvIGFueSBvZiB0aGlzLCBJJ2QgYXBwcmVhY2lhdGUgaXQuCgoKQ2hl
ZXJzLAogIExsdWlzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRw
czovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
