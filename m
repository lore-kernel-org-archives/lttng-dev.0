From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Addition of the return address
 toliblttng-ust-libc-wrapper
Date: Mon, 19 Jan 2015 19:15:37 +0000 (UTC)
Message-ID: <1680663293.9819.1421694937650.JavaMail.zimbra__949.047730728303$1421694985$gmane$org@efficios.com>
References: <OF7097A1B1.090ABAC2-ONC1257DCC.0053FE7C-C1257DCC.00570880@LocalDomain>
 <54250547.44000.1421440866572.JavaMail.zimbra@efficios.com>
 <OF208CF361.F3A478C1-ONC1257DD2.00266C5D-C1257DD2.0026BC70@LocalDomain>
 <1097959140.8621.1421686124960.JavaMail.zimbra@efficios.com>
 <CAO6pHzgetc1HSYvmOzh5u7oMt5LANv1Ttb=qxTdqchspXaGhdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0282272549=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YDHnW-0005AF-8s
 for lttng-dev@lists.lttng.org; Mon, 19 Jan 2015 14:15:41 -0500
In-Reply-To: <CAO6pHzgetc1HSYvmOzh5u7oMt5LANv1Ttb=qxTdqchspXaGhdg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Olivier Delbeke <olivier.delbeke@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0282272549==
Content-Type: multipart/alternative;
	boundary="----=_Part_9811_796484817.1421694937645"

------=_Part_9811_796484817.1421694937645
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- Original Message -----

> From: "Olivier Delbeke" <olivier.delbeke@gmail.com>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: "lttng-dev" <lttng-dev@lists.lttng.org>
> Sent: Monday, January 19, 2015 12:19:41 PM
> Subject: Re: [lttng-dev] Addition of the return address
> toliblttng-ust-libc-wrapper

> Hi Mathieu,

> Yes, feel free to add my Signed-off-by tag to the patch header. I would j=
ust
> ask you to use my gmail address.

OK, now merged into master, thanks!=20

Mathieu=20

> Have a nice evening,

> Best regards,
> Olivier

> On Mon, Jan 19, 2015 at 5:48 PM, Mathieu Desnoyers <
> mathieu.desnoyers@efficios.com > wrote:

> > > From: "Olivier Delbeke" < Olivier.Delbeke@awtce.be >
> >=20
>=20
> > > To: "Mathieu Desnoyers" < mathieu.desnoyers@efficios.com >
> >=20
>=20
> > > Sent: Monday, January 19, 2015 2:03:07 AM
> >=20
>=20
> > > Subject: Re: [lttng-dev] Addition of the return address
> > > toliblttng-ust-libc-wrapper
> >=20
>=20

> > > Hi Mathieu,
> >=20
>=20

> > > Here is the patch you asked me : (See attached file:
> > > lttng-return-address.patch)
> >=20
>=20

> > > First , I named the variable for return address "ra", then changed it=
 to
> > > "caller". Of course, you're free to change it (to make it more clear =
or
> > > more
> > > in line with the rest of your code).
> >=20
>=20
> > Great!
>=20

> > Can I add your Signed-off-by tag to the patch header ?
>=20

> > Thanks,
>=20

> > Mathieu
>=20

> > > Best regards,
> >=20
>=20

> > >=20
> >=20
>=20

> > > Olivier Delbeke Senior Software Engineer Olivier.Delbeke@awtce.be / T=
.
> > > +32
> > > 2
> > > 389 25 53 AWTC Europe S.A. - Avenue de l=E2=80=99Industrie, 19 - 1420
> > > Braine-l=E2=80=99Alleud - Belgium - www.aweurope.eu - www.aisin-aw.co=
.jp VAT : BE
> > > 0474.474.114 - RPM Nivelles
> >=20
>=20

> > > Mathieu Desnoyers ---01/16/2015 09:41:08 PM---Mathieu Desnoyers <
> > > mathieu.desnoyers@efficios.com >
> >=20
>=20

> > > Mathieu Desnoyers < mathieu.desnoyers@efficios.com >
> >=20
>=20

> > > 01/16/2015 09:41 PM
> >=20
>=20
> > > To
> >=20
>=20
> > >=20
> >=20
>=20

> > > Olivier Delbeke < Olivier.Delbeke@awtce.be >
> >=20
>=20

> > > cc
> >=20
>=20
> > >=20
> >=20
>=20

> > > lttng-dev@lists.lttng.org
> >=20
>=20

> > > Subject
> >=20
>=20
> > >=20
> >=20
>=20

> > > Re: [lttng-dev] Addition of the return address to
> > > liblttng-ust-libc-wrapper
> >=20
>=20

> > > From: "Olivier Delbeke" < Olivier.Delbeke@awtce.be > To:
> > > lttng-dev@lists.lttng.org Sent: Tuesday, January 13, 2015 10:50:38 AM
> > > Subject: [lttng-dev] Addition of the return address to
> > > liblttng-ust-libc-wrapper
> >=20
>=20

> > > Hi guys,
> >=20
>=20

> > > I am using liblttng-ust-libc-wrapper to detect memory leaks in my
> > > applications. In order to identify not only the thread where the unfr=
eed
> > > allocations are done, but also the calling function, I extended the
> > > liblttng-ust-libc-wrapper to log the "return address"
> > > (__builtin_return_address(0)) in addition to the parameters of malloc=
().
> > > It
> > > solves my problem and does not affect Trace Compass. Was this the rig=
ht
> > > thing to do ? If it is, then I guess that it might interest other peo=
ple
> > > too.
> >=20
>=20
> > > After further thought, I'm interested to merge this into UST master.
> >=20
>=20

