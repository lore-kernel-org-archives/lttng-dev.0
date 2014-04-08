From: Amit Margalit <AMITM@il.ibm.com>
Subject: [Babeltrace][RFC Patch][1/1] Add
 bt_ctf_get_decl_event_id() to obtain the event ID from the declaration
Date: Tue, 8 Apr 2014 16:02:37 +0300
Message-ID: <OF9D8E0B6C.51939645-ONC2257CB4.00471398-C2257CB4.0047AC03__3069.47582071206$1396962233$gmane$org@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_mixed 0047ABB3C2257CB4_="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp15.uk.ibm.com ([195.75.94.111])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <amitm@il.ibm.com>) id 1WXVg3-0008Ng-NE
 for lttng-dev@lists.lttng.org; Tue, 08 Apr 2014 09:03:00 -0400
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
 Tue, 8 Apr 2014 14:02:53 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id C63DC1B0805F
 for <lttng-dev@lists.lttng.org>; Tue,  8 Apr 2014 14:02:48 +0100 (BST)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s38D2cwd46268438
 for <lttng-dev@lists.lttng.org>; Tue, 8 Apr 2014 13:02:38 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s38D2nPc012131
 for <lttng-dev@lists.lttng.org>; Tue, 8 Apr 2014 07:02:49 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
 [9.149.104.181])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s38D2mDK012099
 for <lttng-dev@lists.lttng.org>; Tue, 8 Apr 2014 07:02:48 -0600
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--=_mixed 0047ABB3C2257CB4_=
Content-Type: multipart/alternative; boundary="=_alternative 0047ABB3C2257CB4_="


--=_alternative 0047ABB3C2257CB4_=
Content-Type: text/plain; charset="US-ASCII"

Hello all,

This patch adds an API to obtain the event ID given a bt_ctf_event_decl 
pointer. This is useful after using bt_ctf_get_event_decl_list() to obtain 
the list of events that exist in a trace that was just opened.

I have tried to make relevant additions to babeltrace.i.in in the Python 
bindings, as best I could, but have not tested these because I am not 
using the Python bindings anymore.



Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230
--=_alternative 0047ABB3C2257CB4_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Hello all,</font>
<br>
<br><font size=2 face="sans-serif">This patch adds an API to obtain the
event ID given a bt_ctf_event_decl pointer. This is useful after using
</font><font size=2 face="Monospace">bt_ctf_get_event_decl_list</font><font size=2 face="sans-serif">()
to obtain the list of events that exist in a trace that was just opened.</font>
<br>
<br><font size=2 face="sans-serif">I have tried to make relevant additions
to babeltrace.i.in in the Python bindings, as best I could, but have not
tested these because I am not using the Python bindings anymore.</font>
<br>
<br>
<br>
<br><font size=2 color=#000080 face="sans-serif">Amit Margalit</font>
<br><font size=2 color=#808000 face="sans-serif">IBM XIV </font><font size=2 face="sans-serif">-
<i>Storage Reinvented</i></font>
<br><font size=2 face="sans-serif">XIV-NAS Development Team</font>
<br><font size=2 face="sans-serif">Tel. 03</font><font size=2 face="Arial">-689-7774</font>
<br><font size=2 face="Arial">Fax. 03-689-7230</font>
--=_alternative 0047ABB3C2257CB4_=--

--=_mixed 0047ABB3C2257CB4_=
Content-Type: application/octet-stream; name="0001-Added-bt_ctf_get_decl_event_id-API-function.patch"
Content-Disposition: attachment; filename="0001-Added-bt_ctf_get_decl_event_id-API-function.patch"
Content-Transfer-Encoding: base64

