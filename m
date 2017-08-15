From: Michael Jeanson <mjeanson@efficios.com>
Subject: Re: Status of MinGW support for babeltrace (either 1.x
 or 2.x)
Date: Tue, 15 Aug 2017 12:34:45 -0400
Message-ID: <0c20d66e-3cdb-7afe-3580-f0f3ddfd234c__4778.33140544153$1502814922$gmane$org@efficios.com>
References: <CAPmGMvh9C2E7y3uDkdHqTizkuPAd9nuPn4OvOjvjDyCqyxhCag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3xWykW2hCszCh9
 for <lttng-dev@lists.lttng.org>; Tue, 15 Aug 2017 16:34:58 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 78B70340011
 for <lttng-dev@lists.lttng.org>; Tue, 15 Aug 2017 16:35:31 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id ULih97_hG_4e for <lttng-dev@lists.lttng.org>;
 Tue, 15 Aug 2017 16:35:25 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id A64923401BF
 for <lttng-dev@lists.lttng.org>; Tue, 15 Aug 2017 16:35:25 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id escgg4jPF_Hw for <lttng-dev@lists.lttng.org>;
 Tue, 15 Aug 2017 16:35:25 +0000 (UTC)
Received: from [172.16.0.63] (cable-192.222.218.157.electronicbox.net
 [192.222.218.157])
 by mail.efficios.com (Postfix) with ESMTPSA id 87BCF340011
 for <lttng-dev@lists.lttng.org>; Tue, 15 Aug 2017 16:35:25 +0000 (UTC)
In-Reply-To: <CAPmGMvh9C2E7y3uDkdHqTizkuPAd9nuPn4OvOjvjDyCqyxhCag@mail.gmail.com>
Content-Language: en-CA
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

T24gMjAxNy0wOC0xNSAxMjoxMiwgSm9uYWggR3JhaGFtIHdyb3RlOgo+IEhlbGxvLAo+IAo+IE92
ZXIgdGhlIHllYXJzIEkgaGF2ZSBzZWVuIHNvbWUgZGlzY3Vzc2lvbnMgYW5kIHBhdGNoZXMgYWJv
dXQgZ2V0dGluZwo+IGZ1bGwgTWluR1cgc3VwcG9ydCBmb3IgYmFiZWx0cmFjZS4gSSBhbSBpbnRl
cmVzdGVkIGluIGlmIHNvbWVvbmUgY2FuCj4gcHJvdmlkZSBhbiBvdmVydmlldyBvZiB0aGUgY3Vy
cmVudCBzdGF0ZSBvZiBNaW5HVy4KPiAKPiBJIGhhdmUgdHJpZWQgdG8gYnVpbGQgMS41LjMgYW5k
IChwcm9iYWJseSBhcyBleHBlY3RlZCkgdGhlcmUgYXJlCj4gbnVtZXJvdXMgY29tcGlsZSBpc3N1
ZXMgKGUuZy4gc3lzL21tYW4uaCkKPiAKPiBJIGhhdmUgZ290dGVuIGZ1cnRoZXIgd2l0aCBjdXJy
ZW50IG1hc3RlciAobXkgcHJpbWFyeSBpbnRlcmVzdCBpcwo+IGxpYmJhYmVsdHJhY2Ugc28gdGhl
IGlzc3VlcyBJIGhhdmUgd2l0aCBjbGkvYmFiZWx0cmFjZS5jIGFuZAo+IHRlc3RzL3Rlc3RfY3Rm
X3dyaXRlci5jIGRvbid0IGNvbmNlcm4gbWUgdG9vIG11Y2ggeWV0KS4gSG93ZXZlciB3aGVuIEkK
PiB0cnkgdG8gcnVuIGEgc2ltcGxlIGV4YW1wbGUgKHRoYXQgd29ya3Mgb24gTGludXgpIGl0IGZh
aWxzIG9uCj4gYnRfY3RmX3N0cmVhbV9mbHVzaC4gSSB3aWxsIGRlYnVnIGZ1cnRoZXIgdG8gaWRl
bnRpZnkgdGhlIHByb2JsZW0uCj4gSG93ZXZlciBJZiBzb21lb25lIGRvZXMgaGF2ZSBhIG1pbmd3
IHBvcnQgd29ya2luZyB3ZWxsIGFueSBndWlkYW5jZSBvbgo+IGJ1aWxkaW5nIHdvdWxkIGJlIG11
Y2ggYXBwcmVjaWF0ZWQuCj4gCj4gVGhhbmtzCj4gSm9uYWgKCkhpIEpvbmFoLAoKQSBmdWxseSB3
b3JraW5nIHBvcnQgdG8gTWluZ3cgaXMgYSByZWxlYXNlIGdvYWwgZm9yIGJhYmVsdHJhY2UgMi4w
LCBhcwp5b3UgbWF5IGhhdmUgbm90aWNlZCBhIGxvdCBvZiBwYXRjaGVzIGZvciBNaW5ndyBjb21w
YXRpYmlsaXR5IGhhdmUgYmVlbgptZXJnZWQgaW4gbWFzdGVyIGluIHRoZSBsYXN0IGZldyB3ZWVr
cy4KCllvdSBjYW4gaGF2ZSBhIGxvb2sgYXQgbXkgcG9ydC1zdGFnaW5nIFsxXSBicmFuY2ggYnV0
IGl0J3MgcmVhbGx5IGEKbW92aW5nIHRhcmdldCByaWdodCBub3cuCgpBcyBhbHdheXMsIHBhdGNo
ZXMgYXJlIHdlbGNvbWUsIGlmIHlvdSBwbGFuIHRvIHdvcmsgb24gc29tZXRoaW5nLCBkb24ndApo
ZXNpdGF0ZSB0byBjb250YWN0IHVzIG9uIHRoaXMgbWFpbGluZyBsaXN0IG9yIG9uIG9mdGMgaW4g
dGhlICNsdHRuZwpjaGFubmVsLgoKQ2hlZXJzLAoKTWljaGFlbAoKClsxXSBodHRwczovL2dpdGh1
Yi5jb20vbWplYW5zb24vYmFiZWx0cmFjZS90cmVlL3BvcnQtc3RhZ2luZwpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0
Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJp
bi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
