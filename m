From: Evgeny Roubinchtein <zhenya1007@gmail.com>
Subject: How do tracepoint macros interact with the optimizer?
Date: Thu, 17 Nov 2016 10:34:59 -0500
Message-ID: <CAGYXaSbnjG1Sh8bx5B2vcsAsfaOKo66yr6-Lt+saZPuuyAJDpg__4788.2690596909$1479397235$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0341290155373640308=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yb0-x231.google.com (mail-yb0-x231.google.com
 [IPv6:2607:f8b0:4002:c09::231])
 by lists.lttng.org (Postfix) with ESMTPS id 3tKQFj5lS7zmWp
 for <lttng-dev@lists.lttng.org>; Thu, 17 Nov 2016 15:36:09 +0000 (UTC)
Received: by mail-yb0-x231.google.com with SMTP id a184so60103663ybb.0
 for <lttng-dev@lists.lttng.org>; Thu, 17 Nov 2016 07:35:00 -0800 (PST)
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

--===============0341290155373640308==
Content-Type: multipart/alternative; boundary=001a114d8accae2359054180ee6b

--001a114d8accae2359054180ee6b
Content-Type: text/plain; charset=UTF-8

Dear LTTNG users and developers,

I would like to know how the tracepoint macro interacts with the compiler's
code optimizer (I am specifically interested in GCC 4.9 if that makes a
difference).

Suppose I add a tracepoint to the section of code that the optimizer would
have eliminated, and then compile with optimization.  What happens?  Does
the optimizer eliminate the statement(s) that the tracepoint macro expands
to?  Or does the tracepoint macro do something to force the optimizer to
keep the statement(s) in? (e.g., declare some variable volatile, or some
moral equivalent).

Now essentially the same question about local variables.  To make things
simple, let's imagine that my tracepoint definition has a single variable
declared inside TP_ARGS, i.e., something like:
TRACEPOINT_EVENT (
      my_provider,  my_trace_point
      TP_ARGS (int, foo_arg),
       TP_FIELDS( ctf_integer(int, foo, foo_arg)))
Let's also imagine that, in my code, I have an automatic local variable,
(let's call it `bar`) that would normally be "optimized out", and I add a
tracepoint statement that references "bar", and compile with optimization.
What happens?  Specifically, can it happen that the optimizer is now
prevented from "optimizing out" `bar`, and is, e.g., forced to
stack-allocated it (rather than keeping it in a register, or whatever other
techniques it employs to "optimize it out").

Please Cc me on replies as I am not subscribed to the list.

Thank you in advance!

-- 
Best,
Zhenya

--001a114d8accae2359054180ee6b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear LTTNG users and developers,<div><br></div><div>I woul=
d like to know how the tracepoint macro interacts with the compiler&#39;s c=
ode optimizer (I am specifically interested in GCC 4.9 if that makes a diff=
erence). =C2=A0</div><div><br></div><div>Suppose I add a tracepoint to the =
section of code that the optimizer would have eliminated, and then compile =
with optimization.=C2=A0 What happens?=C2=A0 Does the optimizer eliminate t=
he statement(s) that the tracepoint macro expands to?=C2=A0 Or does the tra=
cepoint macro do something to force the optimizer to keep the statement(s) =
in? (e.g., declare some variable volatile, or some moral equivalent).</div>=
<div><br></div><div>Now essentially the same question about local variables=
.=C2=A0 To make things simple, let&#39;s imagine that my tracepoint definit=
ion has a single variable declared inside TP_ARGS, i.e., something like:</d=
iv><div>TRACEPOINT_EVENT (<br></div><div>=C2=A0 =C2=A0 =C2=A0 my_provider, =
=C2=A0my_trace_point</div><div>=C2=A0 =C2=A0 =C2=A0 TP_ARGS (int, foo_arg),=
</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0TP_FIELDS( ctf_integer(int, foo, foo_=
arg)))</div><div>Let&#39;s also imagine that, in my code, I have an automat=
ic local variable, (let&#39;s call it `bar`) that would normally be &quot;o=
ptimized out&quot;, and I add a tracepoint statement that references &quot;=
bar&quot;, and compile with optimization.=C2=A0 What happens?=C2=A0 Specifi=
cally, can it happen that the optimizer is now prevented from &quot;optimiz=
ing out&quot; `bar`, and is, e.g., forced to stack-allocated it (rather tha=
n keeping it in a register, or whatever other techniques it employs to &quo=
t;optimize it out&quot;).</div><div><br></div><div>Please Cc me on replies =
as I am not subscribed to the list.</div><div><br></div><div>Thank you in a=
dvance!</div><div><br></div><div>--=C2=A0</div><div>Best,</div><div>Zhenya<=
/div></div>

--001a114d8accae2359054180ee6b--

--===============0341290155373640308==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============0341290155373640308==--