> > > Can you re-send either as an attachment, or as plain text without the
> >=20
>=20
> > > base64 encoding ?
> >=20
>=20

> > > Thanks!
> >=20
>=20

> > > Mathieu
> >=20
>=20

> > > diff -Nurd b/liblttng-ust-libc-wrapper/lttng-ust-malloc.c
> > > c/liblttng-ust-libc-wrapper/lttng-ust-malloc.c ---
> > > b/liblttng-ust-libc-wrapper/lttng-ust-malloc.c 2015-01-06
> > > 17:14:34.000000000
> > > +0100 +++ c/liblttng-ust-libc-wrapper/lttng-ust-malloc.c 2015-01-06
> > > 17:16:40.811145106 +0100 @@ -260,7 +260,7 @@ } retval =3D
> > > cur_alloc.malloc(size); if (URCU_TLS(malloc_nesting) =3D=3D 1) { -
> > > tracepoint(ust_libc, malloc, size, retval); + tracepoint(ust_libc,
> > > malloc,
> > > size, retval, __builtin_return_address(0) ); }
> > > URCU_TLS(malloc_nesting)--;
> > > return retval; @@ -279,7 +279,7 @@ } if (URCU_TLS(malloc_nesting) =3D=
=3D 1) {
> > > -
> > > tracepoint(ust_libc, free, ptr); + tracepoint(ust_libc, free, ptr,
> > > __builtin_return_address(0) ); } if (cur_alloc.free =3D=3D NULL) { @@=
 -308,7
> > > +308,7 @@ } retval =3D cur_alloc.calloc(nmemb, size); if
> > > (URCU_TLS(malloc_nesting) =3D=3D 1) { - tracepoint(ust_libc, calloc, =
nmemb,
> > > size, retval); + tracepoint(ust_libc, calloc, nmemb, size, retval,
> > > __builtin_return_address(0) ); } URCU_TLS(malloc_nesting)--; return
> > > retval;
> > > @@ -360,7 +360,7 @@ retval =3D cur_alloc.realloc(ptr, size); end: if
> > > (URCU_TLS(malloc_nesting) =3D=3D 1) { - tracepoint(ust_libc, realloc,=
 ptr,
> > > size,
> > > retval); + tracepoint(ust_libc, realloc, ptr, size, retval,
> > > __builtin_return_address(0) ); } URCU_TLS(malloc_nesting)--; return
> > > retval;
> > > @@ -380,7 +380,7 @@ } retval =3D cur_alloc.memalign(alignment, size);=
 if
> > > (URCU_TLS(malloc_nesting) =3D=3D 1) { - tracepoint(ust_libc, memalign=
,
> > > alignment, size, retval); + tracepoint(ust_libc, memalign, alignment,
> > > size,
> > > retval, __builtin_return_address(0) ); } URCU_TLS(malloc_nesting)--;
> > > return
> > > retval; @@ -401,7 +401,7 @@ retval =3D cur_alloc.posix_memalign(mempt=
r,
> > > alignment, size); if (URCU_TLS(malloc_nesting) =3D=3D 1) {
> > > tracepoint(ust_libc,
> > > posix_memalign, *memptr, alignment, size, - retval); + retval,
> > > __builtin_return_address(0) ); } URCU_TLS(malloc_nesting)--; return
> > > retval;
> > > diff -Nurd b/liblttng-ust-libc-wrapper/ust_libc.h
> > > c/liblttng-ust-libc-wrapper/ust_libc.h ---
> > > b/liblttng-ust-libc-wrapper/ust_libc.h 2015-01-06 17:14:34.000000000
> > > +0100
> > > +++ c/liblttng-ust-libc-wrapper/ust_libc.h 2015-01-06 17:16:40.811145=
106
> > > +0100 @@ -33,54 +33,60 @@ #include <lttng/tracepoint.h>
> > > TRACEPOINT_EVENT(ust_libc, malloc, - TP_ARGS(size_t, size, void *, pt=
r),
> > > +
> > > TP_ARGS(size_t, size, void *, ptr, void *, ra), TP_FIELDS(
> > > ctf_integer(size_t, size, size) ctf_integer_hex(void *, ptr, ptr) +
> > > ctf_integer_hex(void *, ra, ra) ) ) TRACEPOINT_EVENT(ust_libc, free, =
-
> > > TP_ARGS(void *, ptr), + TP_ARGS(void *, ptr, void *, ra), TP_FIELDS(
> > > ctf_integer_hex(void *, ptr, ptr) + ctf_integer_hex(void *, ra, ra) )=
 )
