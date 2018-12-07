From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
 <jeremie.galarneau@efficios.com>
Subject: [PATCH urcu 2/4] Fix: don't wait after completion of
 job batch if work queue is empty
Date: Fri,  7 Dec 2018 17:06:37 -0500
Message-ID: <20181207220639.4801-2-jeremie.galarneau__43307.4164241136$1544220303$gmane$org@efficios.com>
References: <20181207220639.4801-1-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com
 [209.85.222.194])
 by lists.lttng.org (Postfix) with ESMTPS id 43BRQJ51Zrz15ym
 for <lttng-dev@lists.lttng.org>; Fri,  7 Dec 2018 17:06:48 -0500 (EST)
Received: by mail-qk1-f194.google.com with SMTP id o89so3367967qko.0
 for <lttng-dev@lists.lttng.org>; Fri, 07 Dec 2018 14:06:48 -0800 (PST)
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

T24gY29tcGxldGlvbiBvZiBhIGJhdGNoIG9mIGpvYnMgZnJvbSB0aGUgd29yayBxdWV1ZSwgYSB3
YWl0IG9mIDEwCm1zICh1c2luZyBwb2xsKCkpIGlzIHBlcmZvcm1lZCBpZiB0aGVyZSBpcyBubyB3
b3JrIHByZXNlbnQgaW4gdGhlCndvcmsgcXVldWUgYmVmb3JlIHdhaXRpbmcgb24gaXRzIGZ1dGV4
LgoKVGhlIHdvcmsgcXVldWUgdGhyZWFkJ3Mgc3RydWN0dXJlIGlzIGluc3BpcmVkIGJ5IHRoZSBj
YWxsLXJjdSB0aHJlYWQuCkluIHRoZSBjb250ZXh0IG9mIHRoZSBjYWxsLXJjdSB0aHJlYWQsIG15
IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCB0aGUKaW50ZW50aW9uIGlzIHRvIGVuc3VyZSB0aGF0IHRo
ZSB0aHJlYWQgZG9lcyBub3QgY29udGludW91c2x5IHdha2UtdXAKdG8gcHJvY2VzcyBhIHNpbmds
ZSBxdWV1ZWQgaXRlbS4gVGhpcyBpcyBmaW5lIGFzIGFuIGFwcGxpY2F0aW9uIHNob3VsZApub3Qg
d2FpdCBmb3IgYSBjYWxsLXJjdSBqb2IgdG8gYmUgZXhlY3V0ZWQgKG9yIGF0IGxlYXN0IEkgZG9u
J3Qgc2VlIGEKdXNlLWNhc2UgZm9yIHRoYXQpLgoKSW4gdGhlIGNvbnRleHQgb2YgdGhlIHdvcmsg
cXVldWUsIHdhaXRpbmcgZm9yIG1vcmUgd29yayB0byBiZSBhdmFpbGFibGUKYXJ0aWZpY2lhbGx5
IHNsb3dzIGRvd24gdGhlIGV4ZWN1dGlvbiBvZiB3b3JrIG9uIHdoaWNoIGFuIGFwcGxpY2F0aW9u
Cm1heSB3YWl0LgoKSSBoYXZlIG9ic2VydmVkIGEgY2FzZSB3aGVyZSBMVFRuZydzIHNlc3Npb24g
ZGFlbW9uJ3Mgc2h1dGRvd24gaXMKdGFrZXMgYXJvdW5kIDQgc2Vjb25kcyBhcyBhIGxhcmdlIG51
bWJlciBvZiBjZHNfbGZodCBvYmplY3RzIGFyZQpkZXN0cm95ZWQuIFJlbW92aW5nIHRoZSB3YWl0
IHJlZHVjZXMgdGhlIGR1cmF0aW9uIG9mIHRoaXMgcGhhc2Ugb2YgdGhlCnNodXQtZG93biB0byBh
bG1vc3QgfjEwbXMuCgpTaWduZWQtb2ZmLWJ5OiBKw6lyw6ltaWUgR2FsYXJuZWF1IDxqZXJlbWll
LmdhbGFybmVhdUBlZmZpY2lvcy5jb20+Ci0tLQogc3JjL3dvcmtxdWV1ZS5jIHwgMSAtCiAxIGZp
bGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3NyYy93b3JrcXVldWUuYyBi
L3NyYy93b3JrcXVldWUuYwppbmRleCA4NTYxYTdhLi5kNjA5MDA2IDEwMDY0NAotLS0gYS9zcmMv
d29ya3F1ZXVlLmMKKysrIGIvc3JjL3dvcmtxdWV1ZS5jCkBAIC0yNDAsNyArMjQwLDYgQEAgc3Rh
dGljIHZvaWQgKndvcmtxdWV1ZV90aHJlYWQodm9pZCAqYXJnKQogCQkJaWYgKGNkc193ZmNxX2Vt
cHR5KCZ3b3JrcXVldWUtPmNic19oZWFkLAogCQkJCQkmd29ya3F1ZXVlLT5jYnNfdGFpbCkpIHsK
IAkJCQlmdXRleF93YWl0KCZ3b3JrcXVldWUtPmZ1dGV4KTsKLQkJCQkodm9pZCkgcG9sbChOVUxM
LCAwLCAxMCk7CiAJCQkJdWF0b21pY19kZWMoJndvcmtxdWV1ZS0+ZnV0ZXgpOwogCQkJCS8qCiAJ
CQkJICogRGVjcmVtZW50IGZ1dGV4IGJlZm9yZSByZWFkaW5nCi0tIAoyLjE5LjIKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5n
IGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9j
Z2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
