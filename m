From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: test_mi test
Date: Thu, 6 Aug 2015 16:38:25 -0400
Message-ID: <CA+jJMxuSfvaHSZbgwdWSXv3SFLhgY7OSzE-Trm_xKuSBEO_1Ng__29280.3713855848$1438893555$gmane$org@mail.gmail.com>
References: <1438890757-29800-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1613734783=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f171.google.com ([209.85.160.171])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZNRvt-0006uE-4W
 for lttng-dev@lists.lttng.org; Thu, 06 Aug 2015 16:38:34 -0400
Received: by ykcq64 with SMTP id q64so67848820ykc.2
 for <lttng-dev@lists.lttng.org>; Thu, 06 Aug 2015 13:38:25 -0700 (PDT)
In-Reply-To: <1438890757-29800-1-git-send-email-mathieu.desnoyers@efficios.com>
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

--===============1613734783==
Content-Type: multipart/alternative; boundary=94eb2c0885be479f15051caa8008

--94eb2c0885be479f15051caa8008
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Merged in master, stable-2.7 and stable-2.6, thanks!

J=C3=A9r=C3=A9mie

On Thu, Aug 6, 2015 at 3:52 PM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  tests/regression/tools/mi/test_mi | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/tests/regression/tools/mi/test_mi
> b/tests/regression/tools/mi/test_mi
> index a5c7493..5bd29ed 100755
> --- a/tests/regression/tools/mi/test_mi
> +++ b/tests/regression/tools/mi/test_mi
> @@ -27,8 +27,8 @@ RELAYD_BIN=3D"lttng-relayd"
>  TESTAPP_PATH=3D"$TESTDIR/utils/testapp"
>  TESTAPP_NAME=3D"gen-ust-events"
>  TESTAPP_BIN=3D"$TESTAPP_PATH/$TESTAPP_NAME/$TESTAPP_NAME"
> -NR_USEC_WAIT=3D10000
> -
> +NR_USEC_WAIT=3D0
> +NR_ITER=3D10000
>
>  #Temp file output
>  OUTPUT_DIR=3D$(mktemp -d)
> @@ -500,14 +500,25 @@ function test_list_session ()
>
>  function test_list_ust_event ()
>  {
> +       local file_sync_after_first=3D$(mktemp -u)
> +       local file_sync_before_last=3D$(mktemp -u)
> +
>         OUTPUT_FILE=3D"list_ust_event.xml"
>
>         #Test buid up
>         OUTPUT_DEST=3D$OUTPUT_DIR/$OUTPUT_FILE
>
>         #Begin testing
> -       $TESTAPP_BIN $NR_USEC_WAIT & 2>/dev/null
> +       $TESTAPP_BIN $NR_ITER $NR_USEC_WAIT ${file_sync_after_first}
> ${file_sync_before_last} & 2>/dev/null
> +
> +       while [ ! -f "${file_sync_after_first}" ]; do
> +               sleep 0.5
> +       done
> +
>         list_lttng_with_opts "-u -f"
> +
> +       touch ${file_sync_before_last}
> +
>         $XML_VALIDATE $OUTPUT_DEST
>         ok $? "Mi test: list ust event xsd validation"
>
> @@ -530,6 +541,9 @@ function test_list_ust_event ()
>
>         #Wait for all background processes
>         wait
> +
> +       rm -f ${file_sync_after_first}
> +       rm -f ${file_sync_before_last}
>  }
>
>  function test_start_stop () {
> --
> 2.1.4
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--94eb2c0885be479f15051caa8008
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Merged in master, stable-2.7 and stable-2.6, thanks!<div><=
br></div><div>J=C3=A9r=C3=A9mie</div></div><div class=3D"gmail_extra"><br><=
div class=3D"gmail_quote">On Thu, Aug 6, 2015 at 3:52 PM, Mathieu Desnoyers=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" ta=
rget=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;</span> wrote:<br><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">Signed-off-by: Mathieu Desnoyers &lt;<a href=3D=
"mailto:mathieu.desnoyers@efficios.com">mathieu.desnoyers@efficios.com</a>&=
gt;<br>
---<br>
=C2=A0tests/regression/tools/mi/test_mi | 20 +++++++++++++++++---<br>
=C2=A01 file changed, 17 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/tests/regression/tools/mi/test_mi b/tests/regression/tools/mi/=
test_mi<br>
index a5c7493..5bd29ed 100755<br>
--- a/tests/regression/tools/mi/test_mi<br>
+++ b/tests/regression/tools/mi/test_mi<br>
@@ -27,8 +27,8 @@ RELAYD_BIN=3D&quot;lttng-relayd&quot;<br>
=C2=A0TESTAPP_PATH=3D&quot;$TESTDIR/utils/testapp&quot;<br>
=C2=A0TESTAPP_NAME=3D&quot;gen-ust-events&quot;<br>
=C2=A0TESTAPP_BIN=3D&quot;$TESTAPP_PATH/$TESTAPP_NAME/$TESTAPP_NAME&quot;<b=
r>
-NR_USEC_WAIT=3D10000<br>
-<br>
+NR_USEC_WAIT=3D0<br>
+NR_ITER=3D10000<br>
<br>
=C2=A0#Temp file output<br>
=C2=A0OUTPUT_DIR=3D$(mktemp -d)<br>
@@ -500,14 +500,25 @@ function test_list_session ()<br>
<br>
=C2=A0function test_list_ust_event ()<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0local file_sync_after_first=3D$(mktemp -u)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0local file_sync_before_last=3D$(mktemp -u)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 OUTPUT_FILE=3D&quot;list_ust_event.xml&quot;<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 #Test buid up<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 OUTPUT_DEST=3D$OUTPUT_DIR/$OUTPUT_FILE<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 #Begin testing<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTAPP_BIN $NR_USEC_WAIT &amp; 2&gt;/dev/null=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT ${file_sync=
_after_first} ${file_sync_before_last} &amp; 2&gt;/dev/null<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0while [ ! -f &quot;${file_sync_after_first}&quo=
t; ]; do<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sleep 0.5<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0done<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 list_lttng_with_opts &quot;-u -f&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0touch ${file_sync_before_last}<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 $XML_VALIDATE $OUTPUT_DEST<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ok $? &quot;Mi test: list ust event xsd validat=
ion&quot;<br>
<br>
@@ -530,6 +541,9 @@ function test_list_ust_event ()<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 #Wait for all background processes<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 wait<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f ${file_sync_after_first}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f ${file_sync_before_last}<br>
=C2=A0}<br>
<br>
=C2=A0function test_start_stop () {<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.1.4<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS In=
c.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://www.effi=
cios.com</a></div>
</div>

--94eb2c0885be479f15051caa8008--


--===============1613734783==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1613734783==--
