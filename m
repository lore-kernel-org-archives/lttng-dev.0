From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: destroy session removes
 the default config file
Date: Wed, 27 May 2015 14:53:41 -0400
Message-ID: <CA+jJMxsJNzy294Stve-ajKJzk_8eFFRvW_ObNs-t2kpCcz0jnQ__49659.4882607043$1432752910$gmane$org@mail.gmail.com>
References: <87h9r7yt1m.fsf@hahabo.in>
 <CA+jJMxsMHrN7D7XhAte8jSn9=yd2+aSvJM9e5jNexTYaexXcLg@mail.gmail.com>
 <87r3q3yl5g.fsf@hahabo.in>
 <CA+jJMxtQ-=CXzXpA_eaY8ogwDjYp8hGxH=HRns+UixF15PLWmg@mail.gmail.com>
 <87k2vtyl6u.fsf@hahabo.in>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0362538721=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1YxgSZ-0005ja-G7
 for lttng-dev@lists.lttng.org; Wed, 27 May 2015 14:53:56 -0400
Received: by qkhg32 with SMTP id g32so11299724qkh.0
 for <lttng-dev@lists.lttng.org>; Wed, 27 May 2015 11:53:42 -0700 (PDT)
In-Reply-To: <87k2vtyl6u.fsf@hahabo.in>
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

--===============0362538721==
Content-Type: multipart/alternative; boundary=001a11c16580028829051714c3c0

--001a11c16580028829051714c3c0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2015 at 1:39 PM, Partha Pratim Mukherjee <
ppm.floss@gmail.com> wrote:

> J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@efficios.com> writes:
>
> ...
> > This may not be an error.
> > get_session_name() will return NULL whenever a default session is not
> defined. This will happen, for instance, when loading a session
> > configuration.
> >
> > The test_load script, under lttng-tools/tests/regression/tools/save-loa=
d
> will perform:
> >
> > $ lttng load -i load-42.lttng
> > $ lttng destroy load-42
> > Session load-42 destroyed
> > Error: Can't find valid lttng config /home/jgalar/.lttngrc
> > Did you create a session? (lttng create <my_session>)
> > Error: Command error
> >
> > (make sure you delete ~/.lttngrc beforehand to test this properly)
> >
> >> + if (strncmp(session->name, session_name, NAME_MAX) =3D=3D 0) {
> >> + config_destroy_default();
> >> + }
> >> +
> >
> > We should skip this check if get_session_name() returned NULL with
> something like:
> >
> > if (session_name && strncmp(session->name, session_name, NAME_MAX) =3D=
=3D 0)
> { ...
> >
>
> I did not know about load option which may load single/multiple sessions
> from a file. So we can't set a default session. I agree on your
> suggestion. This may be handled like this.
>
>         session_name =3D get_session_name();
>
>         if (session_name && strncmp(session->name, session_name, NAME_MAX=
)
> =3D=3D 0) {
>                 config_destroy_default();
>         }
>
>         free(session_name);
>
> >
> > get_session_name() should not log this when an .lttngrc file can't be
> found; it might not be an error.
> > It should be handled on a case-by-case basis by its callers.
> >
>
> Now if we remove the error messages from get_session_name() as you have
> suggested, then we have to handle other commands which are looking for a
> default session like enable-event which now gives a very generic error
> message like this
>
> Error: Command error
>
> So we have to add error messages on all those commands which are expectin=
g
> a default session. As per the help message the following commands need to
> be modified.
>
> destroy, disable-channel, disable-event, enable-channel, enable-event,
> save, snapshot, start, stop, track, untrack, view
>
> If yes, then I will create another patch and send.
>
> What do you suggest?
>
>
Sounds good to me. Thanks!

J=C3=A9r=C3=A9mie


> Thanks,
> Partha
>
> > Thanks,
> > J=C3=A9r=C3=A9mie
> >
>



--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--001a11c16580028829051714c3c0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Wed, May 27, 2015 at 1:39 PM, Partha Pratim Mukherjee <span dir=3D"l=
tr">&lt;<a href=3D"mailto:ppm.floss@gmail.com" target=3D"_blank">ppm.floss@=
gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">J=C3=A9r=
=C3=A9mie Galarneau &lt;<a href=3D"mailto:jeremie.galarneau@efficios.com">j=
eremie.galarneau@efficios.com</a>&gt; writes:<br>
<br>
...<br>
<span class=3D"">&gt; This may not be an error.<br>
&gt; get_session_name() will return NULL whenever a default session is not =
defined. This will happen, for instance, when loading a session<br>
&gt; configuration.<br>
&gt;<br>
&gt; The test_load script, under=C2=A0lttng-tools/tests/regression/tools/sa=
ve-load will perform:<br>
&gt;<br>
&gt; $ lttng load -i load-42.lttng<br>
&gt; $ lttng destroy load-42<br>
&gt; Session load-42 destroyed<br>
&gt; Error: Can&#39;t find valid lttng config /home/jgalar/.lttngrc<br>
&gt; Did you create a session? (lttng create &lt;my_session&gt;)<br>
&gt; Error: Command error<br>
&gt;<br>
&gt; (make sure you delete ~/.lttngrc beforehand to test this properly)<br>
&gt;<br>
&gt;&gt; + if (strncmp(session-&gt;name, session_name, NAME_MAX) =3D=3D 0) =
{<br>
&gt;&gt; + config_destroy_default();<br>
&gt;&gt; + }<br>
&gt;&gt; +<br>
&gt;<br>
&gt; We should skip this check if get_session_name() returned NULL with som=
ething like:<br>
&gt;<br>
&gt; if (session_name &amp;&amp; strncmp(session-&gt;name, session_name, NA=
ME_MAX) =3D=3D 0) { ...<br>
&gt;<br>
<br>
</span>I did not know about load option which may load single/multiple sess=
ions<br>
from a file. So we can&#39;t set a default session. I agree on your<br>
suggestion. This may be handled like this.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 session_name =3D get_session_name();<br>
<span class=3D""><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (session_name &amp;&amp; strncmp(session-&gt=
;name, session_name, NAME_MAX) =3D=3D 0) {<br>
</span>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 config_destr=
oy_default();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 free(session_name);<br>
<span class=3D""><br>
&gt;<br>
&gt; get_session_name() should not log this when an .lttngrc file can&#39;t=
 be found; it might not be an error.<br>
&gt; It should be handled on a case-by-case basis by its callers.<br>
&gt;<br>
<br>
</span>Now if we remove the error messages from get_session_name() as you h=
ave<br>
suggested, then we have to handle other commands which are looking for a<br=
>
default session like enable-event which now gives a very generic error<br>
message like this<br>
<br>
Error: Command error<br>
<br>
So we have to add error messages on all those commands which are expecting<=
br>
a default session. As per the help message the following commands need to<b=
r>
be modified.<br>
<br>
destroy, disable-channel, disable-event, enable-channel, enable-event,<br>
save, snapshot, start, stop, track, untrack, view<br>
<br>
If yes, then I will create another patch and send.<br>
<br>
What do you suggest?<br>
<br></blockquote><div><br></div><div>Sounds good to me. Thanks!</div><div><=
br></div><div>J=C3=A9r=C3=A9mie</div><div>=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">
Thanks,<br>
Partha<br>
<br>
&gt; Thanks,<br>
&gt; J=C3=A9r=C3=A9mie<br>
&gt;<br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS Inc.<br><a hre=
f=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.com</a>=
</div>
</div></div>

--001a11c16580028829051714c3c0--


--===============0362538721==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0362538721==--
