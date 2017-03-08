From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Fix: use of uninitialized ret
 value in lttng_abi_open_metadata_stream
Date: Wed, 8 Mar 2017 19:38:46 +0000 (UTC)
Message-ID: <361132797.860.1489001926780.JavaMail.zimbra__36695.6949969337$1489001926$gmane$org@efficios.com>
References: <1489001551-14259-1-git-send-email-francis.deslauriers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3vdkN76yLrzwPd
 for <lttng-dev@lists.lttng.org>; Wed,  8 Mar 2017 19:38:31 +0000 (UTC)
In-Reply-To: <1489001551-14259-1-git-send-email-francis.deslauriers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Francis Deslauriers <francis.deslauriers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

bWVyZ2VkIGludG8gbWFzdGVyLCAyLjksIDIuOCwgdGhhbmtzIQoKTWF0aGlldQoKLS0tLS0gT24g
TWFyIDgsIDIwMTcsIGF0IDI6MzIgUE0sIEZyYW5jaXMgRGVzbGF1cmllcnMgZnJhbmNpcy5kZXNs
YXVyaWVyc0BlZmZpY2lvcy5jb20gd3JvdGU6Cgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgY29tcGls
ZXIgd2FybmluZzoKPiAKPiBsdHRuZy1hYmkuYzogSW4gZnVuY3Rpb24g4oCYbHR0bmdfbWV0YWRh
dGFfaW9jdGzigJk6Cj4gbHR0bmctYWJpLmM6OTcxOjY6IHdhcm5pbmc6IOKAmHJldOKAmSBtYXkg
YmUgdXNlZCB1bmluaXRpYWxpemVkIGluIHRoaXMgZnVuY3Rpb24KPiBbLVdtYXliZS11bmluaXRp
YWxpemVkXQo+ICBpbnQgcmV0Owo+ICAgICAgXgo+IAo+IFNpZ25lZC1vZmYtYnk6IEZyYW5jaXMg
RGVzbGF1cmllcnMgPGZyYW5jaXMuZGVzbGF1cmllcnNAZWZmaWNpb3MuY29tPgo+IC0tLQo+IGx0
dG5nLWFiaS5jIHwgNSArKysrLQo+IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvbHR0bmctYWJpLmMgYi9sdHRuZy1hYmkuYwo+
IGluZGV4IGUxOTNmNDMuLjQ3OGE1OTEgMTAwNjQ0Cj4gLS0tIGEvbHR0bmctYWJpLmMKPiArKysg
Yi9sdHRuZy1hYmkuYwo+IEBAIC05OTgsOCArOTk4LDExIEBAIGludCBsdHRuZ19hYmlfb3Blbl9t
ZXRhZGF0YV9zdHJlYW0oc3RydWN0IGZpbGUKPiAqY2hhbm5lbF9maWxlKQo+IAkJZ290byBub3Ry
YW5zcG9ydDsKPiAJfQo+IAo+IC0JaWYgKCFsdHRuZ19rcmVmX2dldCgmc2Vzc2lvbi0+bWV0YWRh
dGFfY2FjaGUtPnJlZmNvdW50KSkKPiArCWlmICghbHR0bmdfa3JlZl9nZXQoJnNlc3Npb24tPm1l
dGFkYXRhX2NhY2hlLT5yZWZjb3VudCkpIHsKPiArCQlyZXQgPSAtRU9WRVJGTE9XOwo+IAkJZ290
byBrcmVmX2Vycm9yOwo+ICsJfQo+ICsKPiAJcmV0ID0gbHR0bmdfYWJpX2NyZWF0ZV9zdHJlYW1f
ZmQoY2hhbm5lbF9maWxlLCBzdHJlYW1fcHJpdiwKPiAJCQkmbHR0bmdfbWV0YWRhdGFfcmluZ19i
dWZmZXJfZmlsZV9vcGVyYXRpb25zKTsKPiAJaWYgKHJldCA8IDApCj4gLS0KPiAyLjcuNAoKLS0g
Ck1hdGhpZXUgRGVzbm95ZXJzCkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
