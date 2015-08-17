From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Instrumenting a Shared Object
Date: Mon, 17 Aug 2015 18:22:07 -0400
Message-ID: <CA+jJMxvp+rZCAEtjhv+DAWRf8fFqOf4-8E5fbXp3URJKBc9AVg__13616.0547649071$1439850189$gmane$org@mail.gmail.com>
References: <SN1PR0301MB159862AA83F63780E73A8CFAC87D0@SN1PR0301MB1598.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1981863604=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f176.google.com ([209.85.160.176])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZRSnE-0002Ai-Ki
 for lttng-dev@lists.lttng.org; Mon, 17 Aug 2015 18:22:15 -0400
Received: by ykll84 with SMTP id l84so77487286ykl.0
 for <lttng-dev@lists.lttng.org>; Mon, 17 Aug 2015 15:22:07 -0700 (PDT)
In-Reply-To: <SN1PR0301MB159862AA83F63780E73A8CFAC87D0@SN1PR0301MB1598.namprd03.prod.outlook.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Brian Robbins <brianrob@microsoft.com>
Cc: Rama Krishnan Raghupathy <ramarag@microsoft.com>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1981863604==
Content-Type: multipart/alternative; boundary=001a113947465c8d7f051d893b15

--001a113947465c8d7f051d893b15
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Brian,

Mathieu will probably weigh in on this shortly. In the meantime, here's my
understanding of the problem.

In order to produce a trace, you have to ensure both liblttng-ust and your
provider(s) are linked into the application. That can be done either by
LD_PRELOAD-ing, dynamically linking, or dlopen-ing() both. Not linking
against liblttng-ust will simply result in your application not producing a
trace (since the application will never register to the session daemon),
but will have no adverse effect.

The real concern with dlclose-ing the providers is that you have to be
entirely sure that no tracepoints will be triggered after the provider is
unloaded/dlclose. There is no reference counting to ensure the provider
remains loaded as long as any probes remain reachable or any other
mechanism of the sort. Therefore, triggering a tracepoint after the
provider has been unloaded will result in a crash. Keep in mind that
triggering tracepoints remains entirely safe if the providers are never
loaded. Only triggering after a dlopen/dlclose of providers may cause
problems.

If you can guarantee this doesn't happen, you should be pretty much good to
go.

Regards,
J=C3=A9r=C3=A9mie


On Thu, Aug 13, 2015 at 7:40 PM, Brian Robbins <brianrob@microsoft.com>
wrote:

> Hello,
>
>
>
> I=E2=80=99m looking to instrument a shared object using LTTng-UST tracepo=
ints.
> The expectation is that users of the library will use dlopen to open it a=
t
> the beginning of their application and dlclose right before process exit.
> From what I=E2=80=99ve read at
> http://lttng.org/docs/#doc-building-tracepoint-providers-and-user-applica=
tion,
> it sounds like there is some complexity with this as the tracepoint
> definition must remain in memory, but I want to make sure I fully
> understand.
>
>
>
> If I want to instrument a shared object, is my only option to dynamically
> link and use LD_PRELOAD?  Also, do my options change if I know that the
> process will exit right after it calls dlclose on the library?
>
>
>
> Thank you very much.
>
> -Brian
>
>
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--001a113947465c8d7f051d893b15
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Brian,<div><br></div><div>Mathieu will probably weigh i=
n on this shortly. In the meantime, here&#39;s my understanding of the prob=
lem.</div><div><br></div><div>In order to produce a trace, you have to ensu=
re both liblttng-ust and your provider(s) are linked into the application. =
That can be done either by LD_PRELOAD-ing, dynamically linking, or dlopen-i=
ng() both. Not linking against liblttng-ust will simply result in your appl=
ication not producing a trace (since the application will never register to=
 the session daemon), but will have no adverse effect.</div><div><br></div>=
<div>The real concern with dlclose-ing the providers is that you have to be=
 entirely sure that no tracepoints will be triggered after the provider is =
unloaded/dlclose. There is no reference counting to ensure the provider rem=
ains loaded as long as any probes remain reachable or any other mechanism o=
f the sort. Therefore, triggering a tracepoint after the provider has been =
unloaded will result in a crash. Keep in mind that triggering tracepoints r=
emains entirely safe if the providers are never loaded. Only triggering aft=
er a dlopen/dlclose of providers may cause problems.</div><div><br></div><d=
iv>If you can guarantee this doesn&#39;t happen, you should be pretty much =
good to go.</div><div><br></div><div>Regards,</div><div>J=C3=A9r=C3=A9mie</=
div><div><br></div></div><div class=3D"gmail_extra"><br><div class=3D"gmail=
_quote">On Thu, Aug 13, 2015 at 7:40 PM, Brian Robbins <span dir=3D"ltr">&l=
t;<a href=3D"mailto:brianrob@microsoft.com" target=3D"_blank">brianrob@micr=
osoft.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">





<div lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div>
<p class=3D"MsoNormal">Hello,<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">I=E2=80=99m looking to instrument a shared object us=
ing LTTng-UST tracepoints.=C2=A0 The expectation is that users of the libra=
ry will use dlopen to open it at the beginning of their application and dlc=
lose right before process exit.=C2=A0 From what I=E2=80=99ve
 read at <span style=3D"font-size:10.0pt;font-family:&quot;Segoe UI&quot;,s=
ans-serif;color:black">
<a href=3D"http://lttng.org/docs/#doc-building-tracepoint-providers-and-use=
r-application" target=3D"_blank">http://lttng.org/docs/#doc-building-tracep=
oint-providers-and-user-application</a></span>, it sounds like there is som=
e complexity with this as the tracepoint definition must remain in memory, =
but I want to make sure I fully understand.<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">If I want to instrument a shared object, is my only =
option to dynamically link and use LD_PRELOAD?=C2=A0 Also, do my options ch=
ange if I know that the process will exit right after it calls dlclose on t=
he library?<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">Thank you very much.<span class=3D"HOEnZb"><font col=
or=3D"#888888"><u></u><u></u></font></span></p><span class=3D"HOEnZb"><font=
 color=3D"#888888">
<p class=3D"MsoNormal">-Brian<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</font></span></div>
</div>

<br>_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/li=
stinfo/lttng-dev</a><br>
<br></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div cla=
ss=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS Inc.<br><a h=
ref=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.com</=
a></div>
</div>

--001a113947465c8d7f051d893b15--


--===============1981863604==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1981863604==--
