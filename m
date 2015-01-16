From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Addition of the return address
	to	liblttng-ust-libc-wrapper
Date: Fri, 16 Jan 2015 20:13:42 +0000 (UTC)
Message-ID: <1127206322.43789.1421439222351.JavaMail.zimbra__46749.0657618784$1421439270$gmane$org@efficios.com>
References: <OF7097A1B1.090ABAC2-ONC1257DCC.0053FE7C-C1257DCC.00570880@LocalDomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1006597482=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YCDH5-0000ug-8x
 for lttng-dev@lists.lttng.org; Fri, 16 Jan 2015 15:13:45 -0500
In-Reply-To: <OF7097A1B1.090ABAC2-ONC1257DCC.0053FE7C-C1257DCC.00570880@LocalDomain>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Olivier Delbeke <Olivier.Delbeke@awtce.be>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1006597482==
Content-Type: multipart/alternative;
	boundary="----=_Part_43783_1152637141.1421439222348"

------=_Part_43783_1152637141.1421439222348
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- Original Message -----

> From: "Olivier Delbeke" <Olivier.Delbeke@awtce.be>
> To: lttng-dev@lists.lttng.org
> Sent: Tuesday, January 13, 2015 10:50:38 AM
> Subject: [lttng-dev] Addition of the return address to
> liblttng-ust-libc-wrapper

> Hi guys,

> I am using liblttng-ust-libc-wrapper to detect memory leaks in my
> applications.
> In order to identify not only the thread where the unfreed allocations ar=
e
> done, but also the calling function, I extended the
> liblttng-ust-libc-wrapper to log the "return address"
> (__builtin_return_address(0)) in addition to the parameters of malloc(). =
It
> solves my problem and does not affect Trace Compass.
> Was this the right thing to do ?
You should be able to achieve the same thing with the "ip" context, e.g.:=
=20

lttng create=20
lttng enable-event -u -a=20
lttng add-context -u -t ip=20
lttng start=20
....=20

All this dynamically without changing the instrumentation.=20

Thanks,=20

Mathieu=20

> If it is, then I guess that it might interest other people too.

> diff -Nurd b/liblttng-ust-libc-wrapper/lttng-ust-malloc.c
> c/liblttng-ust-libc-wrapper/lttng-ust-malloc.c
> --- b/liblttng-ust-libc-wrapper/lttng-ust-malloc.c 2015-01-06
> 17:14:34.000000000 +0100
> +++ c/liblttng-ust-libc-wrapper/lttng-ust-malloc.c 2015-01-06
> 17:16:40.811145106 +0100
> @@ -260,7 +260,7 @@
> }
> retval =3D cur_alloc.malloc(size);
> if (URCU_TLS(malloc_nesting) =3D=3D 1) {
> - tracepoint(ust_libc, malloc, size, retval);
> + tracepoint(ust_libc, malloc, size, retval, __builtin_return_address(0) =
);
> }
> URCU_TLS(malloc_nesting)--;
> return retval;
> @@ -279,7 +279,7 @@
> }

> if (URCU_TLS(malloc_nesting) =3D=3D 1) {
> - tracepoint(ust_libc, free, ptr);
> + tracepoint(ust_libc, free, ptr, __builtin_return_address(0) );
> }

> if (cur_alloc.free =3D=3D NULL) {
> @@ -308,7 +308,7 @@
> }
> retval =3D cur_alloc.calloc(nmemb, size);
> if (URCU_TLS(malloc_nesting) =3D=3D 1) {
> - tracepoint(ust_libc, calloc, nmemb, size, retval);
> + tracepoint(ust_libc, calloc, nmemb, size, retval,
> __builtin_return_address(0) );
> }
> URCU_TLS(malloc_nesting)--;
> return retval;
> @@ -360,7 +360,7 @@
> retval =3D cur_alloc.realloc(ptr, size);
> end:
> if (URCU_TLS(malloc_nesting) =3D=3D 1) {
> - tracepoint(ust_libc, realloc, ptr, size, retval);
> + tracepoint(ust_libc, realloc, ptr, size, retval,
> __builtin_return_address(0) );
> }
> URCU_TLS(malloc_nesting)--;
> return retval;
> @@ -380,7 +380,7 @@
> }
> retval =3D cur_alloc.memalign(alignment, size);
> if (URCU_TLS(malloc_nesting) =3D=3D 1) {
> - tracepoint(ust_libc, memalign, alignment, size, retval);
> + tracepoint(ust_libc, memalign, alignment, size, retval,
> __builtin_return_address(0) );
> }
> URCU_TLS(malloc_nesting)--;
> return retval;
> @@ -401,7 +401,7 @@
> retval =3D cur_alloc.posix_memalign(memptr, alignment, size);
> if (URCU_TLS(malloc_nesting) =3D=3D 1) {
> tracepoint(ust_libc, posix_memalign, *memptr, alignment, size,
> - retval);
> + retval, __builtin_return_address(0) );
> }
> URCU_TLS(malloc_nesting)--;
> return retval;
> diff -Nurd b/liblttng-ust-libc-wrapper/ust_libc.h
> c/liblttng-ust-libc-wrapper/ust_libc.h
> --- b/liblttng-ust-libc-wrapper/ust_libc.h 2015-01-06 17:14:34.000000000
> +0100
> +++ c/liblttng-ust-libc-wrapper/ust_libc.h 2015-01-06 17:16:40.811145106
> +0100
> @@ -33,54 +33,60 @@
> #include <lttng/tracepoint.h>

> TRACEPOINT_EVENT(ust_libc, malloc,
> - TP_ARGS(size_t, size, void *, ptr),
> + TP_ARGS(size_t, size, void *, ptr, void *, ra),
> TP_FIELDS(
> ctf_integer(size_t, size, size)
> ctf_integer_hex(void *, ptr, ptr)
> + ctf_integer_hex(void *, ra, ra)
> )
> )

> TRACEPOINT_EVENT(ust_libc, free,
> - TP_ARGS(void *, ptr),
> + TP_ARGS(void *, ptr, void *, ra),
> TP_FIELDS(
> ctf_integer_hex(void *, ptr, ptr)
> + ctf_integer_hex(void *, ra, ra)
> )
> )

> TRACEPOINT_EVENT(ust_libc, calloc,
> - TP_ARGS(size_t, nmemb, size_t, size, void *, ptr),
> + TP_ARGS(size_t, nmemb, size_t, size, void *, ptr, void *, ra),
> TP_FIELDS(
> ctf_integer(size_t, nmemb, nmemb)
> ctf_integer(size_t, size, size)
> ctf_integer_hex(void *, ptr, ptr)
> + ctf_integer_hex(void *, ra, ra)
> )
> )

