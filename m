From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Lttng user application tracing
Date: Tue, 5 May 2015 19:32:42 -0400
Message-ID: <CA+jJMxt-FcdWRmidAWXP0fHrmY6eX4XJEKukBvNs_YhOaNg=EQ__23289.8747236051$1430868844$gmane$org@mail.gmail.com>
References: <5548F60C.7000403@bsc.es>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1363106426=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1YpmKW-00041m-4T
 for lttng-dev@lists.lttng.org; Tue, 05 May 2015 19:32:57 -0400
Received: by qctx5 with SMTP id x5so12109422qct.0
 for <lttng-dev@lists.lttng.org>; Tue, 05 May 2015 16:32:42 -0700 (PDT)
In-Reply-To: <5548F60C.7000403@bsc.es>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Beatriz Aguilar <beatriz.aguilar@bsc.es>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1363106426==
Content-Type: multipart/alternative; boundary=001a114273ee52b80c05155e1820

--001a114273ee52b80c05155e1820
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2015 at 12:55 PM, Beatriz Aguilar <beatriz.aguilar@bsc.es>
wrote:

> Hi,
>
> I am trying to trace a user application with Lttng.
> I would like to know if it is possible to do it without introducing
> tracepoints in the user code like when the kernel is traced.
>
> For example, I would like to see what every CPU/process is doing in an MP=
I
> + OpenMP application without putting  tracepoints in it.
>

Hi Beatriz,

Without instrumenting your application, you will be limited to the
information provided by the kernel instrumentation which includes syscalls.
Those can already provide you with quite a bit of information to understand
what an application is doing.

Moreover, you can use a couple of lttng-ust helper libraries to trace calls
to some libc functions [1]. You could probably develop other helpers based
around the same idea (overloading symbols) to trace MPI and OpenMP calls
[2].

Unfortunately, if you really want to instrument your application's
internals, you will have to manually add tracepoints to the code. Dynamic
tracing, which we don't support yet, would let you insert probes at runtime
without the need for this static instrumentation.

Regards,
J=C3=A9r=C3=A9mie

[1] http://lttng.org/docs/#doc-prebuilt-ust-helpers
[2] https://github.com/lttng/lttng-ust/tree/master/liblttng-ust-libc-wrappe=
r


>
> Is that possible or is there any alternative to Lttng to generate ctf
> traces?
>
> Thank you very much.
> Your help is very much appreciated =3D)
>
>
> Beatriz Aguilar
>
> WARNING / LEGAL TEXT: This message is intended only for the use of the
> individual or entity to which it is addressed and may contain
> information which is privileged, confidential, proprietary, or exempt
> from disclosure under applicable law. If you are not the intended
> recipient or the person responsible for delivering the message to the
> intended recipient, you are strictly prohibited from disclosing,
> distributing, copying, or in any way using this message. If you have
> received this communication in error, please notify the sender and
> destroy and delete any copies you may have received.
>
> http://www.bsc.es/disclaimer
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

--001a114273ee52b80c05155e1820
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Tue, May 5, 2015 at 12:55 PM, Beatriz Aguilar <span dir=3D"ltr">&lt;=
<a href=3D"mailto:beatriz.aguilar@bsc.es" target=3D"_blank">beatriz.aguilar=
@bsc.es</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,2=
04,204);border-left-style:solid;padding-left:1ex">Hi,<br>
<br>
I am trying to trace a user application with Lttng.<br>
I would like to know if it is possible to do it without introducing tracepo=
ints in the user code like when the kernel is traced.<br>
<br>
For example, I would like to see what every CPU/process is doing in an MPI =
+ OpenMP application without putting=C2=A0 tracepoints in it.<br></blockquo=
te><div><br></div><div>Hi Beatriz,</div><div><br></div><div>Without instrum=
enting your application, you will be limited to the information provided by=
 the kernel instrumentation which includes syscalls. Those can already prov=
ide you with quite a bit of information to understand what an application i=
s doing.</div><div><br></div><div>Moreover, you can use a couple of lttng-u=
st helper libraries to trace calls to some libc functions [1]. You could pr=
obably develop other helpers based around the same idea (overloading symbol=
s) to trace MPI and OpenMP calls [2].</div><div><br></div><div>Unfortunatel=
y, if you really want to instrument your application&#39;s internals, you w=
ill have to manually add tracepoints to the code. Dynamic tracing, which we=
 don&#39;t support yet, would let you insert probes at runtime without the =
need for this static instrumentation.</div><div><br></div><div>Regards,</di=
v><div>J=C3=A9r=C3=A9mie</div><div><br></div><div>[1]=C2=A0<a href=3D"http:=
//lttng.org/docs/#doc-prebuilt-ust-helpers">http://lttng.org/docs/#doc-preb=
uilt-ust-helpers</a></div><div>[2]=C2=A0<a href=3D"https://github.com/lttng=
/lttng-ust/tree/master/liblttng-ust-libc-wrapper">https://github.com/lttng/=
lttng-ust/tree/master/liblttng-ust-libc-wrapper</a></div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;pa=
dding-left:1ex">
<br>
Is that possible or is there any alternative to Lttng to generate ctf trace=
s?<br>
<br>
Thank you very much.<br>
Your help is very much appreciated =3D)<br>
<br>
<br>
Beatriz Aguilar<br>
<br>
WARNING / LEGAL TEXT: This message is intended only for the use of the<br>
individual or entity to which it is addressed and may contain<br>
information which is privileged, confidential, proprietary, or exempt<br>
from disclosure under applicable law. If you are not the intended<br>
recipient or the person responsible for delivering the message to the<br>
intended recipient, you are strictly prohibited from disclosing,<br>
distributing, copying, or in any way using this message. If you have<br>
received this communication in error, please notify the sender and<br>
destroy and delete any copies you may have received.<br>
<br>
<a href=3D"http://www.bsc.es/disclaimer" target=3D"_blank">http://www.bsc.e=
s/disclaimer</a><br>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS Inc.<br><a hre=
f=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.com</a>=
</div>
</div></div>

--001a114273ee52b80c05155e1820--


--===============1363106426==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1363106426==--
