From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [LTTNG-TOOLS PATCH] Fix: only cleanup the
 agent_apps_ht_by_sock as root
Date: Thu, 30 Jul 2015 12:02:59 -0400
Message-ID: <CA+jJMxtq7wLdQnf8QH97hY9=1f5jcs6O9dpKTkghxP5w=FktPQ__10024.5301182897$1438272250$gmane$org@mail.gmail.com>
References: <1438269157-1473-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0397469148=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZKqIT-0005Xh-6k
 for lttng-dev@lists.lttng.org; Thu, 30 Jul 2015 12:03:09 -0400
Received: by pdbbh15 with SMTP id bh15so26523154pdb.1
 for <lttng-dev@lists.lttng.org>; Thu, 30 Jul 2015 09:02:59 -0700 (PDT)
In-Reply-To: <1438269157-1473-1-git-send-email-jdesfossez@efficios.com>
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

--===============0397469148==
Content-Type: multipart/alternative; boundary=047d7bfe945c5921ae051c19d689

--047d7bfe945c5921ae051c19d689
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2015 at 11:12 AM, Julien Desfossez <jdesfossez@efficios.com=
>
wrote:

> Commit 6a4e403927ffef4cae8726064dcf53c463eb128c introduced a bug where
> we could end up iterating over the agent_apps_ht_by_sock regardless if
> it was allocated or not (only when the sessiond is launched as root).
>
> Steps to reproduce:
> $ sudo lttng-sessiond -d
> $ lttng-sessiond
> Error: Already running daemon.
> Segmentation fault (core dumped)
>
> Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
> ---
>  src/bin/lttng-sessiond/main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.=
c
> index 91dd047..5840165 100644
> --- a/src/bin/lttng-sessiond/main.c
> +++ b/src/bin/lttng-sessiond/main.c
> @@ -677,7 +677,9 @@ static void sessiond_cleanup(void)
>         }
>
>         DBG("Cleaning up all agent apps");
> -       agent_app_ht_clean();
> +       if (is_root) {
> +               agent_app_ht_clean();
> +       }
>
>
This will leak the hash table if the session daemon was launched as an
unprivileged user. However, the problem can also be reproduced by launching
two session daemons under the same unprivileged user.

The real issue here seems to be that the session daemon will enter the
"exit_init_data" code path before creating the hash table if it can't
acquire the lock file and that there are no NULL checks performed during
the sessiond_cleanup().

Thanks,
J=C3=A9r=C3=A9mie


>         DBG("Closing all UST sockets");
>         ust_app_clean_list();
> --
> 1.9.1
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--047d7bfe945c5921ae051c19d689
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Thu, Jul 30, 2015 at 11:12 AM, Julien Desfossez <span dir=3D"ltr">&l=
t;<a href=3D"mailto:jdesfossez@efficios.com" target=3D"_blank">jdesfossez@e=
fficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Commit =
6a4e403927ffef4cae8726064dcf53c463eb128c introduced a bug where<br>
we could end up iterating over the agent_apps_ht_by_sock regardless if<br>
it was allocated or not (only when the sessiond is launched as root).<br>
<br>
Steps to reproduce:<br>
$ sudo lttng-sessiond -d<br>
$ lttng-sessiond<br>
Error: Already running daemon.<br>
Segmentation fault (core dumped)<br>
<br>
Signed-off-by: Julien Desfossez &lt;<a href=3D"mailto:jdesfossez@efficios.c=
om">jdesfossez@efficios.com</a>&gt;<br>
---<br>
=C2=A0src/bin/lttng-sessiond/main.c | 4 +++-<br>
=C2=A01 file changed, 3 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c<=
br>
index 91dd047..5840165 100644<br>
--- a/src/bin/lttng-sessiond/main.c<br>
+++ b/src/bin/lttng-sessiond/main.c<br>
@@ -677,7 +677,9 @@ static void sessiond_cleanup(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG(&quot;Cleaning up all agent apps&quot;);<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0agent_app_ht_clean();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (is_root) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0agent_app_ht_clean(=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br></blockquote><div><br></div><div>This will leak the hash table if the s=
ession daemon was launched as an unprivileged user. However, the problem ca=
n also be reproduced by launching two session daemons under the same unpriv=
ileged user.</div><div><br></div><div>The real issue here seems to be that =
the session daemon will enter the &quot;exit_init_data&quot; code path befo=
re creating the hash table if it can&#39;t acquire the lock file and that t=
here are no NULL checks performed during the sessiond_cleanup().</div><div>=
<br></div><div>Thanks,</div><div>J=C3=A9r=C3=A9mie</div><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG(&quot;Closing all UST sockets&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ust_app_clean_list();<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.9.1<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS In=
c.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://www.effi=
cios.com</a></div>
</div></div>

--047d7bfe945c5921ae051c19d689--


--===============0397469148==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0397469148==--
