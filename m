From: Sandeep K Chaudhary <babbusandy2006@gmail.com>
Subject: Re: Working on some bugs
Date: Thu, 13 Mar 2014 23:47:04 -0700
Message-ID: <CAEEAEzV0XASr=H9e2HCVW0UJq2x=MU7UKRbXbyhcKt9DsBcawg__39235.136510297$1394779679$gmane$org@mail.gmail.com>
References: <CAEEAEzWcPk788kF=BptjeGsG=hrWyeK1tcUAM4Fq9GAwZYPXhQ@mail.gmail.com>
	<20140311162201.GE7727@thessa>
	<CAEEAEzX3KOz0JDGGee20f2CBtFuPhrRUX2m2hzhut5WObGVBuw@mail.gmail.com>
	<20140312142646.GA10776@thessa>
	<CAEEAEzXcwbJbv_izsQjL9VTUja2kUj+d_r9iufeqSN4GJvV4Fg@mail.gmail.com>
	<20140313144431.GA8473@thessa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0160213515=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <babbusandy2006@gmail.com>) id 1WOLte-0003NX-Ip
	for lttng-dev@lists.lttng.org; Fri, 14 Mar 2014 02:47:11 -0400
Received: by mail-qc0-f169.google.com with SMTP id i17so2427045qcy.28
	for <lttng-dev@lists.lttng.org>; Thu, 13 Mar 2014 23:47:05 -0700 (PDT)
In-Reply-To: <20140313144431.GA8473@thessa>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0160213515==
Content-Type: multipart/alternative; boundary=001a1139b87617943104f48b705f

--001a1139b87617943104f48b705f
Content-Type: text/plain; charset=ISO-8859-1

Hi David,

What about the following changes?

1071a1072,1079
>
> bool check_conn_version(struct relay_connection *conn, uint32_t major,
uint32_t minor) {
> if((conn->major == major) && (conn->minor == minor))
> return true;
>
> return false;
> }
>
1097,1103c1105
< switch (conn->minor) {
< case 1:
< case 2:
< case 3:
< break;
< case 4: /* LTTng sessiond 2.4 */
< default:
---
> if(check_conn_version(conn, conn->major, 4))
1105d1106
< }
1185,1193c1186,1191
< switch (conn->minor) {
< case 1: /* LTTng sessiond 2.1 */
< ret = cmd_recv_stream_2_1(conn, stream);
< break;
< case 2: /* LTTng sessiond 2.2 */
< default:
< ret = cmd_recv_stream_2_2(conn, stream);
< break;
< }
---
>         if(check_conn_version(conn, conn->major, 1))
>                 ret = cmd_recv_stream_2_1(conn, stream);
>
>         else if(check_conn_version(conn, conn->major, 2))
>                 ret = cmd_recv_stream_2_2(conn, stream);
>

On Thu, Mar 13, 2014 at 7:44 AM, David Goulet <dgoulet@efficios.com> wrote:

> On 12 Mar (22:59:20), Sandeep K Chaudhary wrote:
> > Thanks for pointing it to me, David !
> >
> > However I see the following in relay_add_stream in main.c
> >
> >         switch (conn->minor) {
> >         case 1: /* LTTng sessiond 2.1 */
> >                 ret = cmd_recv_stream_2_1(conn, stream);
> >                 break;
> >         case 2: /* LTTng sessiond 2.2 */
> >         default:
> >                 ret = cmd_recv_stream_2_2(conn, stream);
> >                 break;
> >         }
> >
> > This means that it's calling either 'cmd_recv_stream_2_1' or
> > 'cmd_recv_stream_2_2' depending on the minor version number. Is this not
> we
> > want? Though I don't understand why it should be calling
> > 'cmd_recv_stream_2_2' for minor versions other than 1. Is this correct
> > behavior?
>
> Yes so for now only the minor version matter since a major number other
> than 2 can't be negotiated during the send_version step (the first thing
> the relayd receives for a connection).
>

 In the proposed changes, we simply call the version checker function with
the same major version as in conn. In future, the calls can be made with
desired major and minor version numbers.


>
> At some point in time, we would need to check the major number to here
> so calling cmd_recv_stream_2_2(...) would make more sense. Maybe it's
> something you want to do here before anything, adding a layer that
> checks major + minor and calls the right one? Something that could be
> generic enough so we don't have those ugly switch cases in each
> command... ?
>

 Yes, I understand. And this would make the checking generic and better
than switch statements. Please see the proposed changes and let me know
what you think about it. Though, I have deliberately not taken care of the
'default' case in earlier switch statements. I am not convinced
why cmd_create_session_2_4 (in relay_create_session)
and cmd_recv_stream_2_2 ( in relay_add_stream) should be called in default
cases.

 Thanks and regards,
Sandeep.

