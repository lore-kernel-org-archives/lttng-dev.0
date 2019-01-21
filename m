From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: add cpu_id context to the channel
Date: Mon, 21 Jan 2019 14:06:21 -0500 (EST)
Message-ID: <2127783106.260.1548097581357.JavaMail.zimbra__12047.8170969122$1548097599$gmane$org@efficios.com>
References: <CACJEY86QpFpjiDe_eHfCnpEhRRPgsfW-+xW5LdM=xRFWNgOL-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3856621206151233192=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 43k1HT2JdHzpCX
 for <lttng-dev@lists.lttng.org>; Mon, 21 Jan 2019 14:06:29 -0500 (EST)
In-Reply-To: <CACJEY86QpFpjiDe_eHfCnpEhRRPgsfW-+xW5LdM=xRFWNgOL-Q@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Yonghong Yan <yanyh15@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============3856621206151233192==
Content-Type: multipart/alternative;
	boundary="=_963b3f50-fd4f-4448-9232-9ee95447d5ac"

--=_963b3f50-fd4f-4448-9232-9ee95447d5ac
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Jan 21, 2019, at 12:14 PM, Yonghong Yan <yanyh15@gmail.com> wrote: 

> I saw there is cpu_id field in babeltrace list, how can I add it to the context
> of UST tracepoint events. lttng add-context --list does not show that field and
> I do not see a similar field for the cpu_id.

The cpu_id context only exists for the purpose of lttng-ust and lttng-modules filtering. 
(e.g. lttng enable-event {-u,-k} --filter '$ctx.cpu_id == 2'). 

It is not possible to add it as context to the streams, because its information would 
be completely redundant with the fact that all the data is written into per-cpu buffers, 
and the cpu_id field is available within each packet context (which is right after each 
packet header). 

You just need to use babeltrace to convert to text, and while doing so, it prints a 
"cpu_id = N" context based on the packet_context cpu_id field for each event. 

Thanks, 

Mathieu 

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_963b3f50-fd4f-4448-9232-9ee95447d5ac
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br data-mce-bogus=3D"1"></div><div><span i=
d=3D"zwchr" data-marker=3D"__DIVIDER__">----- On Jan 21, 2019, at 12:14 PM,=
 Yonghong Yan &lt;yanyh15@gmail.com&gt; wrote:<br></span></div><div data-ma=
rker=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF=
;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:=
normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-siz=
e:12pt;"><div dir=3D"ltr"><div dir=3D"ltr">I saw there is cpu_id field in b=
abeltrace list, how can I add it to the context of UST tracepoint events.&n=
bsp;lttng add-context --list does not show that field and I do not see a si=
milar field for the cpu_id.&nbsp;</div></div></blockquote><div><br></div><d=
iv>The cpu_id context only exists for the purpose of lttng-ust and lttng-mo=
dules filtering.<br data-mce-bogus=3D"1"></div><div>(e.g. lttng enable-even=
t {-u,-k} --filter '$ctx.cpu_id =3D=3D 2').<br data-mce-bogus=3D"1"></div><=
div><br data-mce-bogus=3D"1"></div><div>It is not possible to add it as con=
text to the streams, because its information would<br data-mce-bogus=3D"1">=
</div><div>be completely redundant with the fact that all the data is writt=
en into per-cpu buffers,</div><div>and the cpu_id field is available within=
 each packet context (which is right after each</div><div>packet header).<b=
r data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>You j=
ust need to use babeltrace to convert to text, and while doing so, it print=
s a<br data-mce-bogus=3D"1"></div><div>"cpu_id =3D N" context based on the =
packet_context cpu_id field for each event.<br data-mce-bogus=3D"1"></div><=
div><br data-mce-bogus=3D"1"></div><div>Thanks,</div><div><br data-mce-bogu=
s=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div></div><div><br dat=
a-mce-bogus=3D"1"></div><div data-marker=3D"__SIG_POST__">-- <br></div><div=
>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com</div></div><=
/body></html>
--=_963b3f50-fd4f-4448-9232-9ee95447d5ac--

--===============3856621206151233192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3856621206151233192==--
