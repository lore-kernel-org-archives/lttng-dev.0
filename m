From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: Error: opening metadata failed (LTTng on OpenWRT)
Date: Thu, 23 Nov 2017 13:54:05 -0500
Message-ID: <20171123185405.ogq622ssm22d2ye3__22215.2407667183$1511463264$gmane$org@psrcode-TP-X230>
References: <01bf01d35d2c$b2f214b0$18d63e10$@gmail.com>
 <CA+jJMxuwsDjeWXTrypiu-2zXc8B2Akhbn--wyq9isoxo0wY=1w@mail.gmail.com>
 <062b01d35d6b$5189b720$f49d2560$@gmail.com>
 <CA+jJMxsfhj7JKu8MDdLqVb0eELmTq8vORLmyccNQzYpk8yubWw@mail.gmail.com>
 <000801d363b8$d1073880$7315a980$@gmail.com>
 <20171122185514.mvxrlkspqbwunwlt@psrcode-TP-X230>
 <001201d3647f$59759a60$0c60cf20$@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3yjT4x44ddzjW0
 for <lttng-dev@lists.lttng.org>; Thu, 23 Nov 2017 18:54:09 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <001201d3647f$59759a60$0c60cf20$@gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Robin Michielsen <robin.michielsen.1@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

SGksCgpPbiBUaHUsIE5vdiAyMywgMjAxNyBhdCAwNjoyMDoyNFBNICswMTAwLCBSb2JpbiBNaWNo
aWVsc2VuIHdyb3RlOgo+IEhpIEpvbmF0aGFuLAo+IAo+IFRoZSBsdHRuZy1zZXNzaW9uZC5sb2cg
dGhhdCBJIHByb3ZpZGVkIHdhcyBhY3R1YWxseSBmcm9tIGEgc2Vjb25kIHRpbWUgdGhhdCBJIHN0
YXJ0ZWQgJ2x0dG5nLXNlc3Npb25kJyAgKGRpZCBub3QgcmVhbGl6ZSB0aGF0IHRoZXJlIGlzIGEg
ZGlmZmVyZW5jZSksIHdoaWNoIHJlc3VsdGVkIGluIHRoZSBhbHJlYWR5IGxvYWRlZCBlcnJvci4g
V2hlbiBJIGNhcHR1cmVkIHRoZSBvdXRwdXQgZnJvbSBhIGZyZXNoIHN0YXJ0IG9mICdsdHRuZy1z
ZXNzaW9uZCcgSSBub3RpY2VkIGxvdHMgb2YgbW9kcHJvYmUgZXJyb3JzIHdpdGggbW9kdWxlcyB0
aGF0IGNvdWxkIG5vdCBiZSBsb2FkZWQuCgpOb3JtYWxseSwgbHR0bmctc2Vzc2lvbmQgd2lsbCB1
bmxvYWQgdGhlIG1vZHVsZSBpdCBsb2FkZWQgb24gc3RhcnQgaWYgYSBjbGVhbgp0ZWFyZG93biBp
cyBpbml0aWF0ZWQgKFNJR1RFUk0pLgoKPiAKPiBUdXJucyBvdXQgdGhhdCB0aGUgbW9kcHJvYmUg
b24gbXkgT3BlbldydCBzeXN0ZW0gY2FuIG9ubHkgaGFuZGxlIG1vZHVsZXMgd2l0aCBhIG5hbWUg
b2YgbWF4IDMyIGNoYXJhY3RlcnMgKCEpLiBUaGUgZmlyc3QgbWFuZGF0b3J5IGNvcmUgbW9kdWxl
ICgibHR0bmctcmluZy1idWZmZXItY2xpZW50LWRpc2NhcmQiKSBpcyBzdGlsbCBsb2FkZWQgYXMg
aXRzIG5hbWUgaXMgZXhhY3RseSAzMiBjaGFycywgdGhlIG90aGVyIDUgY29yZSBtb2R1bGVzIGRv
IG5vdCBnZXQgbG9hZGVkIGFzIHRoZWlyIG5hbWVzIGFyZSBsb25nZXIgdGhhbiAzMiBjaGFycy4g
SSB3aWxsIG1vZGlmeSBtb2Rwcm9iZSBhcyBhIHByb3BlciBmaXgsIGJ1dCBzaG9ydGVuaW5nIHRo
ZSBuYW1lcyBvZiB0aGUgbHR0bmctKi5rbyBtb2R1bGVzIGFuZCBtYW51YWxseSBsb2FkaW5nIGVh
Y2ggY29yZSBtb2R1bGUgYWxyZWFkeSBzaG93ZWQgdGhhdCB0aGlzIHNvbHZlcyB0aGUgaXNzdWUu
CgpHbGFkIEkgY291bGQgaGVscC4gOlAgSSdtIGN1cmlvdXMgY291bGQgeW91IHBvaW50IG1lIHRv
IHRoZSBtb2Rwcm9iZSBjb2RlIHRoYXQKb3BlbldSVCB1c2VzPwoKQ2hlZXJzIQoKPiAKPiBUaGFu
a3MgZm9yIHlvdXIgcmVwbHkhIFRoaXMgaGVscGVkIGluIHBvaW50aW5nIG1lIGluIHRoZSByaWdo
dCBkaXJlY3Rpb24uCj4gCj4gS2luZCByZWdhcmRzLAo+IFJvYmluCj4gCiAKLS0gCkpvbmF0aGFu
IFJham90dGUtSnVsaWVuCkVmZmljaU9TCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0
dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8v
bHR0bmctZGV2Cg==
