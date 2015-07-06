From: Aravind HT <aravind.ht@gmail.com>
Subject: Re: [RFC PATCH lttng-tools] Fix: metadata push -EPIPE
	should be recoverable
Date: Mon, 6 Jul 2015 22:12:38 +0530
Message-ID: <CACd+_b5JdeMZ58PPLAK=8+4BWqy4-XPZ3DenbJ9CqcRk-XWOLg__39505.6996531368$1436201041$gmane$org@mail.gmail.com>
References: <1436199666-10305-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0029606467=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-la0-f43.google.com ([209.85.215.43])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <aravind.ht@gmail.com>) id 1ZC9Tg-0008Vy-IR
 for lttng-dev@lists.lttng.org; Mon, 06 Jul 2015 12:42:53 -0400
Received: by lagx9 with SMTP id x9so162580148lag.1
 for <lttng-dev@lists.lttng.org>; Mon, 06 Jul 2015 09:42:38 -0700 (PDT)
In-Reply-To: <1436199666-10305-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

--===============0029606467==
Content-Type: multipart/alternative; boundary=089e0158c78af8ff5f051a3797a8

--089e0158c78af8ff5f051a3797a8
Content-Type: text/plain; charset=UTF-8

In case of -EPIPE, im thinking if we can send LTTNG_ERR_UND or some other
error back to the consumer for it to do any relevant clean up.

