From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
 <jeremie.galarneau@efficios.com>
Subject: [PATCH LTTNG-UST] Fix: Cleanup local_apps sock_info in
	lttng_ust_cleanup
Date: Tue,  7 Jul 2015 14:35:54 -0400
Message-ID: <1436294154-8048-1-git-send-email-jeremie.galarneau__35760.5170378976$1436294217$gmane$org@efficios.com>
References: <1436287682-3445-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZCXit-00089S-9w
 for lttng-dev@lists.lttng.org; Tue, 07 Jul 2015 14:36:09 -0400
Received: by qkhu186 with SMTP id u186so146507424qkh.0
 for <lttng-dev@lists.lttng.org>; Tue, 07 Jul 2015 11:35:57 -0700 (PDT)
In-Reply-To: <1436287682-3445-1-git-send-email-jeremie.galarneau@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

TFRUbmctVVNUIHdpbGwgZGVhZGxvY2sgYWZ0ZXIgYSBmb3JrIHdoaWxlIHdhaXRpbmcgb24gdGhl
CiJjb25zdHJ1Y3Rvcl93YWl0IiBzZW1hcGhvcmUgaWYgbG9jYWwgYXBwcywgaGFuZGxlZCB0aGUg
c2Vzc2lvbiBkYWVtb24KcnVubmluZyB1bmRlciB0aGUgY3VycmVudCBVSUQsIGFyZSBkaXNhYmxl
ZCBvciAibm90X2FsbG93ZWQiLgoKVGhpcyBkZWFkbG9jayBjYW4gYmUgdHJpZ2dlcmVkIGJ5IHNl
dHRpbmcgYW4gaW5maW5pdGUgcmVnaXN0cmF0aW9uCnRpbWVvdXQsIGNsZWFyaW5nIHRoZSBIT01F
IGVudmlyb25tZW50IHZhcmlhYmxlIGFuZCBsYXVuY2hpbmcgYW4gYXBwCndoaWNoIGNhbGxzIEZP
UksoMykuIFRoaXMgd2lsbCBjYXVzZSBzZXR1cF9sb2NhbF9hcHBzKCkgdG8gZmFpbCB0bwpkZXRl
cm1pbmUgdGhlIGxvY2FsX2FwcHMgc29ja19wYXRoLCB0aHVzIGxlYXZpbmcKbG9jYWxfYXBwcy5h
bGxvd2VkID09IDAuCgpUaGlzLCBpbiB0dXJuLCB3b3VsZCBjYXVzZSBsdHRuZ191c3RfY2xlYW51
cCB0byBza2lwIHRoZSBjbGVhbnVwCm9mIHRoZSBsb2NhbF9hcHBzIHNvY2tfaW5mbyBhZnRlciBh
IGZvcmssCmxlYXZpbmcgbG9jYWxfYXBwcy5jb25zdHJ1Y3Rvcl9zZW1fcG9zdGVkID09IDEuIFRo
aXMgd291bGQgY2F1c2UKaGFuZGxlX3JlZ2lzdGVyX2RvbmUoKSBpbiB0aGUgY2hpbGQgdG8gc2tp
cCBvdmVyIHRoZSBkZWNyZW1lbnRhdGlvbgpvZiBzZW1fY291bnQgYW5kIHBvc3Qgb2YgdGhlIGNv
bnN0cnVjdG9yX3dhaXQgc2VtYXBob3JlLgoKU2lnbmVkLW9mZi1ieTogSsOpcsOpbWllIEdhbGFy
bmVhdSA8amVyZW1pZS5nYWxhcm5lYXVAZWZmaWNpb3MuY29tPgotLS0KIGxpYmx0dG5nLXVzdC9s
dHRuZy11c3QtY29tbS5jIHwgNCArLS0tCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbGlibHR0bmctdXN0L2x0dG5nLXVzdC1jb21t
LmMgYi9saWJsdHRuZy11c3QvbHR0bmctdXN0LWNvbW0uYwppbmRleCBiMjkwMjA0Li45ZjcxODM5
IDEwMDY0NAotLS0gYS9saWJsdHRuZy11c3QvbHR0bmctdXN0LWNvbW0uYworKysgYi9saWJsdHRu
Zy11c3QvbHR0bmctdXN0LWNvbW0uYwpAQCAtMTU1NCw5ICsxNTU0LDcgQEAgc3RhdGljCiB2b2lk
IGx0dG5nX3VzdF9jbGVhbnVwKGludCBleGl0aW5nKQogewogCWNsZWFudXBfc29ja19pbmZvKCZn
bG9iYWxfYXBwcywgZXhpdGluZyk7Ci0JaWYgKGxvY2FsX2FwcHMuYWxsb3dlZCkgewotCQljbGVh
bnVwX3NvY2tfaW5mbygmbG9jYWxfYXBwcywgZXhpdGluZyk7Ci0JfQorCWNsZWFudXBfc29ja19p
bmZvKCZsb2NhbF9hcHBzLCBleGl0aW5nKTsKIAkvKgogCSAqIFRoZSB0ZWFyZG93biBpbiB0aGlz
IGZ1bmN0aW9uIGFsbCBhZmZlY3QgZGF0YSBzdHJ1Y3R1cmVzCiAJICogYWNjZXNzZWQgdW5kZXIg
dGhlIFVTVCBsb2NrIGJ5IHRoZSBsaXN0ZW5lciB0aHJlYWQuIFRoaXMKLS0gCjIuNC40CgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1h
aWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5v
cmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
