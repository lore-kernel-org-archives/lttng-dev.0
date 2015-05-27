From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: destroy session removes
 the default config file
Date: Wed, 27 May 2015 12:32:30 -0400
Message-ID: <CA+jJMxtQ-=CXzXpA_eaY8ogwDjYp8hGxH=HRns+UixF15PLWmg__20719.1391069957$1432744440$gmane$org@mail.gmail.com>
References: <87h9r7yt1m.fsf@hahabo.in>
 <CA+jJMxsMHrN7D7XhAte8jSn9=yd2+aSvJM9e5jNexTYaexXcLg@mail.gmail.com>
 <87r3q3yl5g.fsf@hahabo.in>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1537116489=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1YxeFw-00051J-3x
 for lttng-dev@lists.lttng.org; Wed, 27 May 2015 12:32:44 -0400
Received: by qkoo18 with SMTP id o18so8827054qko.1
 for <lttng-dev@lists.lttng.org>; Wed, 27 May 2015 09:32:30 -0700 (PDT)
In-Reply-To: <87r3q3yl5g.fsf@hahabo.in>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Partha Pratim Mukherjee <ppm.floss@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1537116489==
Content-Type: multipart/alternative; boundary=001a113ea656135b9c051712cadb

--001a113ea656135b9c051712cadb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Partha,

CC-ing lttng-dev and inlining your patch to ease the review... Read on.

