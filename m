From: Amit Margalit <AMITM@il.ibm.com>
Subject: [RFC patch 2/3] [Babeltrace python bindings] Fixed use
 of braces in format strings,
 to allow use with older Python versions (e.g. 2.6)
Date: Tue, 20 Aug 2013 10:50:04 +0300
Message-ID: <OF9136DF48.7319E766-ONC2257BCD.002AA76A-C2257BCD.002AFEDA__44067.7656945356$1376985065$gmane$org@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_mixed 002AFE67C2257BCD_="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp12.uk.ibm.com ([195.75.94.108])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1VBght-0006l7-SY
	for lttng-dev@lists.lttng.org; Tue, 20 Aug 2013 03:50:27 -0400
Received: from /spool/local
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Tue, 20 Aug 2013 08:44:08 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
	(d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
	by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id AB60017D8058
	for <lttng-dev@lists.lttng.org>; Tue, 20 Aug 2013 08:52:12 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
	[9.149.37.249])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r7K7o69R53149946
	for <lttng-dev@lists.lttng.org>; Tue, 20 Aug 2013 07:50:06 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r7K7oHjQ015489
	for <lttng-dev@lists.lttng.org>; Tue, 20 Aug 2013 01:50:17 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with
	ESMTP id r7K7oHdW015481
	for <lttng-dev@lists.lttng.org>; Tue, 20 Aug 2013 01:50:17 -0600
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

--=_mixed 002AFE67C2257BCD_=
Content-Type: multipart/alternative; boundary="=_alternative 002AFE67C2257BCD_="


--=_alternative 002AFE67C2257BCD_=
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
--=_alternative 002AFE67C2257BCD_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Using braces in format strings without
specifying a number (e.g. &quot;The number {} is incorrect&quot;.format(some_variable))
is available since Python 2.7, and older Python 2.6 required a number,
zero-based (e.g. &quot;The number {0} is incorrect&quot;).</font><font size=3>
<br>
</font><font size=2 face="sans-serif"><br>
This patch adds these numbers for the sake of older systems.</font><font size=3>
</font>
<br>
<br>
<br>
<br><font size=2 color=#000080 face="sans-serif">Amit Margalit</font>
<br><font size=2 color=#808000 face="sans-serif">IBM XIV </font><font size=2 face="sans-serif">-
<i>Storage Reinvented</i></font>
<br><font size=2 face="sans-serif">XIV-NAS Development Team</font>
<br><font size=2 face="sans-serif">Tel. 03</font><font size=2 face="Arial">-689-7774</font>
<br><font size=2 face="Arial">Fax. 03-689-7230</font>
--=_alternative 002AFE67C2257BCD_=--

--=_mixed 002AFE67C2257BCD_=
Content-Type: application/octet-stream; name="0002-Fixed-use-of-braces-in-format-strings-to-allow-use-w.patch"
Content-Disposition: attachment; filename="0002-Fixed-use-of-braces-in-format-strings-to-allow-use-w.patch"
Content-Transfer-Encoding: base64

