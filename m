From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH babeltrace stable-1.5] Fix: python bindings when
	building with PIE hardening
Date: Wed, 25 Oct 2017 16:30:31 -0400
Message-ID: <1508963431-14553-1-git-send-email-mjeanson__14641.7733435102$1508963456$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3yMhbp6SqGz14JR
 for <lttng-dev@lists.lttng.org>; Wed, 25 Oct 2017 20:30:46 +0000 (UTC)
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
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

V29yayBhcm91bmQgYSBidWcvbGltaXRhdGlvbiBpbiBweXRob24gZGlzdHV0aWxzIHdoZXJlIG9i
amVjdCBmaWxlcyBhcmUKYnVpbHQgd2l0aCAtZlBJQyBhcHBlbmRlZCBhZnRlciB0aGUgQ0ZMQUdT
IGJ1dCB0aGUgZmluYWwgc2hhcmVkIG9iamVjdAppcyBsaW5rZWQgd2l0aCAtc2hhcmVkIGJlZm9y
ZSB0aGUgTERGTEFHUyB3aGljaCBjYW4gdGhlbiBiZSBvdmVycmlkZW4gYnkKaGFyZGVuaW5nIGZs
YWdzIGFuZCByZXN1bHQgaW4gYW4gaW52YWxpZCBidWlsZC4KClRoZSB3b3JrIGFyb3VuZCBpcyB0
byBhcHBlbmQgLXNoYXJlZCB0byB0aGUgTERGTEFHUyBtYWtpbmcgc3VyZSBpdCdzIG5vdApvdmVy
cmlkZW4uCgpTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIEplYW5zb24gPG1qZWFuc29uQGVmZmljaW9z
LmNvbT4KLS0tCiBiaW5kaW5ncy9weXRob24vTWFrZWZpbGUuYW0gfCAyICstCiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9iaW5kaW5n
cy9weXRob24vTWFrZWZpbGUuYW0gYi9iaW5kaW5ncy9weXRob24vTWFrZWZpbGUuYW0KaW5kZXgg
MmNlYWIwMy4uNWU0ZGRlOCAxMDA2NDQKLS0tIGEvYmluZGluZ3MvcHl0aG9uL01ha2VmaWxlLmFt
CisrKyBiL2JpbmRpbmdzL3B5dGhvbi9NYWtlZmlsZS5hbQpAQCAtMjUsNyArMjUsNyBAQCBCSU5E
SU5HU19ERVBTPXNldHVwLnB5IFwKIEJVSUxEX0ZMQUdTPUNDPSIkKENDKSIgXAogCQlDRkxBR1M9
IiQoR0xJQl9DRkxBR1MpICQoQU1fQ0ZMQUdTKSAkKENGTEFHUykiIFwKIAkJQ1BQRkxBR1M9IiQo
REVGUykgJChERUZBVUxUX0lOQ0xVREVTKSAkKEFNX0NQUEZMQUdTKSAkKENQUEZMQUdTKSIgXAot
CQlMREZMQUdTPSIkKEFNX0xERkxBR1MpICQoTERGTEFHUykgJChHTElCX0xJQlMpICQoTElCUyki
CisJCUxERkxBR1M9IiQoQU1fTERGTEFHUykgJChMREZMQUdTKSAkKEdMSUJfTElCUykgLXNoYXJl
ZCAkKExJQlMpIgogCiBidWlsZC1weXRob24tYmluZGluZ3Muc3RhbXA6ICQoQklORElOR1NfREVQ
UykKIAkkKEJVSUxEX0ZMQUdTKSAkKFBZVEhPTikgJChidWlsZGRpcikvc2V0dXAucHkgYnVpbGRf
ZXh0Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0
dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