> > > TRACEPOINT_EVENT(ust_libc, calloc, - TP_ARGS(size_t, nmemb, size_t, s=
ize,
> > > void *, ptr), + TP_ARGS(size_t, nmemb, size_t, size, void *, ptr, voi=
d *,
> > > ra), TP_FIELDS( ctf_integer(size_t, nmemb, nmemb) ctf_integer(size_t,
> > > size,
> > > size) ctf_integer_hex(void *, ptr, ptr) + ctf_integer_hex(void *, ra,=
 ra)
> > > )
> > > ) TRACEPOINT_EVENT(ust_libc, realloc, - TP_ARGS(void *, in_ptr, size_=
t,
> > > size, void *, ptr), + TP_ARGS(void *, in_ptr, size_t, size, void *, p=
tr,
> > > void *, ra), TP_FIELDS( ctf_integer_hex(void *, in_ptr, in_ptr)
> > > ctf_integer(size_t, size, size) ctf_integer_hex(void *, ptr, ptr) +
> > > ctf_integer_hex(void *, ra, ra) ) ) TRACEPOINT_EVENT(ust_libc, memali=
gn,
> > > -
> > > TP_ARGS(size_t, alignment, size_t, size, void *, ptr), + TP_ARGS(size=
_t,
> > > alignment, size_t, size, void *, ptr, void *, ra), TP_FIELDS(
> > > ctf_integer(size_t, alignment, alignment) ctf_integer(size_t, size, s=
ize)
> > > ctf_integer_hex(void *, ptr, ptr) + ctf_integer_hex(void *, ra, ra) )=
 )
> > > TRACEPOINT_EVENT(ust_libc, posix_memalign, - TP_ARGS(void *, out_ptr,
> > > size_t, alignment, size_t, size, int, result), + TP_ARGS(void *, out_=
ptr,
> > > size_t, alignment, size_t, size, int, result, void *, ra), TP_FIELDS(
> > > ctf_integer_hex(void *, out_ptr, out_ptr) ctf_integer(size_t, alignme=
nt,
> > > alignment) ctf_integer(size_t, size, size) ctf_integer(int, result,
> > > result)
> > > + ctf_integer_hex(void *, ra, ra) ) ) Best regards,
> >=20
>=20
> > >=20
> >=20
>=20

> > > Olivier Delbeke Senior Software Engineer Olivier.Delbeke@awtce.be / T=
.
> > > +32
> > > 2
> > > 389 25 53 AWTC Europe S.A. - Avenue de l=E2=80=99Industrie, 19 - 1420
> > > Braine-l=E2=80=99Alleud - Belgium - www.aweurope.eu - www.aisin-aw.co=
.jp VAT : BE
> > > 0474.474.114 - RPM Nivelles This mail, and any attachments thereto, i=
s
> > > intended only for use by the addressee(s) named herein and may contai=
n
> > > legally privileged and/or confidential information. If you are not th=
e
> > > intended recipient, please note that any review, dissemination,
> > > disclosure,
> > > alteration, printing, copying or transmission of this mail and/or any
> > > file
> > > transmitted with it, is strictly prohibited and may be unlawful. If y=
ou
> > > have
> > > received this mail by mistake, please immediately notify the sender a=
s
> > > well
> > > as our mail administrator at postmaster@aweurope.be , and permanently
> > > destroy the original as well as any copy thereof.
> > > _______________________________________________ lttng-dev mailing lis=
t
> > > lttng-dev@lists.lttng.org
> > > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >=20
>=20

> > > --
> >=20
>=20
> > > Mathieu Desnoyers
> >=20
>=20
> > > EfficiOS Inc.
> >=20
>=20
> > > http://www.efficios.com
> >=20
>=20
> > > (See attached file: 1E482660.jpg) (See attached file: ecblank.gif)
> >=20
>=20
> > > This mail, and any attachments thereto, is intended only for use by t=
he
> > > addressee(s) named herein and may contain legally privileged and/or
> > > confidential information. If you are not the intended recipient, plea=
se
> > > note
> > > that any review, dissemination, disclosure, alteration, printing, cop=
ying
> > > or
> > > transmission of this mail and/or any file transmitted with it, is
> > > strictly
> > > prohibited and may be unlawful. If you have received this mail by
> > > mistake,
> > > please immediately notify the sender as well as our mail administrato=
r at
> > > postmaster@aweurope.be , and permanently destroy the original as well=
 as
> > > any
> > > copy thereof.
> >=20
>=20
> > --
>=20
> > Mathieu Desnoyers
>=20
> > EfficiOS Inc.
>=20
> > http://www.efficios.com
>=20

> > _______________________________________________
>=20
> > lttng-dev mailing list
>=20
> > lttng-dev@lists.lttng.org
>=20
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>=20

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_9811_796484817.1421694937645
Content-Type: multipart/related;
	boundary="----=_Part_9812_1254747568.1421694937646"

------=_Part_9812_1254747568.1421694937646
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><hr id=3D"zwchr"><blockquote style=3D=
"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;=
font-weight:normal;font-style:normal;text-decoration:none;font-family:Helve=
tica,Arial,sans-serif;font-size:12pt;"><b>From: </b>"Olivier Delbeke" &lt;o=
livier.delbeke@gmail.com&gt;<br><b>To: </b>"Mathieu Desnoyers" &lt;mathieu.=
desnoyers@efficios.com&gt;<br><b>Cc: </b>"lttng-dev" &lt;lttng-dev@lists.lt=
tng.org&gt;<br><b>Sent: </b>Monday, January 19, 2015 12:19:41 PM<br><b>Subj=
ect: </b>Re: [lttng-dev] Addition of the return address toliblttng-ust-libc=
-wrapper<br><div><br></div><div dir=3D"ltr"><div><div><div><div>Hi Mathieu,=
<br><div><br></div></div>Yes, feel free to add my Signed-off-by tag to the =
patch header. I would just ask you to use my gmail address. </div></div></d=
iv></div></blockquote><div><br></div><div>OK, now merged into master, thank=
s!<br></div><div><br></div><div>Mathieu<br></div><div><br></div><blockquote=
 style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;co=
