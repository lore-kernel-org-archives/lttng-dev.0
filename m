From: Amit Margalit <AMITM@il.ibm.com>
Subject: [RFC patch] [Babeltrace python bindings] Added missing
 call to _bt_ctf_get_decl_from_def in get_int_len(), and defined ssize_t
Date: Mon, 19 Aug 2013 14:15:31 +0300
Message-ID: <OF83984A41.55B3F7DA-ONC2257BCC.003D5BF5-C2257BCC.003DCDC3__21726.3214326978$1376911005$gmane$org@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_mixed 003DCD6AC2257BCC_="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp15.uk.ibm.com ([195.75.94.111])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1VBNRA-0002ww-GF
	for lttng-dev@lists.lttng.org; Mon, 19 Aug 2013 07:15:56 -0400
Received: from /spool/local
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Mon, 19 Aug 2013 12:10:05 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
	(d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id D0B13219005E
	for <lttng-dev@lists.lttng.org>; Mon, 19 Aug 2013 12:20:24 +0100 (BST)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
	[9.149.37.250])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r7JBFWaX62390412
	for <lttng-dev@lists.lttng.org>; Mon, 19 Aug 2013 11:15:32 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r7JBFij2032010
	for <lttng-dev@lists.lttng.org>; Mon, 19 Aug 2013 05:15:44 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with
	ESMTP id r7JBFiDP032007
	for <lttng-dev@lists.lttng.org>; Mon, 19 Aug 2013 05:15:44 -0600
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

--=_mixed 003DCD6AC2257BCC_=
Content-Type: multipart/alternative; boundary="=_alternative 003DCD6AC2257BCC_="


--=_alternative 003DCD6AC2257BCC_=
Content-Type: text/plain; charset="US-ASCII"

In some systems, the system headers use ssize_t, which was not defined, 
causing get_int_len() to return a pointer to a python object instead of 
returning the integer.
Also, the python code that called _bt_ctf_get_int_len() failed to wrap 
self._d with the call to _bt_ctf_get_decl_from_def.

I'm attaching this patch to (hopefully) avoid line formatting issues.




Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230
--=_alternative 003DCD6AC2257BCC_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">In some systems, the system headers use
ssize_t, which was not defined, causing get_int_len() to return a pointer
to a python object instead of returning the integer.</font>
<br><font size=2 face="sans-serif">Also, the python code that called _bt_ctf_get_int_len()
failed to wrap self._d with the call to _bt_ctf_get_decl_from_def.</font>
<br>
<br><font size=2 face="sans-serif">I'm attaching this patch to (hopefully)
avoid line formatting issues.</font>
<br>
<br>
<br>
<br>
<br><font size=2 color=#000080 face="sans-serif">Amit Margalit</font>
<br><font size=2 color=#808000 face="sans-serif">IBM XIV </font><font size=2 face="sans-serif">-
<i>Storage Reinvented</i></font>
<br><font size=2 face="sans-serif">XIV-NAS Development Team</font>
<br><font size=2 face="sans-serif">Tel. 03</font><font size=2 face="Arial">-689-7774</font>
<br><font size=2 face="Arial">Fax. 03-689-7230</font>
--=_alternative 003DCD6AC2257BCC_=--

--=_mixed 003DCD6AC2257BCC_=
Content-Type: application/octet-stream; name="0001-Added-missing-call-to-_bt_ctf_get_decl_from_def-in-g.patch"
Content-Disposition: attachment; filename="0001-Added-missing-call-to-_bt_ctf_get_decl_from_def-in-g.patch"
Content-Transfer-Encoding: base64

RnJvbSBjMzQ3NGE3M2ViMTM3YjJiYjc5ODRkMzE5NTA5NGEyNjNjMDI0ZTY1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWl0IE1hcmdhbGl0IDxhbWl0bUBpbC5pYm0uY29tPgpEYXRl
OiBNb24sIDE5IEF1ZyAyMDEzIDE0OjA4OjQwICswMzAwClN1YmplY3Q6IFtQQVRDSCAxLzJdIEFk
ZGVkIG1pc3NpbmcgY2FsbCB0byBfYnRfY3RmX2dldF9kZWNsX2Zyb21fZGVmIGluCiBnZXRfaW50
X2xlbigpLCBhbmQgZGVmaW5lZCBzc2l6ZV90CgotLS0KIGJpbmRpbmdzL3B5dGhvbi9iYWJlbHRy
YWNlLmkuaW4gfCAzICsrLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQoKZGlmZiAtLWdpdCBhL2JpbmRpbmdzL3B5dGhvbi9iYWJlbHRyYWNlLmkuaW4gYi9i
aW5kaW5ncy9weXRob24vYmFiZWx0cmFjZS5pLmluCmluZGV4IGRkMmRhY2MuLjZjMWY2ZmIgMTAw
NjQ0Ci0tLSBhL2JpbmRpbmdzL3B5dGhvbi9iYWJlbHRyYWNlLmkuaW4KKysrIGIvYmluZGluZ3Mv
cHl0aG9uL2JhYmVsdHJhY2UuaS5pbgpAQCAtNTMsNiArNTMsNyBAQCB0cmFjZSB0byBpdC4iCiB0
eXBlZGVmIHVuc2lnbmVkIGxvbmcgbG9uZyB1aW50NjRfdDsKIHR5cGVkZWYgbG9uZyBsb25nIGlu
dDY0X3Q7CiB0eXBlZGVmIGludCBidF9pbnRlcm5fc3RyOwordHlwZWRlZiB1bnNpZ25lZCBsb25n
IHNzaXplX3Q7CiAKIC8qID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09CiAJCUNPTlRFWFQuSCwgQ09OVEVYVC1JTlRFUk5BTC5I
CkBAIC04NjYsNyArODY3LDcgQEAgY2xhc3MgY3RmOgogCQkJUmV0dXJuIHRoZSBzaXplLCBpbiBi
aXRzLCBvZiBhbiBpbnQgb3IgYSBuZWdhdGl2ZQogCQkJdmFsdWUgb24gZXJyb3IuCiAJCQkiIiIK
LQkJCXJldHVybiBfYnRfY3RmX2dldF9pbnRfbGVuKHNlbGYuX2QpCisJCQlyZXR1cm4gX2J0X2N0
Zl9nZXRfaW50X2xlbihfYnRfY3RmX2dldF9kZWNsX2Zyb21fZGVmKHNlbGYuX2QpKQogCiAJCWRl
ZiBnZXRfZW5jb2Rpbmcoc2VsZik6CiAJCQkiIiIKLS0gCjEuNy4xMS43Cgo=

--=_mixed 003DCD6AC2257BCC_=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=_mixed 003DCD6AC2257BCC_=--
