From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
	<jeremie.galarneau@efficios.com>
Subject: [PATCH lttng-tools] Fix: memory leak when UST events
	are enabled with exclusions
Date: Mon, 20 Jan 2014 12:51:12 -0500
Message-ID: <1390240272-16029-1-git-send-email-jeremie.galarneau__10921.9681624838$1390240347$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1W5J0K-00070J-3T
	for lttng-dev@lists.lttng.org; Mon, 20 Jan 2014 12:51:27 -0500
Received: by mail-qc0-f176.google.com with SMTP id e16so6115559qcx.21
	for <lttng-dev@lists.lttng.org>; Mon, 20 Jan 2014 09:51:14 -0800 (PST)
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

U2lnbmVkLW9mZi1ieTogSsOpcsOpbWllIEdhbGFybmVhdSA8amVyZW1pZS5nYWxhcm5lYXVAZWZm
aWNpb3MuY29tPgotLS0KIHNyYy9iaW4vbHR0bmctc2Vzc2lvbmQvdHJhY2UtdXN0LmMgfCAxICsK
IHNyYy9iaW4vbHR0bmctc2Vzc2lvbmQvdHJhY2UtdXN0LmggfCAyICstCiAyIGZpbGVzIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3NyYy9iaW4v
bHR0bmctc2Vzc2lvbmQvdHJhY2UtdXN0LmMgYi9zcmMvYmluL2x0dG5nLXNlc3Npb25kL3RyYWNl
LXVzdC5jCmluZGV4IDcwYjNhOTEuLmMwODI0NmEgMTAwNjQ0Ci0tLSBhL3NyYy9iaW4vbHR0bmct
c2Vzc2lvbmQvdHJhY2UtdXN0LmMKKysrIGIvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC90cmFjZS11
c3QuYwpAQCAtNTA0LDYgKzUwNCw3IEBAIHZvaWQgdHJhY2VfdXN0X2Rlc3Ryb3lfZXZlbnQoc3Ry
dWN0IGx0dF91c3RfZXZlbnQgKmV2ZW50KQogCiAJREJHMigiVHJhY2UgZGVzdHJveSBVU1QgZXZl
bnQgJXMiLCBldmVudC0+YXR0ci5uYW1lKTsKIAlmcmVlKGV2ZW50LT5maWx0ZXIpOworCWZyZWUo
ZXZlbnQtPmV4Y2x1c2lvbik7CiAJZnJlZShldmVudCk7CiB9CiAKZGlmZiAtLWdpdCBhL3NyYy9i
aW4vbHR0bmctc2Vzc2lvbmQvdHJhY2UtdXN0LmggYi9zcmMvYmluL2x0dG5nLXNlc3Npb25kL3Ry
YWNlLXVzdC5oCmluZGV4IGYyZjhjN2UuLjA3YWYwZjEgMTAwNjQ0Ci0tLSBhL3NyYy9iaW4vbHR0
bmctc2Vzc2lvbmQvdHJhY2UtdXN0LmgKKysrIGIvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC90cmFj
ZS11c3QuaApAQCAtNTAsNyArNTAsNyBAQCBzdHJ1Y3QgbHR0X3VzdF9ldmVudCB7CiAJc3RydWN0
IGx0dG5nX3VzdF9ldmVudCBhdHRyOwogCXN0cnVjdCBsdHRuZ19odF9ub2RlX3N0ciBub2RlOwog
CXN0cnVjdCBsdHRuZ191c3RfZmlsdGVyX2J5dGVjb2RlICpmaWx0ZXI7Ci0JY29uc3Qgc3RydWN0
IGx0dG5nX2V2ZW50X2V4Y2x1c2lvbiAqZXhjbHVzaW9uOworCXN0cnVjdCBsdHRuZ19ldmVudF9l
eGNsdXNpb24gKmV4Y2x1c2lvbjsKIH07CiAKIC8qIFVTVCBjaGFubmVsICovCi0tIAoxLjguNS4y
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmct
ZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5s
dHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