> TRACEPOINT_EVENT(ust_libc, realloc,
> - TP_ARGS(void *, in_ptr, size_t, size, void *, ptr),
> + TP_ARGS(void *, in_ptr, size_t, size, void *, ptr, void *, ra),
> TP_FIELDS(
> ctf_integer_hex(void *, in_ptr, in_ptr)
> ctf_integer(size_t, size, size)
> ctf_integer_hex(void *, ptr, ptr)
> + ctf_integer_hex(void *, ra, ra)
> )
> )

> TRACEPOINT_EVENT(ust_libc, memalign,
> - TP_ARGS(size_t, alignment, size_t, size, void *, ptr),
> + TP_ARGS(size_t, alignment, size_t, size, void *, ptr, void *, ra),
> TP_FIELDS(
> ctf_integer(size_t, alignment, alignment)
> ctf_integer(size_t, size, size)
> ctf_integer_hex(void *, ptr, ptr)
> + ctf_integer_hex(void *, ra, ra)
> )
> )

> TRACEPOINT_EVENT(ust_libc, posix_memalign,
> - TP_ARGS(void *, out_ptr, size_t, alignment, size_t, size, int, result),
> + TP_ARGS(void *, out_ptr, size_t, alignment, size_t, size, int, result, =
void
> *, ra),
> TP_FIELDS(
> ctf_integer_hex(void *, out_ptr, out_ptr)
> ctf_integer(size_t, alignment, alignment)
> ctf_integer(size_t, size, size)
> ctf_integer(int, result, result)
> + ctf_integer_hex(void *, ra, ra)
> )
> )

> Best regards,
>=20
> Olivier Delbeke Senior Software Engineer
> Olivier.Delbeke@awtce.be / T. +32 2 389 25 53
> AWTC Europe S.A. - Avenue de l=E2=80=99Industrie, 19 - 1420 Braine-l=E2=
=80=99Alleud - Belgium
> - www.aweurope.eu - www.aisin-aw.co.jp
> VAT : BE 0474.474.114 - RPM Nivelles

> This mail, and any attachments thereto, is intended only for use by the
> addressee(s) named herein and may contain legally privileged and/or
> confidential information. If you are not the intended recipient, please n=
ote
> that any review, dissemination, disclosure, alteration, printing, copying=
 or
> transmission of this mail and/or any file transmitted with it, is strictl=
y
> prohibited and may be unlawful. If you have received this mail by mistake=
,
> please immediately notify the sender as well as our mail administrator at
> postmaster@aweurope.be, and permanently destroy the original as well as a=
ny
> copy thereof.
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_43783_1152637141.1421439222348
Content-Type: multipart/related;
	boundary="----=_Part_43784_2069932847.1421439222348"

------=_Part_43784_2069932847.1421439222348
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><hr id=3D"zwchr"><blockquote style=3D=
"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;=
font-weight:normal;font-style:normal;text-decoration:none;font-family:Helve=
tica,Arial,sans-serif;font-size:12pt;" data-mce-style=3D"border-left: 2px s=
olid #1010FF; margin-left: 5px; padding-left: 5px; color: #000; font-weight=
: normal; font-style: normal; text-decoration: none; font-family: Helvetica=
,Arial,sans-serif; font-size: 12pt;"><b>From: </b>"Olivier Delbeke" &lt;Oli=
vier.Delbeke@awtce.be&gt;<br><b>To: </b>lttng-dev@lists.lttng.org<br><b>Sen=
t: </b>Tuesday, January 13, 2015 10:50:38 AM<br><b>Subject: </b>[lttng-dev]=
 Addition of the return address to&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;liblttng-ust-libc-wrapper<br><div><br></div><p><span style=3D"font-f=
amily: sans-serif; font-size: small;" data-mce-style=3D"font-family: sans-s=
erif; font-size: small;" face=3D"sans-serif" size=3D"2">Hi guys,</span><br>=
</p><div><br></div><p><span style=3D"font-family: sans-serif; font-size: sm=
all;" data-mce-style=3D"font-family: sans-serif; font-size: small;" face=3D=
"sans-serif" size=3D"2">I am using liblttng-ust-libc-wrapper to detect memo=
ry leaks in my applications. </span><br><span style=3D"font-family: sans-se=
rif; font-size: small;" data-mce-style=3D"font-family: sans-serif; font-siz=
e: small;" face=3D"sans-serif" size=3D"2">In order to identify not only the=
 thread where the unfreed allocations are done, but also the calling functi=
on, I extended the liblttng-ust-libc-wrapper to log the "return address" (_=
_builtin_return_address(0)) in addition to the parameters of malloc(). It s=
olves my problem and does not affect Trace Compass.</span><br><span style=
=3D"font-family: sans-serif; font-size: small;" data-mce-style=3D"font-fami=
ly: sans-serif; font-size: small;" face=3D"sans-serif" size=3D"2">Was this =
the right thing to do ? </span></p></blockquote><div><br></div><div>You sho=
uld be able to achieve the same thing with the "ip" context, e.g.:<br></div=
><div><br></div><div>lttng create<br></div><div>lttng enable-event -u -a<br=
></div><div>lttng add-context -u -t ip<br></div><div>lttng start<br></div><=
div>....<br></div><div><br></div><div>All this dynamically without changing=
 the instrumentation.<br></div><div><br></div><div>Thanks,<br></div><div><b=
r></div><div>Mathieu<br></div><div><br></div><blockquote style=3D"border-le=
ft:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weigh=
t:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial=
,sans-serif;font-size:12pt;" data-mce-style=3D"border-left: 2px solid #1010=
FF; margin-left: 5px; padding-left: 5px; color: #000; font-weight: normal; =
font-style: normal; text-decoration: none; font-family: Helvetica,Arial,san=
s-serif; font-size: 12pt;"><p><span style=3D"font-family: sans-serif; font-=
size: small;" data-mce-style=3D"font-family: sans-serif; font-size: small;"=
 face=3D"sans-serif" size=3D"2">If it is, then I guess that it might intere=
