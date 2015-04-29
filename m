From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: set UST register timeout
	to -1 as test default
Date: Wed, 29 Apr 2015 11:12:44 -0400
Message-ID: <CA+jJMxukjRGWk_4hYp-EETiXYpADtzTFzpkjSzJMDoNdqqJSCg__34401.6519179151$1430320478$gmane$org@mail.gmail.com>
References: <1430230597-25836-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0976130306=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1YnTfO-0001Ez-3z
 for lttng-dev@lists.lttng.org; Wed, 29 Apr 2015 11:13:03 -0400
Received: by qcyk17 with SMTP id k17so14525114qcy.1
 for <lttng-dev@lists.lttng.org>; Wed, 29 Apr 2015 08:12:44 -0700 (PDT)
In-Reply-To: <1430230597-25836-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--===============0976130306==
Content-Type: multipart/alternative; boundary=001a11495a103c3cfd0514de6981

--001a11495a103c3cfd0514de6981
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Merged in master, 2.6 and 2.5.

Thanks!
J=C3=A9r=C3=A9mie

On Tue, Apr 28, 2015 at 10:16 AM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> On busy systems, it's possible to spuriously hit the default 3 seconds
> timeout for UST registration to sessiond, thus causing tests to be flaky
> on those systems.
>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  tests/utils/utils.sh | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tests/utils/utils.sh b/tests/utils/utils.sh
> index c3d8bd4..5f86ece 100644
> --- a/tests/utils/utils.sh
> +++ b/tests/utils/utils.sh
> @@ -27,6 +27,11 @@ KERNEL_MAJOR_VERSION=3D2
>  KERNEL_MINOR_VERSION=3D6
>  KERNEL_PATCHLEVEL_VERSION=3D27
>
> +# We set the default UST register timeout to "wait forever", so that
> +# basic tests don't have to worry about hitting timeouts on busy
> +# systems. Specialized tests should test those corner-cases.
> +export LTTNG_UST_REGISTER_TIMEOUT=3D-1
> +
>  source $TESTDIR/utils/tap/tap.sh
>
>  function print_ok ()
> --
> 2.1.4
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--001a11495a103c3cfd0514de6981
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Merged in master, 2.6 and 2.5.<div><br></div><div>Thanks!<=
/div><div>J=C3=A9r=C3=A9mie</div></div><div class=3D"gmail_extra"><br><div =
class=3D"gmail_quote">On Tue, Apr 28, 2015 at 10:16 AM, Mathieu Desnoyers <=
span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" targ=
et=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;</span> wrote:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">On busy systems, it&#39;s possible to spuriously =
hit the default 3 seconds<br>
timeout for UST registration to sessiond, thus causing tests to be flaky<br=
>
on those systems.<br>
<br>
Signed-off-by: Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@ef=
ficios.com">mathieu.desnoyers@efficios.com</a>&gt;<br>
---<br>
=C2=A0tests/utils/utils.sh | 5 +++++<br>
=C2=A01 file changed, 5 insertions(+)<br>
<br>
diff --git a/tests/utils/utils.sh b/tests/utils/utils.sh<br>
index c3d8bd4..5f86ece 100644<br>
--- a/tests/utils/utils.sh<br>
+++ b/tests/utils/utils.sh<br>
@@ -27,6 +27,11 @@ KERNEL_MAJOR_VERSION=3D2<br>
=C2=A0KERNEL_MINOR_VERSION=3D6<br>
=C2=A0KERNEL_PATCHLEVEL_VERSION=3D27<br>
<br>
+# We set the default UST register timeout to &quot;wait forever&quot;, so =
that<br>
+# basic tests don&#39;t have to worry about hitting timeouts on busy<br>
+# systems. Specialized tests should test those corner-cases.<br>
+export LTTNG_UST_REGISTER_TIMEOUT=3D-1<br>
+<br>
=C2=A0source $TESTDIR/utils/tap/tap.sh<br>
<br>
=C2=A0function print_ok ()<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.1.4<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS In=
c.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://www.effi=
cios.com</a></div>
</div>

--001a11495a103c3cfd0514de6981--


--===============0976130306==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0976130306==--
