From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: can we do live local tracing without relay daemon?
Date: Fri, 8 May 2015 12:55:56 -0400
Message-ID: <CA+jJMxupKBSzuLWtB+fbBusW-5Jv+vg17qXwL328DK39dHNo=w__18966.0110896968$1431104257$gmane$org@mail.gmail.com>
References: <44b3df76-3fac-4311-96b7-160a2d488f24@aliyun.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1498938905=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1YqlZD-0006wQ-H4
 for lttng-dev@lists.lttng.org; Fri, 08 May 2015 12:56:12 -0400
Received: by qgeb100 with SMTP id b100so39308898qge.3
 for <lttng-dev@lists.lttng.org>; Fri, 08 May 2015 09:55:56 -0700 (PDT)
In-Reply-To: <44b3df76-3fac-4311-96b7-160a2d488f24@aliyun.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1498938905==
Content-Type: multipart/alternative; boundary=001a11495a10dd6b2d051594e672

--001a11495a10dd6b2d051594e672
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2015 at 10:56 PM, zhenyu.ren <zhenyu.ren@aliyun.com> wrote:

> Hi,dev
>
>    From https://lttng.org/docs/#doc-lttng-live,it seems that relay daemon
> is necessary for live tracing. I wondered whether I can do live LOCAL
> tracing without relay daemon,say implemented it on consumer daemon side
> rather than relay daemon side, to avoid one more memory copy for the
> performance sake.
>
>
Hi Zhenyu,

This is currently unsupported; the relay-daemon is required to perform live
tracing even in local. However, there is nothing preventing us from
implementing a shared-memory scheme between the consumer, relay and the
live-client (e.g. Babeltrace). This would eliminate the need for copying
the data when used locally.

Regards,
J=C3=A9r=C3=A9mie

Thanks
> zhenyu.ren
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--001a11495a10dd6b2d051594e672
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Thu, May 7, 2015 at 10:56 PM, zhenyu.ren <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:zhenyu.ren@aliyun.com" target=3D"_blank">zhenyu.ren@aliyun.com=
</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,dev<br>
<br>
=C2=A0 =C2=A0From <a href=3D"https://lttng.org/docs/#doc-lttng-live,it" tar=
get=3D"_blank">https://lttng.org/docs/#doc-lttng-live,it</a> seems that rel=
ay daemon is necessary for live tracing. I wondered whether I can do live L=
OCAL tracing without relay daemon,say implemented it on consumer daemon sid=
e rather than relay daemon side, to avoid one more memory copy for the perf=
ormance sake.<br>
<br></blockquote><div><br></div><div>Hi Zhenyu,</div><div><br></div><div>Th=
is is currently unsupported; the relay-daemon is required to perform live t=
racing even in local. However, there is nothing preventing us from implemen=
ting a shared-memory scheme between the consumer, relay and the live-client=
 (e.g. Babeltrace). This would eliminate the need for copying the data when=
 used locally.</div><div><br></div><div>Regards,</div><div>J=C3=A9r=C3=A9mi=
e</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Thanks<br>
zhenyu.ren<br>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS Inc.<br><a hre=
f=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.com</a>=
</div>
</div></div>

--001a11495a10dd6b2d051594e672--


--===============1498938905==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1498938905==--