st other people too.</span><br></p><div><br></div><p><span style=3D"font-fa=
mily: sans-serif; font-size: small;" data-mce-style=3D"font-family: sans-se=
rif; font-size: small;" face=3D"sans-serif" size=3D"2">diff -Nurd b/liblttn=
g-ust-libc-wrapper/lttng-ust-malloc.c c/liblttng-ust-libc-wrapper/lttng-ust=
-malloc.c</span><br><span style=3D"font-family: sans-serif; font-size: smal=
l;" data-mce-style=3D"font-family: sans-serif; font-size: small;" face=3D"s=
ans-serif" size=3D"2">--- b/liblttng-ust-libc-wrapper/lttng-ust-malloc.c 20=
15-01-06 17:14:34.000000000 +0100</span><br><span style=3D"font-family: san=
s-serif; font-size: small;" data-mce-style=3D"font-family: sans-serif; font=
-size: small;" face=3D"sans-serif" size=3D"2">+++ c/liblttng-ust-libc-wrapp=
er/lttng-ust-malloc.c 2015-01-06 17:16:40.811145106 +0100</span><br><span s=
tyle=3D"font-family: sans-serif; font-size: small;" data-mce-style=3D"font-=
family: sans-serif; font-size: small;" face=3D"sans-serif" size=3D"2">@@ -2=
60,7 +260,7 @@</span><br><span style=3D"font-family: sans-serif; font-size:=
 small;" data-mce-style=3D"font-family: sans-serif; font-size: small;" face=
=3D"sans-serif" size=3D"2">&nbsp; }</span><br><span style=3D"font-family: s=
ans-serif; font-size: small;" data-mce-style=3D"font-family: sans-serif; fo=
nt-size: small;" face=3D"sans-serif" size=3D"2">&nbsp; retval =3D cur_alloc=
.malloc(size);</span><br><span style=3D"font-family: sans-serif; font-size:=
 small;" data-mce-style=3D"font-family: sans-serif; font-size: small;" face=
=3D"sans-serif" size=3D"2">&nbsp; if (URCU_TLS(malloc_nesting) =3D=3D 1) {<=
/span><br><span style=3D"font-family: sans-serif; font-size: small;" data-m=
ce-style=3D"font-family: sans-serif; font-size: small;" face=3D"sans-serif"=
 size=3D"2">- tracepoint(ust_libc, malloc, size, retval);</span><br><span s=
tyle=3D"font-family: sans-serif; font-size: small;" data-mce-style=3D"font-=
family: sans-serif; font-size: small;" face=3D"sans-serif" size=3D"2">+ tra=
cepoint(ust_libc, malloc, size, retval, __builtin_return_address(0) );</spa=
n><br><span style=3D"font-family: sans-serif; font-size: small;" data-mce-s=
tyle=3D"font-family: sans-serif; font-size: small;" face=3D"sans-serif" siz=
e=3D"2">&nbsp; }</span><br><span style=3D"font-family: sans-serif; font-siz=
e: small;" data-mce-style=3D"font-family: sans-serif; font-size: small;" fa=
ce=3D"sans-serif" size=3D"2">&nbsp; URCU_TLS(malloc_nesting)--;</span><br><=
span style=3D"font-family: sans-serif; font-size: small;" data-mce-style=3D=
"font-family: sans-serif; font-size: small;" face=3D"sans-serif" size=3D"2"=
>&nbsp; return retval;</span><br><span style=3D"font-family: sans-serif; fo=
nt-size: small;" data-mce-style=3D"font-family: sans-serif; font-size: smal=
l;" face=3D"sans-serif" size=3D"2">@@ -279,7 +279,7 @@</span><br><span styl=
e=3D"font-family: sans-serif; font-size: small;" data-mce-style=3D"font-fam=
ily: sans-serif; font-size: small;" face=3D"sans-serif" size=3D"2">&nbsp; }=
</span><br><span style=3D"font-family: sans-serif; font-size: small;" data-=
mce-style=3D"font-family: sans-serif; font-size: small;" face=3D"sans-serif=
" size=3D"2">&nbsp;</span><br><span style=3D"font-family: sans-serif; font-=
size: small;" data-mce-style=3D"font-family: sans-serif; font-size: small;"=
 face=3D"sans-serif" size=3D"2">&nbsp; if (URCU_TLS(malloc_nesting) =3D=3D =
1) {</span><br><span style=3D"font-family: sans-serif; font-size: small;" d=
ata-mce-style=3D"font-family: sans-serif; font-size: small;" face=3D"sans-s=
erif" size=3D"2">- tracepoint(ust_libc, free, ptr);</span><br><span style=
=3D"font-family: sans-serif; font-size: small;" data-mce-style=3D"font-fami=
ly: sans-serif; font-size: small;" face=3D"sans-serif" size=3D"2">+ tracepo=
int(ust_libc, free, ptr, __builtin_return_address(0) );</span><br><span sty=
le=3D"font-family: sans-serif; font-size: small;" data-mce-style=3D"font-fa=
mily: sans-serif; font-size: small;" face=3D"sans-serif" size=3D"2">&nbsp; =
}</span><br><span style=3D"font-family: sans-serif; font-size: small;" data=
-mce-style=3D"font-family: sans-serif; font-size: small;" face=3D"sans-seri=
f" size=3D"2">&nbsp;</span><br><span style=3D"font-family: sans-serif; font=
-size: small;" data-mce-style=3D"font-family: sans-serif; font-size: small;=
" face=3D"sans-serif" size=3D"2">&nbsp; if (cur_alloc.free =3D=3D NULL) {</=
span><br><span style=3D"font-family: sans-serif; font-size: small;" data-mc=
e-style=3D"font-family: sans-serif; font-size: small;" face=3D"sans-serif" =
size=3D"2">@@ -308,7 +308,7 @@</span><br><span style=3D"font-family: sans-s=
erif; font-size: small;" data-mce-style=3D"font-family: sans-serif; font-si=
ze: small;" face=3D"sans-serif" size=3D"2">&nbsp; }</span><br><span style=
=3D"font-family: sans-serif; font-size: small;" data-mce-style=3D"font-fami=
ly: sans-serif; font-size: small;" face=3D"sans-serif" size=3D"2">&nbsp; re=
tval =3D cur_alloc.calloc(nmemb, size);</span><br><span style=3D"font-famil=
y: sans-serif; font-size: small;" data-mce-style=3D"font-family: sans-serif=
; font-size: small;" face=3D"sans-serif" size=3D"2">&nbsp; if (URCU_TLS(mal=
loc_nesting) =3D=3D 1) {</span><br><span style=3D"font-family: sans-serif; =
font-size: small;" data-mce-style=3D"font-family: sans-serif; font-size: sm=
all;" face=3D"sans-serif" size=3D"2">- tracepoint(ust_libc, calloc, nmemb, =
size, retval);</span><br><span style=3D"font-family: sans-serif; font-size:=
 small;" data-mce-style=3D"font-family: sans-serif; font-size: small;" face=
