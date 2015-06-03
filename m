From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [LTTNG-TOOLS PATCH 2/2] Test the viewer detach
	command
Date: Wed, 3 Jun 2015 12:04:04 +0200
Message-ID: <CA+jJMxv4a8Pt-5P55e2ZTf_ka5sL36N_bWLuqSc4j06g3s6jng__13155.067273374$1433325922$gmane$org@mail.gmail.com>
References: <1427389072-3763-1-git-send-email-jdesfossez@efficios.com>
 <1427389072-3763-2-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0414007306=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-la0-f52.google.com ([209.85.215.52])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1Z05Wr-0004Vc-9F
 for lttng-dev@lists.lttng.org; Wed, 03 Jun 2015 06:04:11 -0400
Received: by labpy14 with SMTP id py14so4080178lab.0
 for <lttng-dev@lists.lttng.org>; Wed, 03 Jun 2015 03:04:05 -0700 (PDT)
In-Reply-To: <1427389072-3763-2-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--===============0414007306==
Content-Type: multipart/alternative; boundary=089e0160b6f0d77cad05179a2dfc

--089e0160b6f0d77cad05179a2dfc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2015 at 5:57 PM, Julien Desfossez <jdesfossez@efficios.com>
wrote:

> Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
> ---
>  tests/regression/tools/live/live_test.c | 64
> ++++++++++++++++++++++++++++++++-
>  1 file changed, 63 insertions(+), 1 deletion(-)
>
> diff --git a/tests/regression/tools/live/live_test.c
> b/tests/regression/tools/live/live_test.c
> index e30c391..8d718f6 100644
> --- a/tests/regression/tools/live/live_test.c
> +++ b/tests/regression/tools/live/live_test.c
> @@ -50,7 +50,7 @@
>  #define LIVE_TIMER 2000000
>
>  /* Number of TAP tests in this file */
> -#define NUM_TESTS 8
> +#define NUM_TESTS 11
>  #define mmap_size 524288
>
>  int ust_consumerd32_fd;
> @@ -257,6 +257,59 @@ error:
>         return ret;
>  }
>
> +int detach_viewer_session(uint64_t id)
> +{
> +       struct lttng_viewer_cmd cmd;
> +       struct lttng_viewer_detach_session_response resp;
> +       struct lttng_viewer_detach_session_request rq;
> +       int ret;
> +       ssize_t ret_len;
> +
> +       cmd.cmd =3D htobe32(LTTNG_VIEWER_DETACH_SESSION);
> +       cmd.data_size =3D sizeof(rq);
> +       cmd.cmd_version =3D 0;
> +
> +       memset(&rq, 0, sizeof(rq));
> +       rq.session_id =3D htobe64(id);
> +
> +       do {
> +               ret_len =3D send(control_sock, &cmd, sizeof(cmd), 0);
> +       } while (ret_len < 0 && errno =3D=3D EINTR);
> +       if (ret_len < 0) {
> +               fprintf(stderr, "[error] Error sending cmd\n");
> +               ret =3D ret_len;
> +               goto error;
> +       }
> +       assert(ret_len =3D=3D sizeof(cmd));
>

Please fail the test without asserting if this happens.


> +       do {
> +               ret =3D send(control_sock, &rq, sizeof(rq), 0);
> +       } while (ret < 0 && errno =3D=3D EINTR);
> +       if (ret < 0) {
> +               fprintf(stderr, "Error sending attach request\n");
> +               goto error;
> +       }
> +
> +       do {
> +               ret_len =3D recv(control_sock, &resp, sizeof(resp), 0);
> +       } while (ret_len < 0 && errno =3D=3D EINTR);
> +       if (ret_len < 0) {
> +               fprintf(stderr, "[error] Error receiving detach session
> reply\n");
> +               ret =3D ret_len;
> +               goto error;
> +       }
> +       assert(ret_len =3D=3D sizeof(resp));
>

Same here.

Thanks!
J=C3=A9r=C3=A9mie

+
> +       if (be32toh(resp.status) !=3D LTTNG_VIEWER_DETACH_SESSION_OK) {
> +               fprintf(stderr, "[error] Error detaching viewer
> session\n");
> +               ret =3D -1;
> +               goto error;
> +       }
> +       ret =3D 0;
> +
> +error:
> +       return ret;
> +}
> +
>  int attach_session(int id)
>  {
>         struct lttng_viewer_cmd cmd;
> @@ -643,5 +696,14 @@ int main(int argc, char **argv)
>                         first_packet_stream_id, first_packet_offset,
>                         first_packet_len);
>
> +       ret =3D detach_viewer_session(session_id);
> +       ok(ret =3D=3D 0, "Detach viewer session");
> +
> +       ret =3D list_sessions(&session_id);
> +       ok(ret > 0, "List sessions : %d session(s)", ret);
> +
> +       ret =3D attach_session(session_id);
> +       ok(ret > 0, "Attach to session, %d streams received", ret);
> +
>         return exit_status();
>  }
> --
> 1.9.1
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--089e0160b6f0d77cad05179a2dfc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Thu, Mar 26, 2015 at 5:57 PM, Julien Desfossez <span dir=3D"ltr">&lt=
;<a href=3D"mailto:jdesfossez@efficios.com" target=3D"_blank">jdesfossez@ef=
ficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Signed-o=
ff-by: Julien Desfossez &lt;<a href=3D"mailto:jdesfossez@efficios.com">jdes=
fossez@efficios.com</a>&gt;<br>
---<br>
=C2=A0tests/regression/tools/live/live_test.c | 64 ++++++++++++++++++++++++=
++++++++-<br>
=C2=A01 file changed, 63 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/tests/regression/tools/live/live_test.c b/tests/regression/too=
ls/live/live_test.c<br>
index e30c391..8d718f6 100644<br>
--- a/tests/regression/tools/live/live_test.c<br>
+++ b/tests/regression/tools/live/live_test.c<br>
@@ -50,7 +50,7 @@<br>
=C2=A0#define LIVE_TIMER 2000000<br>
<br>
=C2=A0/* Number of TAP tests in this file */<br>
-#define NUM_TESTS 8<br>
+#define NUM_TESTS 11<br>
=C2=A0#define mmap_size 524288<br>
<br>
=C2=A0int ust_consumerd32_fd;<br>
@@ -257,6 +257,59 @@ error:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
=C2=A0}<br>
<br>
+int detach_viewer_session(uint64_t id)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct lttng_viewer_cmd cmd;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct lttng_viewer_detach_session_response res=
p;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct lttng_viewer_detach_session_request rq;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ssize_t ret_len;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0cmd.cmd =3D htobe32(LTTNG_VIEWER_DETACH_SESSION=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0cmd.data_size =3D sizeof(rq);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0cmd.cmd_version =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0memset(&amp;rq, 0, sizeof(rq));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rq.session_id =3D htobe64(id);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0do {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret_len =3D send(co=
ntrol_sock, &amp;cmd, sizeof(cmd), 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} while (ret_len &lt; 0 &amp;&amp; errno =3D=3D=
 EINTR);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret_len &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &qu=
ot;[error] Error sending cmd\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D ret_len;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0assert(ret_len =3D=3D sizeof(cmd));<br></blockq=
uote><div><br></div><div>Please fail the test without asserting if this hap=
pens.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0do {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D send(contro=
l_sock, &amp;rq, sizeof(rq), 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} while (ret &lt; 0 &amp;&amp; errno =3D=3D EIN=
TR);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &qu=
ot;Error sending attach request\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0do {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret_len =3D recv(co=
ntrol_sock, &amp;resp, sizeof(resp), 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} while (ret_len &lt; 0 &amp;&amp; errno =3D=3D=
 EINTR);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret_len &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &qu=
ot;[error] Error receiving detach session reply\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D ret_len;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0assert(ret_len =3D=3D sizeof(resp));<br>
</blockquote><div><br></div><div>Same here.</div><div>=C2=A0</div><div>Than=
ks!</div><div>J=C3=A9r=C3=A9mie</div><div><br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (be32toh(resp.status) !=3D LTTNG_VIEWER_DETA=
CH_SESSION_OK) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &qu=
ot;[error] Error detaching viewer session\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D 0;<br>
+<br>
+error:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+}<br>
+<br>
=C2=A0int attach_session(int id)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct lttng_viewer_cmd cmd;<br>
@@ -643,5 +696,14 @@ int main(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 first_packet_stream_id, first_packet_offset,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 first_packet_len);<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D detach_viewer_session(session_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ok(ret =3D=3D 0, &quot;Detach viewer session&qu=
ot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D list_sessions(&amp;session_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ok(ret &gt; 0, &quot;List sessions : %d session=
(s)&quot;, ret);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D attach_session(session_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ok(ret &gt; 0, &quot;Attach to session, %d stre=
ams received&quot;, ret);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return exit_status();<br>
=C2=A0}<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.9.1<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS In=
c.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://www.effi=
cios.com</a></div>
</div></div>

--089e0160b6f0d77cad05179a2dfc--


--===============0414007306==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0414007306==--
