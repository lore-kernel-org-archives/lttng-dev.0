From: Amit Margalit <AMITM@il.ibm.com>
Subject: [RFC patch 3/3] [Babeltrace python bindings] Added
 missing typedef of ssize_t to babeltrace.i.in
Date: Tue, 20 Aug 2013 10:58:53 +0300
Message-ID: <OFF39EE861.F113E1F5-ONC2257BCD.002B4E00-C2257BCD.002BCD61__8756.51372266493$1376985610$gmane$org@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_mixed 002BCD11C2257BCD_="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp14.uk.ibm.com ([195.75.94.110])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1VBgqS-0007GP-9O
	for lttng-dev@lists.lttng.org; Tue, 20 Aug 2013 03:59:21 -0400
Received: from /spool/local
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Tue, 20 Aug 2013 08:49:40 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
	(d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
	by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9ED5817D8057
	for <lttng-dev@lists.lttng.org>; Tue, 20 Aug 2013 09:01:01 +0100 (BST)
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
	[9.149.37.247])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r7K7wtEm64225428
	for <lttng-dev@lists.lttng.org>; Tue, 20 Aug 2013 07:58:55 GMT
Received: from d06av12.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r7K7x6T9014143
	for <lttng-dev@lists.lttng.org>; Tue, 20 Aug 2013 01:59:06 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with
	ESMTP id r7K7x63Z014132
	for <lttng-dev@lists.lttng.org>; Tue, 20 Aug 2013 01:59:06 -0600
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

--=_mixed 002BCD11C2257BCD_=
Content-Type: multipart/alternative; boundary="=_alternative 002BCD11C2257BCD_="


--=_alternative 002BCD11C2257BCD_=
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

The file babeltrace.i.in contains a declaration of bt=5Fget=5Fint=5Flen()=20
returning ssize=5Ft, which SWIG does not recognize as an integer (perhaps=20
only in some cases).
Adding a typedef causes generation of correct code.

J=E9r=E9mie, perhaps your suggestion to solve this in config time is better=
,=20
so I would leave this to your discretion.



Thanks,

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230
--=_alternative 002BCD11C2257BCD_=
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<font size=3D2 face=3D"sans-serif">The file babeltrace.i.in contains a decl=
aration
of bt=5Fget=5Fint=5Flen() returning ssize=5Ft, which SWIG does not recogniz=
e as
an integer (perhaps only in some cases).</font>
<br><font size=3D2 face=3D"sans-serif">Adding a typedef causes generation of
correct code.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">J=E9r=E9mie, perhaps your suggestion=
 to
solve this in config time is better, so I would leave this to your discreti=
on.</font>
<br>
<br>
<br>
<br><font size=3D2 face=3D"sans-serif">Thanks,</font>
<br>
<br><font size=3D2 color=3D#000080 face=3D"sans-serif">Amit Margalit</font>
<br><font size=3D2 color=3D#808000 face=3D"sans-serif">IBM XIV </font><font=
 size=3D2 face=3D"sans-serif">-
<i>Storage Reinvented</i></font>
<br><font size=3D2 face=3D"sans-serif">XIV-NAS Development Team</font>
<br><font size=3D2 face=3D"sans-serif">Tel. 03</font><font size=3D2 face=3D=
"Arial">-689-7774</font>
<br><font size=3D2 face=3D"Arial">Fax. 03-689-7230</font>
--=_alternative 002BCD11C2257BCD_=--

--=_mixed 002BCD11C2257BCD_=
Content-Type: application/octet-stream; name="0003-Added-missing-declaration-of-ssize_t-as-unsigned-lon.patch"
Content-Disposition: attachment; filename="0003-Added-missing-declaration-of-ssize_t-as-unsigned-lon.patch"
Content-Transfer-Encoding: base64

RnJvbSBmMjkzNGNlMWZlOWFlMGI5ZWZiYmMxZDEzMTYyMmUwYjQ5ZTY3NTQ4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWl0IE1hcmdhbGl0IDxhbWl0bUBpbC5pYm0uY29tPgpEYXRl
OiBUdWUsIDIwIEF1ZyAyMDEzIDEwOjQxOjMwICswMzAwClN1YmplY3Q6IFtQQVRDSCAzLzNdIEFk
ZGVkIG1pc3NpbmcgZGVjbGFyYXRpb24gb2Ygc3NpemVfdCBhcyB1bnNpZ25lZCBsb25nCiBmb3Ig
U1dJRy4KClNpZ25lZC1vZmYtYnk6IEFtaXQgTWFyZ2FsaXQgPGFtaXRtQGlsLmlibS5jb20+Ci0t
LQogYmluZGluZ3MvcHl0aG9uL2JhYmVsdHJhY2UuaS5pbiB8IDEgKwogMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvYmluZGluZ3MvcHl0aG9uL2JhYmVsdHJhY2Uu
aS5pbiBiL2JpbmRpbmdzL3B5dGhvbi9iYWJlbHRyYWNlLmkuaW4KaW5kZXggMjQ1ODE2MC4uYmQy
ZDc0MCAxMDA2NDQKLS0tIGEvYmluZGluZ3MvcHl0aG9uL2JhYmVsdHJhY2UuaS5pbgorKysgYi9i
aW5kaW5ncy9weXRob24vYmFiZWx0cmFjZS5pLmluCkBAIC01Myw2ICs1Myw3IEBAIHRyYWNlIHRv
IGl0LiIKIHR5cGVkZWYgdW5zaWduZWQgbG9uZyBsb25nIHVpbnQ2NF90OwogdHlwZWRlZiBsb25n
IGxvbmcgaW50NjRfdDsKIHR5cGVkZWYgaW50IGJ0X2ludGVybl9zdHI7Cit0eXBlZGVmIHVuc2ln
bmVkIGxvbmcgc3NpemVfdDsKIAogLyogPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KIAkJQ09OVEVYVC5ILCBDT05URVhULUlO
VEVSTkFMLkgKLS0gCjEuNy4xMS43Cgo=

--=_mixed 002BCD11C2257BCD_=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=_mixed 002BCD11C2257BCD_=--
