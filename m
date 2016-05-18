From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 05/10] Fix: bogus mask on error.h
	PRINT types
Date: Wed, 18 May 2016 14:04:14 -0400
Message-ID: <1463594659-10964-6-git-send-email-mathieu.desnoyers__49972.4560454071$1463594697$gmane$org@efficios.com>
References: <1463594659-10964-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 2E314A359E
 for <lttng-dev@lists.lttng.org>; Wed, 18 May 2016 18:04:28 +0000 (UTC)
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

UFJJTlRfRVJSIG1hcHMgdG8gMHgxLCBQUklOVF9XQVJOIG1hcHMgdG8gMHgyLCB3aGljaCBpcyBm
aW5lIHNvIGZhciB0bwp1c2UgYXMgbWFza3MsIGJ1dCBQUklOVF9CVUcgbWFwcyB0byAweDMsIHdo
aWNoIGlzIHRoZSBzYW1lIGFzIGJvdGgKUFJJTlRfRVJSIGFuZCBQUklOVF9XQVJOLCBhbmQgZG9l
cyBub3QgbWFrZSBzZW5zZSB0byB1c2UgaW4gbWFza3Mgd2l0aApfX2x0dG5nX3ByaW50OgoKICAo
dHlwZSAmIChQUklOVF9XQVJOIHwgUFJJTlRfRVJSIHwgUFJJTlRfQlVHKSkKCkZpeCB0aGlzIGJ5
IGVuc3VyaW5nIFBSSU5UX0JVRyBoYXMgaXRzIG93biBtYXNrLCBhbmQgZXhwcmVzcyBhbGwKY29u
c3RhbnRzIGFzIHNoaWZ0cyB0byBlbGltaW5hdGUgdGhlIHJpc2sgb2YgcmUtaW50cm9kdWNpbmcg
YSBzaW1pbGFyCmJ1ZyBpbiB0aGUgZnV0dXJlLgoKU2lnbmVkLW9mZi1ieTogTWF0aGlldSBEZXNu
b3llcnMgPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4KLS0tCiBzcmMvY29tbW9uL2Vy
cm9yLmggfCAxNCArKysrKysrLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygr
KSwgNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zcmMvY29tbW9uL2Vycm9yLmggYi9zcmMv
Y29tbW9uL2Vycm9yLmgKaW5kZXggZjJhMzFkZi4uM2FiMWQ0NiAxMDA2NDQKLS0tIGEvc3JjL2Nv
bW1vbi9lcnJvci5oCisrKyBiL3NyYy9jb21tb24vZXJyb3IuaApAQCAtNTcsMTMgKzU3LDEzIEBA
IGV4dGVybiBpbnQgbHR0bmdfb3B0X3ZlcmJvc2U7CiBleHRlcm4gaW50IGx0dG5nX29wdF9taTsK
IAogLyogRXJyb3IgdHlwZS4gKi8KLSNkZWZpbmUgUFJJTlRfRVJSICAgMHgxCi0jZGVmaW5lIFBS
SU5UX1dBUk4gIDB4MgotI2RlZmluZSBQUklOVF9CVUcgICAweDMKLSNkZWZpbmUgUFJJTlRfTVNH
ICAgMHg0Ci0jZGVmaW5lIFBSSU5UX0RCRyAgIDB4MTAKLSNkZWZpbmUgUFJJTlRfREJHMiAgMHgy
MAotI2RlZmluZSBQUklOVF9EQkczICAweDMwCisjZGVmaW5lIFBSSU5UX0VSUiAgICgxIDw8IDAp
CisjZGVmaW5lIFBSSU5UX1dBUk4gICgxIDw8IDEpCisjZGVmaW5lIFBSSU5UX0JVRyAgICgxIDw8
IDIpCisjZGVmaW5lIFBSSU5UX01TRyAgICgxIDw8IDMpCisjZGVmaW5lIFBSSU5UX0RCRyAgICgx
IDw8IDQpCisjZGVmaW5lIFBSSU5UX0RCRzIgICgxIDw8IDUpCisjZGVmaW5lIFBSSU5UX0RCRzMg
ICgxIDw8IDYpCiAKIC8qCiAgKiBNYWNybyBmb3IgcHJpbnRpbmcgbWVzc2FnZSBkZXBlbmRpbmcg
b24gY29tbWFuZCBsaW5lIG9wdGlvbiBhbmQgdmVyYm9zaXR5LgotLSAKMi4xLjQKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5n
IGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9j
Z2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