--001a1139b87617943104f48b705f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi David,<div><br></div><div>What about the following chan=
ges?</div><div><br></div><div><div>1071a1072,1079</div><div>&gt;=A0</div><d=
iv>&gt; bool check_conn_version(struct relay_connection *conn, uint32_t maj=
or, uint32_t minor) {</div>
<div>&gt; <span class=3D"" style=3D"white-space:pre">	</span>if((conn-&gt;m=
ajor =3D=3D major) &amp;&amp; (conn-&gt;minor =3D=3D minor))</div><div>&gt;=
 <span class=3D"" style=3D"white-space:pre">		</span>return true;</div><div=
>&gt;=A0</div>
<div>&gt; <span class=3D"" style=3D"white-space:pre">	</span>return false;<=
/div><div>&gt; }</div><div>&gt;=A0</div><div>1097,1103c1105</div><div>&lt; =
<span class=3D"" style=3D"white-space:pre">	</span>switch (conn-&gt;minor) =
{</div>
<div>&lt; <span class=3D"" style=3D"white-space:pre">	</span>case 1:</div><=
div>&lt; <span class=3D"" style=3D"white-space:pre">	</span>case 2:</div><d=
iv>&lt; <span class=3D"" style=3D"white-space:pre">	</span>case 3:</div><di=
v>&lt; <span class=3D"" style=3D"white-space:pre">		</span>break;</div>
<div>&lt; <span class=3D"" style=3D"white-space:pre">	</span>case 4: /* LTT=
ng sessiond 2.4 */</div><div>&lt; <span class=3D"" style=3D"white-space:pre=
">	</span>default:</div><div>---</div><div>&gt; <span class=3D"" style=3D"w=
hite-space:pre">	</span>if(check_conn_version(conn, conn-&gt;major, 4))</di=
v>
<div>1105d1106</div><div>&lt; <span class=3D"" style=3D"white-space:pre">	<=
/span>}</div><div>1185,1193c1186,1191</div><div>&lt; <span class=3D"" style=
=3D"white-space:pre">	</span>switch (conn-&gt;minor) {</div><div>&lt; <span=
 class=3D"" style=3D"white-space:pre">	</span>case 1: /* LTTng sessiond 2.1=
 */</div>
<div>&lt; <span class=3D"" style=3D"white-space:pre">		</span>ret =3D cmd_r=
ecv_stream_2_1(conn, stream);</div><div>&lt; <span class=3D"" style=3D"whit=
e-space:pre">		</span>break;</div><div>&lt; <span class=3D"" style=3D"white=
-space:pre">	</span>case 2: /* LTTng sessiond 2.2 */</div>
<div>&lt; <span class=3D"" style=3D"white-space:pre">	</span>default:</div>=
<div>&lt; <span class=3D"" style=3D"white-space:pre">		</span>ret =3D cmd_r=
ecv_stream_2_2(conn, stream);</div><div>&lt; <span class=3D"" style=3D"whit=
e-space:pre">		</span>break;</div>
<div>&lt; <span class=3D"" style=3D"white-space:pre">	</span>}</div><div>--=
-</div><div>&gt; =A0 =A0 =A0 =A0 if(check_conn_version(conn, conn-&gt;major=
, 1))</div><div>&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D cmd_recv_strea=
m_2_1(conn, stream);</div>
<div>&gt;=A0</div><div>&gt; =A0 =A0 =A0 =A0 else if(check_conn_version(conn=
, conn-&gt;major, 2))</div><div>&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =
=3D cmd_recv_stream_2_2(conn, stream);</div><div>&gt;=A0</div></div><div cl=
ass=3D"gmail_extra"><br><div class=3D"gmail_quote">
On Thu, Mar 13, 2014 at 7:44 AM, David Goulet <span dir=3D"ltr">&lt;<a href=
=3D"mailto:dgoulet@efficios.com" target=3D"_blank">dgoulet@efficios.com</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);bor=
der-left-style:solid;padding-left:1ex">
<div class=3D""><div class=3D"h5">On 12 Mar (22:59:20), Sandeep K Chaudhary=
 wrote:<br>
&gt; Thanks for pointing it to me, David !<br>
&gt;<br>
&gt; However I see the following in relay_add_stream in main.c<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 switch (conn-&gt;minor) {<br>
&gt; =A0 =A0 =A0 =A0 case 1: /* LTTng sessiond 2.1 */<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D cmd_recv_stream_2_1(conn, stre=
am);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
&gt; =A0 =A0 =A0 =A0 case 2: /* LTTng sessiond 2.2 */<br>
&gt; =A0 =A0 =A0 =A0 default:<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D cmd_recv_stream_2_2(conn, stre=
am);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
&gt; =A0 =A0 =A0 =A0 }<br>
&gt;<br>
&gt; This means that it&#39;s calling either &#39;cmd_recv_stream_2_1&#39; =
or<br>
&gt; &#39;cmd_recv_stream_2_2&#39; depending on the minor version number. I=
s this not we<br>
&gt; want? Though I don&#39;t understand why it should be calling<br>
&gt; &#39;cmd_recv_stream_2_2&#39; for minor versions other than 1. Is this=
 correct<br>
&gt; behavior?<br>
<br>
</div></div>Yes so for now only the minor version matter since a major numb=
er other<br>
than 2 can&#39;t be negotiated during the send_version step (the first thin=
g<br>
the relayd receives for a connection).<br></blockquote><div><br></div><div>=
=A0In the proposed changes, we simply call the version checker function wit=
h the same major version as in conn. In future, the calls can be made with =
desired major and minor version numbers.</div>
<div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left=
-style:solid;padding-left:1ex">
<br>
At some point in time, we would need to check the major number to here<br>
so calling cmd_recv_stream_2_2(...) would make more sense. Maybe it&#39;s<b=
r>
something you want to do here before anything, adding a layer that<br>
checks major + minor and calls the right one? Something that could be<br>
generic enough so we don&#39;t have those ugly switch cases in each<br>
command... ?<br></blockquote><div><br></div><div>=A0Yes, I understand. And =
this would make the checking generic and better than switch statements. Ple=
ase see the proposed changes and let me know what you think about it. Thoug=
h, I have deliberately not taken care of the &#39;default&#39; case in earl=
ier switch statements. I am not convinced why=A0cmd_create_session_2_4 (in=
=A0relay_create_session) and=A0cmd_recv_stream_2_2 ( in=A0relay_add_stream)=
 should be called in default cases.</div>
<div><br></div><div>=A0Thanks and regards,</div><div>Sandeep.</div></div></=
div></div>

--001a1139b87617943104f48b705f--


--===============0160213515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0160213515==--
