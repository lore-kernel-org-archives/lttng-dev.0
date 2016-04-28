From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Re: [PATCH 1/3] tests/lib/Makefile.am: Remove
 test_seek_empty_packet and test_seek_big_trace from SCRIPT_LIST
Date: Thu, 28 Apr 2016 14:36:17 -0400
Message-ID: <aa6a47a32d5c10e16676a8b9b332d09e__47429.4635271237$1461868610$gmane$org@simark.ca>
References: <1461811940-8336-1-git-send-email-simon.marchi@polymtl.ca>
 <e2a89f7d42d3628541f53cae8ca478ac@simark.ca>
 <1804225761.72412.1461860179512.JavaMail.zimbra@efficios.com>
 <1d03bf34bd523c31ab8d32e7abda56ec@simark.ca>
 <808373029.72582.1461868129007.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from simark.ca (simark.ca [158.69.221.121])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 57C5AA3315
 for <lttng-dev@lists.lttng.org>; Thu, 28 Apr 2016 18:36:21 +0000 (UTC)
In-Reply-To: <808373029.72582.1461868129007.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

T24gMjAxNi0wNC0yOCAxNDoyOCwgTWljaGFlbCBKZWFuc29uIHdyb3RlOgo+IC0tLS0tIE9uIEFw
ciAyOCwgMjAxNiwgYXQgMTI6NDQgUE0sIFNpbW9uIE1hcmNoaSAKPiBzaW1vbi5tYXJjaGlAcG9s
eW10bC5jYSB3cm90ZToKPj4gCj4+IE9rIHRoYW5rcy4KPj4gCj4+IEp1c3QgYW4gaWRlYTogSSBm
aW5kIGl0IHF1aXRlIGN1bWJlcnNvbWUgdG8gYWRkIGEgbmV3IGVudHJ5IGluCj4+IGNvbmZpZ3Vy
ZS5hYyBmb3IgZWFjaCB0ZXN0IHNjcmlwdCB0aGF0IHdlIHdhbnQgYXV0b2NvbmYgdG8gcHJvY2Vz
cyAKPj4gKHN1Y2gKPj4gYXMgaW4gcGF0Y2ggMy8zKS4gIEkgdGhpbmsgaXQgY291bGQgYmUgZWFz
aWVyIHRvIGhhdmUgYSBzaW5nbGUgZmlsZQo+PiAoZS5nLiB2YXJzLnNoKSBhbmQgaGF2ZSBpdCBj
b250YWluIGRlZmluaXRpb25zIG9mIHZhcmlvdXMgZGlyZWN0b3JpZXM6Cj4+IAo+PiAgIHNyY2Rp
cj1Ac3JjZGlyQAo+PiAgIHRvcF9zcmNkaXI9QHRvcF9zcmNkaXJACj4+ICAgYWJzX3RvcF9zcmNk
aXI9QGFic190b3Bfc3JjZGlyQAo+PiAgIGJ1aWxkZGlyPUBidWlsZGRpckAKPj4gICAuLi4KPj4g
Cj4+IFRoaXMgd2F5LCB5b3UgY291bGQgaGF2ZSBvbmx5IGEgc2luZ2xlIGdlbmVyYXRlZCBmaWxl
ICh2YXJzLnNoLmluIC0+Cj4+IHZhcnMuc2gpLCBhbmQgZWFjaCB0ZXN0IHNjcmlwdCB3b3VsZCBq
dXN0IGhhdmUgdG8gc291cmNlIHRoYXQgZmlsZSB0bwo+PiB1c2UgdGhlIHZhbHVlcy4KPiAKPiBB
cyBkaXNjdXNzZWQgb24gI2x0dG5nLCBoZXJlIGlzIHRoZSBQUiByZXN1bHRpbmcgZnJvbSBteSB1
cGRhdGVzIHRvIAo+IHlvdXIKPiBwYXRjaGVzIDoKPiAKPiAgIGh0dHBzOi8vZ2l0aHViLmNvbS9l
ZmZpY2lvcy9iYWJlbHRyYWNlL3B1bGwvNDMKClRoYW5rcyBmb3IgZm9sbG93aW5nIHVwLgoKPiBD
b25jZXJuaW5nIHRoZSBpbmNsdWRlIGZpbGUsIEknbSBub3QgY29udmluY2VkIGl0IHdvdWxkIGJl
IHNpbXBsZXIsIHdlIAo+IHdvdWxkCj4gZW5kIHVwIHdpdGggc3RhdGljIHNjcmlwdHMgaW4gdGhl
IHNvdXJjZSBkaXIgaW5jbHVkaW5nIGEgZ2VuZXJhdGVkIGZpbGUgCj4gaW4KPiB0aGUgYnVpbGRk
aXIuCgpJbiB0aGUgY3VycmVudCBzdGF0ZSwgZXZlbiB0aGUgc3RhdGljIHNjcmlwdHMgYXJlIGNv
cGllZCB0byB0aGUgYnVpbGQgCmRpciwgc28gaXQKd291bGRuJ3QgYmUgYSBwcm9ibGVtLiAgQW55
d2F5LCBpZiBpdCdzIG5vdCBhIHByb2JsZW0sIEkgdGhpbmsgaXQgbG9va3MgCmdvb2QgaW4geW91
cgpQUi4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0
bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlz
dHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
