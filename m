From: =?UTF-8?q?Genevi=C3=A8ve=20Bastien?= <gbastien+lttng@versatic.net>
Subject: [RFC-PATCH] Add packet details to net_* tracepoints
Date: Fri, 15 Mar 2013 12:55:31 -0400
Message-ID: <1363366532-28892-1-git-send-email-gbastien+lttng__29592.5266146243$1363366687$gmane$org@versatic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <gbastien+lttng@versatic.net>) id 1UGXuy-0002ln-H0
	for lttng-dev@lists.lttng.org; Fri, 15 Mar 2013 12:55:44 -0400
Received: from wilbrod.dgi.polymtl.ca ([132.207.169.211])
	by smtp.polymtl.ca (8.14.3/8.14.3) with ESMTP id r2FGthos013733
	for <lttng-dev@lists.lttng.org>; Fri, 15 Mar 2013 12:55:44 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

CkhpLAoKSSdtIHdvcmtpbmcgb24gdGhlIHRyYWNlIHN5bmNocm9uaXphdGlvbiBpbiB0aGUgVE1G
IHZpZXdlci4gIEZvciB0aGlzIEkgbmVlZCB0byBtYXRjaCBuZXR3b3JrIHBhY2tldHMgZnJvbSBh
bGwgbWFjaGluZXMuICBUaGUgbmV0X2Rldl9xdWV1ZSBhbmQgbmV0aWZfcmVjZWl2ZV9za2IgdHJh
Y2Vwb2ludHMgYXJlIGlkZWFsIGNhbmRpZGF0ZXMgZm9yIHRoaXMsIGJ1dCB0aGV5IGRvIG5vdCBy
ZWNvcmQgZW5vdWdoIGluZm9ybWF0aW9uIGFuZCBmcm9tIHRoZWlyIGxvY2F0aW9uIGluIHRoZSBr
ZXJuZWwgY29kZSwgdGhleSBkbyBub3QgeWV0IGhhdmUgYWxsIHRoZSByZXF1aXJlZCBpbmZvcm1h
dGlvbiBlYXNpbHkgYXZhaWxhYmxlIChzZWUgY29tbWVudCBpbiB0aGUgcGF0Y2gpLgoKVGhpcyBw
YXRjaCBwcm9wb3NlcyBhbiBhcHByb2FjaCB0byBnZXQgdGhpcyBpbmZvcm1hdGlvbiB3aXRob3V0
IGhhdmluZyB0b28gbXVjaCBwYWNrZXQgcHJvY2Vzc2luZyB0byBkby4gIEZvciBub3csIEkgcGxh
biB0byB1c2Ugb25seSB0Y3AgaGVhZGVyIGluZm9ybWF0aW9uIHRvIG1hdGNoIHBhY2tldHMuICBF
dmVudHVhbGx5IEknZCBsaWtlIHRvIGNoYW5nZSB0aGUgbWV0YWRhdGEgb2YgdGhvc2UgZXZlbnRz
IGZvciBhIHZhcmlhbnQgdHlwZSBzbyB0aGUgYnl0ZXMgb2YgdGhlIHBhY2tldCBoZWFkZXJzIGFs
cmVhZHkgbWFwIHRvIHRoZWlyIGZpZWxkcyBpbiB0aGUgc3RydWN0LgoKSSdkIGxpa2Ugc29tZSBm
ZWVkYmFjayBvbiB0aGUgYXBwcm9hY2guICBPciBpZiB0aGVyZSBpcyBhbm90aGVyIGFwcHJvYWNo
IHRvIHRoaXMgKG5ldHdvcmsgcGFja2V0IG1hdGNoaW5nKSB0aGF0IHNlZW1zIG1vcmUgYXBwcm9w
cmlhdGUgd2l0aCBsdHRuZyAyLngKClRoYW5rcywKR2VuZXZpw6h2ZSBCYXN0aWVuCgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxp
bmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcv
Y2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
