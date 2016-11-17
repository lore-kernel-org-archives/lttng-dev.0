From: Evgeny Roubinchtein <zhenya1007@gmail.com>
Subject: Re: How do tracepoint macros interact with the
	optimizer?
Date: Thu, 17 Nov 2016 12:18:39 -0500
Message-ID: <CAGYXaSaBsJVaCFT3=nRYq0XJqihys_aVQC=tYJxSC1iCcFMZJA__31838.1210942336$1479403262$gmane$org@mail.gmail.com>
References: <CAGYXaSbnjG1Sh8bx5B2vcsAsfaOKo66yr6-Lt+saZPuuyAJDpg@mail.gmail.com>
 <32594678.5908.1479401406952.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6370150004443618309=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yb0-x242.google.com (mail-yb0-x242.google.com
 [IPv6:2607:f8b0:4002:c09::242])
 by lists.lttng.org (Postfix) with ESMTPS id 3tKSYL4r6XzmgQ
 for <lttng-dev@lists.lttng.org>; Thu, 17 Nov 2016 17:19:50 +0000 (UTC)
Received: by mail-yb0-x242.google.com with SMTP id d59so7610932ybi.2
 for <lttng-dev@lists.lttng.org>; Thu, 17 Nov 2016 09:18:41 -0800 (PST)
In-Reply-To: <32594678.5908.1479401406952.JavaMail.zimbra@efficios.com>
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

--===============6370150004443618309==
Content-Type: multipart/alternative; boundary=001a11488d1678812b05418261c0

--001a11488d1678812b05418261c0
Content-Type: text/plain; charset=UTF-8

Hi, Mathieu,

Thank you for a quick and informative reply.  I really appreciate it.

Should I have more questions, I'll ask, but, for now, I think I am in good
shape. :-)

-- 
Best,
Zhenya

On Thu, Nov 17, 2016 at 11:50 AM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> ---- On Nov 17, 2016, at 10:34 AM, Evgeny Roubinchtein <
> zhenya1007@gmail.com> wrote:
>
> Dear LTTNG users and developers,
> I would like to know how the tracepoint macro interacts with the
> compiler's code optimizer (I am specifically interested in GCC 4.9 if that
> makes a difference).
>
> Suppose I add a tracepoint to the section of code that the optimizer would
> have eliminated, and then compile with optimization.  What happens?  Does
> the optimizer eliminate the statement(s) that the tracepoint macro expands
> to?  Or does the tracepoint macro do something to force the optimizer to
> keep the statement(s) in? (e.g., declare some variable volatile, or some
> moral equivalent).
>
> If you put a tracepoint in dead code, it will prevent dead code
> elimination, because
> the code is not dead anymore: it now has a side-effect, which is to call
> the tracepoint
> callbacks if there are any ever connected. Also, reading the "state"
> variable is done
> with a volatile load, which is considered as another side-effect.
>
> Now essentially the same question about local variables.  To make things
> simple, let's imagine that my tracepoint definition has a single variable
> declared inside TP_ARGS, i.e., something like:
> TRACEPOINT_EVENT (
>       my_provider,  my_trace_point
>       TP_ARGS (int, foo_arg),
>        TP_FIELDS( ctf_integer(int, foo, foo_arg)))
> Let's also imagine that, in my code, I have an automatic local variable,
> (let's call it `bar`) that would normally be "optimized out", and I add a
> tracepoint statement that references "bar", and compile with optimization.
> What happens?  Specifically, can it happen that the optimizer is now
> prevented from "optimizing out" `bar`, and is, e.g., forced to
> stack-allocated it (rather than keeping it in a register, or whatever other
> techniques it employs to "optimize it out").
>
> Adding a tracepoint adds liveness contraints (this is on purpose).
> So it may increase register pressure, or in some situations require
> to save/reload the variable from the stack, but note that such reload
> would be done within the "unlikely" if() branch, so loading such variable
> from the stack would only affect "tracing active" case.
>
> As a rule of thumb, you may want to keep your static tracepoints
> close to where variables are actually used by the application.
>
> Another aspect to consider with respect to optimisations: if you
> put a tracepoint in a "leaf" function, the function call of the tracepoint
> turns it into a non-leaf function.
>
> Those are very relevant questions :) Let me know if you need
> further clarification.
>
> Thanks,
>
> Mathieu
>
>
> Please Cc me on replies as I am not subscribed to the list.
>
> Thank you in advance!
>
> --
> Best,
> Zhenya
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--001a11488d1678812b05418261c0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi, Mathieu,<div><br></div><div>Thank you for a quick and =
informative reply.=C2=A0 I really appreciate it.</div><div><br></div><div>S=
hould I have more questions, I&#39;ll ask, but, for now, I think I am in go=
od shape. :-)</div><div><br></div><div>--=C2=A0</div><div>Best,</div><div>Z=
henya</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, Nov 17, 2016 at 11:50 AM, Mathieu Desnoyers <span dir=3D"ltr">&lt;<=
a href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu.=
desnoyers@efficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex"><div><div style=3D"font-family:arial,helvetica,sans-serif;font-size:12p=
t;color:#000000"><span class=3D""><div><span id=3D"m_6474070569969954429zwc=
hr">---- On Nov 17, 2016, at 10:34 AM, Evgeny Roubinchtein &lt;<a href=3D"m=
ailto:zhenya1007@gmail.com" target=3D"_blank">zhenya1007@gmail.com</a>&gt; =
wrote:<br></span></div></span><div><span class=3D""><blockquote style=3D"bo=
rder-left:2px solid #1010ff;margin-left:5px;padding-left:5px;color:#000;fon=
t-weight:normal;font-style:normal;text-decoration:none;font-family:Helvetic=
a,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr">Dear LTTNG users and de=
velopers,<br><div>I would like to know how the tracepoint macro interacts w=
ith the compiler&#39;s code optimizer (I am specifically interested in GCC =
4.9 if that makes a difference). =C2=A0</div><br><div>Suppose I add a trace=
point to the section of code that the optimizer would have eliminated, and =
then compile with optimization.=C2=A0 What happens?=C2=A0 Does the optimize=
r eliminate the statement(s) that the tracepoint macro expands to?=C2=A0 Or=
 does the tracepoint macro do something to force the optimizer to keep the =
