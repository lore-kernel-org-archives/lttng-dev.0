From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
 <jeremie.galarneau@efficios.com>
Subject: [PATCH urcu 1/4] Fix: mixup between URCU_WORKQUEUE_RT
 and URCU_CALL_RCU_RT
Date: Fri,  7 Dec 2018 17:06:36 -0500
Message-ID: <20181207220639.4801-1-jeremie.galarneau__5099.00509282506$1544220288$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com
 [209.85.160.195])
 by lists.lttng.org (Postfix) with ESMTPS id 43BRQF4TStz15yT
 for <lttng-dev@lists.lttng.org>; Fri,  7 Dec 2018 17:06:45 -0500 (EST)
Received: by mail-qt1-f195.google.com with SMTP id d18so6205249qto.8
 for <lttng-dev@lists.lttng.org>; Fri, 07 Dec 2018 14:06:45 -0800 (PST)
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
Cc: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

VGhlIHdvcmsgcXVldWUgaW1wbGVtZW50YXRpb24gaXMgZGVyaXZlZCBmcm9tIHRoZSBjYWxsLXJj
dSB0aHJlYWQuIEEKbnVtYmVyIG9mIHJlZmVyZW5jZXMgc2VlbSB0byBoYXZlIGJlZW4gbGVmdCBp
biBwbGFjZSB3aGVuIGFkYXB0aW5nIHRoZQpjb2RlIGZvciBpdHMgbmV3IHB1cnBvc2UuCgpUaGUg
VVJDVV9DQUxMX1JDVV9SVCBmbGFnIGlzIHVzZWQgYnkgd2FrZV93b3JrZXJfdGhyZWFkKCkgd2hp
bGUgdGhlCnJlc3Qgb2YgdGhlIHdvcmtxdWV1ZS5jIGNvZGUgdXNlcyBVUkNVX1dPUktRVUVVRV9S
VCB0byBkZXRlcm1pbmUgaWYKdGhlIHdvcmsgcXVldWUgd2FzIGNvbmZpZ3VyZWQgaW4gcmVhbC10
aW1lIG1vZGUuIEJvdGggZmxhZ3MgYXJlIGRlZmluZWQKdG8gdGhlIHNhbWUgdmFsdWUgKDB4MSkg
YW5kIHRoZSBjdXJyZW50IGludGVybmFsIHVzZXIgb2YgdGhlCndvcmsgcXVldWUgKGxmaHQpIG5l
dmVyIHNwZWNpZmllcyBhbnkgZmxhZ3MuCgpJbiBwcmFjdGljZSwgdGhpcyBkb2VzIG5vdCBjYXVz
ZSBhbnkgcHJvYmxlbSBzbyBJIGRvdWJ0IHRoaXMgcGF0Y2gKbmVlZHMgdG8gYmUgYmFja3BvcnRl
ZC4gRmVlbCBmcmVlIHRvIHJlbmFtZSAiRml4IiB0byAiQ2xlYW4tdXAiLgoKVGhlcmUgYXJlIGEg
bnVtYmVyIG9mIGNvbW1lbnRzIHJlZmVyZW5jaW5nIGNhbGwtcmN1IHdoaWNoIG1heSBuZWVkCnRv
IGJlIGFkYXB0ZWQuIENoYW5naW5nIHRoZW0gaXMgbGVmdCBhcyBhbiBleGVyY2lzZSB0byB0aGUg
bWFpbnRhaW5lcgphcyBJIGRvbid0IGtub3cgaWYgdGhleSBhcHBseSB0byB0aGUgd29ya3F1ZXVl
IHRocmVhZC4KClNpZ25lZC1vZmYtYnk6IErDqXLDqW1pZSBHYWxhcm5lYXUgPGplcmVtaWUuZ2Fs
YXJuZWF1QGVmZmljaW9zLmNvbT4KLS0tCiBzcmMvd29ya3F1ZXVlLmMgfCAyICstCiAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9zcmMv
d29ya3F1ZXVlLmMgYi9zcmMvd29ya3F1ZXVlLmMKaW5kZXggMTdlYTgzNS4uODU2MWE3YSAxMDA2
NDQKLS0tIGEvc3JjL3dvcmtxdWV1ZS5jCisrKyBiL3NyYy93b3JrcXVldWUuYwpAQCAtMzA5LDcg
KzMwOSw3IEBAIHN0cnVjdCB1cmN1X3dvcmtxdWV1ZSAqdXJjdV93b3JrcXVldWVfY3JlYXRlKHVu
c2lnbmVkIGxvbmcgZmxhZ3MsCiAKIHN0YXRpYyB2b2lkIHdha2Vfd29ya2VyX3RocmVhZChzdHJ1
Y3QgdXJjdV93b3JrcXVldWUgKndvcmtxdWV1ZSkKIHsKLQlpZiAoIShfQ01NX0xPQURfU0hBUkVE
KHdvcmtxdWV1ZS0+ZmxhZ3MpICYgVVJDVV9DQUxMX1JDVV9SVCkpCisJaWYgKCEoX0NNTV9MT0FE
X1NIQVJFRCh3b3JrcXVldWUtPmZsYWdzKSAmIFVSQ1VfV09SS1FVRVVFX1JUKSkKIAkJZnV0ZXhf
d2FrZV91cCgmd29ya3F1ZXVlLT5mdXRleCk7CiB9CiAKLS0gCjIuMTkuMgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlz
dApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1i
aW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
