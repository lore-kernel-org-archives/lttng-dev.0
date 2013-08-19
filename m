From: Amit Margalit <AMITM@il.ibm.com>
Subject: [RFC patch] [Babeltrace python bindings] Fixed use of
 braces in format strings, to allow use with older Python versions (e.g. 2.6)
Date: Mon, 19 Aug 2013 14:18:49 +0300
Message-ID: <OFE20CB39E.5E7B83A1-ONC2257BCC.003DD28C-C2257BCC.003E1AD5__31205.410269513$1376911188$gmane$org@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_mixed 003E1AAFC2257BCC_="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1VBNUP-00037c-2Z
	for lttng-dev@lists.lttng.org; Mon, 19 Aug 2013 07:19:13 -0400
Received: from /spool/local
	by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Mon, 19 Aug 2013 12:14:10 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
	(d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id C37BB2190056
	for <lttng-dev@lists.lttng.org>; Mon, 19 Aug 2013 12:23:43 +0100 (BST)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r7JBIpsY56688844
	for <lttng-dev@lists.lttng.org>; Mon, 19 Aug 2013 11:18:51 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r7JBJ2dC021346
	for <lttng-dev@lists.lttng.org>; Mon, 19 Aug 2013 05:19:02 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with
	ESMTP id r7JBJ1uT021280
	for <lttng-dev@lists.lttng.org>; Mon, 19 Aug 2013 05:19:01 -0600
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

--=_mixed 003E1AAFC2257BCC_=
Content-Type: multipart/alternative; boundary="=_alternative 003E1AAFC2257BCC_="


--=_alternative 003E1AAFC2257BCC_=
Content-Type: text/plain; charset="US-ASCII"

Using braces in format strings without specifying a number (e.g. "The 
number {} is incorrect".format(some_variable)) is available since Python 
2.7, and older Python 2.6 required a number, zero-based (e.g. "The number 
{0} is incorrect").

This patch adds these numbers for the sake of older systems.



Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230
--=_alternative 003E1AAFC2257BCC_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Using braces in format strings without
specifying a number (e.g. &quot;The number {} is incorrect&quot;.format(some_variable))
is available since Python 2.7, and older Python 2.6 required a number,
zero-based (e.g. &quot;The number {0} is incorrect&quot;).</font>
<br>
<br><font size=2 face="sans-serif">This patch adds these numbers for the
sake of older systems.</font>
<br>
<br>
<br>
<br><font size=2 color=#000080 face="sans-serif">Amit Margalit</font>
<br><font size=2 color=#808000 face="sans-serif">IBM XIV </font><font size=2 face="sans-serif">-
<i>Storage Reinvented</i></font>
<br><font size=2 face="sans-serif">XIV-NAS Development Team</font>
<br><font size=2 face="sans-serif">Tel. 03</font><font size=2 face="Arial">-689-7774</font>
<br><font size=2 face="Arial">Fax. 03-689-7230</font>
--=_alternative 003E1AAFC2257BCC_=--

--=_mixed 003E1AAFC2257BCC_=
Content-Type: application/octet-stream; name="0002-Fixed-use-of-braces-in-format-strings-to-allow-use-w.patch"
Content-Disposition: attachment; filename="0002-Fixed-use-of-braces-in-format-strings-to-allow-use-w.patch"
Content-Transfer-Encoding: base64

RnJvbSAzODk2NmVmZmJhZDBiZjM2YTAzNjFmNzNkYzAzMjI5YTIwNWIzMzFkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWl0IE1hcmdhbGl0IDxhbWl0bUBpbC5pYm0uY29tPgpEYXRl
OiBNb24sIDE5IEF1ZyAyMDEzIDE0OjA5OjM0ICswMzAwClN1YmplY3Q6IFtQQVRDSCAyLzJdIEZp
eGVkIHVzZSBvZiBicmFjZXMgaW4gZm9ybWF0IHN0cmluZ3MsIHRvIGFsbG93IHVzZSB3aXRoCiBv
bGRlciBQeXRob24gdmVyc2lvbnMgKGUuZy4gMi42KQoKLS0tCiBiaW5kaW5ncy9weXRob24vYmFi
ZWx0cmFjZS5pLmluIHwgMTAgKysrKystLS0tLQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9u
cygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9iaW5kaW5ncy9weXRob24vYmFiZWx0
cmFjZS5pLmluIGIvYmluZGluZ3MvcHl0aG9uL2JhYmVsdHJhY2UuaS5pbgppbmRleCA2YzFmNmZi
Li5iZDJkNzQwIDEwMDY0NAotLS0gYS9iaW5kaW5ncy9weXRob24vYmFiZWx0cmFjZS5pLmluCisr
KyBiL2JpbmRpbmdzL3B5dGhvbi9iYWJlbHRyYWNlLmkuaW4KQEAgLTQ3OCw3ICs0NzgsNyBAQCBj
bGFzcyBUcmFjZUhhbmRsZShvYmplY3QpOgogCQlyYWlzZSBOb3RJbXBsZW1lbnRlZEVycm9yKCJU
cmFjZUhhbmRsZSBjYW5ub3QgYmUgaW5zdGFudGlhdGVkIikKIAogCWRlZiBfX3JlcHJfXyhzZWxm
KToKLQkJcmV0dXJuICJCYWJlbHRyYWNlIFRyYWNlSGFuZGxlOiB0cmFjZV9pZCgne30nKSIuZm9y
bWF0KHNlbGYuX2lkKQorCQlyZXR1cm4gIkJhYmVsdHJhY2UgVHJhY2VIYW5kbGU6IHRyYWNlX2lk
KCd7MH0nKSIuZm9ybWF0KHNlbGYuX2lkKQogCiAJZGVmIGdldF9pZChzZWxmKToKIAkJIiIiUmV0
dXJuIHRoZSBUcmFjZUhhbmRsZSBpZC4iIiIKQEAgLTgzMyw3ICs4MzMsNyBAQCBjbGFzcyBjdGY6
CiAJCQlyYWlzZSBOb3RJbXBsZW1lbnRlZEVycm9yKCJjdGYuRGVmaW5pdGlvbiBjYW5ub3QgYmUg
aW5zdGFudGlhdGVkIikKIAogCQlkZWYgX19yZXByX18oc2VsZik6Ci0JCQlyZXR1cm4gIkJhYmVs
dHJhY2UgRGVmaW5pdGlvbjogbmFtZSgne30nKSwgdHlwZSh7fSkiLmZvcm1hdCgKKwkJCXJldHVy
biAiQmFiZWx0cmFjZSBEZWZpbml0aW9uOiBuYW1lKCd7MH0nKSwgdHlwZSh7MX0pIi5mb3JtYXQo
CiAJCQkJc2VsZi5maWVsZF9uYW1lKCksIHNlbGYuZmllbGRfdHlwZSgpKQogCiAJCWRlZiBmaWVs
ZF9uYW1lKHNlbGYpOgpAQCAtOTI3LDcgKzkyNyw3IEBAIGNsYXNzIGN0ZjoKIAkJCXJhaXNlIE5v
dEltcGxlbWVudGVkRXJyb3IoImN0Zi5FdmVudERlY2wgY2Fubm90IGJlIGluc3RhbnRpYXRlZCIp
CiAKIAkJZGVmIF9fcmVwcl9fKHNlbGYpOgotCQkJcmV0dXJuICJCYWJlbHRyYWNlIEV2ZW50RGVj
bDogbmFtZSB7fSIuZm9ybWF0KHNlbGYuZ2V0X25hbWUoKSkKKwkJCXJldHVybiAiQmFiZWx0cmFj
ZSBFdmVudERlY2w6IG5hbWUgezB9Ii5mb3JtYXQoc2VsZi5nZXRfbmFtZSgpKQogCiAJCWRlZiBn
ZXRfbmFtZShzZWxmKToKIAkJCSIiIlJldHVybiB0aGUgbmFtZSBvZiB0aGUgZXZlbnQgb3IgTm9u
ZSBvbiBlcnJvciIiIgpAQCAtOTY2LDcgKzk2Niw3IEBAIGNsYXNzIGN0ZjoKIAkJCXJhaXNlIE5v
dEltcGxlbWVudGVkRXJyb3IoImN0Zi5GaWVsZERlY2wgY2Fubm90IGJlIGluc3RhbnRpYXRlZCIp
CiAKIAkJZGVmIF9fcmVwcl9fKHNlbGYpOgotCQkJcmV0dXJuICJCYWJlbHRyYWNlIEZpZWxkRGVj
bDogbmFtZSB7fSIuZm9ybWF0KHNlbGYuZ2V0X25hbWUoKSkKKwkJCXJldHVybiAiQmFiZWx0cmFj
ZSBGaWVsZERlY2w6IG5hbWUgezB9Ii5mb3JtYXQoc2VsZi5nZXRfbmFtZSgpKQogCiAJCWRlZiBn
ZXRfbmFtZShzZWxmKToKIAkJCSIiIlJldHVybiB0aGUgbmFtZSBvZiBhIEZpZWxkRGVjbCBvciBO
b25lIG9uIGVycm9yIiIiCkBAIC0xMDg2LDcgKzEwODYsNyBAQCBjbGFzcyBGaWxlKG9iamVjdCk6
CiAJCQlzdGF0ID0gJ29wZW5lZCcKIAkJZWxzZToKIAkJCXN0YXQgPSAnY2xvc2VkJwotCQlyZXR1
cm4gInt9IGJhYmVsdHJhY2UgRmlsZTsgZmlsZV9wYXRoKCd7fScpLCBtb2RlKCd7fScpIi5mb3Jt
YXQoCisJCXJldHVybiAiezB9IGJhYmVsdHJhY2UgRmlsZTsgZmlsZV9wYXRoKCd7MX0nKSwgbW9k
ZSgnezJ9JykiLmZvcm1hdCgKIAkJCXN0YXQsIHNlbGYuX2ZpbGVfcGF0aCwgc2VsZi5fbW9kZSkK
IAogCWRlZiBjbG9zZShzZWxmKToKLS0gCjEuNy4xMS43Cgo=

--=_mixed 003E1AAFC2257BCC_=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=_mixed 003E1AAFC2257BCC_=--
