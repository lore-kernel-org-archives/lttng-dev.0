From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
	<jeremie.galarneau@efficios.com>
Subject: [PATCH lttng-ust] Fix: Add --no-as-needed to the demo
	example's Makefile
Date: Fri, 14 Jun 2013 17:31:46 -0400
Message-ID: <1371245506-4478-1-git-send-email-jeremie.galarneau__39389.0347135768$1371245545$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qe0-f48.google.com ([209.85.128.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1Unbb9-0007Sq-2Y
	for lttng-dev@lists.lttng.org; Fri, 14 Jun 2013 17:31:55 -0400
Received: by mail-qe0-f48.google.com with SMTP id 2so634877qea.35
	for <lttng-dev@lists.lttng.org>; Fri, 14 Jun 2013 14:31:49 -0700 (PDT)
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

U29tZSBkaXN0cmlidXRpb25zIG5vdyBzaGlwIHdpdGggdGhlIC0tYXMtbmVlZGVkIGxpbmtlciBm
bGFnCnNldCBieSBkZWZhdWx0IChVYnVudHUgMTMuMDQpLiBUaGlzIHdpbGwgY2F1c2UgdGhlIGxp
bmtlciB0bwpyZW1vdmUgdGhlIHJlZmVyZW5jZXMgdG8gbHR0bmctdXN0IGZyb20gdGhlIHByb3Zp
ZGVyIG9iamVjdHMKdGh1cyBjYXVzaW5nIHRoZSBhcHBsaWNhdGlvbiB0byBmYWlsIHdoZW4gcHJl
bG9hZGluZyB0aGVtLgoKU2lnbmVkLW9mZi1ieTogSsOpcsOpbWllIEdhbGFybmVhdSA8amVyZW1p
ZS5nYWxhcm5lYXVAZWZmaWNpb3MuY29tPgotLS0KIGRvYy9leGFtcGxlcy9kZW1vL01ha2VmaWxl
IHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2RvYy9leGFtcGxlcy9kZW1vL01ha2VmaWxlIGIvZG9jL2V4YW1wbGVz
L2RlbW8vTWFrZWZpbGUKaW5kZXggMjdjYTkyYi4uZDU1YTFiMSAxMDA2NDQKLS0tIGEvZG9jL2V4
YW1wbGVzL2RlbW8vTWFrZWZpbGUKKysrIGIvZG9jL2V4YW1wbGVzL2RlbW8vTWFrZWZpbGUKQEAg
LTQzLDEzICs0MywxMyBAQCB0cDIubzogdHAyLmMgdXN0X3Rlc3RzX2RlbW8yLmgKIAkkKENDKSAk
KENQUEZMQUdTKSAkKExPQ0FMX0NQUEZMQUdTKSAkKENGTEFHUykgLWZwaWMgLWMgLW8gJEAgJDwK
IAogbHR0bmctdXN0LXByb3ZpZGVyLXVzdC10ZXN0cy1kZW1vLnNvOiB0cC5vIHRwMi5vCi0JJChD
QykgLXNoYXJlZCAtbyAkQCAkKExERkxBR1MpIC1sbHR0bmctdXN0ICReCisJJChDQykgLXNoYXJl
ZCAtV2wsLS1uby1hcy1uZWVkZWQgLW8gJEAgJChMREZMQUdTKSAtbGx0dG5nLXVzdCAkXgogCiB0
cDMubzogdHAzLmMgdXN0X3Rlc3RzX2RlbW8zLmgKIAkkKENDKSAkKENQUEZMQUdTKSAkKExPQ0FM
X0NQUEZMQUdTKSAkKENGTEFHUykgLWZwaWMgLWMgLW8gJEAgJDwKIAogbHR0bmctdXN0LXByb3Zp
ZGVyLXVzdC10ZXN0cy1kZW1vMy5zbzogdHAzLm8KLQkkKENDKSAtc2hhcmVkIC1vICRAICQoTERG
TEFHUykgLWxsdHRuZy11c3QgJF4KKwkkKENDKSAtc2hhcmVkIC1XbCwtLW5vLWFzLW5lZWRlZCAt
byAkQCAkKExERkxBR1MpIC1sbHR0bmctdXN0ICReCiAKIGRlbW8ubzogZGVtby5jCiAJJChDQykg
JChDUFBGTEFHUykgJChMT0NBTF9DUFBGTEFHUykgJChDRkxBR1MpIC1jIC1vICRAICQ8Ci0tIAox
LjguMwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0
dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwOi8vbGlz
dHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
