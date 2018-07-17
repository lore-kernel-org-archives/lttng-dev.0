From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: Issues compiling User Space Tracing examples from
 documentation
Date: Tue, 17 Jul 2018 15:56:47 -0400
Message-ID: <20180717195647.GA21308__10533.9861628183$1531857300$gmane$org@joraj-alpa>
References: <bf0f2e0a73c24ac0b87da7ad2412224b@PGHPRDEXCH02.corp.bbns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 41VWJT2FKHz19ZX
 for <lttng-dev@lists.lttng.org>; Tue, 17 Jul 2018 15:56:57 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <bf0f2e0a73c24ac0b87da7ad2412224b@PGHPRDEXCH02.corp.bbns.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: John O'Sullivan <John.OSullivan@BlackBox.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

SGkgSm9obiwKCk9uIFR1ZSwgSnVsIDE3LCAyMDE4IGF0IDAyOjM3OjA2UE0gKzAwMDAsIEpvaG4g
TydTdWxsaXZhbiB3cm90ZToKPiBIaSAsCj4gSSBhbSB0cnlpbmcgdG8gdXNlIHNvbWUgdXNlciBz
cGFjZSB0cmFjaW5nLCBmb2xsb3dpbmcgdGhlIGV4YW1wbGUgc2hvd24gaGVyZToKPiBodHRwczov
L2x0dG5nLm9yZy9kb2NzL3YyLjEwLwo+IEluIHRoZSBzZWN0aW9uIFRyYWNlIGEgdXNlciBhcHBs
aWNhdGlvbiwgSSBhbSB1c2luZyB0aGUgc2FtcGxlIHByb3ZpZGVkCj4gQXMgc29vbiBhcyBJIGNv
bXBpbGUKPiAKPiBnY2Nhcm0gLWMgLUkgPHBhdGggdG8gbXkgaW5jbHVkZXM+ICBoZWxsby10cC5j
CgpDb3VsZCBpdCBiZSBwb3NzaWJsZSB0aGF0IHlvdSBhcmUgbWlzc2luZyB0aGUgY3VycmVudCBk
aXIgaW5jbHVkZSA/CgpUaGUgZ2NjIGNvbW1hbmQgZnJvbSB0aGUgZG9jOgoKICAgZ2NjIC1jIC1J
LiBoZWxsby10cC5jCgpJIGFsc28gaGF2ZSBvbiBteSBtYWNoaW5lIGEgcGFydGljdWxhciB3YXkg
b2YgYnVpbGRpbmcgZXRjLiBidXQgaXQgd29ya3MgcXVpdGUKZmluZSB3aXRoIHRoZSBnb29kIGlt
cG9ydDoKCmpvcmFqQH4vbHR0bmcvbWFzdGVyL3Rlc3QyWzBdJCBnY2MgLWMgLUkuICRDUFBGTEFH
UyBoZWxsby10cC5jCisgZ2NjIC1jIC1JLiAtSS9ob21lL2pvcmFqL2x0dG5nL21hc3Rlci8vaW5z
dGFsbC9pbmNsdWRlIGhlbGxvLXRwLmMKCkJ1dCBJIGdldCB0aGUgc2FtZSBlcnJvciB5b3UgaGF2
ZSBpZiBJIHJlbW92ZSB0aGUgbG9jYWwgZGlyIGluY2x1ZGUgb3B0aW9uICgiLUkgLiIpCgpqb3Jh
akB+L2x0dG5nL21hc3Rlci90ZXN0MlswXSQgZ2NjIC1jICAkQ1BQRkxBR1MgaGVsbG8tdHAuYwog
ICAgKyBnY2MgLWMgLUkvaG9tZS9qb3Jhai9sdHRuZy9tYXN0ZXIvL2luc3RhbGwvaW5jbHVkZSBo
ZWxsby10cC5jCiAgICBJbiBmaWxlIGluY2x1ZGVkIGZyb20gaGVsbG8tdHAuYzo0OjA6CiAgICBo
ZWxsby10cC5oOjU6Mjg6IGZhdGFsIGVycm9yOiAuL2hlbGxvLXRwLmg6IE5vIHN1Y2ggZmlsZSBv
ciBkaXJlY3RvcnkKICAgICAjZGVmaW5lIFRSQUNFUE9JTlRfSU5DTFVERSAiLi9oZWxsby10cC5o
IgoKTWFrZSBzdXJlIHRvIGluc3RydWN0IGdjYyB0byBsb29rIGEgdGhlIGN1cnJlbnQgZGlyZWN0
b3J5IGZvciB0aGlzIHBhcnRpY3VsYXIKZXhhbXBsZS4KCkNoZWVycwoKLS0gCkpvbmF0aGFuIFJh
am90dGUtSnVsaWVuCkVmZmljaU9TCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5n
Lm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0
bmctZGV2Cg==