=3D"sans-serif" size=3D"2">+ tracepoint(ust_libc, calloc, nmemb, size, retv=
al, __builtin_return_address(0) );</span><br><span style=3D"font-family: sa=
ns-serif; font-size: small;" data-mce-style=3D"font-family: sans-serif; fon=
t-size: small;" face=3D"sans-serif" size=3D"2">&nbsp; }</span><br><span sty=
le=3D"font-family: sans-serif; font-size: small;" data-mce-style=3D"font-fa=
mily: sans-serif; font-size: small;" face=3D"sans-serif" size=3D"2">&nbsp; =
URCU_TLS(malloc_nesting)--;</span><br><span style=3D"font-family: sans-seri=
f; font-size: small;" data-mce-style=3D"font-family: sans-serif; font-size:=
 small;" face=3D"sans-serif" size=3D"2">&nbsp; return retval;</span><br><sp=
an style=3D"font-family: sans-serif; font-size: small;" data-mce-style=3D"f=
ont-family: sans-serif; font-size: small;" face=3D"sans-serif" size=3D"2">@=
@ -360,7 +360,7 @@</span><br><span style=3D"font-family: sans-serif; font-s=
ize: small;" data-mce-style=3D"font-family: sans-serif; font-size: small;" =
face=3D"sans-serif" size=3D"2">&nbsp; retval =3D cur_alloc.realloc(ptr, siz=
e);</span><br><span style=3D"font-family: sans-serif; font-size: small;" da=
ta-mce-style=3D"font-family: sans-serif; font-size: small;" face=3D"sans-se=
rif" size=3D"2">&nbsp;end:</span><br><span style=3D"font-family: sans-serif=
; font-size: small;" data-mce-style=3D"font-family: sans-serif; font-size: =
small;" face=3D"sans-serif" size=3D"2">&nbsp; if (URCU_TLS(malloc_nesting) =
=3D=3D 1) {</span><br><span style=3D"font-family: sans-serif; font-size: sm=
all;" data-mce-style=3D"font-family: sans-serif; font-size: small;" face=3D=
"sans-serif" size=3D"2">- tracepoint(ust_libc, realloc, ptr, size, retval);=
</span><br><span style=3D"font-family: sans-serif; font-size: small;" data-=
mce-style=3D"font-family: sans-serif; font-size: small;" face=3D"sans-serif=
" size=3D"2">+ tracepoint(ust_libc, realloc, ptr, size, retval, __builtin_r=
eturn_address(0) );</span><br><span style=3D"font-family: sans-serif; font-=
size: small;" data-mce-style=3D"font-family: sans-serif; font-size: small;"=
 face=3D"sans-serif" size=3D"2">&nbsp; }</span><br><span style=3D"font-fami=
ly: sans-serif; font-size: small;" data-mce-style=3D"font-family: sans-seri=
f; font-size: small;" face=3D"sans-serif" size=3D"2">&nbsp; URCU_TLS(malloc=
_nesting)--;</span><br><span style=3D"font-family: sans-serif; font-size: s=
mall;" data-mce-style=3D"font-family: sans-serif; font-size: small;" face=
=3D"sans-serif" size=3D"2">&nbsp; return retval;</span><br><span style=3D"f=
ont-family: sans-serif; font-size: small;" data-mce-style=3D"font-family: s=
ans-serif; font-size: small;" face=3D"sans-serif" size=3D"2">@@ -380,7 +380=
,7 @@</span><br><span style=3D"font-family: sans-serif; font-size: small;" =
data-mce-style=3D"font-family: sans-serif; font-size: small;" face=3D"sans-=
serif" size=3D"2">&nbsp; }</span><br><span style=3D"font-family: sans-serif=
; font-size: small;" data-mce-style=3D"font-family: sans-serif; font-size: =
small;" face=3D"sans-serif" size=3D"2">&nbsp; retval =3D cur_alloc.memalign=
(alignment, size);</span><br><span style=3D"font-family: sans-serif; font-s=
ize: small;" data-mce-style=3D"font-family: sans-serif; font-size: small;" =
face=3D"sans-serif" size=3D"2">&nbsp; if (URCU_TLS(malloc_nesting) =3D=3D 1=
) {</span><br><span style=3D"font-family: sans-serif; font-size: small;" da=
ta-mce-style=3D"font-family: sans-serif; font-size: small;" face=3D"sans-se=
rif" size=3D"2">- tracepoint(ust_libc, memalign, alignment, size, retval);<=
/span><br><span style=3D"font-family: sans-serif; font-size: small;" data-m=
ce-style=3D"font-family: sans-serif; font-size: small;" face=3D"sans-serif"=
 size=3D"2">+ tracepoint(ust_libc, memalign, alignment, size, retval, __bui=
ltin_return_address(0) );</span><br><span style=3D"font-family: sans-serif;=
 font-size: small;" data-mce-style=3D"font-family: sans-serif; font-size: s=
mall;" face=3D"sans-serif" size=3D"2">&nbsp; }</span><br><span style=3D"fon=
t-family: sans-serif; font-size: small;" data-mce-style=3D"font-family: san=
s-serif; font-size: small;" face=3D"sans-serif" size=3D"2">&nbsp; URCU_TLS(=
malloc_nesting)--;</span><br><span style=3D"font-family: sans-serif; font-s=
ize: small;" data-mce-style=3D"font-family: sans-serif; font-size: small;" =
face=3D"sans-serif" size=3D"2">&nbsp; return retval;</span><br><span style=
=3D"font-family: sans-serif; font-size: small;" data-mce-style=3D"font-fami=
ly: sans-serif; font-size: small;" face=3D"sans-serif" size=3D"2">@@ -401,7=
 +401,7 @@</span><br><span style=3D"font-family: sans-serif; font-size: sma=