> diff --git a/src/bin/lttng/commands/destroy.c
b/src/bin/lttng/commands/destroy.c
> index 95343c9..2d1200f 100644
> --- a/src/bin/lttng/commands/destroy.c
> +++ b/src/bin/lttng/commands/destroy.c
> @@ -75,6 +75,7 @@ static void usage(FILE *ofp)
>  static int destroy_session(struct lttng_session *session)
>  {
>   int ret;
> + char *session_name =3D NULL;
>
>   ret =3D lttng_destroy_session(session->name);
>   if (ret < 0) {
> @@ -90,7 +91,18 @@ static int destroy_session(struct lttng_session
*session)
>   }
>
>   MSG("Session %s destroyed", session->name);
> - config_destroy_default();
> +
> + session_name =3D get_session_name();
> + if (session_name =3D=3D NULL) {
> + ret =3D CMD_ERROR;
> + goto error;
> + }
> +

This may not be an error.
get_session_name() will return NULL whenever a default session is not
defined. This will happen, for instance, when loading a session
configuration.

The test_load script, under lttng-tools/tests/regression/tools/save-load
will perform:

$ lttng load -i load-42.lttng
$ lttng destroy load-42
Session load-42 destroyed
Error: Can't find valid lttng config /home/jgalar/.lttngrc
Did you create a session? (lttng create <my_session>)
Error: Command error

(make sure you delete ~/.lttngrc beforehand to test this properly)

> + if (strncmp(session->name, session_name, NAME_MAX) =3D=3D 0) {
> + config_destroy_default();
> + }
> +

We should skip this check if get_session_name() returned NULL with
something like:

if (session_name && strncmp(session->name, session_name, NAME_MAX) =3D=3D 0=
) {
...

> + free(session_name);
>
>   if (lttng_opt_mi) {
>   ret =3D mi_lttng_session(writer, session, 0);
> diff --git a/src/bin/lttng/conf.c b/src/bin/lttng/conf.c
> index 7e6c833..6b8bf51 100644
> --- a/src/bin/lttng/conf.c
> +++ b/src/bin/lttng/conf.c
> @@ -199,8 +199,6 @@ char *config_read_session_name(char *path)
>
>   fp =3D open_config(path, "r");
>   if (fp =3D=3D NULL) {
> - ERR("Can't find valid lttng config %s/.lttngrc", path);
> - MSG("Did you create a session? (lttng create <my_session>)");
>   free(session_name);
>   goto error;
>   }
> diff --git a/src/bin/lttng/utils.c b/src/bin/lttng/utils.c
> index ef8d023..d6e854b 100644
> --- a/src/bin/lttng/utils.c
> +++ b/src/bin/lttng/utils.c
> @@ -59,6 +59,8 @@ char *get_session_name(void)
>   /* Get session name from config */
>   session_name =3D config_read_session_name(path);
>   if (session_name =3D=3D NULL) {
> + ERR("Can't find valid lttng config %s/.lttngrc", path);
> + MSG("Did you create a session? (lttng create <my_session>)");
>   goto error;
>   }

get_session_name() should not log this when an .lttngrc file can't be
found; it might not be an error.
It should be handled on a case-by-case basis by its callers.

Thanks,
J=C3=A9r=C3=A9mie

>
> --
> 1.7.9.5
>


On Tue, May 26, 2015 at 1:15 AM, Partha Pratim Mukherjee <
ppm.floss@gmail.com> wrote:

> J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@efficios.com> writes:
>
> > Hi Partha,
> >
> > First, thanks for the patch! Unfortunately, there are a couple of issue=
s
> with this fix. Read on.
> >
> > On Wed, May 20, 2015 at 2:59 PM, Partha Pratim Mukherjee <
> ppm.floss@gmail.com> wrote:
> >
> >     Destroy session command by default removes the default config file
> >     without checking the current session. As a result when we call any
> >     other command which expects a default session by calling
> >     get_session_name() function, it fails.
> >
> >     This patch will fix this by checking that the default config file
> gets
> >     removed only when destroy session is called with the current sessio=
n.
> >
> >     Fixes: #887
> >
> >     Signed-off-by: Partha Pratim Mukherjee <ppm.floss@gmail.com>
> >     ---
> >      src/bin/lttng/commands/destroy.c |    4 +++-
> >      1 file changed, 3 insertions(+), 1 deletion(-)
> >
> >     diff --git a/src/bin/lttng/commands/destroy.c
> b/src/bin/lttng/commands/destroy.c
> >     index 95343c9..3fcecc2 100644
> >     --- a/src/bin/lttng/commands/destroy.c
> >     +++ b/src/bin/lttng/commands/destroy.c
> >     @@ -90,7 +90,9 @@ static int destroy_session(struct lttng_session
> *session)
> >             }
> >
> >             MSG("Session %s destroyed", session->name);
> >     -       config_destroy_default();
> >     +       if (strncmp(session->name, get_session_name(), NAME_MAX) =
=3D=3D
> 0) {
> >
> > This will leak the string returned by get_session_name().
> >
> > Moreover, config_read_session_name(), which is called
> by get_session_name() will spam the error logs anytime an .lttngrc file
> can't be found;
> > the error logging statement should be moved out to the different caller=
s.
> >
> > Looking forward to a v2!
> > J=C3=A9r=C3=A9mie
>
> Hi J=C3=A9r=C3=A9mie,
>
> Thanks for the review comments. I have incorporated your comments in the
> attached patch. Please review.
>
> Thanks,
> Partha
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--001a113ea656135b9c051712cadb
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Partha,<div><br></div><div>CC-ing lttng-dev and inlinin=
g your patch to ease the review... Read on.</div><div><br></div><div><div>&=
gt; diff --git a/src/bin/lttng/commands/destroy.c b/src/bin/lttng/commands/=
destroy.c</div><div>&gt; index 95343c9..2d1200f 100644</div><div>&gt; --- a=
/src/bin/lttng/commands/destroy.c</div><div>&gt; +++ b/src/bin/lttng/comman=
ds/destroy.c</div><div>&gt; @@ -75,6 +75,7 @@ static void usage(FILE *ofp)<=
/div><div>&gt; =C2=A0static int destroy_session(struct lttng_session *sessi=
on)</div><div>&gt; =C2=A0{</div><div>&gt; =C2=A0<span class=3D"" style=3D"w=
hite-space:pre">	</span>int ret;</div><div>&gt; +<span class=3D"" style=3D"=
white-space:pre">	</span>char *session_name =3D NULL;</div><div>&gt; =C2=A0=
</div><div>&gt; =C2=A0<span class=3D"" style=3D"white-space:pre">	</span>re=
t =3D lttng_destroy_session(session-&gt;name);</div><div>&gt; =C2=A0<span c=
lass=3D"" style=3D"white-space:pre">	</span>if (ret &lt; 0) {</div><div>&gt=
; @@ -90,7 +91,18 @@ static int destroy_session(struct lttng_session *sessi=
on)</div><div>&gt; =C2=A0<span class=3D"" style=3D"white-space:pre">	</span=
>}</div><div>&gt; =C2=A0</div><div>&gt; =C2=A0<span class=3D"" style=3D"whi=
te-space:pre">	</span>MSG(&quot;Session %s destroyed&quot;, session-&gt;nam=
e);</div><div>&gt; -<span class=3D"" style=3D"white-space:pre">	</span>conf=
ig_destroy_default();</div><div>&gt; +</div><div>&gt; +<span class=3D"" sty=
le=3D"white-space:pre">	</span>session_name =3D get_session_name();</div><d=
iv>&gt; +<span class=3D"" style=3D"white-space:pre">	</span>if (session_nam=
e =3D=3D NULL) {</div><div>&gt; +<span class=3D"" style=3D"white-space:pre"=
>		</span>ret =3D CMD_ERROR;</div><div>&gt; +<span class=3D"" style=3D"whit=
e-space:pre">		</span>goto error;</div><div>&gt; +<span class=3D"" style=3D=
"white-space:pre">	</span>}</div><div>&gt; +</div><div><br></div><div>This =
may not be an error.</div><div>get_session_name() will return NULL whenever=
 a default session is not defined. This will happen, for instance, when loa=
ding a session configuration.</div><div><br></div><div>The test_load script=
, under=C2=A0lttng-tools/tests/regression/tools/save-load will perform:</di=
v><div><br></div><div>$ lttng load -i load-42.lttng</div><div><div>$ lttng =
destroy load-42</div><div>Session load-42 destroyed</div><div>Error: Can&#3=
9;t find valid lttng config /home/jgalar/.lttngrc</div><div>Did you create =
a session? (lttng create &lt;my_session&gt;)</div><div>Error: Command error=
</div></div><div><br></div><div>(make sure you delete ~/.lttngrc beforehand=
 to test this properly)</div><div><br></div><div>&gt; +<span class=3D"" sty=
le=3D"white-space:pre">	</span>if (strncmp(session-&gt;name, session_name, =
NAME_MAX) =3D=3D 0) {</div><div>&gt; +<span class=3D"" style=3D"white-space=
:pre">		</span>config_destroy_default();</div><div>&gt; +<span class=3D"" s=
tyle=3D"white-space:pre">	</span>}</div><div>&gt; +</div><div><br></div><di=
v>We should skip this check if get_session_name() returned NULL with someth=
ing like:</div><div><br></div><div>if (session_name &amp;&amp; strncmp(sess=
ion-&gt;name, session_name, NAME_MAX) =3D=3D 0) { ...</div><div><br></div><=
div>&gt; +<span class=3D"" style=3D"white-space:pre">	</span>free(session_n=
ame);</div><div>&gt; =C2=A0</div><div>&gt; =C2=A0<span class=3D"" style=3D"=
white-space:pre">	</span>if (lttng_opt_mi) {</div><div>&gt; =C2=A0<span cla=
ss=3D"" style=3D"white-space:pre">		</span>ret =3D mi_lttng_session(writer,=
 session, 0);</div><div>&gt; diff --git a/src/bin/lttng/conf.c b/src/bin/lt=
tng/conf.c</div><div>&gt; index 7e6c833..6b8bf51 100644</div><div>&gt; --- =
a/src/bin/lttng/conf.c</div><div>&gt; +++ b/src/bin/lttng/conf.c</div><div>=
&gt; @@ -199,8 +199,6 @@ char *config_read_session_name(char *path)</div><d=
iv>&gt; =C2=A0</div><div>&gt; =C2=A0<span class=3D"" style=3D"white-space:p=
re">	</span>fp =3D open_config(path, &quot;r&quot;);</div><div>&gt; =C2=A0<=
span class=3D"" style=3D"white-space:pre">	</span>if (fp =3D=3D NULL) {</di=
v><div>&gt; -<span class=3D"" style=3D"white-space:pre">		</span>ERR(&quot;=
Can&#39;t find valid lttng config %s/.lttngrc&quot;, path);</div><div>&gt; =
-<span class=3D"" style=3D"white-space:pre">		</span>MSG(&quot;Did you crea=
te a session? (lttng create &lt;my_session&gt;)&quot;);</div><div>&gt; =C2=
=A0<span class=3D"" style=3D"white-space:pre">		</span>free(session_name);<=
/div><div>&gt; =C2=A0<span class=3D"" style=3D"white-space:pre">		</span>go=
to error;</div><div>&gt; =C2=A0<span class=3D"" style=3D"white-space:pre">	=
</span>}</div><div>&gt; diff --git a/src/bin/lttng/utils.c b/src/bin/lttng/=
utils.c</div><div>&gt; index ef8d023..d6e854b 100644</div><div>&gt; --- a/s=
rc/bin/lttng/utils.c</div><div>&gt; +++ b/src/bin/lttng/utils.c</div><div>&=
gt; @@ -59,6 +59,8 @@ char *get_session_name(void)</div><div>&gt; =C2=A0<sp=
an class=3D"" style=3D"white-space:pre">	</span>/* Get session name from co=
nfig */</div><div>&gt; =C2=A0<span class=3D"" style=3D"white-space:pre">	</=
span>session_name =3D config_read_session_name(path);</div><div>&gt; =C2=A0=
<span class=3D"" style=3D"white-space:pre">	</span>if (session_name =3D=3D =
NULL) {</div><div>&gt; +<span class=3D"" style=3D"white-space:pre">		</span=
>ERR(&quot;Can&#39;t find valid lttng config %s/.lttngrc&quot;, path);</div=
><div>&gt; +<span class=3D"" style=3D"white-space:pre">		</span>MSG(&quot;D=
id you create a session? (lttng create &lt;my_session&gt;)&quot;);</div><di=
v>&gt; =C2=A0<span class=3D"" style=3D"white-space:pre">		</span>goto error=
;</div><div>&gt; =C2=A0<span class=3D"" style=3D"white-space:pre">	</span>}=
</div><div><br></div><div>get_session_name() should not log this when an .l=
ttngrc file can&#39;t be found; it might not be an error.</div><div>It shou=
ld be handled on a case-by-case basis by its callers.</div><div><br></div><=
div>Thanks,</div><div>J=C3=A9r=C3=A9mie</div><div><br></div><div>&gt; =C2=
=A0</div><div>&gt; --=C2=A0</div><div>&gt; 1.7.9.5</div><div>&gt;=C2=A0</di=
v></div><div><br></div><div class=3D"gmail_extra"><br><div class=3D"gmail_q=
uote">On Tue, May 26, 2015 at 1:15 AM, Partha Pratim Mukherjee <span dir=3D=
"ltr">&lt;<a href=3D"mailto:ppm.floss@gmail.com" target=3D"_blank">ppm.flos=
s@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(2=
04,204,204);border-left-style:solid;padding-left:1ex"><div class=3D""><div =
class=3D"h5">J=C3=A9r=C3=A9mie Galarneau &lt;<a href=3D"mailto:jeremie.gala=
rneau@efficios.com">jeremie.galarneau@efficios.com</a>&gt; writes:<br>
<br>
&gt; Hi Partha,<br>
&gt;<br>
&gt; First, thanks for the patch! Unfortunately, there are a couple of issu=
es with this fix. Read on.<br>
&gt;<br>
&gt; On Wed, May 20, 2015 at 2:59 PM, Partha Pratim Mukherjee &lt;<a href=
=3D"mailto:ppm.floss@gmail.com">ppm.floss@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Destroy session command by default removes the defa=
ult config file<br>
&gt;=C2=A0 =C2=A0 =C2=A0without checking the current session. As a result w=
hen we call any<br>
&gt;=C2=A0 =C2=A0 =C2=A0other command which expects a default session by ca=
lling<br>
&gt;=C2=A0 =C2=A0 =C2=A0get_session_name() function, it fails.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0This patch will fix this by checking that the defau=
lt config file gets<br>
&gt;=C2=A0 =C2=A0 =C2=A0removed only when destroy session is called with th=
e current session.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Fixes: #887<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: Partha Pratim Mukherjee &lt;<a href=
=3D"mailto:ppm.floss@gmail.com">ppm.floss@gmail.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0---<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0src/bin/lttng/commands/destroy.c |=C2=A0 =C2=
=A0 4 +++-<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A01 file changed, 3 insertions(+), 1 deletion(-=
)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/src/bin/lttng/commands/destroy.c b/src=
/bin/lttng/commands/destroy.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0index 95343c9..3fcecc2 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/src/bin/lttng/commands/destroy.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/src/bin/lttng/commands/destroy.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -90,7 +90,9 @@ static int destroy_session(struct=
 lttng_session *session)<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 MSG(&quot;Session %s de=
stroyed&quot;, session-&gt;name);<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0config_destroy_default(=
);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (strncmp(session-&gt=
;name, get_session_name(), NAME_MAX) =3D=3D 0) {<br>
&gt;<br>
&gt; This will leak the string returned by get_session_name().<br>
&gt;<br>
&gt; Moreover, config_read_session_name(), which is called by=C2=A0get_sess=
ion_name() will spam the error logs anytime an .lttngrc file can&#39;t be f=
ound;<br>
&gt; the error logging statement should be moved out to the different calle=
rs.<br>
&gt;<br>
&gt; Looking forward to a v2!<br>
&gt; J=C3=A9r=C3=A9mie<br>
<br>
</div></div>Hi J=C3=A9r=C3=A9mie,<br>
<br>
Thanks for the review comments. I have incorporated your comments in the<br=
>
attached patch. Please review.<br>
<br>
Thanks,<br>
Partha<br>
<br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS Inc.<br><a hre=
f=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.com</a>=
</div>
</div></div>

--001a113ea656135b9c051712cadb--


--===============1537116489==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1537116489==--
