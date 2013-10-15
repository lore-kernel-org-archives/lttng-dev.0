From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
	<jeremie.galarneau@efficios.com>
Subject: [PATCH babeltrace] Fix: Uninitialized ctf_stream_pos
	structure in ctf_float_write()
Date: Tue, 15 Oct 2013 13:23:33 -0400
Message-ID: <1381857813-6904-1-git-send-email-jeremie.galarneau__2071.44902456111$1381857963$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1VW8LN-0001k6-Vf
	for lttng-dev@lists.lttng.org; Tue, 15 Oct 2013 13:23:47 -0400
Received: by mail-qc0-f179.google.com with SMTP id l4so6163405qcv.38
	for <lttng-dev@lists.lttng.org>; Tue, 15 Oct 2013 10:23:36 -0700 (PDT)
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

VGhpcyBzdHJ1Y3R1cmUgaXMgcGFzc2VkIHRvIF9jdGZfZmxvYXRfY29weSgpIHdoaWNoIHVzZXMg
dGhlCnVuaW5pdGlhbGl6ZWQgbW1hcF9vZmZzZXQgYW5kIG9mZnNldCB2YWx1ZXMgdG8gcmVhZCB0
aGUgc291cmNlCmZsb2F0aW5nIHBvaW50IHZhbHVlLgoKU2lnbmVkLW9mZi1ieTogSsOpcsOpbWll
IEdhbGFybmVhdSA8amVyZW1pZS5nYWxhcm5lYXVAZWZmaWNpb3MuY29tPgpSZXZpZXdlZC1ieTog
TWF0aGlldSBEZXNub3llcnMgPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4KLS0tCiBm
b3JtYXRzL2N0Zi90eXBlcy9mbG9hdC5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZm9ybWF0cy9jdGYvdHlwZXMvZmxv
YXQuYyBiL2Zvcm1hdHMvY3RmL3R5cGVzL2Zsb2F0LmMKaW5kZXggMmRhYWRmOS4uNjg5MDI4MyAx
MDA2NDQKLS0tIGEvZm9ybWF0cy9jdGYvdHlwZXMvZmxvYXQuYworKysgYi9mb3JtYXRzL2N0Zi90
eXBlcy9mbG9hdC5jCkBAIC0yMzIsNyArMjMyLDcgQEAgaW50IGN0Zl9mbG9hdF93cml0ZShzdHJ1
Y3QgYnRfc3RyZWFtX3BvcyAqcHBvcywgc3RydWN0IGJ0X2RlZmluaXRpb24gKmRlZmluaXRpb24K
IAl1bmlvbiBkb3VibGVJRUVFNzU0IHU7CiAJc3RydWN0IGJ0X2RlZmluaXRpb24gKnRtcGRlZjsK
IAlzdHJ1Y3QgZGVmaW5pdGlvbl9mbG9hdCAqdG1wZmxvYXQ7Ci0Jc3RydWN0IGN0Zl9zdHJlYW1f
cG9zIHNyY3A7CisJc3RydWN0IGN0Zl9zdHJlYW1fcG9zIHNyY3AgPSB7IHsgMCB9IH07CiAJc3Ry
dWN0IG1tYXBfYWxpZ24gbW1hOwogCWludCByZXQ7CiAKLS0gCjEuOC40CgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlz
dApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJp
bi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
