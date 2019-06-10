From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: babeltrace python binding and multiple streams with
 out of order samples
Date: Mon, 10 Jun 2019 13:59:01 -0400
Message-ID: <CA+jJMxv+Mt6WdG+gk+86kY3AQsMD1wwfUWAEisBYU1X0obrFcQ__6319.30439719639$1560189602$gmane$org@mail.gmail.com>
References: <ee93b1b8-6e02-d40a-067a-99ab88b2cadf@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1317518056147157984=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 45N19m69BMz18fg
 for <lttng-dev@lists.lttng.org>; Mon, 10 Jun 2019 13:59:40 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 39C451E9A33
 for <lttng-dev@lists.lttng.org>; Mon, 10 Jun 2019 13:59:40 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id CgI0O-1Wcc7t for <lttng-dev@lists.lttng.org>;
 Mon, 10 Jun 2019 13:59:39 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id C16141E9A22
 for <lttng-dev@lists.lttng.org>; Mon, 10 Jun 2019 13:59:39 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id WCB8sv5v5NW1 for <lttng-dev@lists.lttng.org>;
 Mon, 10 Jun 2019 13:59:39 -0400 (EDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com
 [209.85.208.178])
 by mail.efficios.com (Postfix) with ESMTPSA id 660951E9A03
 for <lttng-dev@lists.lttng.org>; Mon, 10 Jun 2019 13:59:39 -0400 (EDT)
Received: by mail-lj1-f178.google.com with SMTP id m23so8811826lje.12
 for <lttng-dev@lists.lttng.org>; Mon, 10 Jun 2019 10:59:39 -0700 (PDT)
In-Reply-To: <ee93b1b8-6e02-d40a-067a-99ab88b2cadf@gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Carlo Caione <carlo.caione@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1317518056147157984==
Content-Type: multipart/alternative; boundary="0000000000009548bf058afbf133"

--0000000000009548bf058afbf133
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Carlo,

Events do indeed need to be passed in order. You
can use a heap to sort the streams as they are read. This is the strategy
used
by babeltrace to multiplex streams and present them chronologically.

Otherwise, if the streams contain the same event descriptions, you could
convert
the per-CPU event sets independently and combine the stream files with
a single metadata file to obtain a "complete" trace.

Regards,
J=C3=A9r=C3=A9mie

On Tue, 28 May 2019 at 09:11, Carlo Caione <carlo.caione@gmail.com> wrote:

> Hi,
> I'm using the babeltrace python bindings (v1.5.x) to convert some raw
> data I have into a CTF file.
>
> This raw data is organized in fixed data chunks composed by serializing
> the events for each CPU:
>
> [cpu0, cpu0, cpu0, ..., cpu1, cpu1, cpu1, ..., cpu2,... ]
>
> Each event for each CPU has a timestamp that is monotonic within each
> CPU set.
>
> I wanted to create one stream per CPU and since the events are the same
> for each CPU, I was using a single stream_class linked to a stream
> object for each CPU. Something in the structure similar to [0] with:
>
> stream_cpu0 =3D writer.create_stream(stream_class)
> stream_cpu1 =3D writer.create_stream(stream_class)
> stream_cpu2 =3D writer.create_stream(stream_class)
> ...
>
> The problem is that being the clock one for the stream_class when
> feeding the events to the library I get a:
>
> ValueError: Invalid time value
>
> When the first event on cpu1 is parsed, because the timestamp is in the
> past with respect to the timestamp of the latest event of the cpu0.
>
> I can sort the events before feeding them to babeltrace but this seems
> sub-optimal to me. My question is: am I using the library correctly or
> there is any way to achieve this?
>
> Thank you,
>
> [0] https://lists.lttng.org/pipermail/lttng-dev/2015-November/025231.html
>
> --
> Carlo Caione
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--0000000000009548bf058afbf133
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Carlo,</div><div><br></div><div>Events do indeed n=
eed to be passed in order. You</div><div>can use a heap to sort the streams=
 as they are read. This is the strategy used</div><div>by babeltrace to mul=
tiplex streams and present them chronologically.</div><div><br></div><div>O=
therwise, if the streams contain the same event descriptions, you could con=
vert</div><div>the per-CPU event sets independently and combine the stream =
files with</div><div>a single metadata file to obtain a &quot;complete&quot=
; trace.</div><div><br></div><div>Regards,<br></div><div>J=C3=A9r=C3=A9mie<=
br></div><div></div><div><br></div><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Tue, 28 May 2019 at 09:11, Carlo Caione &lt;<a =
href=3D"mailto:carlo.caione@gmail.com">carlo.caione@gmail.com</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
I&#39;m using the babeltrace python bindings (v1.5.x) to convert some raw <=
br>
data I have into a CTF file.<br>
<br>
This raw data is organized in fixed data chunks composed by serializing <br=
>
the events for each CPU:<br>
<br>
[cpu0, cpu0, cpu0, ..., cpu1, cpu1, cpu1, ..., cpu2,... ]<br>
<br>
Each event for each CPU has a timestamp that is monotonic within each <br>
CPU set.<br>
<br>
I wanted to create one stream per CPU and since the events are the same <br=
>
for each CPU, I was using a single stream_class linked to a stream <br>
object for each CPU. Something in the structure similar to [0] with:<br>
<br>
stream_cpu0 =3D writer.create_stream(stream_class)<br>
stream_cpu1 =3D writer.create_stream(stream_class)<br>
stream_cpu2 =3D writer.create_stream(stream_class)<br>
...<br>
<br>
The problem is that being the clock one for the stream_class when <br>
feeding the events to the library I get a:<br>
<br>
ValueError: Invalid time value<br>
<br>
When the first event on cpu1 is parsed, because the timestamp is in the <br=
>
past with respect to the timestamp of the latest event of the cpu0.<br>
<br>
I can sort the events before feeding them to babeltrace but this seems <br>
sub-optimal to me. My question is: am I using the library correctly or <br>
there is any way to achieve this?<br>
<br>
Thank you,<br>
<br>
[0] <a href=3D"https://lists.lttng.org/pipermail/lttng-dev/2015-November/02=
5231.html" rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/pip=
ermail/lttng-dev/2015-November/025231.html</a><br>
<br>
--<br>
Carlo Caione<br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailman/l=
istinfo/lttng-dev</a><br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS Inc.<br><a href=3D"=
http://www.efficios.com" target=3D"_blank">http://www.efficios.com</a></div=
></div>

--0000000000009548bf058afbf133--

--===============1317518056147157984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1317518056147157984==--