lor:#000;font-weight:normal;font-style:normal;text-decoration:none;font-fam=
ily:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div><div>=
<div><div><br></div></div>Have a nice evening,<br><div><br></div></div>Best=
 regards,<br></div>Olivier<br></div><div class=3D"gmail_extra"><br><div cla=
ss=3D"gmail_quote">On Mon, Jan 19, 2015 at 5:48 PM, Mathieu Desnoyers <span=
 dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=
=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;</span> wrote:<br><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex"><div><div style=3D"font-family:times new roman,new =
york,times,serif;font-size:12pt;color:#000000"><hr><blockquote style=3D"bor=
der-left:2px solid #1010ff;margin-left:5px;padding-left:5px;color:#000;font=
-weight:normal;font-style:normal;text-decoration:none;font-family:Helvetica=
,Arial,sans-serif;font-size:12pt"><b>From: </b>"Olivier Delbeke" &lt;<a hre=
f=3D"mailto:Olivier.Delbeke@awtce.be" target=3D"_blank">Olivier.Delbeke@awt=
ce.be</a>&gt;<br><b>To: </b>"Mathieu Desnoyers" &lt;<a href=3D"mailto:mathi=
eu.desnoyers@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com=
</a>&gt;<br><b>Sent: </b>Monday, January 19, 2015 2:03:07 AM<br><b>Subject:=
 </b>Re: [lttng-dev] Addition of the return address toliblttng-ust-libc-wra=
pper<br><div><br></div><p><span style=3D"font-family:sans-serif;font-size:s=
mall">Hi Mathieu,</span><br></p><div><br></div><span style=3D"font-family:s=
ans-serif;font-size:small">Here is the patch you asked me : </span><i>(See =
attached file: lttng-return-address.patch)</i><br><div><br></div><span styl=
e=3D"font-family:sans-serif;font-size:small">First , I named the variable f=
or return address "ra", then changed it to "caller". Of course, you're free=
 to change it (to make it more clear or more in line with the rest of your =
code).</span></blockquote><div><br></div><div>Great!<br></div><div><br></di=
v><div>Can I add your Signed-off-by tag to the patch header ?<br></div><div=
><br></div><div>Thanks,<br></div><div><br></div><div>Mathieu<br></div><div>=
<br></div><blockquote style=3D"border-left:2px solid #1010ff;margin-left:5p=
x;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-dec=
oration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><span c=
lass=3D""><div><br></div><span style=3D"font-family:sans-serif;font-size:sm=
all">Best regards,</span><br><div><br></div><table class=3D"mceItemTable" b=
order=3D"0" cellpadding=3D"0" cellspacing=3D"0"><tbody><tr valign=3D"top"><=
td rowspan=3D"2" valign=3D"middle" width=3D"108"><div align=3D"center"><img=
 src=3D"cid:2__=3D4EBBF741DFB5EACD8f9e8a93df93@aweurope.be" height=3D"98" w=
idth=3D"107" align=3D"bottom"></div></td><td width=3D"788"><img src=3D"cid:=
3__=3D4EBBF741DFB5EACD8f9e8a93df93@aweurope.be" alt=3D"" height=3D"1" width=
=3D"1" border=3D"0"></td></tr><tr valign=3D"top"><td valign=3D"middle" widt=
h=3D"788"><ul style=3D"padding-left:0pt"><span style=3D"color:#000080;font-=
family:serif;font-size:medium"><b>Olivier Delbeke </b></span><span style=3D=
"color:#000080;font-family:serif;font-size:medium"><i>Senior Software Engin=
eer</i></span><span style=3D"color:#565051;font-family:serif;font-size:medi=
um"><br><a href=3D"mailto:Olivier.Delbeke@awtce.be" target=3D"_blank">Olivi=
er.Delbeke@awtce.be</a> / T. <a href=3D"tel:%2B32%202%20389%2025%2053" targ=
et=3D"_blank">+32 2 389 25 53</a></span><hr style=3D"color:#333399" size=3D=
"2" noshade=3D"" width=3D"100%" align=3D"left"><span style=3D"font-family:s=
erif;font-size:medium">&nbsp;</span><span style=3D"color:#000080;font-famil=
y:serif;font-size:xx-small"><b>AWTC Europe S.A. </b></span><span style=3D"c=
olor:#565051;font-family:serif;font-size:xx-small">- Avenue de l=E2=80=99In=
dustrie, 19 - 1420 Braine-l=E2=80=99Alleud - Belgium - <a href=3D"http://ww=
w.aweurope.eu" target=3D"_blank">www.aweurope.eu</a> - <a href=3D"http://ww=
w.aisin-aw.co.jp" target=3D"_blank">www.aisin-aw.co.jp</a><br>VAT : BE 0474=
.474.114 - RPM Nivelles</span><span style=3D"font-family:serif;font-size:me=
dium">&nbsp;</span></ul></td></tr></tbody></table><br><div><br></div></span=
><img src=3D"cid:4__=3D4EBBF741DFB5EACD8f9e8a93df93@aweurope.be" alt=3D"Ina=
ctive hide details for Mathieu Desnoyers ---01/16/2015 09:41:08 PM---Mathie=
u Desnoyers <mathieu.desnoyers@efficios.com>" height=3D"16" width=3D"16" bo=
rder=3D"0"><span style=3D"color:#424282;font-family:sans-serif;font-size:sm=
all">Mathieu Desnoyers ---01/16/2015 09:41:08 PM---Mathieu Desnoyers &lt;<a=
 href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu.d=
