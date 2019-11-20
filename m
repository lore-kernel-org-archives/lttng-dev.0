From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: documentation about CTF event payload
Date: Wed, 20 Nov 2019 09:32:35 -0500 (EST)
Message-ID: <1361419525.123.1574260355956.JavaMail.zimbra__30849.9120803148$1574260382$gmane$org@efficios.com>
References: <tencent_7650B3E62F4AC4C75D42A69A@qq.com>
 <20190820160220.GA31760@joraj-alpa> <tencent_690A1E7757901F8A10D2CB64@qq.com>
 <20191104165454.GA2344@joraj-alpa> <tencent_728E005C598C6B7038AD5A41@qq.com>
 <20191106171800.GA26063@joraj-alpa> <tencent_2D749AE44D158E681A6166AC@qq.com>
 <tencent_3EE1250109255673062B819B@qq.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6696418898515075047=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 47J4sm2TMnz1S8b
 for <lttng-dev@lists.lttng.org>; Wed, 20 Nov 2019 09:32:44 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 6B33925F68F
 for <lttng-dev@lists.lttng.org>; Wed, 20 Nov 2019 09:32:37 -0500 (EST)
In-Reply-To: <tencent_3EE1250109255673062B819B@qq.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: =?utf-8?B?5p2o5rW3?= <hai.yang@magic-shield.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============6696418898515075047==
Content-Type: multipart/alternative;
	boundary="=_ac7d9904-2e23-40de-a624-d1c23ef0fcbd"

--=_ac7d9904-2e23-40de-a624-d1c23ef0fcbd
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

For the system call payload documentation, you might want to refer to the L=
inux system call=20
man pages.=20

For internal kernel tracepoints like sched_switch, there is no documentatio=
n of the meaning of=20
each field at the moment. This state is the same as the upstream Linux kern=
el trace event. You'll=20
have to figure it out on your own. Documenting each field of the ~500-1000 =
Linux kernel tracepoints=20
is no small task.=20

Thanks,=20

Mathieu=20

----- On Nov 19, 2019, at 9:25 PM, =E6=9D=A8=E6=B5=B7 <hai.yang@magic-shiel=
d.com> wrote:=20

> To be more specific, I suppose we can refer to
> instrumentation\syscalls\3.10.0-rc7\x86-64-syscalls-3.10.0-rc7 for the pa=
yload
> format of syscall event. Is it exactly in the CTF syscall event?

> Regards
> Hai
> ------------------ Original ------------------
> From: "=E6=9D=A8=E6=B5=B7"<hai.yang@magic-shield.com>;
> Date: Mon, Nov 18, 2019 09:54 AM
> To: "lttng-dev"<lttng-dev@lists.lttng.org>;
> Subject: documentation about CTF event payload
> Hi

> As LTTng generated CTF and babeltrace parse it, we have the output as att=
ached.
> We saw events such as sched_switch, but the payload cannot be understood
> easily. Where we can find the document to explain the LTTng payload and
> parameters?

> Regards
> Hai

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

--=_ac7d9904-2e23-40de-a624-d1c23ef0fcbd
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div>For the system call payload documentation, =
you might want to refer to the Linux system call<br></div><div>man pages.<b=
r data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>For i=
nternal kernel tracepoints like sched_switch, there is no documentation of =
the meaning of<br data-mce-bogus=3D"1"></div><div>each field at the moment.=
 This state is the same as the upstream Linux kernel trace event. You'll</d=
iv><div>have to figure it out on your own. Documenting each field of the ~5=
00-1000 Linux kernel tracepoints</div><div>is no small task.<br data-mce-bo=
gus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Thanks,<br data-mc=
e-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Mathieu<br dat=
a-mce-bogus=3D"1"></div><div><br></div><div><span id=3D"zwchr" data-marker=
=3D"__DIVIDER__">----- On Nov 19, 2019, at 9:25 PM, =E6=9D=A8=E6=B5=B7 &lt;=
hai.yang@magic-shield.com&gt; wrote:<br></span></div><div data-marker=3D"__=
QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF;margin-le=
ft:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;tex=
t-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><=
div>To be more specific, I suppose we can refer to instrumentation\syscalls=
\3.10.0-rc7\x86-64-syscalls-3.10.0-rc7 for the payload format of syscall ev=
ent. Is it exactly in the CTF syscall event?</div><br><div>Regards</div><di=
v>Hai</div><div><div>&nbsp;</div><div style=3D"font:'verdana' normal 14px;c=
olor:#000"><div style=3D"font-size:12px;font-family:'arial narrow';padding:=
2px 0 2px 0">------------------&nbsp;Original&nbsp;------------------</div>=
<div style=3D"font-size:12px;background:#efefef;padding:8px"><div><b>From: =
</b>&nbsp;"=E6=9D=A8=E6=B5=B7"&lt;hai.yang@magic-shield.com&gt;;</div><div>=
<b>Date: </b>&nbsp;Mon, Nov 18, 2019 09:54 AM</div><div><b>To: </b>&nbsp;"l=
ttng-dev"&lt;lttng-dev@lists.lttng.org&gt;; </div><div><b>Subject: </b>&nbs=
p;documentation about CTF event payload</div></div><div>&nbsp;</div><div><d=
iv>Hi</div><br><div>As LTTng generated CTF and babeltrace parse it, we have=
 the output as attached. We saw events such as sched_switch, but the payloa=
d cannot be understood easily. Where we can find the document to explain th=
e LTTng payload and parameters?</div><br><div>Regards</div><div>Hai</div></=
div></div></div><br>_______________________________________________<br>lttn=
g-dev mailing list<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/=
cgi-bin/mailman/listinfo/lttng-dev<br></blockquote></div><div><br></div><di=
v data-marker=3D"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>Effic=
iOS Inc.<br>http://www.efficios.com</div></div></body></html>
--=_ac7d9904-2e23-40de-a624-d1c23ef0fcbd--

--===============6696418898515075047==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6696418898515075047==--
