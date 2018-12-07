From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
 <jeremie.galarneau@efficios.com>
Subject: [PATCH urcu 4/4] [RFC] Fix: only wait if work queue is
 empty in real-time mode
Date: Fri,  7 Dec 2018 17:06:39 -0500
Message-ID: <20181207220639.4801-4-jeremie.galarneau__16967.8403334276$1544220330$gmane$org@efficios.com>
References: <20181207220639.4801-1-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com
 [209.85.160.194])
 by lists.lttng.org (Postfix) with ESMTPS id 43BRQQ6X3Kz160M
 for <lttng-dev@lists.lttng.org>; Fri,  7 Dec 2018 17:06:54 -0500 (EST)
Received: by mail-qt1-f194.google.com with SMTP id n21so6223552qtl.6
 for <lttng-dev@lists.lttng.org>; Fri, 07 Dec 2018 14:06:54 -0800 (PST)
In-Reply-To: <20181207220639.4801-1-jeremie.galarneau@efficios.com>
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

VW5jb25kaXRpb25hbGx5IHdhaXRpbmcgZm9yIDEwIG1zIGFmdGVyIHRoZSBjb21wbGV0aW9uIG9m
IGV2ZXJ5IGJhdGNoCm9mIGpvYnMgb2YgdGhlIHdvcmsgcXVldWUgaW4gcmVhbC10aW1lIG1vZGUg
YXBwZWFycyB0byBiZSBhIGJlaGF2aW91cgppbmhlcml0ZWQgZnJvbSB0aGUgY2FsbC1yY3UgdGhy
ZWFkLgoKV2hpbGUgdGhpcyBpcyBhIGZhaXIgdHJhZGUtb2ZmIGluIHRoZSBjb250ZXh0IG9mIGNh
bGwtcmN1LCBpdCBpcyBsZXNzCmV2aWRlbnQgdGhhdCBpdCBpcyBkZXNpcmFibGUgaW4gdGhlIGNv
bnRleHQgb2YgYSBnZW5lcmFsLXB1cnBvc2UKd29yayBxdWV1ZS4gV2FpdGluZyB3aGVuIHdvcmsg
aXMgYXZhaWxhYmxlIGFydGlmaWNpYWxseSBkZWdyYWRlcyB0aGUKbGF0ZW5jeSBjaGFyYWN0ZXJp
c3RpY3Mgb2YgdGhlIHdvcmsgcXVldWUuCgpUaGVyZSBtYXkgYmUgb3RoZXIgdHJhZGUtb2ZmcyB0
aGF0IEkgYW0gbm90IGF3YXJlIG9mLiBIZW5jZSwgdGhpcwppcyBzdWJtaXR0ZWQgYXMgIlJGQyIu
CgpTaWduZWQtb2ZmLWJ5OiBKw6lyw6ltaWUgR2FsYXJuZWF1IDxqZXJlbWllLmdhbGFybmVhdUBl
ZmZpY2lvcy5jb20+Ci0tLQogc3JjL3dvcmtxdWV1ZS5jIHwgNSArKysrLQogMSBmaWxlIGNoYW5n
ZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3NyYy93b3Jr
cXVldWUuYyBiL3NyYy93b3JrcXVldWUuYwppbmRleCA2ODIyMzE0Li5kODFlMzgxIDEwMDY0NAot
LS0gYS9zcmMvd29ya3F1ZXVlLmMKKysrIGIvc3JjL3dvcmtxdWV1ZS5jCkBAIC0yNDgsNyArMjQ4
LDEwIEBAIHN0YXRpYyB2b2lkICp3b3JrcXVldWVfdGhyZWFkKHZvaWQgKmFyZykKIAkJCQljbW1f
c21wX21iKCk7CiAJCQl9CiAJCX0gZWxzZSB7Ci0JCQkodm9pZCkgcG9sbChOVUxMLCAwLCAxMCk7
CisJCQlpZiAoY2RzX3dmY3FfZW1wdHkoJndvcmtxdWV1ZS0+Y2JzX2hlYWQsCisJCQkJCSZ3b3Jr
cXVldWUtPmNic190YWlsKSkgeworCQkJCSh2b2lkKSBwb2xsKE5VTEwsIDAsIDEwKTsKKwkJCX0K
IAkJfQogCQlpZiAod29ya3F1ZXVlLT53b3JrZXJfYWZ0ZXJfd2FrZV91cF9mY3QpCiAJCQl3b3Jr
cXVldWUtPndvcmtlcl9hZnRlcl93YWtlX3VwX2ZjdCh3b3JrcXVldWUsIHdvcmtxdWV1ZS0+cHJp
dik7Ci0tIAoyLjE5LjIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpo
dHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2
Cg==
