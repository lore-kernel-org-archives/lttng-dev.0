From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
	<jeremie.galarneau@efficios.com>
Subject: [PATCH lttng-tools] Fix: Unchecked session pointer when
	destroying a connection in relayd
Date: Tue,  4 Mar 2014 13:45:17 -0500
Message-ID: <1393958717-27967-1-git-send-email-jeremie.galarneau__24892.9729256362$1393958792$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1WKuLF-0002FC-O6
	for lttng-dev@lists.lttng.org; Tue, 04 Mar 2014 13:45:31 -0500
Received: by mail-qc0-f178.google.com with SMTP id i8so5927949qcq.9
	for <lttng-dev@lists.lttng.org>; Tue, 04 Mar 2014 10:45:20 -0800 (PST)
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

QW4gdW5rbm93biBjb21tYW5kIGN1cnJlbnRseSBjcmFzaGVzIHRoZSByZWxheSBkYWVtb24gc2lu
Y2UKZGVzdHJveV9jb25uZWN0aW9uIGNhbGxzIGRlc3Ryb3lfc2Vzc2lvbiB3aXRob3V0IGNoZWNr
aW5nIHdoZXRoZXIKb3Igbm90IGEgc2Vzc2lvbiBpcyBhc3NvY2lhdGVkIHdpdGggdGhlIGNvbm5l
Y3Rpb24uCgpTaWduZWQtb2ZmLWJ5OiBKw6lyw6ltaWUgR2FsYXJuZWF1IDxqZXJlbWllLmdhbGFy
bmVhdUBlZmZpY2lvcy5jb20+Ci0tLQogc3JjL2Jpbi9sdHRuZy1yZWxheWQvbWFpbi5jIHwgMiAr
LQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0t
Z2l0IGEvc3JjL2Jpbi9sdHRuZy1yZWxheWQvbWFpbi5jIGIvc3JjL2Jpbi9sdHRuZy1yZWxheWQv
bWFpbi5jCmluZGV4IDUzZWFjYTIuLmE5MzE1MWEgMTAwNjQ0Ci0tLSBhL3NyYy9iaW4vbHR0bmct
cmVsYXlkL21haW4uYworKysgYi9zcmMvYmluL2x0dG5nLXJlbGF5ZC9tYWluLmMKQEAgLTIzODks
NyArMjM4OSw3IEBAIHN0YXRpYyB2b2lkIGRlc3Ryb3lfY29ubmVjdGlvbihzdHJ1Y3QgbHR0bmdf
aHQgKnJlbGF5X2Nvbm5lY3Rpb25zX2h0LAogCWNvbm5lY3Rpb25fZGVsZXRlKHJlbGF5X2Nvbm5l
Y3Rpb25zX2h0LCBjb25uKTsKIAogCS8qIEZvciB0aGUgY29udHJvbCBzb2NrZXQsIHdlIHRyeSB0
byBkZXN0cm95IHRoZSBzZXNzaW9uLiAqLwotCWlmIChjb25uLT50eXBlID09IFJFTEFZX0NPTlRS
T0wpIHsKKwlpZiAoY29ubi0+dHlwZSA9PSBSRUxBWV9DT05UUk9MICYmIGNvbm4tPnNlc3Npb24p
IHsKIAkJZGVzdHJveV9zZXNzaW9uKGNvbm4tPnNlc3Npb24sIGNvbm4tPnNlc3Npb25zX2h0KTsK
IAl9CiAKLS0gCjEuOS4wCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3Jn
Cmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRl
dgo=
