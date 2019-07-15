From: Ravindra Kumar Meena <rmeena840@gmail.com>
Subject: Re: Need help with CTF
Date: Mon, 15 Jul 2019 21:07:17 +0530
Message-ID: <CAEWVvOSL0TbGYPW6bPwYrP=KHQ5bJ_mqjFs7Rp+hZThnMkfj7Q__31905.5520625383$1563205098$gmane$org@mail.gmail.com>
References: <CAEWVvOQHcvj3A=8Rufusv9Ti3aF=+yR4ZqWQFc-DpOvgVZUfvg@mail.gmail.com>
 <CAB4xu_3oTAYHrmYg5pLBy+OT0rwzmEm3G0jeWxTOPnhFKPgQVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3249643077259330601=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by lists.lttng.org (Postfix) with ESMTPS id 45nSN35Ttkz16CR
 for <lttng-dev@lists.lttng.org>; Mon, 15 Jul 2019 11:37:55 -0400 (EDT)
Received: by mail-wr1-x435.google.com with SMTP id 31so17650714wrm.1
 for <lttng-dev@lists.lttng.org>; Mon, 15 Jul 2019 08:37:55 -0700 (PDT)
In-Reply-To: <CAB4xu_3oTAYHrmYg5pLBy+OT0rwzmEm3G0jeWxTOPnhFKPgQVg@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Philippe Proulx <eeppeliteloop@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============3249643077259330601==
Content-Type: multipart/alternative; boundary="00000000000028a62e058dba0b81"

--00000000000028a62e058dba0b81
Content-Type: text/plain; charset="UTF-8"

>
> > trace {
> >     major = 1;
> >     minor = 8;
> >     uuid = "6a7715d0-b502-4c65-8678-6777ac7f755a";
> >     byte_order = le;
> >     packet.header := struct {
> >         uint32_t magic;
> >         uint8_t  uuid[16];
> >         uint32_t stream_id;
> >         uint64_t stream_instance_id;
> >     };
> > };
> >
> > In the above what does stream_instance_id does? In CTF documentation [1]
> it looks like packet.header can contain three values(magic, uuid,
> stream_id) then what is stream_instance_id?
>
> This is the ID of the stream itself, whereas `stream_id` is in fact the
> ID of the class or type of stream. Many streams (one per CPU, for
> example) can share the same stream class ID (`stream_id`), but have
> different stream IDs (`stream_instance_id`).


Okay. This was very helpful. I have a doubt about packet.context.

struct packet_context {
uint64_clock_monotonic_t timestamp_begin;
uint64_clock_monotonic_t timestamp_end;
uint64_t content_size;
uint64_t packet_size;
uint64_t packet_seq_num;
unsigned long events_discarded;
uint32_t cpu_id;
};

In CTF documentation information is provided about all packet.context
members except for packet_seq_num and events_discarded. Some of them just
have the name on CTF documentation.

What are these two variables(packet_seq_num and events_discarded)?


> >
> > Please attend this ASAP
>
> Was that turnaround time good enough for you?
>
Thanks for helping me out. I am GSoC 2019 student at RTEMS. I have been
assigned a few tasks which I have to complete before 22nd July. The 2nd
evaluation will begin on 22nd July.
That's why I am in a rush. :) :)


-- 
*Ravindra Kumar Meena*,
B. Tech. Computer Science and Engineering,
Indian Institute of Technology (Indian School of Mines)
<https://www.iitism.ac.in/>, Dhanbad

--00000000000028a62e058dba0b81
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">&gt; trace {<br>
&gt;=C2=A0 =C2=A0 =C2=A0major =3D 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0minor =3D 8;<br>
&gt;=C2=A0 =C2=A0 =C2=A0uuid =3D &quot;6a7715d0-b502-4c65-8678-6777ac7f755a=
&quot;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0byte_order =3D le;<br>
&gt;=C2=A0 =C2=A0 =C2=A0packet.header :=3D struct {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t magic;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t=C2=A0 uuid[16];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t stream_id;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t stream_instance_id;<br>
&gt;=C2=A0 =C2=A0 =C2=A0};<br>
&gt; };<br>
&gt;<br>
&gt; In the above what does stream_instance_id does? In CTF documentation [=
1] it looks like packet.header can contain three values(magic, uuid, stream=
_id) then what is stream_instance_id?<br>
<br>
This is the ID of the stream itself, whereas `stream_id` is in fact the<br>
ID of the class or type of stream. Many streams (one per CPU, for<br>
example) can share the same stream class ID (`stream_id`), but have<br>
different stream IDs (`stream_instance_id`).</blockquote><div>=C2=A0</div><=
div>Okay. This was very helpful. I have a doubt about packet.context.</div>=
<div><br></div><div>struct packet_context {<br>	uint64_clock_monotonic_t ti=
mestamp_begin;<br>	uint64_clock_monotonic_t timestamp_end;<br>	uint64_t con=
tent_size;<br>	uint64_t packet_size;<br>	uint64_t packet_seq_num;<br>	unsig=
ned long events_discarded;<br>	uint32_t cpu_id;<br>};<br></div><div><br></d=
iv><div>In CTF documentation information is provided about all packet.conte=
xt members except for packet_seq_num and events_discarded. Some of them jus=
t have the name on CTF documentation.</div><div><br></div><div>What are the=
se two variables(packet_seq_num and events_discarded)?</div><div><br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;<br>
&gt; Please attend this ASAP<br>
<br>
Was that turnaround time good enough for you?<br></blockquote><div>Thanks f=
or helping me out. I am GSoC 2019 student at RTEMS. I have been assigned a =
few tasks which I have to complete before 22nd July. The 2nd evaluation wil=
l begin on 22nd July.</div><div>That&#39;s why I am in a rush. :) :)</div><=
/div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr" class=3D"m_-8=
678806957642640150gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><=
font size=3D"4"><b>Ravindra Kumar Meena</b></font>,<div><span style=3D"colo=
r:rgb(102,102,102)">B. Tech. Computer Science and Engineering,<br></span></=
div><div><span style=3D"color:rgb(102,102,102)"><a href=3D"https://www.iiti=
sm.ac.in/" style=3D"color:rgb(17,85,204)" target=3D"_blank">Indian Institut=
e of Technology (Indian School of Mines)</a>, Dhanbad</span></div></div></d=
iv></div></div></div>

--00000000000028a62e058dba0b81--

--===============3249643077259330601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3249643077259330601==--
