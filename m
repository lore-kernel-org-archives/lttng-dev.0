From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust 1/2] Fix: reset cached vpid
	context on fork
Date: Mon, 5 Mar 2018 10:43:56 -0500 (EST)
Message-ID: <1958067740.2189.1520264636616.JavaMail.zimbra__14868.4605410837$1520264549$gmane$org@efficios.com>
References: <1520030186-5612-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 3zw42W3kzdznsY
 for <lttng-dev@lists.lttng.org>; Mon,  5 Mar 2018 10:44:03 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 8B9C5419571
 for <lttng-dev@lists.lttng.org>; Mon,  5 Mar 2018 10:43:57 -0500 (EST)
In-Reply-To: <1520030186-5612-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Qm90aCBwYXRjaGVzIG1lcmdlZCBpbnRvIG1hc3RlciwgMi4xMCwgMi45LCB0aGFua3MhCgpNYXRo
aWV1CgotLS0tLSBPbiBNYXIgMiwgMjAxOCwgYXQgNTozNiBQTSwgTWljaGFlbCBKZWFuc29uIG1q
ZWFuc29uQGVmZmljaW9zLmNvbSB3cm90ZToKCj4gV2UgY3VycmVudGx5IHJlc2V0IHRoZSBjYWNo
ZWQgdnRpZCBvbiBmb3JrIGJ1dCBub3QgdGhlIHZwaWQuIFRoaXMgaXMgbm90Cj4gYSBwcm9ibGVt
IG9uIExpbnV4IGJlY2F1c2Ugd2UgZG9uJ3QgY2FjaGUgdGhlIHZwaWQgaW50ZXJuYWxseSBidXQg
Y2FsbAo+IGdldHBpZCgpIGRpcmVjdGx5IGFuZCByZWx5IG9uIHRoZSBnbGliYyBwaWQgY2FjaGUu
Cj4gCj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZpY2lvcy5j
b20+Cj4gLS0tCj4gbGlibHR0bmctdXN0L2x0dG5nLXVzdC1jb21tLmMgfCAxICsKPiAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPiAKPiBkaWZmIC0tZ2l0IGEvbGlibHR0bmctdXN0L2x0
dG5nLXVzdC1jb21tLmMgYi9saWJsdHRuZy11c3QvbHR0bmctdXN0LWNvbW0uYwo+IGluZGV4IDQz
OTE0NDYuLmQ0YWRkMWMgMTAwNjQ0Cj4gLS0tIGEvbGlibHR0bmctdXN0L2x0dG5nLXVzdC1jb21t
LmMKPiArKysgYi9saWJsdHRuZy11c3QvbHR0bmctdXN0LWNvbW0uYwo+IEBAIC0yMDExLDYgKzIw
MTEsNyBAQCB2b2lkIHVzdF9hZnRlcl9mb3JrX2NoaWxkKHNpZ3NldF90ICpyZXN0b3JlX3NpZ3Nl
dCkKPiB7Cj4gCWlmIChVUkNVX1RMUyhsdHRuZ191c3RfbmVzdF9jb3VudCkpCj4gCQlyZXR1cm47
Cj4gKwlsdHRuZ19jb250ZXh0X3ZwaWRfcmVzZXQoKTsKPiAJbHR0bmdfY29udGV4dF92dGlkX3Jl
c2V0KCk7Cj4gCURCRygicHJvY2VzcyAlZCIsIGdldHBpZCgpKTsKPiAJLyogUmVsZWFzZSB1cmN1
IG11dGV4ZXMgKi8KPiAtLQo+IDIuNy40CgotLSAKTWF0aGlldSBEZXNub3llcnMKRWZmaWNpT1Mg
SW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0
cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3Rp
bmZvL2x0dG5nLWRldgo=