On Mon, Jul 6, 2015 at 9:51 PM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> This return value can be caused by application terminating concurrently
> (when using per-PID buffers), so it should not make the consumer
> management thread exit.
>
> CC: Aravind HT <aravind.ht@gmail.com>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  src/bin/lttng-sessiond/ust-app.c      | 13 ++++++++++---
>  src/bin/lttng-sessiond/ust-consumer.c |  7 +++++--
>  2 files changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/src/bin/lttng-sessiond/ust-app.c
> b/src/bin/lttng-sessiond/ust-app.c
> index c30792c..6f032da 100644
> --- a/src/bin/lttng-sessiond/ust-app.c
> +++ b/src/bin/lttng-sessiond/ust-app.c
> @@ -431,6 +431,9 @@ void delete_ust_app_channel(int sock, struct
> ust_app_channel *ua_chan,
>   * Must be called with the registry lock held.
>   *
>   * On success, return the len of metadata pushed or else a negative value.
> + * Returning a -EPIPE return value means we could not send the metadata,
> + * but it can be caused by recoverable errors (e.g. the application has
> + * terminated concurrently).
>   */
>  ssize_t ust_app_push_metadata(struct ust_registry_session *registry,
>                 struct consumer_socket *socket, int send_zero_data)
> @@ -454,9 +457,10 @@ ssize_t ust_app_push_metadata(struct
> ust_registry_session *registry,
>         /*
>          * On a push metadata error either the consumer is dead or the
>          * metadata channel has been destroyed because its endpoint
> -        * might have died (e.g: relayd). If so, the metadata closed
> -        * flag is set to 1 so we deny pushing metadata again which is
> -        * not valid anymore on the consumer side.
> +        * might have died (e.g: relayd), or because the application has
> +        * exited. If so, the metadata closed flag is set to 1 so we
> +        * deny pushing metadata again which is not valid anymore on the
> +        * consumer side.
>          */
>         if (registry->metadata_closed) {
>                 return -EPIPE;
> @@ -547,6 +551,9 @@ error_push:
>   * of socket throughout this function.
>   *
>   * Return 0 on success else a negative error.
> + * Returning a -EPIPE return value means we could not send the metadata,
> + * but it can be caused by recoverable errors (e.g. the application has
> + * terminated concurrently).
>   */
>  static int push_metadata(struct ust_registry_session *registry,
>                 struct consumer_output *consumer)
> diff --git a/src/bin/lttng-sessiond/ust-consumer.c
> b/src/bin/lttng-sessiond/ust-consumer.c
> index 78e50df..ad076e3 100644
> --- a/src/bin/lttng-sessiond/ust-consumer.c
> +++ b/src/bin/lttng-sessiond/ust-consumer.c
> @@ -511,12 +511,15 @@ int ust_consumer_metadata_request(struct
> consumer_socket *socket)
>         pthread_mutex_lock(&ust_reg->lock);
>         ret_push = ust_app_push_metadata(ust_reg, socket, 1);
>         pthread_mutex_unlock(&ust_reg->lock);
> -       if (ret_push < 0) {
> +       if (ret_push == -EPIPE) {
> +               DBG("Application or relay closed while pushing metadata");
> +       } else if (ret_push < 0) {
>                 ERR("Pushing metadata");
>                 ret = -1;
>                 goto end;
> +       } else {
> +               DBG("UST Consumer metadata pushed successfully");
>         }
> -       DBG("UST Consumer metadata pushed successfully");
>         ret = 0;
>
>  end:
> --
> 2.1.4
>
>

--089e0158c78af8ff5f051a3797a8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">In case of -EPIPE, im thinking if we can send=C2=A0<span s=
tyle=3D"color:rgb(0,0,0);white-space:pre-wrap">LTTNG_ERR_UND or some other =
error back to the consumer for it to do any relevant clean up.</span></div>=
<div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Mon, Jul 6, 20=
15 at 9:51 PM, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:ma=
thieu.desnoyers@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.=
com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">This return val=
ue can be caused by application terminating concurrently<br>
(when using per-PID buffers), so it should not make the consumer<br>
management thread exit.<br>
<br>
CC: Aravind HT &lt;<a href=3D"mailto:aravind.ht@gmail.com">aravind.ht@gmail=
.com</a>&gt;<br>
Signed-off-by: Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@ef=
ficios.com">mathieu.desnoyers@efficios.com</a>&gt;<br>
---<br>
=C2=A0src/bin/lttng-sessiond/ust-app.c=C2=A0 =C2=A0 =C2=A0 | 13 ++++++++++-=
--<br>
=C2=A0src/bin/lttng-sessiond/ust-consumer.c |=C2=A0 7 +++++--<br>
=C2=A02 files changed, 15 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-=
app.c<br>
index c30792c..6f032da 100644<br>
--- a/src/bin/lttng-sessiond/ust-app.c<br>
+++ b/src/bin/lttng-sessiond/ust-app.c<br>
@@ -431,6 +431,9 @@ void delete_ust_app_channel(int sock, struct ust_app_ch=
annel *ua_chan,<br>
=C2=A0 * Must be called with the registry lock held.<br>
=C2=A0 *<br>
=C2=A0 * On success, return the len of metadata pushed or else a negative v=
alue.<br>
+ * Returning a -EPIPE return value means we could not send the metadata,<b=
r>
+ * but it can be caused by recoverable errors (e.g. the application has<br=
>
+ * terminated concurrently).<br>
=C2=A0 */<br>
=C2=A0ssize_t ust_app_push_metadata(struct ust_registry_session *registry,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct consumer_soc=
ket *socket, int send_zero_data)<br>
@@ -454,9 +457,10 @@ ssize_t ust_app_push_metadata(struct ust_registry_sess=
ion *registry,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* On a push metadata error either the con=
sumer is dead or the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* metadata channel has been destroyed bec=
ause its endpoint<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * might have died (e.g: relayd). If so, the me=
tadata closed<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * flag is set to 1 so we deny pushing metadata=
 again which is<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * not valid anymore on the consumer side.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * might have died (e.g: relayd), or because th=
e application has<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * exited. If so, the metadata closed flag is s=
et to 1 so we<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * deny pushing metadata again which is not val=
id anymore on the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * consumer side.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (registry-&gt;metadata_closed) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EPIPE;<br>
@@ -547,6 +551,9 @@ error_push:<br>
=C2=A0 * of socket throughout this function.<br>
=C2=A0 *<br>
=C2=A0 * Return 0 on success else a negative error.<br>
+ * Returning a -EPIPE return value means we could not send the metadata,<b=
r>
+ * but it can be caused by recoverable errors (e.g. the application has<br=
>
+ * terminated concurrently).<br>
=C2=A0 */<br>
=C2=A0static int push_metadata(struct ust_registry_session *registry,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct consumer_out=
put *consumer)<br>
diff --git a/src/bin/lttng-sessiond/ust-consumer.c b/src/bin/lttng-sessiond=
/ust-consumer.c<br>
index 78e50df..ad076e3 100644<br>
--- a/src/bin/lttng-sessiond/ust-consumer.c<br>
+++ b/src/bin/lttng-sessiond/ust-consumer.c<br>
@@ -511,12 +511,15 @@ int ust_consumer_metadata_request(struct consumer_soc=
ket *socket)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pthread_mutex_lock(&amp;ust_reg-&gt;lock);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret_push =3D ust_app_push_metadata(ust_reg, soc=
ket, 1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pthread_mutex_unlock(&amp;ust_reg-&gt;lock);<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret_push &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret_push =3D=3D -EPIPE) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DBG(&quot;Applicati=
on or relay closed while pushing metadata&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (ret_push &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ERR(&quot;Pushing m=
etadata&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DBG(&quot;UST Consu=
mer metadata pushed successfully&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG(&quot;UST Consumer metadata pushed successf=
ully&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D 0;<br>
<br>
=C2=A0end:<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.1.4<br>
<br>
</font></span></blockquote></div><br></div>

--089e0158c78af8ff5f051a3797a8--


--===============0029606467==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0029606467==--