ll;" data-mce-style=3D"font-family: sans-serif; font-size: small;" face=3D"=
sans-serif" size=3D"2">&nbsp; retval =3D cur_alloc.posix_memalign(memptr, a=
lignment, size);</span><br><span style=3D"font-family: sans-serif; font-siz=
e: small;" data-mce-style=3D"font-family: sans-serif; font-size: small;" fa=
ce=3D"sans-serif" size=3D"2">&nbsp; if (URCU_TLS(malloc_nesting) =3D=3D 1) =
{</span><br><span style=3D"font-family: sans-serif; font-size: small;" data=
-mce-style=3D"font-family: sans-serif; font-size: small;" face=3D"sans-seri=
f" size=3D"2">&nbsp; tracepoint(ust_libc, posix_memalign, *memptr, alignmen=
t, size,</span><br><span style=3D"font-family: sans-serif; font-size: small=
;" data-mce-style=3D"font-family: sans-serif; font-size: small;" face=3D"sa=
ns-serif" size=3D"2">- retval);</span><br><span style=3D"font-family: sans-=
serif; font-size: small;" data-mce-style=3D"font-family: sans-serif; font-s=
ize: small;" face=3D"sans-serif" size=3D"2">+ retval, __builtin_return_addr=
ess(0) );</span><br><span style=3D"font-family: sans-serif; font-size: smal=
l;" data-mce-style=3D"font-family: sans-serif; font-size: small;" face=3D"s=
ans-serif" size=3D"2">&nbsp; }</span><br><span style=3D"font-family: sans-s=
erif; font-size: small;" data-mce-style=3D"font-family: sans-serif; font-si=
ze: small;" face=3D"sans-serif" size=3D"2">&nbsp; URCU_TLS(malloc_nesting)-=
-;</span><br><span style=3D"font-family: sans-serif; font-size: small;" dat=
a-mce-style=3D"font-family: sans-serif; font-size: small;" face=3D"sans-ser=
if" size=3D"2">&nbsp; return retval;</span><br><span style=3D"font-family: =
sans-serif; font-size: small;" data-mce-style=3D"font-family: sans-serif; f=
ont-size: small;" face=3D"sans-serif" size=3D"2">diff -Nurd b/liblttng-ust-=
libc-wrapper/ust_libc.h c/liblttng-ust-libc-wrapper/ust_libc.h</span><br><s=
pan style=3D"font-family: sans-serif; font-size: small;" data-mce-style=3D"=
font-family: sans-serif; font-size: small;" face=3D"sans-serif" size=3D"2">=
--- b/liblttng-ust-libc-wrapper/ust_libc.h 2015-01-06 17:14:34.000000000 +0=
100</span><br><span style=3D"font-family: sans-serif; font-size: small;" da=
ta-mce-style=3D"font-family: sans-serif; font-size: small;" face=3D"sans-se=
rif" size=3D"2">+++ c/liblttng-ust-libc-wrapper/ust_libc.h 2015-01-06 17:16=
:40.811145106 +0100</span><br><span style=3D"font-family: sans-serif; font-=
size: small;" data-mce-style=3D"font-family: sans-serif; font-size: small;"=
 face=3D"sans-serif" size=3D"2">@@ -33,54 +33,60 @@</span><br><span style=
=3D"font-family: sans-serif; font-size: small;" data-mce-style=3D"font-fami=
ly: sans-serif; font-size: small;" face=3D"sans-serif" size=3D"2">&nbsp;#in=
clude &lt;lttng/tracepoint.h&gt;</span><br><span style=3D"font-family: sans=
-serif; font-size: small;" data-mce-style=3D"font-family: sans-serif; font-=
size: small;" face=3D"sans-serif" size=3D"2">&nbsp;</span><br><span style=
=3D"font-family: sans-serif; font-size: small;" data-mce-style=3D"font-fami=
ly: sans-serif; font-size: small;" face=3D"sans-serif" size=3D"2">&nbsp;TRA=
CEPOINT_EVENT(ust_libc, malloc,</span><br><span style=3D"font-family: sans-=
serif; font-size: small;" data-mce-style=3D"font-family: sans-serif; font-s=
ize: small;" face=3D"sans-serif" size=3D"2">- TP_ARGS(size_t, size, void *,=
 ptr),</span><br><span style=3D"font-family: sans-serif; font-size: small;"=
 data-mce-style=3D"font-family: sans-serif; font-size: small;" face=3D"sans=
-serif" size=3D"2">+ TP_ARGS(size_t, size, void *, ptr, void *, ra),</span>=
<br><span style=3D"font-family: sans-serif; font-size: small;" data-mce-sty=
le=3D"font-family: sans-serif; font-size: small;" face=3D"sans-serif" size=
=3D"2">&nbsp; TP_FIELDS(</span><br><span style=3D"font-family: sans-serif; =
font-size: small;" data-mce-style=3D"font-family: sans-serif; font-size: sm=
all;" face=3D"sans-serif" size=3D"2">&nbsp; ctf_integer(size_t, size, size)=
</span><br><span style=3D"font-family: sans-serif; font-size: small;" data-=
mce-style=3D"font-family: sans-serif; font-size: small;" face=3D"sans-serif=
" size=3D"2">&nbsp; ctf_integer_hex(void *, ptr, ptr)</span><br><span style=
=3D"font-family: sans-serif; font-size: small;" data-mce-style=3D"font-fami=
ly: sans-serif; font-size: small;" face=3D"sans-serif" size=3D"2">+ ctf_int=
eger_hex(void *, ra, ra)</span><br><span style=3D"font-family: sans-serif; =
font-size: small;" data-mce-style=3D"font-family: sans-serif; font-size: sm=
all;" face=3D"sans-serif" size=3D"2">&nbsp; )</span><br><span style=3D"font=
-family: sans-serif; font-size: small;" data-mce-style=3D"font-family: sans=
-serif; font-size: small;" face=3D"sans-serif" size=3D"2">&nbsp;)</span><br=
><span style=3D"font-family: sans-serif; font-size: small;" data-mce-style=
=3D"font-family: sans-serif; font-size: small;" face=3D"sans-serif" size=3D=
"2">&nbsp;</span><br><span style=3D"font-family: sans-serif; font-size: sma=
ll;" data-mce-style=3D"font-family: sans-serif; font-size: small;" face=3D"=
sans-serif" size=3D"2">&nbsp;TRACEPOINT_EVENT(ust_libc, free,</span><br><sp=
an style=3D"font-family: sans-serif; font-size: small;" data-mce-style=3D"f=
ont-family: sans-serif; font-size: small;" face=3D"sans-serif" size=3D"2">-=
 TP_ARGS(void *, ptr),</span><br><span style=3D"font-family: sans-serif; fo=
nt-size: small;" data-mce-style=3D"font-family: sans-serif; font-size: smal=
l;" face=3D"sans-serif" size=3D"2">+ TP_ARGS(void *, ptr, void *, ra),</spa=
n><br><span style=3D"font-family: sans-serif; font-size: small;" data-mce-s=
tyle=3D"font-family: sans-serif; font-size: small;" face=3D"sans-serif" siz=
e=3D"2">&nbsp; TP_FIELDS(</span><br><span style=3D"font-family: sans-serif;=
 font-size: small;" data-mce-style=3D"font-family: sans-serif; font-size: s=
mall;" face=3D"sans-serif" size=3D"2">&nbsp; ctf_integer_hex(void *, ptr, p=
tr)</span><br><span style=3D"font-family: sans-serif; font-size: small;" da=
ta-mce-style=3D"font-family: sans-serif; font-size: small;" face=3D"sans-se=
rif" size=3D"2">+ ctf_integer_hex(void *, ra, ra)</span><br><span style=3D"=
font-family: sans-serif; font-size: small;" data-mce-style=3D"font-family: =
sans-serif; font-size: small;" face=3D"sans-serif" size=3D"2">&nbsp; )</spa=
n><br><span style=3D"font-family: sans-serif; font-size: small;" data-mce-s=
tyle=3D"font-family: sans-serif; font-size: small;" face=3D"sans-serif" siz=
e=3D"2">&nbsp;)</span><br><span style=3D"font-family: sans-serif; font-size=
: small;" data-mce-style=3D"font-family: sans-serif; font-size: small;" fac=
e=3D"sans-serif" size=3D"2">&nbsp;</span><br><span style=3D"font-family: sa=
ns-serif; font-size: small;" data-mce-style=3D"font-family: sans-serif; fon=
t-size: small;" face=3D"sans-serif" size=3D"2">&nbsp;TRACEPOINT_EVENT(ust_l=
ibc, calloc,</span><br><span style=3D"font-family: sans-serif; font-size: s=
mall;" data-mce-style=3D"font-family: sans-serif; font-size: small;" face=
=3D"sans-serif" size=3D"2">- TP_ARGS(size_t, nmemb, size_t, size, void *, p=
tr),</span><br><span style=3D"font-family: sans-serif; font-size: small;" d=
ata-mce-style=3D"font-family: sans-serif; font-size: small;" face=3D"sans-s=
erif" size=3D"2">+ TP_ARGS(size_t, nmemb, size_t, size, void *, ptr, void *=
, ra),</span><br><span style=3D"font-family: sans-serif; font-size: small;"=
 data-mce-style=3D"font-family: sans-serif; font-size: small;" face=3D"sans=