RnJvbSA2ZGQ0NTM2ODI4NWRmNDhiYzU1YjVjNjViMzFlMTNkNjk2YzNkODU1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWl0IE1hcmdhbGl0IDxhbWl0bUBpbC5pYm0uY29tPgpEYXRl
OiBUdWUsIDIwIEF1ZyAyMDEzIDA5OjMwOjM4ICswMzAwClN1YmplY3Q6IFtQQVRDSCAyLzNdIEZp
eGVkIHVzZSBvZiBicmFjZXMgaW4gZm9ybWF0IHN0cmluZ3MsIHRvIGFsbG93IHVzZSB3aXRoCiBv
bGRlciBQeXRob24gdmVyc2lvbnMgKGUuZy4gMi42KQoKU2lnbmVkLW9mZi1ieTogQW1pdCBNYXJn
YWxpdCA8YW1pdG1AaWwuaWJtLmNvbT4KLS0tCiBiaW5kaW5ncy9weXRob24vYmFiZWx0cmFjZS5p
LmluIHwgMTAgKysrKystLS0tLQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNSBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9iaW5kaW5ncy9weXRob24vYmFiZWx0cmFjZS5pLmlu
IGIvYmluZGluZ3MvcHl0aG9uL2JhYmVsdHJhY2UuaS5pbgppbmRleCAxNmRiYmJkLi4yNDU4MTYw
IDEwMDY0NAotLS0gYS9iaW5kaW5ncy9weXRob24vYmFiZWx0cmFjZS5pLmluCisrKyBiL2JpbmRp
bmdzL3B5dGhvbi9iYWJlbHRyYWNlLmkuaW4KQEAgLTQ3Nyw3ICs0NzcsNyBAQCBjbGFzcyBUcmFj
ZUhhbmRsZShvYmplY3QpOgogCQlyYWlzZSBOb3RJbXBsZW1lbnRlZEVycm9yKCJUcmFjZUhhbmRs
ZSBjYW5ub3QgYmUgaW5zdGFudGlhdGVkIikKIAogCWRlZiBfX3JlcHJfXyhzZWxmKToKLQkJcmV0
dXJuICJCYWJlbHRyYWNlIFRyYWNlSGFuZGxlOiB0cmFjZV9pZCgne30nKSIuZm9ybWF0KHNlbGYu
X2lkKQorCQlyZXR1cm4gIkJhYmVsdHJhY2UgVHJhY2VIYW5kbGU6IHRyYWNlX2lkKCd7MH0nKSIu
Zm9ybWF0KHNlbGYuX2lkKQogCiAJZGVmIGdldF9pZChzZWxmKToKIAkJIiIiUmV0dXJuIHRoZSBU
cmFjZUhhbmRsZSBpZC4iIiIKQEAgLTgzMiw3ICs4MzIsNyBAQCBjbGFzcyBjdGY6CiAJCQlyYWlz
ZSBOb3RJbXBsZW1lbnRlZEVycm9yKCJjdGYuRGVmaW5pdGlvbiBjYW5ub3QgYmUgaW5zdGFudGlh
dGVkIikKIAogCQlkZWYgX19yZXByX18oc2VsZik6Ci0JCQlyZXR1cm4gIkJhYmVsdHJhY2UgRGVm
aW5pdGlvbjogbmFtZSgne30nKSwgdHlwZSh7fSkiLmZvcm1hdCgKKwkJCXJldHVybiAiQmFiZWx0
cmFjZSBEZWZpbml0aW9uOiBuYW1lKCd7MH0nKSwgdHlwZSh7MX0pIi5mb3JtYXQoCiAJCQkJc2Vs
Zi5maWVsZF9uYW1lKCksIHNlbGYuZmllbGRfdHlwZSgpKQogCiAJCWRlZiBmaWVsZF9uYW1lKHNl
bGYpOgpAQCAtOTI2LDcgKzkyNiw3IEBAIGNsYXNzIGN0ZjoKIAkJCXJhaXNlIE5vdEltcGxlbWVu
dGVkRXJyb3IoImN0Zi5FdmVudERlY2wgY2Fubm90IGJlIGluc3RhbnRpYXRlZCIpCiAKIAkJZGVm
IF9fcmVwcl9fKHNlbGYpOgotCQkJcmV0dXJuICJCYWJlbHRyYWNlIEV2ZW50RGVjbDogbmFtZSB7
fSIuZm9ybWF0KHNlbGYuZ2V0X25hbWUoKSkKKwkJCXJldHVybiAiQmFiZWx0cmFjZSBFdmVudERl
Y2w6IG5hbWUgezB9Ii5mb3JtYXQoc2VsZi5nZXRfbmFtZSgpKQogCiAJCWRlZiBnZXRfbmFtZShz
ZWxmKToKIAkJCSIiIlJldHVybiB0aGUgbmFtZSBvZiB0aGUgZXZlbnQgb3IgTm9uZSBvbiBlcnJv
ciIiIgpAQCAtOTY1LDcgKzk2NSw3IEBAIGNsYXNzIGN0ZjoKIAkJCXJhaXNlIE5vdEltcGxlbWVu
dGVkRXJyb3IoImN0Zi5GaWVsZERlY2wgY2Fubm90IGJlIGluc3RhbnRpYXRlZCIpCiAKIAkJZGVm
IF9fcmVwcl9fKHNlbGYpOgotCQkJcmV0dXJuICJCYWJlbHRyYWNlIEZpZWxkRGVjbDogbmFtZSB7
fSIuZm9ybWF0KHNlbGYuZ2V0X25hbWUoKSkKKwkJCXJldHVybiAiQmFiZWx0cmFjZSBGaWVsZERl
Y2w6IG5hbWUgezB9Ii5mb3JtYXQoc2VsZi5nZXRfbmFtZSgpKQogCiAJCWRlZiBnZXRfbmFtZShz
ZWxmKToKIAkJCSIiIlJldHVybiB0aGUgbmFtZSBvZiBhIEZpZWxkRGVjbCBvciBOb25lIG9uIGVy
cm9yIiIiCkBAIC0xMDg1LDcgKzEwODUsNyBAQCBjbGFzcyBGaWxlKG9iamVjdCk6CiAJCQlzdGF0
ID0gJ29wZW5lZCcKIAkJZWxzZToKIAkJCXN0YXQgPSAnY2xvc2VkJwotCQlyZXR1cm4gInt9IGJh
YmVsdHJhY2UgRmlsZTsgZmlsZV9wYXRoKCd7fScpLCBtb2RlKCd7fScpIi5mb3JtYXQoCisJCXJl
dHVybiAiezB9IGJhYmVsdHJhY2UgRmlsZTsgZmlsZV9wYXRoKCd7MX0nKSwgbW9kZSgnezJ9Jyki
LmZvcm1hdCgKIAkJCXN0YXQsIHNlbGYuX2ZpbGVfcGF0aCwgc2VsZi5fbW9kZSkKIAogCWRlZiBj
bG9zZShzZWxmKToKLS0gCjEuNy4xMS43Cgo=

--=_mixed 002AFE67C2257BCD_=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=_mixed 002AFE67C2257BCD_=--
