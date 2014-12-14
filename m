From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: bug #857 -- babeltrace may core dump if index file
 is too short (with patch)
Date: Sun, 14 Dec 2014 13:47:11 -0500
Message-ID: <CA+jJMxu1vGN_CoqdK6he8nfE-0P3nyFh9_9oFAs_bpjpP8tmJA__26711.8055293851$1418582882$gmane$org@mail.gmail.com>
References: <CADjtVtb6J6ird2fYgWibLzq4tFmjNtv8G23Z+Krk6Fqabcc5Pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1Y0ECK-00081g-Qn
 for lttng-dev@lists.lttng.org; Sun, 14 Dec 2014 13:47:20 -0500
Received: by mail-qc0-f170.google.com with SMTP id x3so7851953qcv.29
 for <lttng-dev@lists.lttng.org>; Sun, 14 Dec 2014 10:47:11 -0800 (PST)
In-Reply-To: <CADjtVtb6J6ird2fYgWibLzq4tFmjNtv8G23Z+Krk6Fqabcc5Pw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: craig harmer <charmster@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, charmer-lttng.org@punchdown.org
List-Id: lttng-dev@lists.lttng.org

T24gU2F0LCBEZWMgMTMsIDIwMTQgYXQgMTA6MDggUE0sIGNyYWlnIGhhcm1lciA8Y2hhcm1zdGVy
QGdtYWlsLmNvbT4gd3JvdGU6Cj4gaGkgYWxsLAo+Cj4gaSBvcGVuZWQgYSBidWcgYXQgYnVncy5s
dHRuZy5vcmcgYWJvdXQgYSBwcm9ibGVtIHRoYXQgaSBoYWQgd2hlcmUgYmFiZWx0cmFjZQo+IHdv
dWxkIGV4aXQsIHBvc3NpYmx5IHdpdGggYSBjb3JlIGR1bXAsIGlmIG9uZSB0aGUgdHJhY2UncyBp
bmRleCBmaWxlcyB3YXMKPiB0b28gc2hvcnQuCj4KPiB5b3UgY2FuIHJlYWQgdGhlIGJ1Zywgd2l0
aCBwYXRjaCwgYXQgQnVnICM4NTcgYmFiZWx0cmFjZSB3aWxsIGV4aXQgKG9mdGVuCj4gd2l0aCBh
IGNvcmUgZHVtcCkgaWYgYW4gaW5kZXggZmlsZSBpcyB0b28gc2hvcnQKPgo+IGkgc3VibWl0dGVk
IGEgcGF0Y2ggZm9yIHRoZSBwcm9ibGVtIGFsc28gZml4ZXMgYSBmZXcgb3RoZXIgcGxhY2VzIHRo
YXQgc2hvcnQKPiByZWFkcyBhcmUgbm90IGhhbmRsZWQgcHJvcGVybHkuCj4KPiB0aGVyZSBoYXNu
J3QgYmVlbiBhbnkgYWN0aXZpdHkgb24gdGhlIGJ1ZyBzaW5jZSBpIHN1Ym1pdHRlZCB0aGUgcGF0
Y2ggYWJvdXQKPiAxIG1vbnRoIGFnbywgc28gaSdtIHdvbmRlcmluZyBpZiBpIG5lZWQgdG8gc3Vi
bWl0IHRoZSBwYXRjaCB0byB0aGlzIGxpc3QgYXMKPiB3ZWxsLgo+CgpIaSBDcmFpZyEKCkkgZG8g
cmVjb21tZW5kIHBlb3BsZSBzZW5kIHRoZSBwYXRjaGVzIHRvIHRoZSBtYWlsaW5nIGxpc3QgYW5k
IGxpbmsgdG8KaXQgaW4gdGhlIGJ1ZyB0cmFja2VyLiBUaGlzIG1ha2VzIGl0IGVhc2llciB0byB0
cmFjayB3aGV0aGVyIG9yIG5vdCBhCnBhdGNoIGhhcyBiZWVuIG1lcmdlZC4KClRoZSBidWcgdHJh
Y2tlciBzZWVtcyBkb3duIGF0IHRoZSBtb21lbnQgKGludGVybmFsIHNlcnZlciBlcnJvcikuIEkn
bGwKbG9vayBhdCB0aGUgcGF0aCBvbmNlIGl0IGlzIGJhY2sgdXAuCgpUaGFua3MsCkrDqXLDqW1p
ZQoKPiBjaGVlcnMsCj4KPiBjcmFpZy4KPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCj4gbHR0bmctZGV2IG1haWxpbmcgbGlzdAo+IGx0dG5nLWRldkBs
aXN0cy5sdHRuZy5vcmcKPiBodHRwOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9s
aXN0aW5mby9sdHRuZy1kZXYKPgoKCgotLSAKSsOpcsOpbWllIEdhbGFybmVhdQpFZmZpY2lPUyBJ
bmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0
cy5sdHRuZy5vcmcKaHR0cDovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGlu
Zm8vbHR0bmctZGV2Cg==