-serif" size=3D"2">&nbsp; TP_FIELDS(</span><br><span style=3D"font-family: =
sans-serif; font-size: small;" data-mce-style=3D"font-family: sans-serif; f=
ont-size: small;" face=3D"sans-serif" size=3D"2">&nbsp; ctf_integer(size_t,=
 nmemb, nmemb)</span><br><span style=3D"font-family: sans-serif; font-size:=
 small;" data-mce-style=3D"font-family: sans-serif; font-size: small;" face=
=3D"sans-serif" size=3D"2">&nbsp; ctf_integer(size_t, size, size)</span><br=
><span style=3D"font-family: sans-serif; font-size: small;" data-mce-style=
=3D"font-family: sans-serif; font-size: small;" face=3D"sans-serif" size=3D=
"2">&nbsp; ctf_integer_hex(void *, ptr, ptr)</span><br><span style=3D"font-=
family: sans-serif; font-size: small;" data-mce-style=3D"font-family: sans-=
serif; font-size: small;" face=3D"sans-serif" size=3D"2">+ ctf_integer_hex(=
void *, ra, ra)</span><br><span style=3D"font-family: sans-serif; font-size=
: small;" data-mce-style=3D"font-family: sans-serif; font-size: small;" fac=
e=3D"sans-serif" size=3D"2">&nbsp; )</span><br><span style=3D"font-family: =
sans-serif; font-size: small;" data-mce-style=3D"font-family: sans-serif; f=
ont-size: small;" face=3D"sans-serif" size=3D"2">&nbsp;)</span><br><span st=
yle=3D"font-family: sans-serif; font-size: small;" data-mce-style=3D"font-f=
amily: sans-serif; font-size: small;" face=3D"sans-serif" size=3D"2">&nbsp;=
</span><br><span style=3D"font-family: sans-serif; font-size: small;" data-=
mce-style=3D"font-family: sans-serif; font-size: small;" face=3D"sans-serif=
" size=3D"2">&nbsp;TRACEPOINT_EVENT(ust_libc, realloc,</span><br><span styl=
e=3D"font-family: sans-serif; font-size: small;" data-mce-style=3D"font-fam=
ily: sans-serif; font-size: small;" face=3D"sans-serif" size=3D"2">- TP_ARG=
S(void *, in_ptr, size_t, size, void *, ptr),</span><br><span style=3D"font=
-family: sans-serif; font-size: small;" data-mce-style=3D"font-family: sans=
-serif; font-size: small;" face=3D"sans-serif" size=3D"2">+ TP_ARGS(void *,=
 in_ptr, size_t, size, void *, ptr, void *, ra),</span><br><span style=3D"f=
