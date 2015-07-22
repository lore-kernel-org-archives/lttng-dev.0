From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: Re: [PATCH] Fix: Rename kvm TRACE_SYSTEM to avoid name
	clash
Date: Wed, 22 Jul 2015 20:25:24 +0000
Message-ID: <CAC6yHM7ttA6FfJeMrxq6NtbW+uRs0n9riBbPAX32wEy8ZPgvGA__34279.93191076$1437596801$gmane$org@mail.gmail.com>
References: <1436899428-26416-1-git-send-email-francis.giraldeau@gmail.com>
 <265205524.235.1437064862252.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0513497181=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <francis.giraldeau@gmail.com>) id 1ZI0aA-0007lk-W3
 for lttng-dev@lists.lttng.org; Wed, 22 Jul 2015 16:25:40 -0400
Received: by qkbm65 with SMTP id m65so106813879qkb.2
 for <lttng-dev@lists.lttng.org>; Wed, 22 Jul 2015 13:25:33 -0700 (PDT)
In-Reply-To: <265205524.235.1437064862252.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, =?UTF-8?Q?C=C3=A9dric_Biancheri?= <cedric.biancheri@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

--===============0513497181==
Content-Type: multipart/alternative; boundary=001a1146ed3aa2c532051b7c924e

--001a1146ed3aa2c532051b7c924e
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Le jeu. 16 juil. 2015 =C3=A0 12:41, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> a =C3=A9crit :

> I cannot reproduce this issue with a kernel 4.1.1 and with
> lttng-modules master and stable-2.6 HEAD.
>
> Can you double-check ?
>

Thanks for this follow-up. I confirm that the bug is reproducible with
lttng-modules master on linux 4.1. I opened an issue in the bug tracker for
further details. I added a script to reproduce the bug easily.

https://bugs.lttng.org/issues/895


> Moreover, just changing the TRACE_SYSTEM without changing
> the tracepoint namespacing prefix from kvm_ to kvm_x86 in the
> whole file is wrong.


I do not understand. In lttng-ust, there is a TRACEPOINT_PROVIDER string
that must be repeated into each TRACEPOINT_EVENT declaration, but this is
not the case for the kernel LTTNG_TRACEPOINT_EVENT macro. Can you explain
what you mean by "namespace"?


> And if we do this, we would need the _MAP
> flavor of the macros to map to the original kernel names.
>

In fact, event names are not modified by the patch, such that backward
compatibility seems preserved AFAIK. Do I miss something?

Francis


