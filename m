From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Use get_domain_str on add
	context
Date: Tue, 5 Apr 2016 09:49:43 -0400
Message-ID: <CA+jJMxuCapag__=sUo_1gOb+c-4Wa9UgVobZkEuP2UuH_qQ0YQ__35805.3209413358$1459864207$gmane$org@mail.gmail.com>
References: <1458339923-7955-1-git-send-email-jonathan.rajotte-julien@efficios.com>
 <CA+jJMxuyd6HzZNQ_98EibMrnCzho4nbkixR8cPOj7uB+=uTULg@mail.gmail.com>
 <791925521.45480.1459862641781.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0956947338731199650=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f196.google.com (mail-ig0-f196.google.com
 [209.85.213.196])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 9E36EA2FCD
 for <lttng-dev@lists.lttng.org>; Tue,  5 Apr 2016 13:49:44 +0000 (UTC)
Received: by mail-ig0-f196.google.com with SMTP id qu10so2364717igc.1
 for <lttng-dev@lists.lttng.org>; Tue, 05 Apr 2016 06:49:44 -0700 (PDT)
In-Reply-To: <791925521.45480.1459862641781.JavaMail.zimbra@efficios.com>
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
Cc: lttng-dev@lists.lttng.org, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--===============0956947338731199650==
Content-Type: multipart/alternative; boundary=047d7b10d1ab0dfec2052fbd1ea6

--047d7b10d1ab0dfec2052fbd1ea6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Apr 5, 2016 09:24, "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
wrote:
>
> Hi J=C3=A9r=C3=A9mie,
>
> I don't see this commit in master nor stable-2.8,
> but I see newer commits from joraj that were merged
> after. Any idea why ?
>

It is indeed missing, thanks for the heads-up!

J=C3=A9r=C3=A9mie

> Thanks,
>
> Mathieu
>
> ----- On Apr 4, 2016, at 12:49 PM, Jeremie Galarneau
jeremie.galarneau@efficios.com wrote:
>
> > Merged, thanks!
> >
> > J=C3=A9r=C3=A9mie
> >
> > On Fri, Mar 18, 2016 at 6:25 PM, Jonathan Rajotte
> > <jonathan.rajotte-julien@efficios.com> wrote:
> >> Fixes #1006
> >>
> >> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> >> ---
> >>  src/bin/lttng/commands/add_context.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/src/bin/lttng/commands/add_context.c
> >> b/src/bin/lttng/commands/add_context.c
> >> index a6d73a0..f77edb1 100644
> >> --- a/src/bin/lttng/commands/add_context.c
> >> +++ b/src/bin/lttng/commands/add_context.c
> >> @@ -661,11 +661,11 @@ static int add_context(char *session_name)
> >>                 } else {
> >>                         if (opt_channel_name) {
> >>                                 MSG("%s context %s added to channel
%s",
> >> -                                               opt_kernel ? "kernel"
: "UST",
> >> type->opt->symbol,
> >> +
 get_domain_str(dom.type),
> >> type->opt->symbol,
> >>                                                 opt_channel_name);
> >>                         } else {
> >>                                 MSG("%s context %s added to all
channels",
> >> -                                               opt_kernel ? "kernel"
: "UST",
> >> type->opt->symbol)
> >> +
 get_domain_str(dom.type),
> >> type->opt->symbol)
> >>                         }
> >>                         success =3D 1;
> >>                 }
> >> --
> >> 2.7.0
> >>
> >
> >
> >
> > --
> > J=C3=A9r=C3=A9mie Galarneau
> > EfficiOS Inc.
> > http://www.efficios.com
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

