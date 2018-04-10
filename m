From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: null pointer dereference
Date: Tue, 10 Apr 2018 18:42:28 -0400
Message-ID: <20180410224226.GA16989__21656.4012728215$1523400036$gmane$org@gmail.com>
References: <1523392412-1379-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt0-x243.google.com (mail-qt0-x243.google.com
 [IPv6:2607:f8b0:400d:c0d::243])
 by lists.lttng.org (Postfix) with ESMTPS id 40LMcm25HHzyHg
 for <lttng-dev@lists.lttng.org>; Tue, 10 Apr 2018 18:42:31 -0400 (EDT)
Received: by mail-qt0-x243.google.com with SMTP id s2so15244358qti.2
 for <lttng-dev@lists.lttng.org>; Tue, 10 Apr 2018 15:42:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1523392412-1379-1-git-send-email-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev@lists.lttng.org, jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGluIG1hc3RlciwgdGhhbmtzIQoKSsOpcsOpbWllCgpPbiBUdWUsIEFwciAxMCwgMjAx
OCBhdCAwNDozMzozMlBNIC0wNDAwLCBKb25hdGhhbiBSYWpvdHRlIHdyb3RlOgo+IFNpZ25lZC1v
ZmYtYnk6IEpvbmF0aGFuIFJham90dGUgPGpvbmF0aGFuLnJham90dGUtanVsaWVuQGVmZmljaW9z
LmNvbT4KPiAtLS0KPiAgc3JjL2xpYi9sdHRuZy1jdGwvcm90YXRlLmMgfCA3ICsrKysrLS0KPiAg
MSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiAKPiBkaWZm
IC0tZ2l0IGEvc3JjL2xpYi9sdHRuZy1jdGwvcm90YXRlLmMgYi9zcmMvbGliL2x0dG5nLWN0bC9y
b3RhdGUuYwo+IGluZGV4IGJkY2U4ZDguLmUzNDA0MjkgMTAwNjQ0Cj4gLS0tIGEvc3JjL2xpYi9s
dHRuZy1jdGwvcm90YXRlLmMKPiArKysgYi9zcmMvbGliL2x0dG5nLWN0bC9yb3RhdGUuYwo+IEBA
IC0yNjgsOCArMjY4LDExIEBAIGVuZDoKPiAgdm9pZCBsdHRuZ19yb3RhdGlvbl9oYW5kbGVfZGVz
dHJveSgKPiAgCQlzdHJ1Y3QgbHR0bmdfcm90YXRpb25faGFuZGxlICpyb3RhdGlvbl9oYW5kbGUp
Cj4gIHsKPiAtCWx0dG5nX3RyYWNlX2FyY2hpdmVfbG9jYXRpb25fZGVzdHJveShyb3RhdGlvbl9o
YW5kbGUtPmFyY2hpdmVfbG9jYXRpb24pOwo+IC0JZnJlZShyb3RhdGlvbl9oYW5kbGUpOwo+ICsJ
aWYgKHJvdGF0aW9uX2hhbmRsZSkgewo+ICsJCWx0dG5nX3RyYWNlX2FyY2hpdmVfbG9jYXRpb25f
ZGVzdHJveShyb3RhdGlvbl9oYW5kbGUtPmFyY2hpdmVfbG9jYXRpb24pOwo+ICsJCWZyZWUocm90
YXRpb25faGFuZGxlKTsKPiArCQlyb3RhdGlvbl9oYW5kbGUgPSBOVUxMOwo+ICsJfQo+ICB9Cj4g
IAo+ICBzdGF0aWMKPiAtLSAKPiAyLjcuNAo+IApfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0
cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3Rp
bmZvL2x0dG5nLWRldgo=
