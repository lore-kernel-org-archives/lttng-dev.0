From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [LTTNG-TOOLS PATCH] Fix: only cleanup the
 agent_apps_ht_by_sock as root
Date: Thu, 30 Jul 2015 12:53:07 -0400
Message-ID: <CA+jJMxtDov8wEtZp=T3+2LRieRjAcfMQ6WxESgzaw+Gj1KhfKw__21177.386903628$1438275273$gmane$org@mail.gmail.com>
References: <1438269157-1473-1-git-send-email-jdesfossez@efficios.com>
 <CA+jJMxtq7wLdQnf8QH97hY9=1f5jcs6O9dpKTkghxP5w=FktPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1333158289=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZKr4z-0005nx-Ml
 for lttng-dev@lists.lttng.org; Thu, 30 Jul 2015 12:53:24 -0400
Received: by pdbbh15 with SMTP id bh15so27144643pdb.1
 for <lttng-dev@lists.lttng.org>; Thu, 30 Jul 2015 09:53:08 -0700 (PDT)
In-Reply-To: <CA+jJMxtq7wLdQnf8QH97hY9=1f5jcs6O9dpKTkghxP5w=FktPQ@mail.gmail.com>
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

--===============1333158289==
Content-Type: multipart/alternative; boundary=047d7bdc18a6aafc25051c1a89e8

--047d7bdc18a6aafc25051c1a89e8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Here is my proposed fix. Can you test it on your end?

https://github.com/jgalar/lttng-tools/commits/sessiond-agent-crash

commit 5e249e09a2bd68f96e546bf83b4710596518f675
Author: J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@efficios.com>
Date:   Thu Jul 30 12:48:52 2015 -0400

    Clean-up: Move agent_apps_ht_by_sock definition to main.c

    Signed-off-by: J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@efficios.=
com>

commit 1af8b99faa625033f9e0c2a6eaa9b3006cfadadd
Author: J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@efficios.com>
Date:   Thu Jul 30 12:46:56 2015 -0400

    Fix: Initialize global agent_apps_ht_by_sock on session daemon launch

    Signed-off-by: J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@efficios.=
com>


J=C3=A9r=C3=A9mie


On Thu, Jul 30, 2015 at 12:02 PM, J=C3=A9r=C3=A9mie Galarneau <
jeremie.galarneau@efficios.com> wrote:

>
>
> On Thu, Jul 30, 2015 at 11:12 AM, Julien Desfossez <
> jdesfossez@efficios.com> wrote:
>
>> Commit 6a4e403927ffef4cae8726064dcf53c463eb128c introduced a bug where
>> we could end up iterating over the agent_apps_ht_by_sock regardless if
>> it was allocated or not (only when the sessiond is launched as root).
>>
>> Steps to reproduce:
>> $ sudo lttng-sessiond -d
>> $ lttng-sessiond
>> Error: Already running daemon.
>> Segmentation fault (core dumped)
>>
>> Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
>> ---
>>  src/bin/lttng-sessiond/main.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main=
.c
>> index 91dd047..5840165 100644
>> --- a/src/bin/lttng-sessiond/main.c
>> +++ b/src/bin/lttng-sessiond/main.c
>> @@ -677,7 +677,9 @@ static void sessiond_cleanup(void)
>>         }
>>
>>         DBG("Cleaning up all agent apps");
>> -       agent_app_ht_clean();
>> +       if (is_root) {
>> +               agent_app_ht_clean();
>> +       }
>>
>>
> This will leak the hash table if the session daemon was launched as an
> unprivileged user. However, the problem can also be reproduced by launchi=
ng
> two session daemons under the same unprivileged user.
>
> The real issue here seems to be that the session daemon will enter the
> "exit_init_data" code path before creating the hash table if it can't
> acquire the lock file and that there are no NULL checks performed during
> the sessiond_cleanup().
>
> Thanks,
> J=C3=A9r=C3=A9mie
>
>
>>         DBG("Closing all UST sockets");
>>         ust_app_clean_list();
>> --
>> 1.9.1
>>
>>
>
>
> --
> J=C3=A9r=C3=A9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
>