--047d7b10d1ab0dfec2052fbd1ea6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On Apr 5, 2016 09:24, &quot;Mathieu Desnoyers&quot; &lt;<a href=3D"mailto:m=
athieu.desnoyers@efficios.com">mathieu.desnoyers@efficios.com</a>&gt; wrote=
:<br>
&gt;<br>
&gt; Hi J=C3=A9r=C3=A9mie,<br>
&gt;<br>
&gt; I don&#39;t see this commit in master nor stable-2.8,<br>
&gt; but I see newer commits from joraj that were merged<br>
&gt; after. Any idea why ?<br>
&gt;</p>
<p dir=3D"ltr">It is indeed missing, thanks for the heads-up!</p>
<p dir=3D"ltr">J=C3=A9r=C3=A9mie</p>
<p dir=3D"ltr">&gt; Thanks,<br>
&gt;<br>
&gt; Mathieu<br>
&gt;<br>
&gt; ----- On Apr 4, 2016, at 12:49 PM, Jeremie Galarneau <a href=3D"mailto=
:jeremie.galarneau@efficios.com">jeremie.galarneau@efficios.com</a> wrote:<=
br>
&gt;<br>
&gt; &gt; Merged, thanks!<br>
&gt; &gt;<br>
&gt; &gt; J=C3=A9r=C3=A9mie<br>
&gt; &gt;<br>
&gt; &gt; On Fri, Mar 18, 2016 at 6:25 PM, Jonathan Rajotte<br>
&gt; &gt; &lt;<a href=3D"mailto:jonathan.rajotte-julien@efficios.com">jonat=
han.rajotte-julien@efficios.com</a>&gt; wrote:<br>
&gt; &gt;&gt; Fixes #1006<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Signed-off-by: Jonathan Rajotte &lt;<a href=3D"mailto:jonatha=
n.rajotte-julien@efficios.com">jonathan.rajotte-julien@efficios.com</a>&gt;=
<br>
&gt; &gt;&gt; ---<br>
&gt; &gt;&gt;=C2=A0 src/bin/lttng/commands/add_context.c | 4 ++--<br>
&gt; &gt;&gt;=C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; diff --git a/src/bin/lttng/commands/add_context.c<br>
&gt; &gt;&gt; b/src/bin/lttng/commands/add_context.c<br>
&gt; &gt;&gt; index a6d73a0..f77edb1 100644<br>
&gt; &gt;&gt; --- a/src/bin/lttng/commands/add_context.c<br>
&gt; &gt;&gt; +++ b/src/bin/lttng/commands/add_context.c<br>
&gt; &gt;&gt; @@ -661,11 +661,11 @@ static int add_context(char *session_na=
me)<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
} else {<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (opt_channel_name) {<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MSG(&quot;%s contex=
t %s added to channel %s&quot;,<br>
&gt; &gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0opt_kernel ? &quot;kernel&quot; : &quot;U=
ST&quot;,<br>
&gt; &gt;&gt; type-&gt;opt-&gt;symbol,<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0get_domain_str(dom.type),<br>
&gt; &gt;&gt; type-&gt;opt-&gt;symbol,<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0opt_channel_name);<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MSG(&quot;%s contex=
t %s added to all channels&quot;,<br>
&gt; &gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0opt_kernel ? &quot;kernel&quot; : &quot;U=
ST&quot;,<br>
&gt; &gt;&gt; type-&gt;opt-&gt;symbol)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0get_domain_str(dom.type),<br>
&gt; &gt;&gt; type-&gt;opt-&gt;symbol)<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0success =3D 1;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
}<br>
&gt; &gt;&gt; --<br>
&gt; &gt;&gt; 2.7.0<br>
&gt; &gt;&gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; --<br>
&gt; &gt; J=C3=A9r=C3=A9mie Galarneau<br>
&gt; &gt; EfficiOS Inc.<br>
&gt; &gt; <a href=3D"http://www.efficios.com">http://www.efficios.com</a><b=
r>
&gt; &gt; _______________________________________________<br>
&gt; &gt; lttng-dev mailing list<br>
&gt; &gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttn=
g.org</a><br>
&gt; &gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng=
-dev">https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>
&gt;<br>
&gt; --<br>
&gt; Mathieu Desnoyers<br>
&gt; EfficiOS Inc.<br>
&gt; <a href=3D"http://www.efficios.com">http://www.efficios.com</a><br>
</p>

--047d7b10d1ab0dfec2052fbd1ea6--

--===============0956947338731199650==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============0956947338731199650==--
