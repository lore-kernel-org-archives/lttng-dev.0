From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: [RFC patch] [Babeltrace python bindings] Added
 missing call to _bt_ctf_get_decl_from_def in get_int_len(),
 and defined ssize_t
Date: Tue, 20 Aug 2013 10:38:34 +0300
Message-ID: <OF1BDE6557.7A55C16D-ONC2257BCD.0028F2BD-C2257BCD.0029F0F3__37179.6711268418$1376984405$gmane$org@il.ibm.com>
References: <OF83984A41.55B3F7DA-ONC2257BCC.003D5BF5-C2257BCC.003DCDC3@il.ibm.com>
	<CA+jJMxuL5X+VWntZXHD2Mm3pJQjc-zgW2BqKpAu9XBVsb565Yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0334248700=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp10.uk.ibm.com ([195.75.94.106])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1VBgWn-00065E-V5
	for lttng-dev@lists.lttng.org; Tue, 20 Aug 2013 03:39:04 -0400
Received: from /spool/local
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Tue, 20 Aug 2013 08:35:49 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
	(d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id DD1542190070
	for <lttng-dev@lists.lttng.org>; Tue, 20 Aug 2013 08:43:29 +0100 (BST)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r7K7carW64749676
	for <lttng-dev@lists.lttng.org>; Tue, 20 Aug 2013 07:38:36 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r7K7ck0j015419
	for <lttng-dev@lists.lttng.org>; Tue, 20 Aug 2013 01:38:47 -0600
In-Reply-To: <CA+jJMxuL5X+VWntZXHD2Mm3pJQjc-zgW2BqKpAu9XBVsb565Yw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, jeremie.galarneau@gmail.com
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============0334248700==
Content-Type: multipart/alternative; boundary="=_alternative 0029F092C2257BCD_="

This is a multipart message in MIME format.
--=_alternative 0029F092C2257BCD_=
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

(Separated patches with signed-off-by lines follow this email).

My description of the issue with ssize=5Ft was lacking. In babeltrace.i.in =

we have the following declaration:

        ssize=5Ft bt=5Fctf=5Fget=5Fint=5Flen(const struct bt=5Fdeclaration =
*field);

Since ssize=5Ft is not defined elsewhere in babeltrace.i.in, SWIG (I am=20
using swig-2.0.10) doesn't recognize it as an integer, and generates the=20
following code in babeltrace=5Fwrap.c:4710

  result =3D bt=5Fctf=5Fget=5Fint=5Flen((struct bt=5Fdeclaration const *)ar=
g1);
  resultobj =3D SWIG=5FNewPointerObj((ssize=5Ft *)memcpy((ssize=5Ft=20
*)malloc(sizeof(ssize=5Ft)),&result,sizeof(ssize=5Ft)), SWIGTYPE=5Fp=5Fssiz=
e=5Ft,=20
SWIG=5FPOINTER=5FOWN |  0 );
  return resultobj;

This is part of =5Fwrap=5F=5Fbt=5Fctf=5Fget=5Fint=5Flen().

When I compare this to a different function that needs to return an=20
integer, I see =5Fwrap=5F=5Fbt=5Fctf=5Fget=5Farray=5Flen() for example, whi=
ch has these=20
lines:

  result =3D (int)bt=5Fctf=5Fget=5Farray=5Flen((struct bt=5Fdeclaration con=
st *)arg1);
  resultobj =3D SWIG=5FFrom=5Fint((int)(result));
  return resultobj;

This is what led me to define ssize=5Ft as an unsigned long, which produced=
=20
the correct result.

Perhaps different versions of SWIG behave differently, or perhaps still -=20
the same version of SWIG when run on a different system behaves=20
differently.

Thanks,

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
To:     Amit Margalit/Israel/IBM@IBMIL
Cc:     "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Date:   08/19/2013 06:10 PM
Subject:        Re: [lttng-dev] [RFC patch] [Babeltrace python bindings]=20
Added missing call to =5Fbt=5Fctf=5Fget=5Fdecl=5Ffrom=5Fdef in get=5Fint=5F=
len(), and=20
defined ssize=5Ft
Sent by:        jeremie.galarneau@gmail.com



Inlining for review.
Please note that both patches in this series are missing your "signed-off=20
by" line.

Also, the issues addressed in this patch are unrelated and should be fixed =

separately.

> From c3474a73eb137b2bb7984d3195094a263c024e65 Mon Sep 17 00:00:00 2001
> From: Amit Margalit <amitm@il.ibm.com>
> Date: Mon, 19 Aug 2013 14:08:40 +0300
> Subject: [PATCH 1/2] Added missing call to =5Fbt=5Fctf=5Fget=5Fdecl=5Ffro=
m=5Fdef in
>  get=5Fint=5Flen(), and defined ssize=5Ft
>=20
> ---
>  bindings/python/babeltrace.i.in | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/bindings/python/babeltrace.i.in b/bindings/python/
babeltrace.i.in
> index dd2dacc..6c1f6fb 100644
> --- a/bindings/python/babeltrace.i.in
> +++ b/bindings/python/babeltrace.i.in
> @@ -53,6 +53,7 @@ trace to it."
>  typedef unsigned long long uint64=5Ft;
>  typedef long long int64=5Ft;
>  typedef int bt=5Fintern=5Fstr;
> +typedef unsigned long ssize=5Ft;

On which system is ssize=5Ft undefined?
I'd personally use ptrdiff=5Ft, but maybe it is undefined there too?

These typedefs should be handled at config time, is it something you would =

be interested in providing a patch for?

> =20
>  /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   CONTEXT.H, CONTEXT-INTERNAL.H
> @@ -866,7 +867,7 @@ class ctf:
>   Return the size, in bits, of an int or a negative
>   value on error.
>   """
> - return =5Fbt=5Fctf=5Fget=5Fint=5Flen(self.=5Fd)
> + return =5Fbt=5Fctf=5Fget=5Fint=5Flen(=5Fbt=5Fctf=5Fget=5Fdecl=5Ffrom=5F=
def(self.=5Fd))

Good catch!

> =20
>   def get=5Fencoding(self):
>   """
> --=20
> 1.7.11.7
>=20


On Mon, Aug 19, 2013 at 7:15 AM, Amit Margalit <AMITM@il.ibm.com> wrote:
In some systems, the system headers use ssize=5Ft, which was not defined,=20
causing get=5Fint=5Flen() to return a pointer to a python object instead of=
=20
returning the integer.=20
Also, the python code that called =5Fbt=5Fctf=5Fget=5Fint=5Flen() failed to=
 wrap=20
self.=5Fd with the call to =5Fbt=5Fctf=5Fget=5Fdecl=5Ffrom=5Fdef.=20

I'm attaching this patch to (hopefully) avoid line formatting issues.=20




Amit Margalit=20
IBM XIV - Storage Reinvented=20
XIV-NAS Development Team=20
Tel. 03-689-7774=20
Fax. 03-689-7230
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev




--=20
J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com=20

--=_alternative 0029F092C2257BCD_=
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<font size=3D2 face=3D"sans-serif">Hi,</font>
<br>
<br><font size=3D2 face=3D"sans-serif">(Separated patches with signed-off-by
lines follow this email).</font>
<br>
<br><font size=3D2 face=3D"sans-serif">My description of the issue with ssi=
ze=5Ft
was lacking. In babeltrace.i.in we have the following declaration:</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; </font><=
tt><font size=3D2>ssize=5Ft
bt=5Fctf=5Fget=5Fint=5Flen(const struct bt=5Fdeclaration *field);</font></t=
t>
<br>
<br><font size=3D2 face=3D"sans-serif">Since ssize=5Ft is not defined elsew=
here
in babeltrace.i.in, SWIG (I am using swig-2.0.10) doesn't recognize it
as an integer, and generates the following code in babeltrace=5Fwrap.c:4710=
</font>
<br>
<br><tt><font size=3D2>&nbsp; result =3D bt=5Fctf=5Fget=5Fint=5Flen((struct=
 bt=5Fdeclaration
const *)arg1);</font></tt>
<br><tt><font size=3D2>&nbsp; resultobj =3D SWIG=5FNewPointerObj((ssize=5Ft=
 *)memcpy((ssize=5Ft
*)malloc(sizeof(ssize=5Ft)),&amp;result,sizeof(ssize=5Ft)), SWIGTYPE=5Fp=5F=
ssize=5Ft,
SWIG=5FPOINTER=5FOWN | &nbsp;0 );</font></tt>
<br><tt><font size=3D2>&nbsp; return resultobj;</font></tt>
<br>
<br><font size=3D2 face=3D"sans-serif">This is part of </font><tt><font siz=
e=3D2>=5Fwrap=5F=5Fbt=5Fctf=5Fget=5Fint=5Flen()</font></tt><font size=3D2 f=
ace=3D"sans-serif">.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">When I compare this to a different f=
unction
that needs to return an integer, I see </font><tt><font size=3D2>=5Fwrap=5F=
=5Fbt=5Fctf=5Fget=5Farray=5Flen()</font></tt><font size=3D2 face=3D"sans-se=
rif">
for example, which has these lines:</font>
<br>
<br><tt><font size=3D2>&nbsp; result =3D (int)bt=5Fctf=5Fget=5Farray=5Flen(=
(struct
bt=5Fdeclaration const *)arg1);</font></tt>
<br><tt><font size=3D2>&nbsp; resultobj =3D SWIG=5FFrom=5Fint((int)(result)=
);</font></tt>
<br><tt><font size=3D2>&nbsp; return resultobj;</font></tt>
<br>
<br><font size=3D2 face=3D"sans-serif">This is what led me to define ssize=
=5Ft
as an unsigned long, which produced the correct result.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Perhaps different versions of SWIG b=
ehave
differently, or perhaps still - the same version of SWIG when run on a
different system behaves differently.</font>
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
<br>
<br>
<br>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">From: &nbsp; &nbsp; =
&nbsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">J=E9r=E9mie Galarneau &lt;j=
eremie.galarneau@efficios.com&gt;</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">To: &nbsp; &nbsp; &n=
bsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">Amit Margalit/Israel/IBM@IB=
MIL</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Cc: &nbsp; &nbsp; &n=
bsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">&quot;lttng-dev@lists.lttng=
.org&quot;
&lt;lttng-dev@lists.lttng.org&gt;</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Date: &nbsp; &nbsp; =
&nbsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">08/19/2013 06:10 PM</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Subject: &nbsp; &nbs=
p;
&nbsp; &nbsp;</font><font size=3D1 face=3D"sans-serif">Re: [lttng-dev]
[RFC patch] [Babeltrace python bindings] Added missing call to =5Fbt=5Fctf=
=5Fget=5Fdecl=5Ffrom=5Fdef
in get=5Fint=5Flen(), and defined ssize=5Ft</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Sent by: &nbsp; &nbs=
p;
&nbsp; &nbsp;</font><font size=3D1 face=3D"sans-serif">jeremie.galarneau@gm=
ail.com</font>
<br>
<hr noshade>
<br>
<br>
<br><font size=3D3>Inlining for review.</font>
<br><font size=3D3>Please note that both patches in this series are missing
your &quot;signed-off by&quot; line.</font>
<br>
<br><font size=3D3>Also, the issues addressed in this patch are unrelated
and should be fixed separately.</font>
<br>
<br><font size=3D3>&gt; From c3474a73eb137b2bb7984d3195094a263c024e65 Mon
Sep 17 00:00:00 2001</font>
<br><font size=3D3>&gt; From: Amit Margalit &lt;</font><a href=3Dmailto:ami=
tm@il.ibm.com><font size=3D3 color=3Dblue><u>amitm@il.ibm.com</u></font></a=
><font size=3D3>&gt;</font>
<br><font size=3D3>&gt; Date: Mon, 19 Aug 2013 14:08:40 +0300</font>
<br><font size=3D3>&gt; Subject: [PATCH 1/2] Added missing call to =5Fbt=5F=
ctf=5Fget=5Fdecl=5Ffrom=5Fdef
in</font>
<br><font size=3D3>&gt; &nbsp;get=5Fint=5Flen(), and defined ssize=5Ft</fon=
t>
<br><font size=3D3>&gt;&nbsp;</font>
<br><font size=3D3>&gt; ---</font>
<br><font size=3D3>&gt; &nbsp;bindings/python/</font><a href=3Dhttp://babel=
trace.i.in/><font size=3D3 color=3Dblue><u>babeltrace.i.in</u></font></a><f=
ont size=3D3>
| 3 ++-</font>
<br><font size=3D3>&gt; &nbsp;1 file changed, 2 insertions(+), 1 deletion(-=
)</font>
<br><font size=3D3>&gt;&nbsp;</font>
<br><font size=3D3>&gt; diff --git a/bindings/python/</font><a href=3Dhttp:=
//babeltrace.i.in/><font size=3D3 color=3Dblue><u>babeltrace.i.in</u></font=
></a><font size=3D3>
b/bindings/python/</font><a href=3Dhttp://babeltrace.i.in/><font size=3D3 c=
olor=3Dblue><u>babeltrace.i.in</u></font></a>
<br><font size=3D3>&gt; index dd2dacc..6c1f6fb 100644</font>
<br><font size=3D3>&gt; --- a/bindings/python/</font><a href=3Dhttp://babel=
trace.i.in/><font size=3D3 color=3Dblue><u>babeltrace.i.in</u></font></a>
<br><font size=3D3>&gt; +++ b/bindings/python/</font><a href=3Dhttp://babel=
trace.i.in/><font size=3D3 color=3Dblue><u>babeltrace.i.in</u></font></a>
<br><font size=3D3>&gt; @@ -53,6 +53,7 @@ trace to it.&quot;</font>
<br><font size=3D3>&gt; &nbsp;typedef unsigned long long uint64=5Ft;</font>
<br><font size=3D3>&gt; &nbsp;typedef long long int64=5Ft;</font>
<br><font size=3D3>&gt; &nbsp;typedef int bt=5Fintern=5Fstr;</font>
<br><font size=3D3>&gt; +typedef unsigned long ssize=5Ft;</font>
<br>
<br><font size=3D3>On which system is ssize=5Ft undefined?</font>
<br><font size=3D3>I'd personally use ptrdiff=5Ft, but maybe it is undefined
there too?</font>
<br>
<br><font size=3D3>These typedefs should be handled at config time, is it
something you would be interested in providing a patch for?</font>
<br>
<br><font size=3D3>&gt; &nbsp;</font>
<br><font size=3D3>&gt; &nbsp;/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D</font>
<br><font size=3D3>&gt; &nbsp; CONTEXT.H, CONTEXT-INTERNAL.H</font>
<br><font size=3D3>&gt; @@ -866,7 +867,7 @@ class ctf:</font>
<br><font size=3D3>&gt; &nbsp; Return the size, in bits, of an int or a neg=
ative</font>
<br><font size=3D3>&gt; &nbsp; value on error.</font>
<br><font size=3D3>&gt; &nbsp; &quot;&quot;&quot;</font>
<br><font size=3D3>&gt; - return =5Fbt=5Fctf=5Fget=5Fint=5Flen(self.=5Fd)</=
font>
<br><font size=3D3>&gt; + return =5Fbt=5Fctf=5Fget=5Fint=5Flen(=5Fbt=5Fctf=
=5Fget=5Fdecl=5Ffrom=5Fdef(self.=5Fd))</font>
<br>
<br><font size=3D3>Good catch!</font>
<br>
<br><font size=3D3>&gt; &nbsp;</font>
<br><font size=3D3>&gt; &nbsp; def get=5Fencoding(self):</font>
<br><font size=3D3>&gt; &nbsp; &quot;&quot;&quot;</font>
<br><font size=3D3>&gt; --&nbsp;</font>
<br><font size=3D3>&gt; 1.7.11.7</font>
<br><font size=3D3>&gt;&nbsp;</font>
<br><font size=3D3><br>
</font>
<br><font size=3D3>On Mon, Aug 19, 2013 at 7:15 AM, Amit Margalit &lt;</fon=
t><a href=3Dmailto:AMITM@il.ibm.com target=3D=5Fblank><font size=3D3 color=
=3Dblue><u>AMITM@il.ibm.com</u></font></a><font size=3D3>&gt;
wrote:</font>
<br><font size=3D3 face=3D"sans-serif">In some systems, the system headers
use ssize=5Ft, which was not defined, causing get=5Fint=5Flen() to return a=
 pointer
to a python object instead of returning the integer.</font><font size=3D3>
</font><font size=3D3 face=3D"sans-serif"><br>
Also, the python code that called =5Fbt=5Fctf=5Fget=5Fint=5Flen() failed to=
 wrap
self.=5Fd with the call to =5Fbt=5Fctf=5Fget=5Fdecl=5Ffrom=5Fdef.</font><fo=
nt size=3D3>
<br>
</font><font size=3D3 face=3D"sans-serif"><br>
I'm attaching this patch to (hopefully) avoid line formatting issues.</font=
><font size=3D3>
</font><font size=3D3 color=3D#8f8f8f><br>
<br>
<br>
<br>
</font><font size=3D3 color=3D#000080 face=3D"sans-serif"><br>
Amit Margalit</font><font size=3D3 color=3D#8f8f8f> </font><font size=3D3 c=
olor=3D#808000 face=3D"sans-serif"><br>
IBM XIV </font><font size=3D3 color=3D#8f8f8f face=3D"sans-serif">- <i>Stor=
age
Reinvented</i></font><font size=3D3 color=3D#8f8f8f> </font><font size=3D3 =
color=3D#8f8f8f face=3D"sans-serif"><br>
XIV-NAS Development Team</font><font size=3D3 color=3D#8f8f8f> </font><font=
 size=3D3 color=3D#8f8f8f face=3D"sans-serif"><br>
Tel. 03</font><font size=3D3 color=3D#8f8f8f face=3D"Arial">-689-7774</font=
><font size=3D3 color=3D#8f8f8f>
</font><font size=3D3 color=3D#8f8f8f face=3D"Arial"><br>
Fax. 03-689-7230</font><font size=3D3><br>
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F<br>
lttng-dev mailing list</font><font size=3D3 color=3Dblue><u><br>
</u></font><a href=3D"mailto:lttng-dev@lists.lttng.org"><font size=3D3 colo=
r=3Dblue><u>lttng-dev@lists.lttng.org</u></font></a><font size=3D3 color=3D=
blue><u><br>
</u></font><a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng=
-dev" target=3D=5Fblank><font size=3D3 color=3Dblue><u>http://lists.lttng.o=
rg/cgi-bin/mailman/listinfo/lttng-dev</u></font></a><font size=3D3><br>
</font>
<br><font size=3D3><br>
</font>
<br>
<br><font size=3D3>-- <br>
J=E9r=E9mie Galarneau<br>
EfficiOS Inc.</font><font size=3D3 color=3Dblue><u><br>
</u></font><a href=3Dhttp://www.efficios.com/ target=3D=5Fblank><font size=
=3D3 color=3Dblue><u>http://www.efficios.com</u></font></a><font size=3D3>
</font>
<br>
--=_alternative 0029F092C2257BCD_=--



--===============0334248700==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0334248700==--
