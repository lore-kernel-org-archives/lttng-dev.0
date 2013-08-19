From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [RFC patch] [Babeltrace python bindings] Added
 missing call to _bt_ctf_get_decl_from_def in get_int_len(),
 and defined ssize_t
Date: Mon, 19 Aug 2013 11:10:24 -0400
Message-ID: <CA+jJMxuL5X+VWntZXHD2Mm3pJQjc-zgW2BqKpAu9XBVsb565Yw__46725.8095196032$1376925095$gmane$org@mail.gmail.com>
References: <OF83984A41.55B3F7DA-ONC2257BCC.003D5BF5-C2257BCC.003DCDC3@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1534854091=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1VBR6E-0005bx-Ox
	for lttng-dev@lists.lttng.org; Mon, 19 Aug 2013 11:10:36 -0400
Received: by mail-wg0-f49.google.com with SMTP id y10so3550207wgg.4
	for <lttng-dev@lists.lttng.org>; Mon, 19 Aug 2013 08:10:24 -0700 (PDT)
In-Reply-To: <OF83984A41.55B3F7DA-ONC2257BCC.003D5BF5-C2257BCC.003DCDC3@il.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Amit Margalit <AMITM@il.ibm.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1534854091==
Content-Type: multipart/alternative; boundary=001a11c35472fb0f3d04e44e5663

--001a11c35472fb0f3d04e44e5663
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Inlining for review.
Please note that both patches in this series are missing your "signed-off
by" line.

Also, the issues addressed in this patch are unrelated and should be fixed
separately.

> From c3474a73eb137b2bb7984d3195094a263c024e65 Mon Sep 17 00:00:00 2001
> From: Amit Margalit <amitm@il.ibm.com>
> Date: Mon, 19 Aug 2013 14:08:40 +0300
> Subject: [PATCH 1/2] Added missing call to _bt_ctf_get_decl_from_def in
>  get_int_len(), and defined ssize_t
>
> ---
>  bindings/python/babeltrace.i.in | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/bindings/python/babeltrace.i.in b/bindings/python/
babeltrace.i.in
> index dd2dacc..6c1f6fb 100644
> --- a/bindings/python/babeltrace.i.in
> +++ b/bindings/python/babeltrace.i.in
> @@ -53,6 +53,7 @@ trace to it."
>  typedef unsigned long long uint64_t;
>  typedef long long int64_t;
>  typedef int bt_intern_str;
> +typedef unsigned long ssize_t;

On which system is ssize_t undefined?
I'd personally use ptrdiff_t, but maybe it is undefined there too?

These typedefs should be handled at config time, is it something you would
be interested in providing a patch for?

>
>  /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   CONTEXT.H, CONTEXT-INTERNAL.H
> @@ -866,7 +867,7 @@ class ctf:
>   Return the size, in bits, of an int or a negative
>   value on error.
>   """
> - return _bt_ctf_get_int_len(self._d)
> + return _bt_ctf_get_int_len(_bt_ctf_get_decl_from_def(self._d))

Good catch!

>
>   def get_encoding(self):
>   """
> --
> 1.7.11.7
>


On Mon, Aug 19, 2013 at 7:15 AM, Amit Margalit <AMITM@il.ibm.com> wrote:

> In some systems, the system headers use ssize_t, which was not defined,
> causing get_int_len() to return a pointer to a python object instead of
> returning the integer.
> Also, the python code that called _bt_ctf_get_int_len() failed to wrap
> self._d with the call to _bt_ctf_get_decl_from_def.
>
> I'm attaching this patch to (hopefully) avoid line formatting issues.
>
>
>
>
> Amit Margalit
> IBM XIV - *Storage Reinvented*
> XIV-NAS Development Team
> Tel. 03-689-7774
> Fax. 03-689-7230
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>


