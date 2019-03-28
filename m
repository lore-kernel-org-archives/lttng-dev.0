From: tujalasaikiran <tujalasaikiran@gmail.com>
Subject: Fwd: LTTng user space data not flushed out
Date: Thu, 28 Mar 2019 17:20:17 +0530
Message-ID: <CAMDVSgkc_ohVFNZLALS=UQ9QS7zvbHxutd-8jAT0=CGHUb+LsA__43965.4141244077$1553786152$gmane$org@mail.gmail.com>
References: <CAMDVSgkiL9+-Y1fwEiejr9UA1ernY5HqKqDKYqumQYxLfV3eJA@mail.gmail.com>
 <CA+jJMxtYVOnCi+uGi0UskHBZfbq9Dy6z=fnMN2AWgHP4o4sMEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1217966043661524841=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com
 [IPv6:2607:f8b0:4864:20::e29])
 by lists.lttng.org (Postfix) with ESMTPS id 44VNTk4k7qz17SW
 for <lttng-dev@lists.lttng.org>; Thu, 28 Mar 2019 07:50:18 -0400 (EDT)
Received: by mail-vs1-xe29.google.com with SMTP id i207so11902662vsd.10
 for <lttng-dev@lists.lttng.org>; Thu, 28 Mar 2019 04:50:18 -0700 (PDT)
In-Reply-To: <CA+jJMxtYVOnCi+uGi0UskHBZfbq9Dy6z=fnMN2AWgHP4o4sMEg@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1217966043661524841==
Content-Type: multipart/alternative; boundary="00000000000076519d05852628c5"

--00000000000076519d05852628c5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

---------- Forwarded message ----------
From: *J=C3=A9r=C3=A9mie Galarneau* <jeremie.galarneau@efficios.com>
Date: Monday, March 25, 2019
Subject: LTTng user space data not flushed out
To: tujalasaikiran <tujalasaikiran@gmail.com>


Hi Tujala,

Please use the public development mailing list
(lttng-dev@lists.lttng.org) to get community support.
Private support is available through EfficiOS' support agreements.

Thanks,
J=C3=A9r=C3=A9mie

On Sat, 23 Mar 2019 at 13:13, tujalasaikiran <tujalasaikiran@gmail.com>
wrote:
>
> Hi,
> I'm using LTTng live mode, the "live" parameter in the below command is
the time at which data is flushed. We get zero content size packets if we
don't have any data generated from the tracer. This is true for kernel
space domain, that is getting content size zero packets. Whereas in the
user space domain, I'm not getting zero content size packets this makes the
"live viewer"  (babeltrace) to not to show any trace data until the session
stop.
> My application generates the kernel domain events frequently whereas
userspace domain events generate very rarely. Default flush time in "lttng
create" command is 1 second, this is honored in kernel domain whereas in
userspace domain not.
> Below commands, I'm using for LTTng configuration and using babel trace
viewer to view live trace.
>
>                   lttng create mysession --live
>                   lttng enable-event -k sched_swich
>                   lttng enable-event -u mytrace_point:tp_one
>                   lttng start
>                   babeltrace --input-format=3Dlttng-live
net://localhost/host/mypc-name/mysession
>                  <---- not getting any data from babeltrace until I stop
the session------>
>                   lttng stop
>                   <--- I'm getting data from babeltrace once I stop the
lttng session  --->
>                   lttng destroy
> Thanks,
> TSK.
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--00000000000076519d05852628c5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>---------- Forwarded message ----------<br>From: <b>J=C3=A9r=C3=A9m=
ie Galarneau</b> &lt;<a href=3D"mailto:jeremie.galarneau@efficios.com">jere=
mie.galarneau@efficios.com</a>&gt;<br>Date: Monday, March 25, 2019<br>Subje=
ct: LTTng user space data not flushed out<br>To: tujalasaikiran &lt;<a href=
=3D"mailto:tujalasaikiran@gmail.com">tujalasaikiran@gmail.com</a>&gt;<br><b=
r><br>Hi Tujala,<br>
<br>
Please use the public development mailing list<br>
(<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a>=
) to get community support.<br>
Private support is available through EfficiOS&#39; support agreements.<br>
<br>
Thanks,<br>
J=C3=A9r=C3=A9mie<br>
<br>
On Sat, 23 Mar 2019 at 13:13, tujalasaikiran &lt;<a href=3D"mailto:tujalasa=
ikiran@gmail.com">tujalasaikiran@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi,<br>
&gt; I&#39;m using LTTng live mode, the &quot;live&quot; parameter in the b=
elow command is the time at which data is flushed. We get zero content size=
 packets if we don&#39;t have any data generated from the tracer. This is t=
rue for kernel space domain, that is getting content size zero packets. Whe=
reas in the user space domain, I&#39;m not getting zero content size packet=
s this makes the &quot;live viewer&quot;=C2=A0 (babeltrace) to not to show =
any trace data until the session stop.<br>
&gt; My application generates the kernel domain events frequently whereas u=
serspace domain events generate very rarely. Default flush time in &quot;lt=
tng create&quot; command is 1 second, this is honored in kernel domain wher=
eas in userspace domain not.<br>
&gt; Below commands, I&#39;m using for LTTng configuration and using babel =
trace viewer to view live trace.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lt=
tng create mysession --live<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lt=
tng enable-event -k sched_swich<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lt=
tng enable-event -u mytrace_point:tp_one<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lt=
tng start<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ba=
beltrace --input-format=3Dlttng-live net://localhost/host/mypc-<wbr>name/my=
session<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;----=
 not getting any data from babeltrace until I stop the session------&gt;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lt=
tng stop<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&l=
t;--- I&#39;m getting data from babeltrace once I stop the lttng session=C2=
=A0 ---&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lt=
tng destroy<br>
&gt; Thanks,<br>
&gt; TSK.<br>
&gt;<br>
&gt;<br>
<br>
<br>
-- <br>
J=C3=A9r=C3=A9mie Galarneau<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a><br>
<br>

--00000000000076519d05852628c5--

--===============1217966043661524841==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1217966043661524841==--