--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--047d7bdc18a6aafc25051c1a89e8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Here is my proposed fix. Can you test it on your end?=
<br></div><div><br></div><div><a href=3D"https://github.com/jgalar/lttng-to=
ols/commits/sessiond-agent-crash">https://github.com/jgalar/lttng-tools/com=
mits/sessiond-agent-crash</a><br></div><div><br></div><div><div>commit 5e24=
9e09a2bd68f96e546bf83b4710596518f675</div><div>Author: J=C3=A9r=C3=A9mie Ga=
larneau &lt;<a href=3D"mailto:jeremie.galarneau@efficios.com">jeremie.galar=
neau@efficios.com</a>&gt;</div><div>Date: =C2=A0 Thu Jul 30 12:48:52 2015 -=
0400</div><div><br></div><div>=C2=A0 =C2=A0 Clean-up: Move agent_apps_ht_by=
_sock definition to main.c</div><div>=C2=A0 =C2=A0=C2=A0</div><div>=C2=A0 =
=C2=A0 Signed-off-by: J=C3=A9r=C3=A9mie Galarneau &lt;<a href=3D"mailto:jer=
emie.galarneau@efficios.com">jeremie.galarneau@efficios.com</a>&gt;</div><d=
iv><br></div><div>commit 1af8b99faa625033f9e0c2a6eaa9b3006cfadadd</div><div=
>Author: J=C3=A9r=C3=A9mie Galarneau &lt;<a href=3D"mailto:jeremie.galarnea=
u@efficios.com">jeremie.galarneau@efficios.com</a>&gt;</div><div>Date: =C2=
=A0 Thu Jul 30 12:46:56 2015 -0400</div><div><br></div><div>=C2=A0 =C2=A0 F=
ix: Initialize global agent_apps_ht_by_sock on session daemon launch</div><=
div>=C2=A0 =C2=A0=C2=A0</div><div>=C2=A0 =C2=A0 Signed-off-by: J=C3=A9r=C3=
=A9mie Galarneau &lt;<a href=3D"mailto:jeremie.galarneau@efficios.com">jere=
mie.galarneau@efficios.com</a>&gt;</div></div><div><br></div><div><br></div=
><div>J=C3=A9r=C3=A9mie</div><div><br></div></div><div class=3D"gmail_extra=
"><br><div class=3D"gmail_quote">On Thu, Jul 30, 2015 at 12:02 PM, J=C3=A9r=
=C3=A9mie Galarneau <span dir=3D"ltr">&lt;<a href=3D"mailto:jeremie.galarne=
au@efficios.com" target=3D"_blank">jeremie.galarneau@efficios.com</a>&gt;</=
span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><br><div cl=
ass=3D"gmail_extra"><br><div class=3D"gmail_quote"><span class=3D"">On Thu,=
 Jul 30, 2015 at 11:12 AM, Julien Desfossez <span dir=3D"ltr">&lt;<a href=
=3D"mailto:jdesfossez@efficios.com" target=3D"_blank">jdesfossez@efficios.c=
om</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Commit 6a4e40392=
7ffef4cae8726064dcf53c463eb128c introduced a bug where<br>
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
om" target=3D"_blank">jdesfossez@efficios.com</a>&gt;<br>
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
<br></blockquote><div><br></div></span><div>This will leak the hash table i=
f the session daemon was launched as an unprivileged user. However, the pro=
blem can also be reproduced by launching two session daemons under the same=
 unprivileged user.</div><div><br></div><div>The real issue here seems to b=
e that the session daemon will enter the &quot;exit_init_data&quot; code pa=
th before creating the hash table if it can&#39;t acquire the lock file and=
 that there are no NULL checks performed during the sessiond_cleanup().</di=
v><div><br></div><div>Thanks,</div><div>J=C3=A9r=C3=A9mie</div><span class=
=3D""><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG(&quot;Closing all UST sockets&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ust_app_clean_list();<br>
<span><font color=3D"#888888">--<br>
1.9.1<br>
<br>
</font></span></blockquote></span></div><span class=3D"HOEnZb"><font color=
=3D"#888888"><br><br clear=3D"all"><div><br></div>-- <br><div>J=C3=A9r=C3=
=A9mie Galarneau<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" ta=
rget=3D"_blank">http://www.efficios.com</a></div>
</font></span></div></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS Inc.<br><a hre=
f=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.com</a>=
</div>
</div>

--047d7bdc18a6aafc25051c1a89e8--


--===============1333158289==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1333158289==--
