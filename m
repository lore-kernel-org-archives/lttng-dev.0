From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
 <jeremie.galarneau@efficios.com>
Subject: [PATCH urcu 3/4] [RFC] Fix: don't wait after completion
 of a work queue job batch
Date: Fri,  7 Dec 2018 17:06:38 -0500
Message-ID: <20181207220639.4801-3-jeremie.galarneau__27907.3114310906$1544220315$gmane$org@efficios.com>
References: <20181207220639.4801-1-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com
 [209.85.160.194])
 by lists.lttng.org (Postfix) with ESMTPS id 43BRQN6bLSz1602
 for <lttng-dev@lists.lttng.org>; Fri,  7 Dec 2018 17:06:52 -0500 (EST)
Received: by mail-qt1-f194.google.com with SMTP id d19so6208705qtq.9
 for <lttng-dev@lists.lttng.org>; Fri, 07 Dec 2018 14:06:52 -0800 (PST)
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

QXMgaW5kaWNhdGVkIGluIHRoZSBwcmV2aW91cyBwYXRjaCBvZiB0aGlzIHNlcmllcywgd2FpdGlu
ZyBvbgpjb21wbGV0aW9uIG9mIGEgam9iIGJhdGNoIGZyb20gdGhlIHdvcmsgcXVldWUgYXJ0aWZp
Y2lhbGx5IGluY3JlYXNlcwp0aGUgbGF0ZW5jeSBvZiB0aGUgd29yayBxdWV1ZS4KClRoZSBwcmV2
aW91cyBwYXRjaCByZW1vdmVkIHRoZSB3YWl0IHRoYXQgaXMgcGVyZm9ybWVkIHdoZW4gdGhlCndv
cmsgcXVldWUgaXMgb2JzZXJ2ZWQgdG8gYmUgZW1wdHkgYW5kIHdhcyBvYnNlcnZlZCBhcyB0aGUg
Y2F1c2Ugb2YgYQpwZXJmb3JtYW5jZSBwcm9ibGVtLgoKSXQgaXMgbGlrZWx5IHRoYXQgd2FpdGlu
ZyB3aGVuIHRoZSBxdWV1ZSBpcyBvYnNlcnZlZCB0byBiZSBub24tZW1wdHkKaXMgc2ltaWxhcmx5
IHVuaW50ZW5kZWQuIE5vdGUgdGhhdCBJIGhhdmUgbm90IG9ic2VydmVkIHN1Y2ggYSBwcm9ibGVt
Cm15c2VsZi4KClNpZ25lZC1vZmYtYnk6IErDqXLDqW1pZSBHYWxhcm5lYXUgPGplcmVtaWUuZ2Fs
YXJuZWF1QGVmZmljaW9zLmNvbT4KLS0tCiBzcmMvd29ya3F1ZXVlLmMgfCAyIC0tCiAxIGZpbGUg
Y2hhbmdlZCwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zcmMvd29ya3F1ZXVlLmMgYi9z
cmMvd29ya3F1ZXVlLmMKaW5kZXggZDYwOTAwNi4uNjgyMjMxNCAxMDA2NDQKLS0tIGEvc3JjL3dv
cmtxdWV1ZS5jCisrKyBiL3NyYy93b3JrcXVldWUuYwpAQCAtMjQ2LDggKzI0Niw2IEBAIHN0YXRp
YyB2b2lkICp3b3JrcXVldWVfdGhyZWFkKHZvaWQgKmFyZykKIAkJCQkgKiBjYWxsX3JjdSBsaXN0
LgogCQkJCSAqLwogCQkJCWNtbV9zbXBfbWIoKTsKLQkJCX0gZWxzZSB7Ci0JCQkJKHZvaWQpIHBv
bGwoTlVMTCwgMCwgMTApOwogCQkJfQogCQl9IGVsc2UgewogCQkJKHZvaWQpIHBvbGwoTlVMTCwg
MCwgMTApOwotLSAKMi4xOS4yCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5v
cmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5n
LWRldgo=