esnoyers@efficios.com</a>&gt;</span><br><div><br></div><table class=3D"mceI=
temTable" width=3D"100%" border=3D"0" cellpadding=3D"0" cellspacing=3D"0"><=
tbody><tr valign=3D"top"><td width=3D"40%"><ul style=3D"padding-left:72pt">=
<span style=3D"font-family:sans-serif;font-size:xx-small"><b>Mathieu Desnoy=
ers &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank"=
>mathieu.desnoyers@efficios.com</a>&gt;</b></span><span style=3D"font-famil=
y:sans-serif;font-size:xx-small">&nbsp;</span><p><span style=3D"font-family=
:sans-serif;font-size:xx-small">01/16/2015 09:41 PM</span></p></ul></td><td=
 width=3D"60%"><table class=3D"mceItemTable" width=3D"100%" border=3D"0" ce=
llpadding=3D"0" cellspacing=3D"0"><tbody><tr valign=3D"top"><td width=3D"1%=
"><img src=3D"cid:3__=3D4EBBF741DFB5EACD8f9e8a93df93@aweurope.be" alt=3D"" =
height=3D"1" width=3D"58" border=3D"0"><br><div align=3D"right"><span style=
=3D"font-family:sans-serif;font-size:xx-small">To</span></div></td><td widt=
h=3D"100%"><img src=3D"cid:3__=3D4EBBF741DFB5EACD8f9e8a93df93@aweurope.be" =
alt=3D"" height=3D"1" width=3D"1" border=3D"0"><br><ul style=3D"padding-lef=
t:7pt"><span style=3D"font-family:sans-serif;font-size:xx-small">Olivier De=
lbeke &lt;<a href=3D"mailto:Olivier.Delbeke@awtce.be" target=3D"_blank">Oli=
vier.Delbeke@awtce.be</a>&gt;</span></ul></td></tr><tr valign=3D"top"><td w=
idth=3D"1%"><img src=3D"cid:3__=3D4EBBF741DFB5EACD8f9e8a93df93@aweurope.be"=
 alt=3D"" height=3D"1" width=3D"58" border=3D"0"><br><div align=3D"right"><=
span style=3D"font-family:sans-serif;font-size:xx-small">cc</span></div></t=
d><td width=3D"100%"><img src=3D"cid:3__=3D4EBBF741DFB5EACD8f9e8a93df93@awe=
urope.be" alt=3D"" height=3D"1" width=3D"1" border=3D"0"><br><ul style=3D"p=
adding-left:7pt"><span style=3D"font-family:sans-serif;font-size:xx-small">=
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a></span><br data-mce-bogus=3D"1"></ul></td></tr><tr valign=
=3D"top"><td width=3D"1%"><img src=3D"cid:3__=3D4EBBF741DFB5EACD8f9e8a93df9=
3@aweurope.be" alt=3D"" height=3D"1" width=3D"58" border=3D"0"><br><div ali=
gn=3D"right"><span style=3D"font-family:sans-serif;font-size:xx-small">Subj=
ect</span></div></td><td width=3D"100%"><img src=3D"cid:3__=3D4EBBF741DFB5E=
ACD8f9e8a93df93@aweurope.be" alt=3D"" height=3D"1" width=3D"1" border=3D"0"=
><br><ul style=3D"padding-left:7pt"><span style=3D"font-family:sans-serif;f=
ont-size:xx-small">Re: [lttng-dev] Addition of the return address to       =
 liblttng-ust-libc-wrapper</span></ul></td></tr></tbody></table><table clas=
s=3D"mceItemTable" border=3D"0" cellpadding=3D"0" cellspacing=3D"0"><tbody>=
<tr valign=3D"top"><td width=3D"58"><img src=3D"cid:3__=3D4EBBF741DFB5EACD8=
f9e8a93df93@aweurope.be" alt=3D"" height=3D"1" width=3D"1" border=3D"0"></t=
d><td width=3D"336"><img src=3D"cid:3__=3D4EBBF741DFB5EACD8f9e8a93df93@aweu=
rope.be" alt=3D"" height=3D"1" width=3D"1" border=3D"0"></td></tr></tbody><=
/table></td></tr></tbody></table><div><div class=3D"h5"><br><hr size=3D"2" =
width=3D"100%" align=3D"left"><ul style=3D"padding-left:3pt"><span style=3D=
"font-family:Arial;font-size:medium"><b>From: </b></span><span style=3D"fon=
t-family:Arial;font-size:medium">"Olivier Delbeke" &lt;<a href=3D"mailto:Ol=
ivier.Delbeke@awtce.be" target=3D"_blank">Olivier.Delbeke@awtce.be</a>&gt;<=
/span><span style=3D"font-family:Arial;font-size:medium"><b><br>To: </b></s=
pan><span style=3D"font-family:Arial;font-size:medium"><a href=3D"mailto:lt=
tng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a></s=
pan><span style=3D"font-family:Arial;font-size:medium"><b><br>Sent: </b></s=
pan><span style=3D"font-family:Arial;font-size:medium">Tuesday, January 13,=
 2015 10:50:38 AM</span><span style=3D"font-family:Arial;font-size:medium">=
<b><br>Subject: </b></span><span style=3D"font-family:Arial;font-size:mediu=
m">[lttng-dev] Addition of the return address to &nbsp; &nbsp; &nbsp; &nbsp=
;liblttng-ust-libc-wrapper</span><br><p><span style=3D"font-family:Arial;fo=
nt-size:small">Hi guys,</span></p><p><br><span style=3D"font-family:Arial;f=
ont-size:small">I am using liblttng-ust-libc-wrapper to detect memory leaks=
 in my applications. <br>In order to identify not only the thread where the=
 unfreed allocations are done, but also the calling function, I extended th=
