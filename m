From: Sean Heelan <seanheelan@gmail.com>
Subject: Re: Crash on first run of target using
 liblttng-ust-cyg-profile.so, but subsequent runs succeed
Date: Thu, 10 Mar 2016 23:02:04 +0000
Message-ID: <CAL90rL-FSUfgYo+k1ma+J-LfFaR0csFBuB2w-CLJCdM_yvb+bA__13735.7250940569$1457665677$gmane$org@mail.gmail.com>
References: <CAL90rL8u1_3ifDL2QzrqrQMp3+68PhOsMfgdsYhceoLX__MAJw@mail.gmail.com>
 <1311958269.14941.1456940749419.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0448533014480447924=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f179.google.com (mail-lb0-f179.google.com
 [209.85.217.179])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 905DEA0886
 for <lttng-dev@lists.lttng.org>; Thu, 10 Mar 2016 23:02:05 +0000 (UTC)
Received: by mail-lb0-f179.google.com with SMTP id k15so134348970lbg.0
 for <lttng-dev@lists.lttng.org>; Thu, 10 Mar 2016 15:02:05 -0800 (PST)
In-Reply-To: <1311958269.14941.1456940749419.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0448533014480447924==
Content-Type: multipart/alternative; boundary=047d7b342bac9840ec052db9cd1a

--047d7b342bac9840ec052db9cd1a
Content-Type: text/plain; charset=UTF-8

Hi Michael/everyone else,

Indeed the above does seem to resolve the issue. Thanks for looking into
this!

Cheers,
Sean


On Wed, Mar 2, 2016 at 5:45 PM, Michael Jeanson <mjeanson@efficios.com>
wrote:

