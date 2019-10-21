From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: [2.11.0] Saving then loading network session loses
 absolute path
Date: Mon, 21 Oct 2019 14:11:57 -0400
Message-ID: <20191021181157.GD7796__28794.2485579819$1571681546$gmane$org@joraj-alpa>
References: <SN4PR0601MB3614AC3C2037AEC1C434F84191690@SN4PR0601MB3614.namprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 46xl8b1wvMz1QRy
 for <lttng-dev@lists.lttng.org>; Mon, 21 Oct 2019 14:11:59 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 9FE5E3331F1
 for <lttng-dev@lists.lttng.org>; Mon, 21 Oct 2019 14:11:58 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <SN4PR0601MB3614AC3C2037AEC1C434F84191690@SN4PR0601MB3614.namprd06.prod.outlook.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "Kramer, Zach" <Zach.Kramer@cognex.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

SGksCgpJbmRlZWQgdGhpcyBpcyBub3QgZXhwZWN0ZWQuIEkgd2FzIGFibGUgdG8gcmVwcm9kdWNl
LgoKSSBhbSBsb29raW5nIGludG8gaXQuCgpUaGFua3MgZm9yIHJlcG9ydGluZy4KCkNoZWVycwoK
T24gTW9uLCBPY3QgMjEsIDIwMTkgYXQgMDM6Mjc6NTBQTSArMDAwMCwgS3JhbWVyLCBaYWNoIHdy
b3RlOgo+IEhpLAo+IAo+IFdpdGggYWxsIExUVG5nIHZlcnNpb25zIGJlaW5nIDIuMTEuMCBJIGhh
dmUgdGhlIGZvbGxvd2luZyBwcm9ibGVtOgo+IAo+IGx0dG5nLXNlc3Npb25kIC1kCj4gbHR0bmct
cmVsYXlkIC1kCj4gCj4gbHR0bmcgY3JlYXRlIGV4YW1wbGUg4oCTc2V0LXVybD1uZXQ6Ly9sb2Nh
bGhvc3QvdGVzdAo+IE9SCj4gbHR0bmcgY3JlYXRlIGV4YW1wbGUgLS1saXZlIOKAk3NldC11cmw9
bmV0Oi8vbG9jYWxob3N0L3Rlc3QKPiBOT1QKPiBsdHRuZyBjcmVhdGUgZXhhbXBsZSDigJNzZXQt
dXJsPWZpbGU6Ly8vaG9tZS88dXNlcj4vbHR0bmctdHJhY2VzL3Rlc3QKPiAKPiBsdHRuZyBlbmFi
bGUtY2hhbm5lbCAtdSBjaAo+IGx0dG5nIGVuYWJsZS1ldmVudCAtdSAtYSAtYyBjaCAtcyBleGFt
cGxlCj4gbHR0bmcgc3RhcnQgZXhhbXBsZQo+IAo+ICh0cmFjZXMgYXJlIHdyaXR0ZW4gdG8gfi9s
dHRuZy10cmFjZXMvPGhvc3Q+L3Rlc3QpCj4gCj4gbHR0bmcgc3RvcCBleGFtcGxlCj4gbHR0bmcg
c2F2ZSBleGFtcGxlCj4gbHR0bmcgZGVzdHJveSBleGFtcGxlCj4gKHJlbW92ZSBsdHRuZy10cmFj
ZXMvPGhvc3Q+IGZvciB0ZXN0aW5nIHB1cnBvc2VzKQo+IAo+IGx0dG5nIGxvYWQgZXhhbXBsZQo+
IGx0dG5nIHN0YXJ0IGV4YW1wbGUKPiAKPiAodHJhY2VzIG5vdyBleGlzdCBpbiB+L2x0dG5nLXRy
YWNlcy88aG9zdD4vZXhhbXBsZS08dGltZXN0YW1wPikKPiAKPiBUaGlzIGlzLCBmb3IgbWUsIHJl
cHJvZHVjaWJsZSAxMDAlIG9mIHRoZSB0aW1lLiBJIGNhbiByZXByb2R1Y2UgdGhlIHN0ZXBzIHVz
aW5nIHRoZSBUcmFjZSBDb21wYXNzIGNvbnRyb2wgdmlldyBhcyB3ZWxsLiBJZiBJIG92ZXJyaWRl
IHRoZSBzZXNzaW9uIG5hbWUgYW5kIHVybCwgdGhlIHByb2JsZW0gcGVyc2lzdHMuCj4gCj4gVGhl
IC5sdHRuZyBmaWxlIHNlZW1zIHZhbGlkIChhdHRhY2hlZCkuIFRoaXMgaXNzdWUgZXhpc3RzIHdo
ZXRoZXIgSSB1c2UgYW4gZXhpc3RpbmcgLmx0dG5nIGZpbGUgZnJvbSAyLjkgKHdoaWNoIG5ldmVy
IHNob3dlZCB0aGlzIHByb2JsZW0pLCBvciB3aGV0aGVyIEkgY3JlYXRlIGEgbmV3IG9uZSBsaWtl
IGFib3ZlLgo+IAo+IElzIHRoaXMgaW50ZW5kZWQgYmVoYXZpb3I/IElmIG5vdCwgYW55IGlkZWEg
d2hhdCBjb3VsZCBiZSBoYXBwZW5pbmcgaGVyZT8gSXMgdGhpcyByZXByb2R1Y2libGUgYnkgb3Ro
ZXJzPwo+IAo+IEJlc3QsCj4gWmFjaAo+IAoKCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KPiBsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cj4gbHR0bmctZGV2
QGxpc3RzLmx0dG5nLm9yZwo+IGh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1h
bi9saXN0aW5mby9sdHRuZy1kZXYKCgotLSAKSm9uYXRoYW4gUmFqb3R0ZS1KdWxpZW4KRWZmaWNp
T1MKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmct
ZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMu
bHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