ont-family: sans-serif; font-size: small;" data-mce-style=3D"font-family: s=
ans-serif; font-size: small;" face=3D"sans-serif" size=3D"2">&nbsp; TP_FIEL=
DS(</span><br><span style=3D"font-family: sans-serif; font-size: small;" da=
ta-mce-style=3D"font-family: sans-serif; font-size: small;" face=3D"sans-se=
rif" size=3D"2">&nbsp; ctf_integer_hex(void *, in_ptr, in_ptr)</span><br><s=
pan style=3D"font-family: sans-serif; font-size: small;" data-mce-style=3D"=
font-family: sans-serif; font-size: small;" face=3D"sans-serif" size=3D"2">=
&nbsp; ctf_integer(size_t, size, size)</span><br><span style=3D"font-family=
: sans-serif; font-size: small;" data-mce-style=3D"font-family: sans-serif;=
 font-size: small;" face=3D"sans-serif" size=3D"2">&nbsp; ctf_integer_hex(v=
oid *, ptr, ptr)</span><br><span style=3D"font-family: sans-serif; font-siz=
e: small;" data-mce-style=3D"font-family: sans-serif; font-size: small;" fa=
ce=3D"sans-serif" size=3D"2">+ ctf_integer_hex(void *, ra, ra)</span><br><s=
pan style=3D"font-family: sans-serif; font-size: small;" data-mce-style=3D"=
font-family: sans-serif; font-size: small;" face=3D"sans-serif" size=3D"2">=
&nbsp; )</span><br><span style=3D"font-family: sans-serif; font-size: small=
;" data-mce-style=3D"font-family: sans-serif; font-size: small;" face=3D"sa=
ns-serif" size=3D"2">&nbsp;)</span><br><span style=3D"font-family: sans-ser=
if; font-size: small;" data-mce-style=3D"font-family: sans-serif; font-size=
: small;" face=3D"sans-serif" size=3D"2">&nbsp;</span><br><span style=3D"fo=
nt-family: sans-serif; font-size: small;" data-mce-style=3D"font-family: sa=
ns-serif; font-size: small;" face=3D"sans-serif" size=3D"2">&nbsp;TRACEPOIN=
T_EVENT(ust_libc, memalign,</span><br><span style=3D"font-family: sans-seri=
f; font-size: small;" data-mce-style=3D"font-family: sans-serif; font-size:=
 small;" face=3D"sans-serif" size=3D"2">- TP_ARGS(size_t, alignment, size_t=
, size, void *, ptr),</span><br><span style=3D"font-family: sans-serif; fon=
t-size: small;" data-mce-style=3D"font-family: sans-serif; font-size: small=
;" face=3D"sans-serif" size=3D"2">+ TP_ARGS(size_t, alignment, size_t, size=
, void *, ptr, void *, ra),</span><br><span style=3D"font-family: sans-seri=
f; font-size: small;" data-mce-style=3D"font-family: sans-serif; font-size:=
 small;" face=3D"sans-serif" size=3D"2">&nbsp; TP_FIELDS(</span><br><span s=
tyle=3D"font-family: sans-serif; font-size: small;" data-mce-style=3D"font-=
family: sans-serif; font-size: small;" face=3D"sans-serif" size=3D"2">&nbsp=
; ctf_integer(size_t, alignment, alignment)</span><br><span style=3D"font-f=
amily: sans-serif; font-size: small;" data-mce-style=3D"font-family: sans-s=
erif; font-size: small;" face=3D"sans-serif" size=3D"2">&nbsp; ctf_integer(=
size_t, size, size)</span><br><span style=3D"font-family: sans-serif; font-=
size: small;" data-mce-style=3D"font-family: sans-serif; font-size: small;"=
 face=3D"sans-serif" size=3D"2">&nbsp; ctf_integer_hex(void *, ptr, ptr)</s=
pan><br><span style=3D"font-family: sans-serif; font-size: small;" data-mce=
-style=3D"font-family: sans-serif; font-size: small;" face=3D"sans-serif" s=
ize=3D"2">+ ctf_integer_hex(void *, ra, ra)</span><br><span style=3D"font-f=
amily: sans-serif; font-size: small;" data-mce-style=3D"font-family: sans-s=
erif; font-size: small;" face=3D"sans-serif" size=3D"2">&nbsp; )</span><br>=
<span style=3D"font-family: sans-serif; font-size: small;" data-mce-style=
=3D"font-family: sans-serif; font-size: small;" face=3D"sans-serif" size=3D=
"2">&nbsp;)</span><br><span style=3D"font-family: sans-serif; font-size: sm=
all;" data-mce-style=3D"font-family: sans-serif; font-size: small;" face=3D=
"sans-serif" size=3D"2">&nbsp;</span><br><span style=3D"font-family: sans-s=
erif; font-size: small;" data-mce-style=3D"font-family: sans-serif; font-si=
ze: small;" face=3D"sans-serif" size=3D"2">&nbsp;TRACEPOINT_EVENT(ust_libc,=
 posix_memalign,</span><br><span style=3D"font-family: sans-serif; font-siz=
e: small;" data-mce-style=3D"font-family: sans-serif; font-size: small;" fa=
ce=3D"sans-serif" size=3D"2">- TP_ARGS(void *, out_ptr, size_t, alignment, =
size_t, size, int, result),</span><br><span style=3D"font-family: sans-seri=
f; font-size: small;" data-mce-style=3D"font-family: sans-serif; font-size:=
 small;" face=3D"sans-serif" size=3D"2">+ TP_ARGS(void *, out_ptr, size_t, =
alignment, size_t, size, int, result, void *, ra),</span><br><span style=3D=
"font-family: sans-serif; font-size: small;" data-mce-style=3D"font-family:=
 sans-serif; font-size: small;" face=3D"sans-serif" size=3D"2">&nbsp; TP_FI=
ELDS(</span><br><span style=3D"font-family: sans-serif; font-size: small;" =
data-mce-style=3D"font-family: sans-serif; font-size: small;" face=3D"sans-=
serif" size=3D"2">&nbsp; ctf_integer_hex(void *, out_ptr, out_ptr)</span><b=
r><span style=3D"font-family: sans-serif; font-size: small;" data-mce-style=
=3D"font-family: sans-serif; font-size: small;" face=3D"sans-serif" size=3D=
"2">&nbsp; ctf_integer(size_t, alignment, alignment)</span><br><span style=
=3D"font-family: sans-serif; font-size: small;" data-mce-style=3D"font-fami=
ly: sans-serif; font-size: small;" face=3D"sans-serif" size=3D"2">&nbsp; ct=
f_integer(size_t, size, size)</span><br><span style=3D"font-family: sans-se=
rif; font-size: small;" data-mce-style=3D"font-family: sans-serif; font-siz=
e: small;" face=3D"sans-serif" size=3D"2">&nbsp; ctf_integer(int, result, r=
esult)</span><br><span style=3D"font-family: sans-serif; font-size: small;"=
 data-mce-style=3D"font-family: sans-serif; font-size: small;" face=3D"sans=
-serif" size=3D"2">+ ctf_integer_hex(void *, ra, ra)</span><br><span style=
=3D"font-family: sans-serif; font-size: small;" data-mce-style=3D"font-fami=
ly: sans-serif; font-size: small;" face=3D"sans-serif" size=3D"2">&nbsp; )<=
/span><br><span style=3D"font-family: sans-serif; font-size: small;" data-m=
ce-style=3D"font-family: sans-serif; font-size: small;" face=3D"sans-serif"=
 size=3D"2">&nbsp;)</span><br><span style=3D"font-family: sans-serif; font-=
size: small;" data-mce-style=3D"font-family: sans-serif; font-size: small;"=
 face=3D"sans-serif" size=3D"2">&nbsp;</span><br><span style=3D"font-family=
: sans-serif; font-size: small;" data-mce-style=3D"font-family: sans-serif;=
 font-size: small;" face=3D"sans-serif" size=3D"2">Best regards,</span></p>=