> Hi Sean,
>
> As mentioned by Mathieu this is caused by the docker default seccomp
> profile
> blocking the "restart_syscall" syscall. This problem only happens on host
> systems where docker 0.10.2 and up was built against libseccomp 2.2.1 and
> up.
>
> Hopefully docker will add this syscall to their default whitelist but in
> the
> meantime, you can simply get the json profile [1] from git and add this :
>
>   {
>     "name": "restart_syscall",
>     "action": "SCMP_ACT_ALLOW",
>      "args": []
>   }
>
> Then start your container with "--security-opt
> seccomp:/path/to/myprofile.json".
>
> Hope it helps,
>
> Michael
>
>
> [1]
> https://github.com/docker/docker/blob/master/profiles/seccomp/default.json
>
>
> ----- On Feb 11, 2016, at 9:01 AM, Sean Heelan seanheelan@gmail.com wrote:
>
> > Hi all,
> >
> > I am running a target within a Docker instance, and tracing function
> execution
> > using the latest LTTng release (2.7). The commands I am issuing look as
> > follows:
> >
> > ----
> > lttng create cc_session -o bla
> > lttng enable-event --userspace lttng_ust_cyg_profile:func_entry
> > lttng start
> >
> > LD_PRELOAD=liblttng-ust-cyg-profile.so target
> >
> > lttng stop
> > lttng destroy
> > ----
> >
> > When the target is executed it aborts with the following error:
> >
> > ----
> > php: lttng-ust-comm.c:1582: lttng_ust_init: Assertion `!ret' failed.
> > ----
> >
> > If I rerun the command it then works fine. In fact, simply doing the
> following
> > within the Docker container demonstrates the issue:
> >
> > ----
> > LD_PRELOAD=liblttng-ust-cyg-profile.so ls
> > LD_PRELOAD=liblttng-ust-cyg-profile.so ls
> > ----
> >
> > The first 'ls' will fail at the same point mentioned above, while the
> second
> > will succeed. Off the top of my head I'm struggling to come up with an
> > explanation as to what impact the first execution using LD_PRELOAD would
> have
> > on the second. Does it impact a shared lib cache in some way, which I'm
> unaware
> > of?
> >
> > Any assistance would be appreciated!
> >
> > Sean
> >
> >
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

--047d7b342bac9840ec052db9cd1a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hi Michael/everyone else,<br><br></div>Inde=
ed the above does seem to resolve the issue. Thanks for looking into this! =
<br><br></div>Cheers,<br></div>Sean<br><br></div><div class=3D"gmail_extra"=
><br><div class=3D"gmail_quote">On Wed, Mar 2, 2016 at 5:45 PM, Michael Jea=
nson <span dir=3D"ltr">&lt;<a href=3D"mailto:mjeanson@efficios.com" target=
=3D"_blank">mjeanson@efficios.com</a>&gt;</span> wrote:<br><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">Hi Sean,<br>
<br>
As mentioned by Mathieu this is caused by the docker default seccomp profil=
e<br>
blocking the &quot;restart_syscall&quot; syscall. This problem only happens=
 on host<br>
systems where docker 0.10.2 and up was built against libseccomp 2.2.1 and u=
p.<br>
<br>
Hopefully docker will add this syscall to their default whitelist but in th=
e<br>
meantime, you can simply get the json profile [1] from git and add this :<b=
r>
<br>
=C2=A0 {<br>
=C2=A0 =C2=A0 &quot;name&quot;: &quot;restart_syscall&quot;,<br>
=C2=A0 =C2=A0 &quot;action&quot;: &quot;SCMP_ACT_ALLOW&quot;,<br>
=C2=A0 =C2=A0 =C2=A0&quot;args&quot;: []<br>
=C2=A0 }<br>
<br>
Then start your container with &quot;--security-opt seccomp:/path/to/myprof=
ile.json&quot;.<br>
<br>
Hope it helps,<br>
<br>
Michael<br>
<br>
<br>
[1] <a href=3D"https://github.com/docker/docker/blob/master/profiles/seccom=
p/default.json" rel=3D"noreferrer" target=3D"_blank">https://github.com/doc=
ker/docker/blob/master/profiles/seccomp/default.json</a><br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
----- On Feb 11, 2016, at 9:01 AM, Sean Heelan <a href=3D"mailto:seanheelan=
@gmail.com">seanheelan@gmail.com</a> wrote:<br>
<br>
&gt; Hi all,<br>
&gt;<br>
&gt; I am running a target within a Docker instance, and tracing function e=
xecution<br>
&gt; using the latest LTTng release (2.7). The commands I am issuing look a=
s<br>
&gt; follows:<br>
&gt;<br>
&gt; ----<br>
&gt; lttng create cc_session -o bla<br>
&gt; lttng enable-event --userspace lttng_ust_cyg_profile:func_entry<br>
&gt; lttng start<br>
&gt;<br>
&gt; LD_PRELOAD=3Dliblttng-ust-cyg-profile.so target<br>
&gt;<br>
&gt; lttng stop<br>
&gt; lttng destroy<br>
&gt; ----<br>
&gt;<br>
&gt; When the target is executed it aborts with the following error:<br>
&gt;<br>
&gt; ----<br>
&gt; php: lttng-ust-comm.c:1582: lttng_ust_init: Assertion `!ret&#39; faile=
d.<br>
&gt; ----<br>
&gt;<br>
&gt; If I rerun the command it then works fine. In fact, simply doing the f=
ollowing<br>
&gt; within the Docker container demonstrates the issue:<br>
&gt;<br>
&gt; ----<br>
&gt; LD_PRELOAD=3Dliblttng-ust-cyg-profile.so ls<br>
&gt; LD_PRELOAD=3Dliblttng-ust-cyg-profile.so ls<br>
&gt; ----<br>
&gt;<br>
&gt; The first &#39;ls&#39; will fail at the same point mentioned above, wh=
ile the second<br>
&gt; will succeed. Off the top of my head I&#39;m struggling to come up wit=
h an<br>
&gt; explanation as to what impact the first execution using LD_PRELOAD wou=
ld have<br>
&gt; on the second. Does it impact a shared lib cache in some way, which I&=
#39;m unaware<br>
&gt; of?<br>
&gt;<br>
&gt; Any assistance would be appreciated!<br>
&gt;<br>
&gt; Sean<br>
&gt;<br>
&gt;<br>
&gt;<br>
</div></div><div class=3D"HOEnZb"><div class=3D"h5">&gt; __________________=
_____________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
rel=3D"noreferrer" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman=
/listinfo/lttng-dev</a><br>
</div></div></blockquote></div><br></div>

--047d7b342bac9840ec052db9cd1a--

--===============0448533014480447924==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============0448533014480447924==--
