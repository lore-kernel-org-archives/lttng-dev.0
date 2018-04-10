From: Christoffer Ahlbin <Christoffer.Ahlbin@sinch.com>
Subject: Notification event from lttng-relayd on trace rotation
	completion?
Date: Tue, 10 Apr 2018 14:56:16 +0000
Message-ID: <E2315562-B90A-4ABB-B6AC-74C9D896AA82__14260.5618494146$1523457444$gmane$org@sinch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0132.outbound.protection.outlook.com [104.47.1.132])
 by lists.lttng.org (Postfix) with ESMTPS id 40LWKP6dgRz14b4
 for <lttng-dev@lists.lttng.org>; Wed, 11 Apr 2018 00:29:45 -0400 (EDT)
Content-Language: en-US
Content-ID: <BBF94FF57B4B3240A5A36476E70C0EB1@eurprd09.prod.outlook.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

V2hhdCBpcyB0aGUgcmVjb21tZW5kZWQgYXBwcm9hY2ggdG8gaGF2ZSBhbiBleHRlcm5hbCBwcm9j
ZXNzIG5vdGlmaWVkCnRoYXQgYSB0cmFjZSBzZXNzaW9uIHJvdGF0aW9uIGhhcyBjb21wbGV0ZWQg
b24gdGhlIGx0dG5nLXJlbGF5ZCBlbmQ/CgpJJ20gdHJ5aW5nIG91dCB0aGUgdHJhY2Ugcm90YXRp
b24gZnVuY3Rpb25hbGl0eSBhdmFpbGFibGUgaW4gMi4xMQoocHJlLXJlbGVhc2UpIGFuZCB3aWxs
IGJlIHJ1bm5pbmcgYSB0cmFjZSBzZXNzaW9uIGluc2lkZSBhIExpbnV4CmNvbnRhaW5lciAodXNl
cnNwYWNlIHRyYWNlcG9pbnRzIG9ubHkpLCBhbmQgcnVubmluZyBsdHRuZy1yZWxheWQgb24KdGhl
IGNvbnRhaW5lciBob3N0LiBJIHdvdWxkIHRoZW4gbGlrZSB0byBoYXZlIGEgdGhpcmQgcHJvY2Vz
cywgYQoiY29sbGVjdG9yIi1saWtlIHByb2Nlc3MsIHRoYXQgd2lsbCBhbHNvIGJlIHJ1bm5pbmcg
b24gdGhlIGNvbnRhaW5lcgpob3N0IGFuZCB3aWxsIGhhdmUgdGhlIHJlc3BvbnNpYmlsaXR5IG9m
IGNvbGxlY3RpbmcgY29tcGxldGV0ZWQgdHJhY2UKY2h1bmtzIChpLmUuIHJvdGF0ZWQgY2h1bmtz
KSBhbmQgcHVzaCB0aGVtIGZ1cnRoZXIgYWxvbmcgaW50byBhIHRyYWNlCmFuYWx5c2lzIHBpcGVs
aW5lLgoKU28gZmFyIEkndmUgbG9va2VkIGF0IHVzaW5nIGlub3RpZnkgdG8gd2F0Y2ggdGhlIGx0
dG5nLXRyYWNlcy8KZGlyZWN0b3J5LCBhbmQgdGhlIGlkZWEgd291bGQgYmUgdG8gaW5mZXIgYSB0
cmFjZSByb3RhdGlvbiBiYXNlZCBvbgp0aGF0IHRoZSBkZXN0aW5hdGlvbiBkaXJlY3RvcmllcyBw
b3N0IHJvdGF0aW9uIGFyZSBuYW1lZCBvbiB0aGUgZm9ybWF0CiIlWSVtJWRUJUglTSVTJXotJVkl
bSVkVCVIJU0lUyV6LTxzZXFubz4iLiBCdXQgSSdtIG5vdCBlbnRpcmVseQpzYXRpc2lmZWQgd2l0
aCB0aGF0IGFwcHJvYWNoLiBJZGVhbGx5IEkgd291bGQgYmUgYWJsZSB0byBiZSBub3RpZmllZApt
b3JlIGV4cGxpY2l0bHkgdGhhdCBhIHJvdGF0aW9uIGNvbXBsZXRlZC4KCgpBbnkgdGhvdWdodHMg
YW5kIHJlY29tbWVuZGF0aW9ucyBhcmUgbW9zdCB3ZWxjb21lLgoKVGhhbmtzCgpDaHJpc3RvZmZl
ciBBaGxiaW4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczov
L2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
