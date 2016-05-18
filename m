From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 01/10] Fix: bad file descriptors on
	close after rotation error
Date: Wed, 18 May 2016 14:04:10 -0400
Message-ID: <1463594659-10964-2-git-send-email-mathieu.desnoyers__23123.2163649567$1463594686$gmane$org@efficios.com>
References: <1463594659-10964-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id A0A79A09C4
 for <lttng-dev@lists.lttng.org>; Wed, 18 May 2016 18:04:24 +0000 (UTC)
In-Reply-To: <1463594659-10964-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

RW5zdXJlIHdlIGRvbid0IHRyeSB0byBjbG9zZSBvdXRwdXQgc3RyZWFtIGZpbGUgZGVzY3JpcHRv
cnMgdHdpY2Ugd2hlbiBhCnRyYWNlIGZpbGUgcm90YXRpb24gZXJyb3Igb2NjdXJzIChvbmNlIGF0
IHRyYWNlZmlsZSByb3RhdGlvbiwgb25jZSB3aGVuCmNsb3NpbmcgdGhlIHN0cmVhbSkuIFNldCB0
aGUgZmQgdmFsdWUgdG8gLTEgYWZ0ZXIgdGhlIGZpcnN0IGNsb3NlIHRvCmVuc3VyZSB3ZSBkb24n
dCB0cnkgdG8gY2xvc2UgaXQgYWdhaW4uCgpTaWduZWQtb2ZmLWJ5OiBNYXRoaWV1IERlc25veWVy
cyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPgotLS0KIHNyYy9jb21tb24vdXRpbHMu
YyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvc3Jj
L2NvbW1vbi91dGlscy5jIGIvc3JjL2NvbW1vbi91dGlscy5jCmluZGV4IGRmNTVkYzkuLmZkZDg4
MDIgMTAwNjQ0Ci0tLSBhL3NyYy9jb21tb24vdXRpbHMuYworKysgYi9zcmMvY29tbW9uL3V0aWxz
LmMKQEAgLTg1MCw2ICs4NTAsNyBAQCBpbnQgdXRpbHNfcm90YXRlX3N0cmVhbV9maWxlKGNoYXIg
KnBhdGhfbmFtZSwgY2hhciAqZmlsZV9uYW1lLCB1aW50NjRfdCBzaXplLAogCQlQRVJST1IoIkNs
b3NpbmcgdHJhY2VmaWxlIik7CiAJCWdvdG8gZXJyb3I7CiAJfQorCSpzdHJlYW1fZmQgPSAtMTsK
IAogCWlmIChjb3VudCA+IDApIHsKIAkJLyoKLS0gCjIuMS40CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5n
LWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWls
bWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
