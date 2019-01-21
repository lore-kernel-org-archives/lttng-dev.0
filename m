From: Yonghong Yan <yanyh15@gmail.com>
Subject: Re: add cpu_id context to the channel
Date: Mon, 21 Jan 2019 16:21:47 -0500
Message-ID: <CACJEY85gdy86ttpJJwK==1zOhkTERrRcSG_6WQET1_znLSqTdw__10511.1024504126$1548105730$gmane$org@mail.gmail.com>
References: <CACJEY86QpFpjiDe_eHfCnpEhRRPgsfW-+xW5LdM=xRFWNgOL-Q@mail.gmail.com>
 <2127783106.260.1548097581357.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7807611445566535766=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 by lists.lttng.org (Postfix) with ESMTPS id 43k4Hr4qggzpH6
 for <lttng-dev@lists.lttng.org>; Mon, 21 Jan 2019 16:22:00 -0500 (EST)
Received: by mail-pl1-x632.google.com with SMTP id 101so10354376pld.6
 for <lttng-dev@lists.lttng.org>; Mon, 21 Jan 2019 13:22:00 -0800 (PST)
In-Reply-To: <2127783106.260.1548097581357.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============7807611445566535766==
Content-Type: multipart/alternative; boundary="00000000000072c545057ffe731f"

--00000000000072c545057ffe731f
Content-Type: text/plain; charset="UTF-8"

Thank you. make sense. I am using Trace Compass XML based approach to
display UST trace records. Using CPU id helps me easier to sort out the
event records in trace compass. I will check out more on trace compass.

Yonghong


On Mon, Jan 21, 2019 at 2:06 PM Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

>
> ----- On Jan 21, 2019, at 12:14 PM, Yonghong Yan <yanyh15@gmail.com>
> wrote:
>
> I saw there is cpu_id field in babeltrace list, how can I add it to the
> context of UST tracepoint events. lttng add-context --list does not show
> that field and I do not see a similar field for the cpu_id.
>
>
> The cpu_id context only exists for the purpose of lttng-ust and
> lttng-modules filtering.
> (e.g. lttng enable-event {-u,-k} --filter '$ctx.cpu_id == 2').
>
> It is not possible to add it as context to the streams, because its
> information would
> be completely redundant with the fact that all the data is written into
> per-cpu buffers,
> and the cpu_id field is available within each packet context (which is
> right after each
> packet header).
>
> You just need to use babeltrace to convert to text, and while doing so, it
> prints a
> "cpu_id = N" context based on the packet_context cpu_id field for each
> event.
>
> Thanks,
>
> Mathieu
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--00000000000072c545057ffe731f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thank you. make sense. I am using Trace Compass XML based =
approach to display UST trace records. Using CPU id helps me easier to sort=
 out the event records in trace compass. I will check out more on trace com=
pass.=C2=A0<div><br></div><div>Yonghong<br><br></div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr">On Mon, Jan 21, 2019 at 2:06 PM Mathieu D=
esnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com">mathieu.desn=
oyers@efficios.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex"><div><div style=3D"font-family:arial,helvetica,sans-serif=
;font-size:12pt;color:rgb(0,0,0)"><div><br></div><div><span id=3D"gmail-m_-=
6511454066164686156zwchr">----- On Jan 21, 2019, at 12:14 PM, Yonghong Yan =
&lt;<a href=3D"mailto:yanyh15@gmail.com" target=3D"_blank">yanyh15@gmail.co=
m</a>&gt; wrote:<br></span></div><div><blockquote style=3D"border-left:2px =
solid rgb(16,16,255);margin-left:5px;padding-left:5px;color:rgb(0,0,0);font=
-weight:normal;font-style:normal;text-decoration:none;font-family:Helvetica=
,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr"><div dir=3D"ltr">I saw t=
here is cpu_id field in babeltrace list, how can I add it to the context of=
 UST tracepoint events.=C2=A0lttng add-context --list does not show that fi=
eld and I do not see a similar field for the cpu_id.=C2=A0</div></div></blo=
ckquote><div><br></div><div>The cpu_id context only exists for the purpose =
of lttng-ust and lttng-modules filtering.<br></div><div>(e.g. lttng enable-=
event {-u,-k} --filter &#39;$ctx.cpu_id =3D=3D 2&#39;).<br></div><div><br><=
/div><div>It is not possible to add it as context to the streams, because i=
ts information would<br></div><div>be completely redundant with the fact th=
at all the data is written into per-cpu buffers,</div><div>and the cpu_id f=
ield is available within each packet context (which is right after each</di=
v><div>packet header).<br></div><div><br></div><div>You just need to use ba=
beltrace to convert to text, and while doing so, it prints a<br></div><div>=
&quot;cpu_id =3D N&quot; context based on the packet_context cpu_id field f=
or each event.<br></div><div><br></div><div>Thanks,</div><div><br></div><di=
v>Mathieu<br></div></div><div><br></div><div>-- <br></div><div>Mathieu Desn=
oyers<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" target=3D"_bl=
ank">http://www.efficios.com</a></div></div></div></blockquote></div>

--00000000000072c545057ffe731f--

--===============7807611445566535766==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============7807611445566535766==--