> ----- On Jul 14, 2015, at 2:43 PM, Francis Giraldeau
> francis.giraldeau@gmail.com wrote:
>
> > From: C=C3=A9dric Biancheri <cedric.biancheri@polymtl.ca>
> >
> > The lttng-probe-kvm and lttng-probe-kvm-x86 had the same TRACE_SYSTEM
> string.
> > Because of that, both modules can't be loaded at the same time. The
> second
> > module fails to load silently. This patch rename the TRACE_SYSTEM of
> > lttng-probe-kvm-x86 to avoid the clash.
> >
> > Signed-off-by: Francis Giraldeau <francis.giraldeau@gmail.com>
> > ---
> > instrumentation/events/lttng-module/arch/x86/kvm/trace.h | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/instrumentation/events/lttng-module/arch/x86/kvm/trace.h
> > b/instrumentation/events/lttng-module/arch/x86/kvm/trace.h
> > index 32c4743..ddbfda7 100644
> > --- a/instrumentation/events/lttng-module/arch/x86/kvm/trace.h
> > +++ b/instrumentation/events/lttng-module/arch/x86/kvm/trace.h
> > @@ -12,7 +12,7 @@
> > #include <../arch/x86/kvm/kvm_cache_regs.h>
> >
> > #undef TRACE_SYSTEM
> > -#define TRACE_SYSTEM kvm
> > +#define TRACE_SYSTEM kvm_x86
> >
> > /*
> >  * Tracepoint for guest mode entry.
> > --
> > 2.1.4
> >
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--001a1146ed3aa2c532051b7c924e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Le=C2=A0jeu. 16 juil. 2015 =C3=A0=C2=A012:41, Mathieu=
 Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com">mathieu.de=
snoyers@efficios.com</a>&gt; a =C3=A9crit=C2=A0:<br></div><div class=3D"gma=
il_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">I cannot reproduce this issue with=
 a kernel 4.1.1 and with<br>
lttng-modules master and stable-2.6 HEAD.<br>
<br>
Can you double-check ?<br></blockquote><div><br></div><div>Thanks for this =
follow-up. I confirm that the bug is reproducible with lttng-modules master=
 on linux 4.1. I opened an issue in the bug tracker for further details. I =
added a script to reproduce the bug easily.=C2=A0<div><br></div><div><a hre=
f=3D"https://bugs.lttng.org/issues/895">https://bugs.lttng.org/issues/895</=
a><br></div></div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Moreover, just changing the TRACE_SYSTEM without changing<br>
the tracepoint namespacing prefix from kvm_ to kvm_x86 in the<br>
whole file is wrong.</blockquote><div><br></div><div>I do not understand. I=
n lttng-ust, there is a=C2=A0TRACEPOINT_PROVIDER string that must be repeat=
ed into each=C2=A0TRACEPOINT_EVENT declaration, but this is not the case fo=
r the kernel=C2=A0LTTNG_TRACEPOINT_EVENT macro. Can you explain what you me=
an by &quot;namespace&quot;?</div><div>=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">And if we do this, we would need the _MAP<br>
flavor of the macros to map to the original kernel names.<br></blockquote><=
div><br></div><div>In fact, event names are not modified by the patch, such=
 that backward compatibility seems preserved AFAIK. Do I miss something?</d=
iv><div><br></div><div>Francis<br></div><div><br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex"><br>
----- On Jul 14, 2015, at 2:43 PM, Francis Giraldeau <a href=3D"mailto:fran=
cis.giraldeau@gmail.com" target=3D"_blank">francis.giraldeau@gmail.com</a> =
wrote:<br>
<br>
&gt; From: C=C3=A9dric Biancheri &lt;<a href=3D"mailto:cedric.biancheri@pol=
ymtl.ca" target=3D"_blank">cedric.biancheri@polymtl.ca</a>&gt;<br>
&gt;<br>
&gt; The lttng-probe-kvm and lttng-probe-kvm-x86 had the same TRACE_SYSTEM =
string.<br>
&gt; Because of that, both modules can&#39;t be loaded at the same time. Th=
e second<br>
&gt; module fails to load silently. This patch rename the TRACE_SYSTEM of<b=
r>
&gt; lttng-probe-kvm-x86 to avoid the clash.<br>
&gt;<br>
&gt; Signed-off-by: Francis Giraldeau &lt;<a href=3D"mailto:francis.giralde=
au@gmail.com" target=3D"_blank">francis.giraldeau@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; instrumentation/events/lttng-module/arch/x86/kvm/trace.h | 2 +-<br>
&gt; 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/instrumentation/events/lttng-module/arch/x86/kvm/trace.h<=
br>
&gt; b/instrumentation/events/lttng-module/arch/x86/kvm/trace.h<br>
&gt; index 32c4743..ddbfda7 100644<br>
&gt; --- a/instrumentation/events/lttng-module/arch/x86/kvm/trace.h<br>
&gt; +++ b/instrumentation/events/lttng-module/arch/x86/kvm/trace.h<br>
&gt; @@ -12,7 +12,7 @@<br>
&gt; #include &lt;../arch/x86/kvm/kvm_cache_regs.h&gt;<br>
&gt;<br>
&gt; #undef TRACE_SYSTEM<br>
&gt; -#define TRACE_SYSTEM kvm<br>
&gt; +#define TRACE_SYSTEM kvm_x86<br>
&gt;<br>
&gt; /*<br>
&gt;=C2=A0 * Tracepoint for guest mode entry.<br>
&gt; --<br>
&gt; 2.1.4<br>
&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
rel=3D"noreferrer" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman=
/listinfo/lttng-dev</a><br>
<br>
--<br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" rel=3D"noreferrer" target=3D"_blank">ht=
tp://www.efficios.com</a><br>
</blockquote></div></div>

--001a1146ed3aa2c532051b7c924e--


--===============0513497181==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0513497181==--
