From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: [PATCH lttng-ust] Fix: Override AM_PATH_PYTHON's
 default action-if-not-found
Date: Wed, 2 Apr 2014 09:18:44 +0300
Message-ID: <OF71D27810.7FDA322B-ONC2257CAE.0022AE3B-C2257CAE.0022B1D5__9257.88428071446$1396516624$gmane$org@il.ibm.com>
References: <OFEFA91F70.CE626678-ONC2257CAD.004B5DA5-C2257CAD.004C1B49@il.ibm.com>
 <1396367398-31434-1-git-send-email-jeremie.galarneau@efficios.com>
 <1755268860.3617.1396374426194.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1722103768=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp10.uk.ibm.com ([195.75.94.106])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <amitm@il.ibm.com>) id 1WVEVs-0005gK-Pz
 for lttng-dev@lists.lttng.org; Wed, 02 Apr 2014 02:19:10 -0400
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
 Wed, 2 Apr 2014 07:18:59 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 29E5C219004D
 for <lttng-dev@lists.lttng.org>; Wed,  2 Apr 2014 07:18:51 +0100 (BST)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s326IjIL57868438
 for <lttng-dev@lists.lttng.org>; Wed, 2 Apr 2014 06:18:45 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s326Iu9l012705
 for <lttng-dev@lists.lttng.org>; Wed, 2 Apr 2014 00:18:56 -0600
In-Reply-To: <1755268860.3617.1396374426194.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============1722103768==
Content-Type: multipart/alternative; boundary="=_alternative 0022B16BC2257CAE_="

This is a multipart message in MIME format.
--=_alternative 0022B16BC2257CAE_=
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

That was quick! Thank you...

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
Cc:     lttng-dev@lists.lttng.org
Date:   04/01/2014 08:48 PM
Subject:        Re: [lttng-dev] [PATCH lttng-ust] Fix: Override=20
AM=5FPATH=5FPYTHON's default action-if-not-found



Merged, thanks!

Mathieu

