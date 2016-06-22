From: Marian Florea <marian.florea@windriver.com>
Subject: [PATCH lttng-tools] Fix: consumerd memory leak when
	using snapshot sessions
Date: Wed, 22 Jun 2016 10:55:17 +0300
Message-ID: <1466582117-32094-1-git-send-email-marian.florea__22327.5156844922$1466623315$gmane$org@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id B86ECA36C2
 for <lttng-dev@lists.lttng.org>; Wed, 22 Jun 2016 07:54:56 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
 [147.11.189.40])
 by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id u5M7ssrE023947
 (version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
 for <lttng-dev@lists.lttng.org>; Wed, 22 Jun 2016 00:54:54 -0700
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
List-Id: lttng-dev@lists.lttng.org

V2hlbiBzdGFydGluZyB0cmFjaW5nIGEgc25hcHNob3Qgc2Vzc2lvbiBpbiBhbiBhY3RpdmUgZW52
aXJvbm1lbnQKYSBtZXRhZGF0YSBjaGFubmVsIGlzIGNyZWF0ZWQgdGhhdCBvbiBkZXN0cm95IGlz
IG5vdCBmcmVlZC4gQmVjYXVzZSB0aGUKbWV0YWRhdGEgY2hhbm5lbCBjcmVhdGVkIGlzIG5vdCBw
YXNzZWQgdG8gdGhlIG1ldGFkYXRhIHRocmVhZC9pcyBub3QgbW9uaXRvcmVkLAp0aGUgZGVzdHJ1
Y3Rpb24gb2YgdGhpcyBjaGFubmVsIGNhbiBiZSBkb25lIGJ5IG5vdGlmeWluZyB0aGUgY2hhbm5l
bCB0aHJlYWQuClNlc3Npb25kIHRocmVhZCBpbnNpZGUgY29uc3VtZXJkIHdoZW4gcmVjZWl2aW5n
IGEgY2xvc2VfbWV0YWRhdGEgY29tbWFuZAp3aWxsIG5vdyBhbHNvIG5vdGlmeSB0aGUgY2hhbm5l
bCB0aHJlYWQgdG8gZGVzdHJveSB0aGUgbWV0YWRhdGEgY2hhbm5lbC4KCkZpeGVzOiAjMTAxNwoK
U2lnbmVkLW9mZi1ieTogTWFyaWFuIEZsb3JlYSA8bWFyaWFuLmZsb3JlYUB3aW5kcml2ZXIuY29t
PgotLS0KIHNyYy9jb21tb24vdXN0LWNvbnN1bWVyL3VzdC1jb25zdW1lci5jIHwgMiArKwogMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3NyYy9jb21tb24vdXN0
LWNvbnN1bWVyL3VzdC1jb25zdW1lci5jIGIvc3JjL2NvbW1vbi91c3QtY29uc3VtZXIvdXN0LWNv
bnN1bWVyLmMKaW5kZXggMDFkNWVjZi4uMTRkM2RmZiAxMDA2NDQKLS0tIGEvc3JjL2NvbW1vbi91
c3QtY29uc3VtZXIvdXN0LWNvbnN1bWVyLmMKKysrIGIvc3JjL2NvbW1vbi91c3QtY29uc3VtZXIv
dXN0LWNvbnN1bWVyLmMKQEAgLTE2MjIsNiArMTYyMiw4IEBAIGludCBsdHRuZ191c3Rjb25zdW1l
cl9yZWN2X2NtZChzdHJ1Y3QgbHR0bmdfY29uc3VtZXJfbG9jYWxfZGF0YSAqY3R4LAogCQkJcmV0
X2NvZGUgPSByZXQ7CiAJCX0KIAorCQlub3RpZnlfdGhyZWFkX2RlbF9jaGFubmVsKGN0eCwgbXNn
LnUuY2xvc2VfbWV0YWRhdGEua2V5KTsKKwogCQlnb3RvIGVuZF9tc2dfc2Vzc2lvbmQ7CiAJfQog
CWNhc2UgTFRUTkdfQ09OU1VNRVJfRkxVU0hfQ0hBTk5FTDoKLS0gCjEuOS4xCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBs
aXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dp
LWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
