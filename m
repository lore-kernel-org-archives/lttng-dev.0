From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
	<jeremie.galarneau@efficios.com>
Subject: [PATCH lttng-tools] Fix: Succesful session load might
	still report an error
Date: Wed, 19 Mar 2014 11:29:18 -0400
Message-ID: <1395242958-32066-1-git-send-email-jeremie.galarneau__40507.5254072019$1395243001$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1WQIQo-000671-Jy
	for lttng-dev@lists.lttng.org; Wed, 19 Mar 2014 11:29:27 -0400
Received: by mail-qc0-f169.google.com with SMTP id i17so10064648qcy.0
	for <lttng-dev@lists.lttng.org>; Wed, 19 Mar 2014 08:29:21 -0700 (PDT)
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

VGhpcyBlbnN1cmVzIHRoYXQgdGhlIGxvYWQgY29tbWFuZCByZXBvcnRzIGEgc3VjY2Vzc2Z1bCBs
b2FkIHdoZW4KdGhlIHNlc3Npb24gaXMgZm91bmQgaW4gdGhlIHVzZXIncyBob21lIHNlc3Npb24g
Y29uZmlndXJhdGlvbgpkaXJlY3RvcnkgYW5kIG5vdCBpbiB0aGUgc3lzdGVtLXdpZGUgc2Vzc2lv
biBjb25maWd1cmF0aW9uIGRpcmVjdG9yeS4KClNpZ25lZC1vZmYtYnk6IErDqXLDqW1pZSBHYWxh
cm5lYXUgPGplcmVtaWUuZ2FsYXJuZWF1QGVmZmljaW9zLmNvbT4KLS0tCiBzcmMvY29tbW9uL2Nv
bmZpZy9jb25maWcuYyB8IDYgKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NyYy9jb21tb24vY29uZmlnL2NvbmZpZy5j
IGIvc3JjL2NvbW1vbi9jb25maWcvY29uZmlnLmMKaW5kZXggN2M2YzQ5Yi4uZTc0ZTIwZiAxMDA2
NDQKLS0tIGEvc3JjL2NvbW1vbi9jb25maWcvY29uZmlnLmMKKysrIGIvc3JjL2NvbW1vbi9jb25m
aWcvY29uZmlnLmMKQEAgLTI0NTgsNyArMjQ1OCw4IEBAIGludCBjb25maWdfbG9hZF9zZXNzaW9u
KGNvbnN0IGNoYXIgKnBhdGgsIGNvbnN0IGNoYXIgKnNlc3Npb25fbmFtZSwKIAogCQkJcmV0ID0g
bG9hZF9zZXNzaW9uX2Zyb21fcGF0aChwYXRoLCBzZXNzaW9uX25hbWUsCiAJCQkJJnZhbGlkYXRp
b25fY3R4LCAwKTsKLQkJCWlmIChyZXQgJiYgcmV0ICE9IC1MVFROR19FUlJfTE9BRF9TRVNTSU9O
X05PRU5UKSB7CisJCQlpZiAoIXJldCB8fCAocmV0ICYmIHJldCAhPSAtTFRUTkdfRVJSX0xPQURf
U0VTU0lPTl9OT0VOVCkpIHsKKwkJCQkvKiBTZXNzaW9uIGZvdW5kIG9yIGFuIGVycm9yIG9jY3Vy
ZWQgKi8KIAkJCQlmcmVlKHBhdGgpOwogCQkJCWdvdG8gZW5kOwogCQkJfQpAQCAtMjQ2OSw3ICsy
NDcwLDggQEAgaW50IGNvbmZpZ19sb2FkX3Nlc3Npb24oY29uc3QgY2hhciAqcGF0aCwgY29uc3Qg
Y2hhciAqc2Vzc2lvbl9uYW1lLAogCQkvKiBUcnkgc3lzdGVtIHNlc3Npb24gY29uZmlndXJhdGlv
biBwYXRoICovCiAJCXJldCA9IGxvYWRfc2Vzc2lvbl9mcm9tX3BhdGgoREVGQVVMVF9TRVNTSU9O
X1NZU1RFTV9DT05GSUdQQVRILAogCQkJc2Vzc2lvbl9uYW1lLCAmdmFsaWRhdGlvbl9jdHgsIDAp
OwotCQlpZiAocmV0ICYmIHJldCAhPSAtTFRUTkdfRVJSX0xPQURfU0VTU0lPTl9OT0VOVCkgewor
CQlpZiAoIXJldCB8fCAocmV0ICYmIHJldCAhPSAtTFRUTkdfRVJSX0xPQURfU0VTU0lPTl9OT0VO
VCkpIHsKKwkJCS8qIFNlc3Npb24gZm91bmQgb3IgYW4gZXJyb3Igb2NjdXJlZCAqLwogCQkJZ290
byBlbmQ7CiAJCX0KIAl9IGVsc2UgewotLSAKMS45LjAKCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRl
dkBsaXN0cy5sdHRuZy5vcmcKaHR0cDovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4v
bGlzdGluZm8vbHR0bmctZGV2Cg==
