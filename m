From: Sandeep K Chaudhary <babbusandy2006@gmail.com>
Subject: Re: Working on some bugs
Date: Sun, 16 Mar 2014 22:22:50 -0700
Message-ID: <CAEEAEzWXCTQcpynzJhQWodE35X3EYeJchjvwutVUqmZU4rs+Kg__36450.0839649283$1395033842$gmane$org@mail.gmail.com>
References: <CAEEAEzWcPk788kF=BptjeGsG=hrWyeK1tcUAM4Fq9GAwZYPXhQ@mail.gmail.com>
	<20140311162201.GE7727@thessa>
	<CAEEAEzX3KOz0JDGGee20f2CBtFuPhrRUX2m2hzhut5WObGVBuw@mail.gmail.com>
	<20140312142646.GA10776@thessa>
	<CAEEAEzXcwbJbv_izsQjL9VTUja2kUj+d_r9iufeqSN4GJvV4Fg@mail.gmail.com>
	<20140313144431.GA8473@thessa>
	<CAEEAEzV0XASr=H9e2HCVW0UJq2x=MU7UKRbXbyhcKt9DsBcawg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2093920753=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <babbusandy2006@gmail.com>) id 1WPQ0o-0002Uu-O2
	for lttng-dev@lists.lttng.org; Mon, 17 Mar 2014 01:23:01 -0400
Received: by mail-qg0-f47.google.com with SMTP id 63so15306816qgz.6
	for <lttng-dev@lists.lttng.org>; Sun, 16 Mar 2014 22:22:52 -0700 (PDT)
In-Reply-To: <CAEEAEzV0XASr=H9e2HCVW0UJq2x=MU7UKRbXbyhcKt9DsBcawg@mail.gmail.com>
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

--===============2093920753==
Content-Type: multipart/alternative; boundary=001a11c300a65c014304f4c69c36

--001a11c300a65c014304f4c69c36
Content-Type: text/plain; charset=ISO-8859-1

Dear David,

Can you please reply?

Thanks,
Sandeep.

On Thu, Mar 13, 2014 at 11:47 PM, Sandeep K Chaudhary <
babbusandy2006@gmail.com> wrote:

> Hi David,
>
> What about the following changes?
>
> 1071a1072,1079
> >
> > bool check_conn_version(struct relay_connection *conn, uint32_t major,
> uint32_t minor) {
> > if((conn->major == major) && (conn->minor == minor))
> > return true;
> >
> > return false;
> > }
> >
> 1097,1103c1105
> < switch (conn->minor) {
> < case 1:
> < case 2:
> < case 3:
> < break;
> < case 4: /* LTTng sessiond 2.4 */
> < default:
> ---
> > if(check_conn_version(conn, conn->major, 4))
> 1105d1106
> < }
> 1185,1193c1186,1191
> < switch (conn->minor) {
> < case 1: /* LTTng sessiond 2.1 */
> < ret = cmd_recv_stream_2_1(conn, stream);
> < break;
> < case 2: /* LTTng sessiond 2.2 */
> < default:
> < ret = cmd_recv_stream_2_2(conn, stream);
> < break;
> < }
> ---
> >         if(check_conn_version(conn, conn->major, 1))
> >                 ret = cmd_recv_stream_2_1(conn, stream);
> >
> >         else if(check_conn_version(conn, conn->major, 2))
> >                 ret = cmd_recv_stream_2_2(conn, stream);
> >
>
> On Thu, Mar 13, 2014 at 7:44 AM, David Goulet <dgoulet@efficios.com>wrote:
>
>> On 12 Mar (22:59:20), Sandeep K Chaudhary wrote:
>> > Thanks for pointing it to me, David !
>> >
>> > However I see the following in relay_add_stream in main.c
>> >
>> >         switch (conn->minor) {
>> >         case 1: /* LTTng sessiond 2.1 */
>> >                 ret = cmd_recv_stream_2_1(conn, stream);
>> >                 break;
>> >         case 2: /* LTTng sessiond 2.2 */
>> >         default:
>> >                 ret = cmd_recv_stream_2_2(conn, stream);
>> >                 break;
>> >         }
>> >
>> > This means that it's calling either 'cmd_recv_stream_2_1' or
>> > 'cmd_recv_stream_2_2' depending on the minor version number. Is this
>> not we
>> > want? Though I don't understand why it should be calling
>> > 'cmd_recv_stream_2_2' for minor versions other than 1. Is this correct
>> > behavior?
>>
>> Yes so for now only the minor version matter since a major number other
>> than 2 can't be negotiated during the send_version step (the first thing
>> the relayd receives for a connection).
>>
>
>  In the proposed changes, we simply call the version checker function with
> the same major version as in conn. In future, the calls can be made with
> desired major and minor version numbers.
>
>
>>
>> At some point in time, we would need to check the major number to here
>> so calling cmd_recv_stream_2_2(...) would make more sense. Maybe it's
>> something you want to do here before anything, adding a layer that
>> checks major + minor and calls the right one? Something that could be
>> generic enough so we don't have those ugly switch cases in each
>> command... ?
>>
>
>  Yes, I understand. And this would make the checking generic and better
> than switch statements. Please see the proposed changes and let me know
> what you think about it. Though, I have deliberately not taken care of the
> 'default' case in earlier switch statements. I am not convinced
> why cmd_create_session_2_4 (in relay_create_session)
> and cmd_recv_stream_2_2 ( in relay_add_stream) should be called in default
> cases.
>
>  Thanks and regards,
> Sandeep.
>