e liblttng-ust-libc-wrapper to log the "return address" (__builtin_return_a=
ddress(0)) in addition to the parameters of malloc(). It solves my problem =
and does not affect Trace Compass.<br>Was this the right thing to do ? <br>=
If it is, then I guess that it might interest other people too.</span></p><=
/ul><span style=3D"font-family:serif;font-size:medium">After further though=
t, I'm interested to merge this into UST master.</span><br><div><br></div><=
span style=3D"font-family:serif;font-size:medium">Can you re-send either as=
 an attachment, or as plain text without the</span><br><span style=3D"font-=
family:serif;font-size:medium">base64 encoding ?</span><br><div><br></div><=
span style=3D"font-family:serif;font-size:medium">Thanks!</span><br><div><b=
r></div><span style=3D"font-family:serif;font-size:medium">Mathieu</span><b=
r><div><br></div><ul style=3D"padding-left:3pt"><br><span style=3D"font-fam=
ily:Arial;font-size:small">diff -Nurd b/liblttng-ust-libc-wrapper/lttng-ust=
-malloc.c c/liblttng-ust-libc-wrapper/lttng-ust-malloc.c<br>--- b/liblttng-=
ust-libc-wrapper/lttng-ust-malloc.c 2015-01-06 17:14:34.000000000 +0100<br>=
+++ c/liblttng-ust-libc-wrapper/lttng-ust-malloc.c 2015-01-06 17:16:40.8111=
45106 +0100<br>@@ -260,7 +260,7 @@<br> &nbsp;}<br> &nbsp;retval =3D cur_all=
oc.malloc(size);<br> &nbsp;if (URCU_TLS(malloc_nesting) =3D=3D 1) {<br>- tr=
acepoint(ust_libc, malloc, size, retval);<br>+ tracepoint(ust_libc, malloc,=
 size, retval, __builtin_return_address(0) );<br> &nbsp;}<br> &nbsp;URCU_TL=
