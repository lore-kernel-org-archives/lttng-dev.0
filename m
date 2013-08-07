From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
	<jeremie.galarneau@efficios.com>
Subject: [PATCH lttng-tools] Fix: LTTNG_ERR_NEED_ROOT_SESSIOND
	error message
Date: Wed,  7 Aug 2013 14:58:05 -0400
Message-ID: <1375901885-23781-1-git-send-email-jeremie.galarneau__42220.5987423242$1375901947$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1V78w1-00017W-Oy
	for lttng-dev@lists.lttng.org; Wed, 07 Aug 2013 14:58:19 -0400
Received: by mail-qc0-f176.google.com with SMTP id u12so1091383qcx.7
	for <lttng-dev@lists.lttng.org>; Wed, 07 Aug 2013 11:58:08 -0700 (PDT)
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

QSByb290IHNlc3Npb24gZGFlbW9uIF9hbmRfICJ0cmFjaW5nIiBncm91cCB1c2VyIG1lbWJlcnNo
aXAgYXJlIHJlcXVpcmVkCnRvIHRyYWNlIHRoZSBrZXJuZWwuCgpTaWduZWQtb2ZmLWJ5OiBKw6ly
w6ltaWUgR2FsYXJuZWF1IDxqZXJlbWllLmdhbGFybmVhdUBlZmZpY2lvcy5jb20+Ci0tLQogc3Jj
L2NvbW1vbi9lcnJvci5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL2NvbW1vbi9lcnJvci5jIGIvc3JjL2NvbW1v
bi9lcnJvci5jCmluZGV4IGFjZmQ2YzYuLjQyZWQwNmYgMTAwNjQ0Ci0tLSBhL3NyYy9jb21tb24v
ZXJyb3IuYworKysgYi9zcmMvY29tbW9uL2Vycm9yLmMKQEAgLTgyLDcgKzgyLDcgQEAgc3RhdGlj
IGNvbnN0IGNoYXIgKmVycm9yX3N0cmluZ19hcnJheVtdID0gewogCVsgRVJST1JfSU5ERVgoTFRU
TkdfRVJSX1VTVF9FVkVOVF9OT1RfRk9VTkQpXSA9ICJVU1QgZXZlbnQgbm90IGZvdW5kIiwKIAlb
IEVSUk9SX0lOREVYKExUVE5HX0VSUl9VU1RfQ09OVEVYVF9FWElTVCldID0gIlVTVCBjb250ZXh0
IGFscmVhZHkgZXhpc3QiLAogCVsgRVJST1JfSU5ERVgoTFRUTkdfRVJSX1VTVF9DT05URVhUX0lO
VkFMKV0gPSAiVVNUIGludmFsaWQgY29udGV4dCIsCi0JWyBFUlJPUl9JTkRFWChMVFROR19FUlJf
TkVFRF9ST09UX1NFU1NJT05EKSBdID0gIlRyYWNpbmcgdGhlIGtlcm5lbCByZXF1aXJlcyBhIHJv
b3QgbHR0bmctc2Vzc2lvbmQgZGFlbW9uIG9yIFwidHJhY2luZ1wiIGdyb3VwIHVzZXIgbWVtYmVy
c2hpcCIsCisJWyBFUlJPUl9JTkRFWChMVFROR19FUlJfTkVFRF9ST09UX1NFU1NJT05EKSBdID0g
IlRyYWNpbmcgdGhlIGtlcm5lbCByZXF1aXJlcyBhIHJvb3QgbHR0bmctc2Vzc2lvbmQgZGFlbW9u
IGFuZCBcInRyYWNpbmdcIiBncm91cCB1c2VyIG1lbWJlcnNoaXAiLAogCVsgRVJST1JfSU5ERVgo
TFRUTkdfRVJSX1RSQUNFX0FMUkVBRFlfU1RBUlRFRCkgXSA9ICJUcmFjaW5nIGFscmVhZHkgc3Rh
cnRlZCIsCiAJWyBFUlJPUl9JTkRFWChMVFROR19FUlJfVFJBQ0VfQUxSRUFEWV9TVE9QUEVEKSBd
ID0gIlRyYWNpbmcgYWxyZWFkeSBzdG9wcGVkIiwKIAlbIEVSUk9SX0lOREVYKExUVE5HX0VSUl9L
RVJOX0VWRU5UX0VOT1NZUykgXSA9ICJLZXJuZWwgZXZlbnQgdHlwZSBub3Qgc3VwcG9ydGVkIiwK
LS0gCjEuOC4zLjQKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0
cDovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