<table class=3D"mceItemTable" border=3D"0" cellpadding=3D"0" cellspacing=3D=
"0"><tbody><tr valign=3D"top"><td rowspan=3D"2" valign=3D"middle" width=3D"=
108"><div align=3D"center"><img src=3D"cid:1__=3D4EBBF75FDFC078EC8f9e8a93df=
93@aweurope.be" data-mce-src=3D"cid:1__=3D4EBBF75FDFC078EC8f9e8a93df93@aweu=
rope.be" height=3D"98" width=3D"107" align=3D"bottom"></div></td><td width=
=3D"788"><img src=3D"cid:2__=3D4EBBF75FDFC078EC8f9e8a93df93@aweurope.be" al=
t=3D"" data-mce-src=3D"cid:2__=3D4EBBF75FDFC078EC8f9e8a93df93@aweurope.be" =
height=3D"1" width=3D"1" border=3D"0"></td></tr><tr valign=3D"top"><td vali=
gn=3D"middle" width=3D"788"><span style=3D"color: #000080; font-family: Cal=
ibri; font-size: medium;" data-mce-style=3D"color: #000080; font-family: Ca=
libri; font-size: medium;" face=3D"Calibri" color=3D"#000080" size=3D"3"><b=
>Olivier Delbeke </b></span><span style=3D"color: #000080; font-family: Cal=
ibri; font-size: medium;" data-mce-style=3D"color: #000080; font-family: Ca=
libri; font-size: medium;" face=3D"Calibri" color=3D"#000080" size=3D"3"><i=
>Senior Software Engineer</i></span><span style=3D"color: #565051; font-fam=
ily: Calibri; font-size: medium;" data-mce-style=3D"color: #565051; font-fa=
mily: Calibri; font-size: medium;" face=3D"Calibri" color=3D"#565051" size=
=3D"3"><br>Olivier.Delbeke@awtce.be / T. +32 2 389 25 53</span><hr style=3D=
"color:#333399; " data-mce-style=3D"color: #333399;" size=3D"2" noshade=3D"=
noshade" width=3D"100%" align=3D"left"><span style=3D"font-family: serif; f=
ont-size: medium;" data-mce-style=3D"font-family: serif; font-size: medium;=
" face=3D"serif" size=3D"3">&nbsp;</span><span style=3D"color: #000080; fon=
t-family: Calibri; font-size: xx-small;" data-mce-style=3D"color: #000080; =
font-family: Calibri; font-size: xx-small;" face=3D"Calibri" color=3D"#0000=
80" size=3D"1"><b>AWTC Europe S.A. </b></span><span style=3D"color: #565051=
; font-family: Calibri; font-size: xx-small;" data-mce-style=3D"color: #565=
051; font-family: Calibri; font-size: xx-small;" face=3D"Calibri" color=3D"=
#565051" size=3D"1">- Avenue de l=E2=80=99Industrie, 19 - 1420 Braine-l=E2=
=80=99Alleud - Belgium - www.aweurope.eu - www.aisin-aw.co.jp<br>VAT : BE 0=
474.474.114 - RPM Nivelles</span><span style=3D"font-family: serif; font-si=
ze: medium;" data-mce-style=3D"font-family: serif; font-size: medium;" face=
=3D"serif" size=3D"3">&nbsp;</span></td></tr></tbody></table><p><br><span s=
tyle=3D"font-family: sans-serif;" data-mce-style=3D"font-family: sans-serif=
;" face=3D"sans-serif"> This mail, and any attachments thereto, is intended=
 only for use by the addressee(s) named herein and may contain legally priv=
ileged and/or confidential information. If you are not the intended recipie=
nt, please note that any review, dissemination, disclosure, alteration, pri=
nting, copying or transmission of this mail and/or any file transmitted wit=
h it, is strictly prohibited and may be unlawful. If you have received this=
 mail by mistake, please immediately notify the sender as well as our mail =
administrator at postmaster@aweurope.be, and permanently destroy the origin=
al as well as any copy thereof. </span></p><br>____________________________=
___________________<br>lttng-dev mailing list<br>lttng-dev@lists.lttng.org<=
br>http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br></blockquot=
e><div><br><br></div><div><br></div><div>-- <br></div><div><span name=3D"x"=
></span>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com<span =
name=3D"x"></span><br></div></div></body></html>
------=_Part_43784_2069932847.1421439222348
Content-Type: image/jpeg; name=1E482660.jpg
Content-Disposition: attachment; filename=1E482660.jpg
Content-Transfer-Encoding: base64
Content-ID: <1__=4EBBF75FDFC078EC8f9e8a93df93@aweurope.be>

/9j/4AAQSkZJRgABAQEAMgAyAAD/2wBDAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB
AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQH/2wBDAQEBAQEBAQEBAQEBAQEBAQEBAQEB
AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQH/wAARCABiAGsDASIA
AhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQA
AAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3
ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWm
p6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEA
AwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSEx
BhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElK
U1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3
uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD+/iii
kJA6/wA8f5/znA5oAXI9aMj1ryr4q/GT4a/Bbw5L4s+J3jXQvBehI5iju9Yu1jlvrgEZs9M0+KO4
1LVr3H3bPTbK7uCTuaNEPmD84fEn/BY79nDSr2S08PeD/i14thhnMbapb6J4f0GxuIl63FlBrviG
31R1ZuES70+y3jEm5QVNAH655HrRX51/CP8A4Kd/srfFnV7Xw+fFmrfDbXb6eK3stP8AifpFv4ft
L6eUkrBa+JdOv9X8NpM4B8uO+1SykkAbahYYr9DIbmKaKOWKWOaOVVeOWNw6SJIokjdHXKMjoyvG
6sUdGV0YoykgFikyPUfnQDkZrzD4tfFPwv8ABjwD4j+Jfje61Cz8JeFLW3vNau9N0y41i8t4Li8t
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
------=_Part_43784_2069932847.1421439222348
Content-Type: image/gif; name=ecblank.gif
Content-Disposition: attachment; filename=ecblank.gif
Content-Transfer-Encoding: base64
Content-ID: <2__=4EBBF75FDFC078EC8f9e8a93df93@aweurope.be>

R0lGODlhEAABAIAAAAAAAP///yH5BAEAAAEALAAAAAAQAAEAAAIEjI8ZBQA7
------=_Part_43784_2069932847.1421439222348--

------=_Part_43783_1152637141.1421439222348--


--===============1006597482==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1006597482==--