S(malloc_nesting)--;<br> &nbsp;return retval;<br>@@ -279,7 +279,7 @@<br> &n=
bsp;}<br> <br> &nbsp;if (URCU_TLS(malloc_nesting) =3D=3D 1) {<br>- tracepoi=
nt(ust_libc, free, ptr);<br>+ tracepoint(ust_libc, free, ptr, __builtin_ret=
urn_address(0) );<br> &nbsp;}<br> <br> &nbsp;if (cur_alloc.free =3D=3D NULL=
) {<br>@@ -308,7 +308,7 @@<br> &nbsp;}<br> &nbsp;retval =3D cur_alloc.callo=
c(nmemb, size);<br> &nbsp;if (URCU_TLS(malloc_nesting) =3D=3D 1) {<br>- tra=
cepoint(ust_libc, calloc, nmemb, size, retval);<br>+ tracepoint(ust_libc, c=
alloc, nmemb, size, retval, __builtin_return_address(0) );<br> &nbsp;}<br> =
&nbsp;URCU_TLS(malloc_nesting)--;<br> &nbsp;return retval;<br>@@ -360,7 +36=
0,7 @@<br> &nbsp;retval =3D cur_alloc.realloc(ptr, size);<br> end:<br> &nbs=
p;if (URCU_TLS(malloc_nesting) =3D=3D 1) {<br>- tracepoint(ust_libc, reallo=
c, ptr, size, retval);<br>+ tracepoint(ust_libc, realloc, ptr, size, retval=
, __builtin_return_address(0) );<br> &nbsp;}<br> &nbsp;URCU_TLS(malloc_nest=
ing)--;<br> &nbsp;return retval;<br>@@ -380,7 +380,7 @@<br> &nbsp;}<br> &nb=
sp;retval =3D cur_alloc.memalign(alignment, size);<br> &nbsp;if (URCU_TLS(m=
alloc_nesting) =3D=3D 1) {<br>- tracepoint(ust_libc, memalign, alignment, s=
ize, retval);<br>+ tracepoint(ust_libc, memalign, alignment, size, retval, =
__builtin_return_address(0) );<br> &nbsp;}<br> &nbsp;URCU_TLS(malloc_nestin=
g)--;<br> &nbsp;return retval;<br>@@ -401,7 +401,7 @@<br> &nbsp;retval =3D =
cur_alloc.posix_memalign(memptr, alignment, size);<br> &nbsp;if (URCU_TLS(m=
alloc_nesting) =3D=3D 1) {<br> &nbsp;tracepoint(ust_libc, posix_memalign, *=
memptr, alignment, size,<br>- retval);<br>+ retval, __builtin_return_addres=
s(0) );<br> &nbsp;}<br> &nbsp;URCU_TLS(malloc_nesting)--;<br> &nbsp;return =
retval;<br>diff -Nurd b/liblttng-ust-libc-wrapper/ust_libc.h c/liblttng-ust=
-libc-wrapper/ust_libc.h<br>--- b/liblttng-ust-libc-wrapper/ust_libc.h 2015=
-01-06 17:14:34.000000000 +0100<br>+++ c/liblttng-ust-libc-wrapper/ust_libc=
.h 2015-01-06 17:16:40.811145106 +0100<br>@@ -33,54 +33,60 @@<br> #include =
&lt;lttng/tracepoint.h&gt;<br> <br> TRACEPOINT_EVENT(ust_libc, malloc,<br>-=
 TP_ARGS(size_t, size, void *, ptr),<br>+ TP_ARGS(size_t, size, void *, ptr=
, void *, ra),<br> &nbsp;TP_FIELDS(<br> &nbsp;ctf_integer(size_t, size, siz=
e)<br> &nbsp;ctf_integer_hex(void *, ptr, ptr)<br>+ ctf_integer_hex(void *,=
 ra, ra)<br> &nbsp;)<br> )<br> <br> TRACEPOINT_EVENT(ust_libc, free,<br>- T=
P_ARGS(void *, ptr),<br>+ TP_ARGS(void *, ptr, void *, ra),<br> &nbsp;TP_FI=
ELDS(<br> &nbsp;ctf_integer_hex(void *, ptr, ptr)<br>+ ctf_integer_hex(void=
 *, ra, ra)<br> &nbsp;)<br> )<br> <br> TRACEPOINT_EVENT(ust_libc, calloc,<b=
r>- TP_ARGS(size_t, nmemb, size_t, size, void *, ptr),<br>+ TP_ARGS(size_t,=
 nmemb, size_t, size, void *, ptr, void *, ra),<br> &nbsp;TP_FIELDS(<br> &n=
bsp;ctf_integer(size_t, nmemb, nmemb)<br> &nbsp;ctf_integer(size_t, size, s=
ize)<br> &nbsp;ctf_integer_hex(void *, ptr, ptr)<br>+ ctf_integer_hex(void =
*, ra, ra)<br> &nbsp;)<br> )<br> <br> TRACEPOINT_EVENT(ust_libc, realloc,<b=
r>- TP_ARGS(void *, in_ptr, size_t, size, void *, ptr),<br>+ TP_ARGS(void *=
, in_ptr, size_t, size, void *, ptr, void *, ra),<br> &nbsp;TP_FIELDS(<br> =
&nbsp;ctf_integer_hex(void *, in_ptr, in_ptr)<br> &nbsp;ctf_integer(size_t,=
 size, size)<br> &nbsp;ctf_integer_hex(void *, ptr, ptr)<br>+ ctf_integer_h=
ex(void *, ra, ra)<br> &nbsp;)<br> )<br> <br> TRACEPOINT_EVENT(ust_libc, me=
malign,<br>- TP_ARGS(size_t, alignment, size_t, size, void *, ptr),<br>+ TP=
_ARGS(size_t, alignment, size_t, size, void *, ptr, void *, ra),<br> &nbsp;=
TP_FIELDS(<br> &nbsp;ctf_integer(size_t, alignment, alignment)<br> &nbsp;ct=
f_integer(size_t, size, size)<br> &nbsp;ctf_integer_hex(void *, ptr, ptr)<b=
r>+ ctf_integer_hex(void *, ra, ra)<br> &nbsp;)<br> )<br> <br> TRACEPOINT_E=
VENT(ust_libc, posix_memalign,<br>- TP_ARGS(void *, out_ptr, size_t, alignm=
ent, size_t, size, int, result),<br>+ TP_ARGS(void *, out_ptr, size_t, alig=
nment, size_t, size, int, result, void *, ra),<br> &nbsp;TP_FIELDS(<br> &nb=
sp;ctf_integer_hex(void *, out_ptr, out_ptr)<br> &nbsp;ctf_integer(size_t, =
alignment, alignment)<br> &nbsp;ctf_integer(size_t, size, size)<br> &nbsp;c=
tf_integer(int, result, result)<br>+ ctf_integer_hex(void *, ra, ra)<br> &n=
bsp;)<br> )<br> <br>Best regards,</span><table class=3D"mceItemTable" borde=
r=3D"0" cellpadding=3D"0" cellspacing=3D"0"><tbody><tr valign=3D"top"><td r=
owspan=3D"2" valign=3D"middle" width=3D"108"><div align=3D"center"><img src=
=3D"cid:2__=3D4EBBF741DFB5EACD8f9e8a93df93@aweurope.be" height=3D"98" width=
=3D"107" align=3D"bottom"></div></td><td width=3D"788"><img src=3D"cid:3__=
=3D4EBBF741DFB5EACD8f9e8a93df93@aweurope.be" height=3D"1" width=3D"1" align=
=3D"bottom"></td></tr><tr valign=3D"top"><td valign=3D"middle" width=3D"788=
"><ul style=3D"padding-left:36pt"><span style=3D"color:#000080;font-family:=
serif;font-size:medium"><b>Olivier Delbeke </b></span><span style=3D"color:=
#000080;font-family:serif;font-size:medium"><i>Senior Software Engineer</i>=
</span><span style=3D"color:#565051;font-family:serif;font-size:medium"><br=
><a href=3D"mailto:Olivier.Delbeke@awtce.be" target=3D"_blank">Olivier.Delb=
eke@awtce.be</a> / T. <a href=3D"tel:%2B32%202%20389%2025%2053" target=3D"_=
blank">+32 2 389 25 53</a></span><hr size=3D"2" noshade=3D"" width=3D"100%"=
 align=3D"left"><span style=3D"font-family:serif;font-size:medium">&nbsp;</=
