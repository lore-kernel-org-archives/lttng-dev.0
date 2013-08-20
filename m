From: Amit Margalit <AMITM@il.ibm.com>
Subject: [RFC patch 1/3] [Babeltrace python bindings] Added
 missing call to _bt_ctf_get_decl_from_def() when calling
 _bt_ctf_get_int_len().
Date: Tue, 20 Aug 2013 10:46:15 +0300
Message-ID: <OF1E3FA7DB.5BECB4A4-ONC2257BCD.002A81AE-C2257BCD.002AA547__36626.7534475357$1376984848$gmane$org@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_mixed 002AA519C2257BCD_="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp13.uk.ibm.com ([195.75.94.109])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1VBgeD-0006XK-Bc
	for lttng-dev@lists.lttng.org; Tue, 20 Aug 2013 03:46:40 -0400
Received: from /spool/local
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Tue, 20 Aug 2013 08:41:19 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
	(d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
	by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3900017D805D
	for <lttng-dev@lists.lttng.org>; Tue, 20 Aug 2013 08:48:23 +0100 (BST)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
	[9.149.37.250])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r7K7kGvH63504386
	for <lttng-dev@lists.lttng.org>; Tue, 20 Aug 2013 07:46:16 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r7K7kS8h009490
	for <lttng-dev@lists.lttng.org>; Tue, 20 Aug 2013 01:46:28 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with
	ESMTP id r7K7kS2f009486
	for <lttng-dev@lists.lttng.org>; Tue, 20 Aug 2013 01:46:28 -0600
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

--=_mixed 002AA519C2257BCD_=
Content-Type: multipart/alternative; boundary="=_alternative 002AA519C2257BCD_="


--=_alternative 002AA519C2257BCD_=
Content-Type: text/plain; charset="US-ASCII"

The python code that called _bt_ctf_get_int_len() failed to wrap self._d 
with the call to _bt_ctf_get_decl_from_def.



Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230
--=_alternative 002AA519C2257BCD_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">The python code that called </font><tt><font size=2>_bt_ctf_get_int_len()</font></tt><font size=2 face="sans-serif">
failed to wrap </font><tt><font size=2>self._d</font></tt><font size=2 face="sans-serif">
with the call to </font><tt><font size=2>_bt_ctf_get_decl_from_def</font></tt><font size=2 face="sans-serif">.</font>
<br>
<br>
<br>
<br><font size=2 color=#000080 face="sans-serif">Amit Margalit</font>
<br><font size=2 color=#808000 face="sans-serif">IBM XIV </font><font size=2 face="sans-serif">-
<i>Storage Reinvented</i></font>
<br><font size=2 face="sans-serif">XIV-NAS Development Team</font>
<br><font size=2 face="sans-serif">Tel. 03</font><font size=2 face="Arial">-689-7774</font>
<br><font size=2 face="Arial">Fax. 03-689-7230</font>
--=_alternative 002AA519C2257BCD_=--

--=_mixed 002AA519C2257BCD_=
Content-Type: application/octet-stream; name="0001-Added-missing-call-to-_bt_ctf_get_decl_from_def-when.patch"
Content-Disposition: attachment; filename="0001-Added-missing-call-to-_bt_ctf_get_decl_from_def-when.patch"
Content-Transfer-Encoding: base64

RnJvbSBhNmQwZjNiMjJhMGI3OGMzMjM4MzZjZTYzNTI4OGJkODc4NGU5NjAxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWl0IE1hcmdhbGl0IDxhbWl0bUBpbC5pYm0uY29tPgpEYXRl
OiBUdWUsIDIwIEF1ZyAyMDEzIDA5OjI5OjAyICswMzAwClN1YmplY3Q6IFtQQVRDSCAxLzNdIEFk
ZGVkIG1pc3NpbmcgY2FsbCB0byBfYnRfY3RmX2dldF9kZWNsX2Zyb21fZGVmKCkgd2hlbgogY2Fs
bGluZyBfYnRfY3RmX2dldF9pbnRfbGVuKCkuCgpTaWduZWQtb2ZmLWJ5OiBBbWl0IE1hcmdhbGl0
IDxhbWl0bUBpbC5pYm0uY29tPgotLS0KIGJpbmRpbmdzL3B5dGhvbi9iYWJlbHRyYWNlLmkuaW4g
fCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRp
ZmYgLS1naXQgYS9iaW5kaW5ncy9weXRob24vYmFiZWx0cmFjZS5pLmluIGIvYmluZGluZ3MvcHl0
aG9uL2JhYmVsdHJhY2UuaS5pbgppbmRleCBkZDJkYWNjLi4xNmRiYmJkIDEwMDY0NAotLS0gYS9i
aW5kaW5ncy9weXRob24vYmFiZWx0cmFjZS5pLmluCisrKyBiL2JpbmRpbmdzL3B5dGhvbi9iYWJl
bHRyYWNlLmkuaW4KQEAgLTg2Niw3ICs4NjYsNyBAQCBjbGFzcyBjdGY6CiAJCQlSZXR1cm4gdGhl
IHNpemUsIGluIGJpdHMsIG9mIGFuIGludCBvciBhIG5lZ2F0aXZlCiAJCQl2YWx1ZSBvbiBlcnJv
ci4KIAkJCSIiIgotCQkJcmV0dXJuIF9idF9jdGZfZ2V0X2ludF9sZW4oc2VsZi5fZCkKKwkJCXJl
dHVybiBfYnRfY3RmX2dldF9pbnRfbGVuKF9idF9jdGZfZ2V0X2RlY2xfZnJvbV9kZWYoc2VsZi5f
ZCkpCiAKIAkJZGVmIGdldF9lbmNvZGluZyhzZWxmKToKIAkJCSIiIgotLSAKMS43LjExLjcKCg==

--=_mixed 002AA519C2257BCD_=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=_mixed 002AA519C2257BCD_=--