RnJvbSBiNWEyMDM0ZDg1YzMzYmQyNTJiOGY3NzQxMGFlZWE3ZThhMDg4YTk5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWl0IE1hcmdhbGl0IDxhbWl0bUBpbC5pYm0uY29tPgpEYXRl
OiBUdWUsIDggQXByIDIwMTQgMTA6NTE6MDAgKzAzMDAKU3ViamVjdDogW1BBVENIXSBBZGRlZCBi
dF9jdGZfZ2V0X2RlY2xfZXZlbnRfaWQoKSBBUEkgZnVuY3Rpb24uCgpTaWduZWQtT2ZmLUJ5OiBB
bWl0IE1hcmdhbGl0IDxhbWl0bUBpbC5pYm0uY29tPgotLS0KIGJpbmRpbmdzL3B5dGhvbi9iYWJl
bHRyYWNlLmkuaW4gfCA4ICsrKysrKysrCiBmb3JtYXRzL2N0Zi9ldmVudHMuYyAgICAgICAgICAg
IHwgOCArKysrKysrKwogaW5jbHVkZS9iYWJlbHRyYWNlL2N0Zi9ldmVudHMuaCB8IDUgKysrKysK
IDMgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2JpbmRpbmdz
L3B5dGhvbi9iYWJlbHRyYWNlLmkuaW4gYi9iaW5kaW5ncy9weXRob24vYmFiZWx0cmFjZS5pLmlu
CmluZGV4IDI5NDE3N2YuLmNjM2VkNmYgMTAwNjQ0Ci0tLSBhL2JpbmRpbmdzL3B5dGhvbi9iYWJl
bHRyYWNlLmkuaW4KKysrIGIvYmluZGluZ3MvcHl0aG9uL2JhYmVsdHJhY2UuaS5pbgpAQCAtNTA5
LDYgKzUwOSw4IEBAIHN0cnVjdCBidF9jdGZfZXZlbnQgKmJ0X2N0Zl9pdGVyX3JlYWRfZXZlbnQo
c3RydWN0IGJ0X2N0Zl9pdGVyICppdGVyKTsKICVyZW5hbWUoIl9idF9jdGZfZmllbGRfZ2V0X2Vy
cm9yIikgYnRfY3RmX2ZpZWxkX2dldF9lcnJvcih2b2lkKTsKICVyZW5hbWUoIl9idF9jdGZfZ2V0
X2RlY2xfZXZlbnRfbmFtZSIpIGJ0X2N0Zl9nZXRfZGVjbF9ldmVudF9uYW1lKGNvbnN0IHN0cnVj
dAogCQlidF9jdGZfZXZlbnRfZGVjbCAqZXZlbnQpOworJXJlbmFtZSgiX2J0X2N0Zl9nZXRfZGVj
bF9ldmVudF9pZCIpIGJ0X2N0Zl9nZXRfZGVjbF9ldmVudF9pZChjb25zdCBzdHJ1Y3QKKwkJYnRf
Y3RmX2V2ZW50X2RlY2wgKmV2ZW50KTsKICVyZW5hbWUoIl9idF9jdGZfZ2V0X2RlY2xfZmllbGRf
bmFtZSIpIGJ0X2N0Zl9nZXRfZGVjbF9maWVsZF9uYW1lKAogCQljb25zdCBzdHJ1Y3QgYnRfY3Rm
X2ZpZWxkX2RlY2wgKmZpZWxkKTsKICVyZW5hbWUoIl9idF9jdGZfZ2V0X2RlY2xfZnJvbV9kZWYi
KSBidF9jdGZfZ2V0X2RlY2xfZnJvbV9kZWYoCkBAIC01NTEsNiArNTUzLDcgQEAgZG91YmxlIGJ0
X2N0Zl9nZXRfZmxvYXQoY29uc3Qgc3RydWN0IGJ0X2RlZmluaXRpb24gKmZpZWxkKTsKIGNvbnN0
IHN0cnVjdCBidF9kZWZpbml0aW9uICpidF9jdGZfZ2V0X3ZhcmlhbnQoY29uc3Qgc3RydWN0IGJ0
X2RlZmluaXRpb24gKmZpZWxkKTsKIGludCBidF9jdGZfZmllbGRfZ2V0X2Vycm9yKHZvaWQpOwog
Y29uc3QgY2hhciAqYnRfY3RmX2dldF9kZWNsX2V2ZW50X25hbWUoY29uc3Qgc3RydWN0IGJ0X2N0
Zl9ldmVudF9kZWNsICpldmVudCk7Cit1aW50NjRfdCBidF9jdGZfZ2V0X2RlY2xfZXZlbnRfaWQo
Y29uc3Qgc3RydWN0IGJ0X2N0Zl9ldmVudF9kZWNsICpldmVudCk7CiBjb25zdCBjaGFyICpidF9j
dGZfZ2V0X2RlY2xfZmllbGRfbmFtZShjb25zdCBzdHJ1Y3QgYnRfY3RmX2ZpZWxkX2RlY2wgKmZp
ZWxkKTsKIGNvbnN0IHN0cnVjdCBidF9kZWNsYXJhdGlvbiAqYnRfY3RmX2dldF9kZWNsX2Zyb21f
ZGVmKGNvbnN0IHN0cnVjdCBidF9kZWZpbml0aW9uICpmaWVsZCk7CiBjb25zdCBzdHJ1Y3QgYnRf
ZGVjbGFyYXRpb24gKmJ0X2N0Zl9nZXRfZGVjbF9mcm9tX2ZpZWxkX2RlY2woY29uc3Qgc3RydWN0
IGJ0X2N0Zl9maWVsZF9kZWNsICpmaWVsZCk7CkBAIC04MTQsNiArODE3LDExIEBAIGNsYXNzIEV2
ZW50RGVjbGFyYXRpb24ob2JqZWN0KToKIAkJcmV0dXJuIF9idF9jdGZfZ2V0X2RlY2xfZXZlbnRf
bmFtZShzZWxmLl9lZCkKIAogCUBwcm9wZXJ0eQorCWRlZiBpZChzZWxmKToKKwkJIiIiUmV0dXJu
IHRoZSBldmVudC1JRCBvZiB0aGUgZXZlbnQgb3IgKHVpbnQ2NF90KX4wIG9uIGVycm9yIiIiCisJ
CXJldHVybiBfYnRfY3RmX2dldF9kZWNsX2V2ZW50X2lkKHNlbGYuX2VkKQorCisJQHByb3BlcnR5
CiAJZGVmIGZpZWxkcyhzZWxmKToKIAkJIiIiCiAJCUdlbmVyYXRvciByZXR1cm5pbmcgYWxsIEZp
ZWxkRGVjbGFyYXRpb25zIG9mIGFuIGV2ZW50LCBnb2luZyB0aHJvdWdoCmRpZmYgLS1naXQgYS9m
b3JtYXRzL2N0Zi9ldmVudHMuYyBiL2Zvcm1hdHMvY3RmL2V2ZW50cy5jCmluZGV4IDgxNzQyOTMu
LjY5OGM1ZjMgMTAwNjQ0Ci0tLSBhL2Zvcm1hdHMvY3RmL2V2ZW50cy5jCisrKyBiL2Zvcm1hdHMv
Y3RmL2V2ZW50cy5jCkBAIC03MTIsNiArNzEyLDE0IEBAIGNvbnN0IGNoYXIgKmJ0X2N0Zl9nZXRf
ZGVjbF9ldmVudF9uYW1lKGNvbnN0IHN0cnVjdCBidF9jdGZfZXZlbnRfZGVjbCAqZXZlbnQpCiAJ
cmV0dXJuIGdfcXVhcmtfdG9fc3RyaW5nKGV2ZW50LT5wYXJlbnQubmFtZSk7CiB9CiAKK3VpbnQ2
NF90IGJ0X2N0Zl9nZXRfZGVjbF9ldmVudF9pZChjb25zdCBzdHJ1Y3QgYnRfY3RmX2V2ZW50X2Rl
Y2wgKmV2ZW50KQoreworCWlmICghZXZlbnQpCisJCXJldHVybiAodWludDY0X3QpKH4wKTsKKwor
CXJldHVybiBldmVudC0+cGFyZW50LmlkOworfQorCiBpbnQgYnRfY3RmX2dldF9kZWNsX2ZpZWxk
cyhzdHJ1Y3QgYnRfY3RmX2V2ZW50X2RlY2wgKmV2ZW50X2RlY2wsCiAJCWVudW0gYnRfY3RmX3Nj
b3BlIHNjb3BlLAogCQlzdHJ1Y3QgYnRfY3RmX2ZpZWxkX2RlY2wgY29uc3QgKiBjb25zdCAqKmxp
c3QsCmRpZmYgLS1naXQgYS9pbmNsdWRlL2JhYmVsdHJhY2UvY3RmL2V2ZW50cy5oIGIvaW5jbHVk
ZS9iYWJlbHRyYWNlL2N0Zi9ldmVudHMuaAppbmRleCBjODFkODg1Li4zOTk1YzUwIDEwMDY0NAot
LS0gYS9pbmNsdWRlL2JhYmVsdHJhY2UvY3RmL2V2ZW50cy5oCisrKyBiL2luY2x1ZGUvYmFiZWx0
cmFjZS9jdGYvZXZlbnRzLmgKQEAgLTI3MSw2ICsyNzEsMTEgQEAgaW50IGJ0X2N0Zl9nZXRfZXZl
bnRfZGVjbF9saXN0KGludCBoYW5kbGVfaWQsIHN0cnVjdCBidF9jb250ZXh0ICpjdHgsCiBjb25z
dCBjaGFyICpidF9jdGZfZ2V0X2RlY2xfZXZlbnRfbmFtZShjb25zdCBzdHJ1Y3QgYnRfY3RmX2V2
ZW50X2RlY2wgKmV2ZW50KTsKIAogLyoKKyAqIGJ0X2N0Zl9nZXRfZGVjbF9ldmVudF9pZDogcmV0
dXJuIHRoZSBldmVudC1JRCBvZiB0aGUgZXZlbnQgb3IgKHVpbnQ2NF90KSh+MCkgb24gZXJyb3IK
KyAqLwordWludDY0X3QgYnRfY3RmX2dldF9kZWNsX2V2ZW50X2lkKGNvbnN0IHN0cnVjdCBidF9j
dGZfZXZlbnRfZGVjbCAqZXZlbnQpOworCisvKgogICogYnRfY3RmX2dldF9kZWNsX2ZpZWxkczog
Z2V0IGFsbCBmaWVsZCBkZWNsYXJhdGlvbnMgaW4gYSBzY29wZSBvZiBhbiBldmVudAogICoKICAq
IFRoZSBsaXN0IGFycmF5IGlzIHBvaW50ZWQgdG8gdGhlIGFycmF5IG9mIGZpZWxkIGRlY2xhcmF0
aW9uLgotLSAKMS45LjEKCg==

--=_mixed 0047ABB3C2257CB4_=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=_mixed 0047ABB3C2257CB4_=--