--=20
J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--001a11c35472fb0f3d04e44e5663
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Inlining for review.<div>Please note that both patches in =
this series are missing your &quot;signed-off by&quot; line.<br></div><div>=
<br></div><div>Also, the issues addressed in this patch are unrelated and s=
hould be fixed separately.</div>
<div><br></div>
<div><div><div>&gt; From c3474a73eb137b2bb7984d3195094a263c024e65 Mon Sep 1=
7 00:00:00 2001</div><div>&gt; From: Amit Margalit &lt;<a href=3D"mailto:am=
itm@il.ibm.com">amitm@il.ibm.com</a>&gt;</div><div>&gt; Date: Mon, 19 Aug 2=
013 14:08:40 +0300</div>
<div>&gt; Subject: [PATCH 1/2] Added missing call to _bt_ctf_get_decl_from_=
def in</div><div>&gt; =A0get_int_len(), and defined ssize_t</div><div>&gt;=
=A0</div><div>&gt; ---</div><div>&gt; =A0bindings/python/<a href=3D"http://=
babeltrace.i.in">babeltrace.i.in</a> | 3 ++-</div>
<div>&gt; =A01 file changed, 2 insertions(+), 1 deletion(-)</div><div>&gt;=
=A0</div><div>&gt; diff --git a/bindings/python/<a href=3D"http://babeltrac=
e.i.in">babeltrace.i.in</a> b/bindings/python/<a href=3D"http://babeltrace.=
i.in">babeltrace.i.in</a></div>
<div>&gt; index dd2dacc..6c1f6fb 100644</div><div>&gt; --- a/bindings/pytho=
n/<a href=3D"http://babeltrace.i.in">babeltrace.i.in</a></div><div>&gt; +++=
 b/bindings/python/<a href=3D"http://babeltrace.i.in">babeltrace.i.in</a></=
div>
<div>&gt; @@ -53,6 +53,7 @@ trace to it.&quot;</div><div>&gt; =A0typedef un=
signed long long uint64_t;</div><div>&gt; =A0typedef long long int64_t;</di=
v><div>&gt; =A0typedef int bt_intern_str;</div><div>&gt; +typedef unsigned =
long ssize_t;</div>
<div><br></div><div>On which system is ssize_t undefined?</div><div>I&#39;d=
 personally use ptrdiff_t, but maybe it is undefined there too?</div><div><=
br></div><div>These typedefs should be handled at config time, is it someth=
ing you would be interested in providing a patch for?</div>
<div><br></div><div>&gt; =A0</div><div>&gt; =A0/* =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D</div><div>&gt; =A0<span class=3D"" style=3D"white-spa=
ce:pre">		</span>CONTEXT.H, CONTEXT-INTERNAL.H</div><div>&gt; @@ -866,7 +86=
7,7 @@ class ctf:</div>
<div>&gt; =A0<span class=3D"" style=3D"white-space:pre">			</span>Return th=
e size, in bits, of an int or a negative</div><div>&gt; =A0<span class=3D""=
 style=3D"white-space:pre">			</span>value on error.</div><div>&gt; =A0<spa=
n class=3D"" style=3D"white-space:pre">			</span>&quot;&quot;&quot;</div>
<div>&gt; -<span class=3D"" style=3D"white-space:pre">			</span>return _bt_=
ctf_get_int_len(self._d)</div><div>&gt; +<span class=3D"" style=3D"white-sp=
ace:pre">			</span>return _bt_ctf_get_int_len(_bt_ctf_get_decl_from_def(sel=
f._d))</div>
<div><br></div><div>Good catch!</div><div><br></div><div>&gt; =A0</div><div=
>&gt; =A0<span class=3D"" style=3D"white-space:pre">		</span>def get_encodi=
ng(self):</div><div>&gt; =A0<span class=3D"" style=3D"white-space:pre">			<=
/span>&quot;&quot;&quot;</div>
<div>&gt; --=A0</div><div>&gt; 1.7.11.7</div><div>&gt;=A0</div></div></div>=
</div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Mon,=
 Aug 19, 2013 at 7:15 AM, Amit Margalit <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:AMITM@il.ibm.com" target=3D"_blank">AMITM@il.ibm.com</a>&gt;</span> wr=
ote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><font face=3D"sans-serif">In some systems, t=
he system headers use
ssize_t, which was not defined, causing get_int_len() to return a pointer
to a python object instead of returning the integer.</font>
<br><font face=3D"sans-serif">Also, the python code that called _bt_ctf_get=
_int_len()
failed to wrap self._d with the call to _bt_ctf_get_decl_from_def.</font>
<br>
<br><font face=3D"sans-serif">I&#39;m attaching this patch to (hopefully)
avoid line formatting issues.</font>
<br><span class=3D"HOEnZb"><font color=3D"#888888">
<br>
<br>
<br>
<br><font color=3D"#000080" face=3D"sans-serif">Amit Margalit</font>
<br><font color=3D"#808000" face=3D"sans-serif">IBM XIV </font><font face=
=3D"sans-serif">-
<i>Storage Reinvented</i></font>
<br><font face=3D"sans-serif">XIV-NAS Development Team</font>
<br><font face=3D"sans-serif">Tel. 03</font><font face=3D"Arial">-689-7774<=
/font>
<br><font face=3D"Arial">Fax. 03-689-7230</font></font></span><br>_________=
______________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
<br></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>J=E9r=E9=
mie Galarneau<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" targe=
t=3D"_blank">http://www.efficios.com</a>
</div>

--001a11c35472fb0f3d04e44e5663--


--===============1534854091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1534854091==--