-- 
Thanks and regards,
Sandeep K Chaudhary.

--001a11c300a65c014304f4c69c36
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear David,<div><br></div><div>Can you please reply?</div>=
<div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Thanks,<br>=
Sandeep.<br><br><div class=3D"gmail_quote">On Thu, Mar 13, 2014 at 11:47 PM=
, Sandeep K Chaudhary <span dir=3D"ltr">&lt;<a href=3D"mailto:babbusandy200=
6@gmail.com" target=3D"_blank">babbusandy2006@gmail.com</a>&gt;</span> wrot=
e:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr">Hi David,<div><br></div><di=
v>What about the following changes?</div><div><br></div><div><div>1071a1072=
,1079</div>
<div>&gt;=A0</div><div>&gt; bool check_conn_version(struct relay_connection=
 *conn, uint32_t major, uint32_t minor) {</div>
<div>&gt; <span style=3D"white-space:pre-wrap">	</span>if((conn-&gt;major =
=3D=3D major) &amp;&amp; (conn-&gt;minor =3D=3D minor))</div><div>&gt; <spa=
n style=3D"white-space:pre-wrap">		</span>return true;</div><div>&gt;=A0</d=
iv>
<div>&gt; <span style=3D"white-space:pre-wrap">	</span>return false;</div><=
div>&gt; }</div><div>&gt;=A0</div><div>1097,1103c1105</div><div class=3D"">=
<div>&lt; <span style=3D"white-space:pre-wrap">	</span>switch (conn-&gt;min=
or) {</div>

<div>&lt; <span style=3D"white-space:pre-wrap">	</span>case 1:</div></div><=
div>&lt; <span style=3D"white-space:pre-wrap">	</span>case 2:</div><div>&lt=
; <span style=3D"white-space:pre-wrap">	</span>case 3:</div><div>&lt; <span=
 style=3D"white-space:pre-wrap">		</span>break;</div>

<div>&lt; <span style=3D"white-space:pre-wrap">	</span>case 4: /* LTTng ses=
siond 2.4 */</div><div>&lt; <span style=3D"white-space:pre-wrap">	</span>de=
fault:</div><div>---</div><div>&gt; <span style=3D"white-space:pre-wrap">	<=
/span>if(check_conn_version(conn, conn-&gt;major, 4))</div>

<div>1105d1106</div><div>&lt; <span style=3D"white-space:pre-wrap">	</span>=
}</div><div>1185,1193c1186,1191</div><div class=3D""><div>&lt; <span style=
=3D"white-space:pre-wrap">	</span>switch (conn-&gt;minor) {</div><div>&lt; =
<span style=3D"white-space:pre-wrap">	</span>case 1: /* LTTng sessiond 2.1 =
*/</div>

<div>&lt; <span style=3D"white-space:pre-wrap">		</span>ret =3D cmd_recv_st=
ream_2_1(conn, stream);</div><div>&lt; <span style=3D"white-space:pre-wrap"=
>		</span>break;</div><div>&lt; <span style=3D"white-space:pre-wrap">	</spa=
n>case 2: /* LTTng sessiond 2.2 */</div>

<div>&lt; <span style=3D"white-space:pre-wrap">	</span>default:</div><div>&=
lt; <span style=3D"white-space:pre-wrap">		</span>ret =3D cmd_recv_stream_2=
_2(conn, stream);</div><div>&lt; <span style=3D"white-space:pre-wrap">		</s=
pan>break;</div>

<div>&lt; <span style=3D"white-space:pre-wrap">	</span>}</div></div><div>--=
-</div><div>&gt; =A0 =A0 =A0 =A0 if(check_conn_version(conn, conn-&gt;major=
, 1))</div><div>&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D cmd_recv_strea=
m_2_1(conn, stream);</div>

<div>&gt;=A0</div><div>&gt; =A0 =A0 =A0 =A0 else if(check_conn_version(conn=
, conn-&gt;major, 2))</div><div>&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =
=3D cmd_recv_stream_2_2(conn, stream);</div><div>&gt;=A0</div></div><div cl=
ass=3D"gmail_extra"><br><div class=3D"gmail_quote">
<div class=3D"">
On Thu, Mar 13, 2014 at 7:44 AM, David Goulet <span dir=3D"ltr">&lt;<a href=
=3D"mailto:dgoulet@efficios.com" target=3D"_blank">dgoulet@efficios.com</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);bor=
der-left-style:solid;padding-left:1ex">

<div><div>On 12 Mar (22:59:20), Sandeep K Chaudhary wrote:<br>
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
the relayd receives for a connection).<br></blockquote><div><br></div></div=
><div>=A0In the proposed changes, we simply call the version checker functi=
on with the same major version as in conn. In future, the calls can be made=
 with desired major and minor version numbers.</div>
<div class=3D"">
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
command... ?<br></blockquote><div><br></div></div><div>=A0Yes, I understand=
. And this would make the checking generic and better than switch statement=
s. Please see the proposed changes and let me know what you think about it.=
 Though, I have deliberately not taken care of the &#39;default&#39; case i=
n earlier switch statements. I am not convinced why=A0cmd_create_session_2_=
4 (in=A0relay_create_session) and=A0cmd_recv_stream_2_2 ( in=A0relay_add_st=
ream) should be called in default cases.</div>

<div><br></div><div>=A0Thanks and regards,</div><div>Sandeep.</div></div></=
div></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>Thanks and r=
egards,<br>Sandeep K Chaudhary.
</div></div>

--001a11c300a65c014304f4c69c36--


--===============2093920753==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2093920753==--