----- Original Message -----
> From: "J=E9r=E9mie Galarneau" <jeremie.galarneau@efficios.com>
> To: lttng-dev@lists.lttng.org
> Cc: "mathieu desnoyers" <mathieu.desnoyers@efficios.com>, "J=E9r=E9mie=20
Galarneau" <jeremie.galarneau@efficios.com>
> Sent: Tuesday, April 1, 2014 11:49:58 AM
> Subject: [PATCH lttng-ust] Fix: Override AM=5FPATH=5FPYTHON's default=20
action-if-not-found
>=20
> AM=5FPATH=5FPYTHON's default action aborts configure. This fix ensures th=
at
> configure follows through with a noop.
>=20
> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  configure.ac | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/configure.ac b/configure.ac
> index d4926e4..b04d4e3 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -288,7 +288,7 @@ AC=5FDEFINE=5FUNQUOTED([LTTNG=5FSYSTEM=5FRUNDIR],
> ["$lttng=5Fsystem=5Frundir"],
>  lttnglibjavadir=3D"${libdir}/lttng/java"
>  AC=5FSUBST(lttnglibjavadir)
>=20
> -AM=5FPATH=5FPYTHON([2.7],BUILD=5FGEN=5FTP=5FEXAMPLES=3D1)
> +AM=5FPATH=5FPYTHON([2.7],BUILD=5FGEN=5FTP=5FEXAMPLES=3D1,[:])
>  AM=5FCONDITIONAL([BUILD=5FGEN=5FTP=5FEXAMPLES], [test $BUILD=5FGEN=5FTP=
=5FEXAMPLES],
>  [Build examples requiring lttng-gen-tp])
>=20
>  AC=5FCONFIG=5FFILES([
> --
> 1.9.1
>=20
>=20

--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--=_alternative 0022B16BC2257CAE_=
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<font size=3D2 face=3D"sans-serif">That was quick! Thank you...</font>
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
&nbsp;</font><font size=3D1 face=3D"sans-serif">Mathieu Desnoyers &lt;mathi=
eu.desnoyers@efficios.com&gt;</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">To: &nbsp; &nbsp; &n=
bsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">J=E9r=E9mie Galarneau &lt;j=
eremie.galarneau@efficios.com&gt;</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Cc: &nbsp; &nbsp; &n=
bsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">lttng-dev@lists.lttng.org</=
font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Date: &nbsp; &nbsp; =
&nbsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">04/01/2014 08:48 PM</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Subject: &nbsp; &nbs=
p;
&nbsp; &nbsp;</font><font size=3D1 face=3D"sans-serif">Re: [lttng-dev]
[PATCH lttng-ust] Fix: Override AM=5FPATH=5FPYTHON's default action-if-not-=
found</font>
<br>
<hr noshade>
<br>
<br>
<br><tt><font size=3D2>Merged, thanks!<br>
<br>
Mathieu<br>
<br>
----- Original Message -----<br>
&gt; From: &quot;J=E9r=E9mie Galarneau&quot; &lt;jeremie.galarneau@efficios=
.com&gt;<br>
&gt; To: lttng-dev@lists.lttng.org<br>
&gt; Cc: &quot;mathieu desnoyers&quot; &lt;mathieu.desnoyers@efficios.com&g=
t;,
&quot;J=E9r=E9mie Galarneau&quot; &lt;jeremie.galarneau@efficios.com&gt;<br>
&gt; Sent: Tuesday, April 1, 2014 11:49:58 AM<br>
&gt; Subject: [PATCH lttng-ust] Fix: Override AM=5FPATH=5FPYTHON's default
action-if-not-found<br>
&gt; <br>
&gt; AM=5FPATH=5FPYTHON's default action aborts configure. This fix ensures
that<br>
&gt; configure follows through with a noop.<br>
&gt; <br>
&gt; Signed-off-by: J=E9r=E9mie Galarneau &lt;jeremie.galarneau@efficios.co=
m&gt;<br>
&gt; ---<br>
&gt; &nbsp;configure.ac | 2 +-<br>
&gt; &nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/configure.ac b/configure.ac<br>
&gt; index d4926e4..b04d4e3 100644<br>
&gt; --- a/configure.ac<br>
&gt; +++ b/configure.ac<br>
&gt; @@ -288,7 +288,7 @@ AC=5FDEFINE=5FUNQUOTED([LTTNG=5FSYSTEM=5FRUNDIR],<=
br>
&gt; [&quot;$lttng=5Fsystem=5Frundir&quot;],<br>
&gt; &nbsp;lttnglibjavadir=3D&quot;${libdir}/lttng/java&quot;<br>
&gt; &nbsp;AC=5FSUBST(lttnglibjavadir)<br>
&gt; &nbsp;<br>
&gt; -AM=5FPATH=5FPYTHON([2.7],BUILD=5FGEN=5FTP=5FEXAMPLES=3D1)<br>
&gt; +AM=5FPATH=5FPYTHON([2.7],BUILD=5FGEN=5FTP=5FEXAMPLES=3D1,[:])<br>
&gt; &nbsp;AM=5FCONDITIONAL([BUILD=5FGEN=5FTP=5FEXAMPLES], [test $BUILD=5FG=
EN=5FTP=5FEXAMPLES],<br>
&gt; &nbsp;[Build examples requiring lttng-gen-tp])<br>
&gt; &nbsp;<br>
&gt; &nbsp;AC=5FCONFIG=5FFILES([<br>
&gt; --<br>
&gt; 1.9.1<br>
&gt; <br>
&gt; <br>
<br>
-- <br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
</font></tt><a href=3Dhttp://www.efficios.com/><tt><font size=3D2>http://ww=
w.efficios.com</font></tt></a><tt><font size=3D2><br>
<br>
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F<br>
lttng-dev mailing list<br>
lttng-dev@lists.lttng.org<br>
</font></tt><a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttn=
g-dev"><tt><font size=3D2>http://lists.lttng.org/cgi-bin/mailman/listinfo/l=
ttng-dev</font></tt></a><tt><font size=3D2><br>
</font></tt>
<br>
--=_alternative 0022B16BC2257CAE_=--



--===============1722103768==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1722103768==--