statement(s) in? (e.g., declare some variable volatile, or some moral equiv=
alent).</div></div></blockquote></span><div>If you put a tracepoint in dead=
 code, it will prevent dead code elimination, because</div><div> the code i=
s not dead anymore: it now has a side-effect, which is to call the tracepoi=
nt</div><div>callbacks if there are any ever connected. Also, reading the &=
quot;state&quot; variable is done<br></div><div>with a volatile load, which=
 is considered as another side-effect.<br></div><span class=3D""><div><br><=
/div><blockquote style=3D"border-left:2px solid #1010ff;margin-left:5px;pad=
ding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decorati=
on:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=3D"=
ltr"><div>Now essentially the same question about local variables.=C2=A0 To=
 make things simple, let&#39;s imagine that my tracepoint definition has a =
single variable declared inside TP_ARGS, i.e., something like:</div><div>TR=
ACEPOINT_EVENT (<br></div><div>=C2=A0 =C2=A0 =C2=A0 my_provider, =C2=A0my_t=
race_point</div><div>=C2=A0 =C2=A0 =C2=A0 TP_ARGS (int, foo_arg),</div><div=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0TP_FIELDS( ctf_integer(int, foo, foo_arg)))</di=
v><div>Let&#39;s also imagine that, in my code, I have an automatic local v=
ariable, (let&#39;s call it `bar`) that would normally be &quot;optimized o=
ut&quot;, and I add a tracepoint statement that references &quot;bar&quot;,=
 and compile with optimization.=C2=A0 What happens?=C2=A0 Specifically, can=
 it happen that the optimizer is now prevented from &quot;optimizing out&qu=
ot; `bar`, and is, e.g., forced to stack-allocated it (rather than keeping =
it in a register, or whatever other techniques it employs to &quot;optimize=
 it out&quot;).</div></div></blockquote></span><div>Adding a tracepoint add=
s liveness contraints (this is on purpose).<br></div><div>So it may increas=
e register pressure, or in some situations require</div><div>to save/reload=
 the variable from the stack, but note that such reload</div><div>would be =
done within the &quot;unlikely&quot; if() branch, so loading such variable<=
/div><div>from the stack would only affect &quot;tracing active&quot; case.=
<br></div><div><br></div><div>As a rule of thumb, you may want to keep your=
 static tracepoints<br></div><div>close to where variables are actually use=
d by the application.<br></div><div><br></div><div>Another aspect to consid=
er with respect to optimisations: if you</div><div>put a tracepoint in a &q=
uot;leaf&quot; function, the function call of the tracepoint</div><div>turn=
s it into a non-leaf function.<br></div><div><br></div><div>Those are very =
relevant questions :) Let me know if you need<br></div><div>further clarifi=
cation.<br></div><div><br></div><div>Thanks,<br></div><div><br></div><div>M=
athieu<br></div><div><br></div><blockquote style=3D"border-left:2px solid #=
1010ff;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-=
style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;fo=
nt-size:12pt"><span class=3D""><div dir=3D"ltr"><br><div>Please Cc me on re=
plies as I am not subscribed to the list.</div><br><div>Thank you in advanc=
e!</div><br><div>--=C2=A0</div><div>Best,</div><div>Zhenya</div></div><br><=
/span>______________________________<wbr>_________________<br>lttng-dev mai=
ling list<br><a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank"=
>lttng-dev@lists.lttng.org</a><br><a href=3D"https://lists.lttng.org/cgi-bi=
n/mailman/listinfo/lttng-dev" target=3D"_blank">https://lists.lttng.org/cgi=
-<wbr>bin/mailman/listinfo/lttng-dev</a><span class=3D"HOEnZb"><font color=
=3D"#888888"><br></font></span></blockquote></div><span class=3D"HOEnZb"><f=
ont color=3D"#888888"><div><br></div><div>-- <br></div><div>Mathieu Desnoye=
rs<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" target=3D"_blank=
">http://www.efficios.com</a></div></font></span></div></div></blockquote><=
/div><br></div>

--001a11488d1678812b05418261c0--

--===============6370150004443618309==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============6370150004443618309==--
