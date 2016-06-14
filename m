From: Samuel Martin <s.martin49@gmail.com>
Subject: Re: [PATCH babeltrace] configure: fix uuid support
 detection on static build
Date: Tue, 14 Jun 2016 08:21:52 +0200
Message-ID: <CAHXCMMLfmjew0zJPzvdfW5nT2GWrJ=WpZkbo8oAB4660EqPgAQ__16140.2612844997$1465885374$gmane$org@mail.gmail.com>
References: <20160601195632.23585-1-s.martin49@gmail.com>
 <CA+jJMxuRg7U-TuA5sWgW+e8mRf3ebO1BjcQ+1caqHT6ecUOTNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
 [209.85.220.45])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 15EA8A385C
 for <lttng-dev@lists.lttng.org>; Tue, 14 Jun 2016 06:22:33 +0000 (UTC)
Received: by mail-pa0-f45.google.com with SMTP id b13so30927544pat.0
 for <lttng-dev@lists.lttng.org>; Mon, 13 Jun 2016 23:22:33 -0700 (PDT)
In-Reply-To: <CA+jJMxuRg7U-TuA5sWgW+e8mRf3ebO1BjcQ+1caqHT6ecUOTNw@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

SGkgSsOpcsOpbWllLAoKT24gVHVlLCBKdW4gMTQsIDIwMTYgYXQgMToyMSBBTSwgSsOpcsOpbWll
IEdhbGFybmVhdQo8amVyZW1pZS5nYWxhcm5lYXVAZWZmaWNpb3MuY29tPiB3cm90ZToKPiBPbiBX
ZWQsIEp1biAxLCAyMDE2IGF0IDM6NTYgUE0sIFNhbXVlbCBNYXJ0aW4gPHMubWFydGluNDlAZ21h
aWwuY29tPiB3cm90ZToKPj4gVGhpcyBjaGFuZ2UgYWRkcyB1dWlkIGRldGVjdGlvbiB1c2luZyBw
a2ctY29uZmlnIGhlbHBlciBiZWZvcmUgZmFsbGluZwo+PiBiYWNrIG9uIHRoZSBzdGFuZGFyZCBB
Q19DSEVDS19MSUIgZGV0ZWN0aW9uIGZvciBwbGF0Zm9ybXMgbWlzc2luZwo+PiBwa2ctY29uZmln
Lgo+Pgo+PiBBQ19DSEVDS19MSUIgZnVuY3Rpb24gYWNoaWV2ZXMgaXRzIHRlc3QgYnkgdHJ5aW5n
IHRvIGxpbmsgYWdhaW5zdCB0aGUKPj4gcmVxdWVzdGVkIGxpYnJhcnksIHdpdGhvdXQgdGFraW5n
IGNhcmUgb2YgaXRzIGRlcGVuZGVuY3kKPj4gcmVxdWlyZW1lbnRzL2ZsYWdzIHRoYXQgbWF5IGRp
ZmZlciBiZXR3ZWVuIGRpZmZlcmVudCB0YXJnZXRzLgo+PiBUaGVyZWZvcmUsIGluIGNhc2Ugb2Yg
c3RhdGljIGJ1aWxkLCBpdCBjYW4gZmFpbCBvbiB0aGUgdXVpZCBkZXRlY3Rpb24KPj4gbGlrZSBb
MV0sIGJlY2F1c2UgdGhlIHV1aWQncyBkZXBlbmRlbmN5IGZsYWdzIChyZWdhcmRpbmcgZ2V0dGV4
dCkgYXJlCj4+IG1pc3NpbmcuCj4KPiBIaSBTYW11ZWwsCj4KPiBUaGUgc2FtZSByZXF1aXJlbWVu
dHMgc2VlbSB0byBleGlzdCBmb3IgZ2xpYiAoZ2V0dGV4dCksIGRvZXMgdGhlCj4gY2hhbmdlIG5l
ZWQgdG8gYmUgbWFkZSBmb3IgaXQgYWxzbz8KTWF5YmUsIEkgZGlkIG5vdCB0cmlnZ2VyIHRoaXMg
aW4gbXkgdGVzdCAoY2VydGFpbmx5IGJlY2F1c2UgZml4IHRoZQpmaXJzdCBlcnJvciB3YXMgZW5v
dWdoIHRvIHByb3ZpZGUgYWxsIGRlcHMgdGhlIG90aGVycyBuZWVkLi4uKQpJJ2xsIGNoZWNrIGl0
IGFuZCByZXBvcnQgYmFjayBoZXJlLgoKUmVnYXJkcywKCi0tIApTYW11ZWwKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlz
dApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1i
aW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
