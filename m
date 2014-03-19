From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
	<jeremie.galarneau@efficios.com>
Subject: [PATCH lttng-tools] Fix: Remove overly restrictive
	asserts in create_session()
Date: Wed, 19 Mar 2014 11:25:26 -0400
Message-ID: <1395242726-31883-1-git-send-email-jeremie.galarneau__32537.188116885$1395242794$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1WQIND-00062d-2p
	for lttng-dev@lists.lttng.org; Wed, 19 Mar 2014 11:25:43 -0400
Received: by mail-qc0-f169.google.com with SMTP id i17so9986553qcy.14
	for <lttng-dev@lists.lttng.org>; Wed, 19 Mar 2014 08:25:37 -0700 (PDT)
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

VGhlIGN1cnJlbnQgYXNzZXJ0aW9ucyBvbmx5IGFsbG93IHNlc3Npb25zIGNvbnRhaW5pbmcgYWxs
IHRocmVlCmRvbWFpbiB0eXBlcyB0byBiZSBjcmVhdGVkLiBUaGUgcG9pbnRlcnMgYXJlIGFscmVh
ZHkgY2hlY2tlZCBhdApsbiAxMjQyLgoKU2lnbmVkLW9mZi1ieTogSsOpcsOpbWllIEdhbGFybmVh
dSA8amVyZW1pZS5nYWxhcm5lYXVAZWZmaWNpb3MuY29tPgotLS0KIHNyYy9jb21tb24vY29uZmln
L2NvbmZpZy5jIHwgMyAtLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL3NyYy9jb21tb24vY29uZmlnL2NvbmZpZy5jIGIvc3JjL2NvbW1vbi9jb25maWcvY29u
ZmlnLmMKaW5kZXggYTg5MGM5ZC4uMTNhZjJmMSAxMDA2NDQKLS0tIGEvc3JjL2NvbW1vbi9jb25m
aWcvY29uZmlnLmMKKysrIGIvc3JjL2NvbW1vbi9jb25maWcvY29uZmlnLmMKQEAgLTExODYsOSAr
MTE4Niw2IEBAIGludCBjcmVhdGVfc2Vzc2lvbihjb25zdCBjaGFyICpuYW1lLAogCXhtbE5vZGVQ
dHIgY29uc3VtZXJfb3V0cHV0X25vZGU7CiAKIAlhc3NlcnQobmFtZSk7Ci0JYXNzZXJ0KGtlcm5l
bF9kb21haW4pOwotCWFzc2VydCh1c3RfZG9tYWluKTsKLQlhc3NlcnQoanVsX2RvbWFpbik7CiAK
IAlpZiAob3V0cHV0X25vZGUpIHsKIAkJY29uc3VtZXJfb3V0cHV0X25vZGUgPSB4bWxGaXJzdEVs
ZW1lbnRDaGlsZChvdXRwdXRfbm9kZSk7Ci0tIAoxLjkuMAoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmct
ZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1h
bi9saXN0aW5mby9sdHRuZy1kZXYK