span><span style=3D"color:#000080;font-family:serif;font-size:xx-small"><b>=
AWTC Europe S.A. </b></span><span style=3D"color:#565051;font-family:serif;=
font-size:xx-small">- Avenue de l=E2=80=99Industrie, 19 - 1420 Braine-l=E2=
=80=99Alleud - Belgium - </span><span style=3D"color:#565051;font-family:se=
rif;font-size:xx-small"><a href=3D"http://www.aweurope.eu" target=3D"_blank=
">www.aweurope.eu</a></span><span style=3D"color:#565051;font-family:serif;=
font-size:xx-small">&nbsp;- </span><span style=3D"color:#565051;font-family=
:serif;font-size:xx-small"><a href=3D"http://www.aisin-aw.co.jp" target=3D"=
_blank">www.aisin-aw.co.jp</a></span><span style=3D"color:#565051;font-fami=
ly:serif;font-size:xx-small"><br>VAT : BE 0474.474.114 - RPM Nivelles</span=
><span style=3D"font-family:serif;font-size:medium">&nbsp;</span></ul></td>=
</tr></tbody></table><span style=3D"font-family:Arial;font-size:medium"><br=
>This mail, and any attachments thereto, is intended only for use by the ad=
dressee(s) named herein and may contain legally privileged and/or confident=
ial information. If you are not the intended recipient, please note that an=
y review, dissemination, disclosure, alteration, printing, copying or trans=
mission of this mail and/or any file transmitted with it, is strictly prohi=
bited and may be unlawful. If you have received this mail by mistake, pleas=
e immediately notify the sender as well as our mail administrator at <a hre=
f=3D"mailto:postmaster@aweurope.be" target=3D"_blank">postmaster@aweurope.b=
e</a>, and permanently destroy the original as well as any copy thereof. <b=
r>_______________________________________________<br>lttng-dev mailing list=
<br><a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-de=
v@lists.lttng.org</a><br></span><span style=3D"font-family:Arial;font-size:=
medium"><a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-de=
v" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-=
dev</a></span><br></ul><span style=3D"font-family:serif;font-size:medium"><=
br></span><br><div><br></div><span style=3D"font-family:serif;font-size:med=
ium">-- </span><br><span style=3D"font-family:serif;font-size:medium">Mathi=
eu Desnoyers<br>EfficiOS Inc.<br></span><span style=3D"font-family:serif;fo=
nt-size:medium"><a href=3D"http://www.efficios.com" target=3D"_blank">http:=
//www.efficios.com</a></span><br></div></div><i>(See attached file: 1E48266=
0.jpg)</i><i>(See attached file: ecblank.gif)</i><span class=3D""><br><span=
 style=3D"font-family:sans-serif">


This mail, and any attachments thereto, is intended only for use by the add=
ressee(s) named herein and may contain legally privileged and/or confidenti=
al information.  If you are not the intended recipient, please note that an=
y review, dissemination, disclosure, alteration, printing, copying or trans=
mission of this mail and/or any file transmitted with it, is strictly prohi=
bited and may be unlawful.  If you have received this mail by mistake, plea=
se immediately notify the sender as well as our mail administrator at <a hr=
ef=3D"mailto:postmaster@aweurope.be" target=3D"_blank">postmaster@aweurope.=
be</a>, and permanently destroy the original as well as any copy thereof.
</span></span></blockquote><div><br><div><br></div></div><span class=3D""><=
div><br></div><div>-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>=
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a><br></div></span></div></div><br>____________________________________=
___________<br>
lttng-dev mailing list<br><a href=3D"mailto:lttng-dev@lists.lttng.org" targ=
et=3D"_blank">lttng-dev@lists.lttng.org</a><br><a href=3D"http://lists.lttn=
g.org/cgi-bin/mailman/listinfo/lttng-dev" target=3D"_blank">http://lists.lt=
tng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br><br></blockquote></div><b=
r></div></blockquote><div><br><br></div><div><br></div><div>-- <br></div><d=
iv><span name=3D"x"></span>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www=
.efficios.com<span name=3D"x"></span><br></div></div></body></html>
------=_Part_9812_1254747568.1421694937646
Content-Type: image/jpeg; name=1D220451.jpg
Content-Disposition: attachment; filename=1D220451.jpg
Content-Transfer-Encoding: base64
Content-ID: <2__=4EBBF741DFB5EACD8f9e8a93df93@aweurope.be>

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
------=_Part_9812_1254747568.1421694937646
Content-Type: image/gif; name=ecblank.gif
Content-Disposition: attachment; filename=ecblank.gif
Content-Transfer-Encoding: base64
Content-ID: <3__=4EBBF741DFB5EACD8f9e8a93df93@aweurope.be>

R0lGODlhEAABAIAAAAAAAP///yH5BAEAAAEALAAAAAAQAAEAAAIEjI8ZBQA7
------=_Part_9812_1254747568.1421694937646
Content-Type: image/gif; name=graycol.gif
Content-Disposition: attachment; filename=graycol.gif
Content-Transfer-Encoding: base64
Content-ID: <4__=4EBBF741DFB5EACD8f9e8a93df93@aweurope.be>

R0lGODlhEAAQAKECAMzMzAAAAP///wAAACH5BAEAAAIALAAAAAAQABAAAAIXlI+py+0PopwxUbpu
ZRfKZ2zgSJbmSRYAIf4fT3B0aW1pemVkIGJ5IFVsZWFkIFNtYXJ0U2F2ZXIhAAA7
------=_Part_9812_1254747568.1421694937646--

------=_Part_9811_796484817.1421694937645--




--===============0282272549==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0282272549==--
