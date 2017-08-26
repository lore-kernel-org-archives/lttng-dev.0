From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools v2] Fix: wrong use of the
 relay_streams_sent in snapshot
Date: Sat, 26 Aug 2017 00:03:29 +0000 (UTC)
Message-ID: <1491477965.16422.1503705809339.JavaMail.zimbra__11294.3512307995$1503705766$gmane$org@efficios.com>
References: <1503521333-4905-1-git-send-email-jdesfossez@efficios.com>
 <165346610.15437.1503587759926.JavaMail.zimbra@efficios.com>
 <516484ad-49e6-d89f-f8c1-6a1326c4def2@efficios.com>
 <1348147249.16120.1503679655259.JavaMail.zimbra@efficios.com>
 <8cbd4059-f68b-ced2-2ed2-29a94f562887@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3xfJBB58SwztPZ
 for <lttng-dev@lists.lttng.org>; Sat, 26 Aug 2017 00:02:26 +0000 (UTC)
In-Reply-To: <8cbd4059-f68b-ced2-2ed2-29a94f562887@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

LS0tLS0gT24gQXVnIDI1LCAyMDE3LCBhdCAxMjo0NyBQTSwgSnVsaWVuIERlc2Zvc3NleiBqZGVz
Zm9zc2V6QGVmZmljaW9zLmNvbSB3cm90ZToKCj4+Pj4gSWYgeW91IHJlbW92ZSB0aGlzLCBJIHRo
aW5rIHRoZSBzdHJlYW1zIHdpbGwgbmV2ZXIgZ2V0IHB1Ymxpc2hlZAo+Pj4+IHdpdGhpbiB0aGUg
cmVsYXlkLiAocHVibGlzaF9jb25uZWN0aW9uX2xvY2FsX3N0cmVhbXMoKSkuIElzIHRoaXMKPj4+
PiBhbiBleHBlY3RlZCBzaWRlLWVmZmVjdCA/IEl0IHNob3VsZCBiZSBkb2N1bWVudGVkIGluIHRo
ZSBjaGFuZ2Vsb2cuCj4+Pj4gTXkgZ3Vlc3MgaXMgdGhhdCB3ZSBpbmRlZWQgZG9uJ3Qgd2FudCB0
byBwdWJsaXNoIHRoZSBzbmFwc2hvdAo+Pj4+IHN0cmVhbXMgdG8gdGhlIHZpZXdlcnMuCj4+PiBJ
bmRlZWQsIGEgc25hcHNob3Qgc2Vzc2lvbiBjYW5ub3QgYmUgYSBsaXZlIHNlc3Npb24sIHNvIHdl
IGRvbid0Cj4+PiB3YW50L25lZWQgdG8gcHVibGlzaCB0aG9zZSBzdHJlYW1zLiBBbHNvLCBzZW5k
aW5nIHRoaXMgbWVzc2FnZSBldmVyeQo+Pj4gdGltZSB3ZSBzZW5kIGEgc3RyZWFtIGlzIGEgd3Jv
bmcgdXNhZ2Ugb2YgdGhlIGNvbW1hbmQuCj4+IAo+PiBZb3UnbGwgbmVlZCB0byBlbnN1cmUgdGhh
dCB3ZSBhcmUgbm90IGZyZWVpbmcgdGhlIHN0cmVhbXMgdG9vCj4+IHF1aWNrbHkgb3IgbGVha2lu
ZyB0aGVtIGluIHJlbGF5ZCBhZnRlciB5b3VyIGNoYW5nZS4KPiAKPiBQdWJsaXNoaW5nIHRoZSBz
dHJlYW0gZG9lcyBub3QgdGFrZSBhIG5ldyByZWZlcmVuY2Ugb24gdGhlIHN0cmVhbSwgaXQKPiBq
dXN0IGFkZHMgaXQgaW4gdGhlIHN0cmVhbV9saXN0IHNvIGl0IGJlY29tZXMgdmlzaWJsZSBpbiB0
aGUgdmlld2VyCj4gdGhyZWFkLiBTbyBpdCBkb2VzIG5vdCBjaGFuZ2UgdGhlIGxpZmV0aW1lIG9m
IHRoZSBzdHJlYW0uIEFuZCBpZiB0aGUKPiBzdHJlYW0gaXMgbm90IHB1Ymxpc2hlZCB3aGVuIHdl
IHJlbW92ZSBpdCB3ZSBkb24ndCB0cnkgdG8gdW5wdWJsaXNoIGl0Lgo+IAo+Pj4+IFRoZSByZWFz
b24gZm9yIGRvaW5nIHRoaXMgY2hhbmdlIHNob3VsZCBhbHNvIGJlIGRvY3VtZW50ZWQuIFdoYXQK
Pj4+PiBiZWhhdmlvciBpcyB1bndhbnRlZCBoZXJlIGZyb20gYSByZWxheWQgcGVyc3BlY3RpdmUg
Pwo+Pj4gV2UgYXJlIHNlbmRpbmcgdGhpcyBtZXNzYWdlIHRvIHRoZSByZWxheSAoYW5kIHdhaXRp
bmcgZm9yIHRoZQo+Pj4gY29uZmlybWF0aW9uKSBiZWZvcmUgdGFraW5nIHRoZSBzbmFwc2hvdCBv
ZiBlYWNoIHN0cmVhbS4gU28sIGluIGFkZGl0aW9uCj4+PiB0byBiZWluZyB3cm9uZyBhbmQgdXNl
bGVzcywgaXQgYWRkcyBhIGNvbnNpZGVyYWJsZSBkZWxheSBiZWZvcmUgdGFraW5nCj4+PiB0aGUg
c25hcHNob3Qgb2YgZWFjaCBzdHJlYW0uCj4+Pgo+Pj4gRG8geW91IGFncmVlID8KPj4gCj4+IEl0
IGxvb2tzIGxpa2UgYSBnb29kIGlkZWEgdG8gcmVtb3ZlIGl0LiBJIGp1c3Qgd2FudCB1cyB0byBt
YWtlIHN1cmUgdGhlCj4+IHNuYXBzaG90IG1vZGUgZG9lcyBub3Qgc29tZWhvdyBleHBlY3QgdGhl
IHN0cmVhbXMgdG8gYmUgcHVibGlzaGVkCj4+IHdpdGhpbiBvdGhlciBwYXJ0cyBvZiB0aGUgcmVs
YXlkIGNvZGUuCj4gCj4gSXQgbG9va3MgZ29vZC4KCkFsbHJpZ2h0IHRoZW4sIHRoYW5rcyEKCk1h
dGhpZXUKCj4gCj4gVGhhbmtzLAo+IAo+IEp1bGllbgoKLS0gCk1hdGhpZXUgRGVzbm95ZXJzCkVm
ZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1k
ZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1h
bi9saXN0aW5mby9sdHRuZy1kZXYK
