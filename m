From: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Subject: Re: Beginner question: how to inspect scheduling of
 multi-threaded user application?
Date: Wed, 24 Aug 2016 12:39:12 -0400
Message-ID: <CAF4oYfHyRe1KmbAgy4eKk6oDVWvZp+TP3SRXZ+BuJf5iWwEQwQ__26329.2113588706$1472056764$gmane$org@mail.gmail.com>
References: <35de22c3d2034f3abb75596477b23e3a@EUX13SRV1.EU.NEC.COM>
 <CADcCL0hqkvEPZEu85GzJnJKi9nOi0wntpOYoVz37QhcRVpb+=g@mail.gmail.com>
 <CAF4oYfHJCGnmmDfNokV2029Kp_8k7n1rCt4CX=OaLrLKEc_5wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0515356347014771057=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-it0-f44.google.com (mail-it0-f44.google.com
 [209.85.214.44])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 11678A3D43
 for <lttng-dev@lists.lttng.org>; Wed, 24 Aug 2016 16:39:30 +0000 (UTC)
Received: by mail-it0-f44.google.com with SMTP id n128so43960949ith.1
 for <lttng-dev@lists.lttng.org>; Wed, 24 Aug 2016 09:39:13 -0700 (PDT)
In-Reply-To: <CAF4oYfHJCGnmmDfNokV2029Kp_8k7n1rCt4CX=OaLrLKEc_5wg@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Francis Deslauriers <francis.deslauriers@mail.utoronto.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0515356347014771057==
Content-Type: multipart/alternative; boundary=94eb2c05c7d4db536e053ad3ebca

--94eb2c05c7d4db536e053ad3ebca
Content-Type: text/plain; charset=UTF-8

Sorry had a sending problem.

Here is the rest.

On Wed, Aug 24, 2016 at 12:35 PM, Jonathan Rajotte <
jonathan.r.julien@gmail.com> wrote:

> Hi,
>
> On Aug 24, 2016 12:18 PM, "Francis Deslauriers" <
> francis.deslauriers@mail.utoronto.ca> wrote:
> >
> > Hi David,
> > If you specifically want to trace the scheduling of the threads of your
> app, you don't need custom tracepoints.
> > Enabling the sched_switch kernel event will give you both of cpu id and
> thread id. Look at the cpu_id and next_tid fields.
> >
> > You can enable the sched_switch event using : lttng enable-event -k
> sched_switch
>
> In TraceCompass you can inspect this data with the control flow view and
> the Ressource view under the Kernel analysis node under the trace node in
> the project explorer.
>
> I'm not sure of the base requirement for those views you can use the safe
> enable-event:
>

replace "safe" by "easiest".


> lttng enable-event -k 'sched*'
>
>
> You can also use "lttng track" to limi the gathering of event to a certain
> pid.
>
>
> Another way to reduce the scope would be to filter per procname:
>
>
> lttng create
> lttng add-context -k -t procname
> lttng enable-event 'sched*' --filter '$ctx.procname == "PROCNAMEHERE"'
>
lttng start


PROCNAMEHERE can contain '*' wildcard. See the man page for more
information.

Cheers



> >
> > Cheers,
> > Francis
> >
> >
> > 2016-08-24 3:17 GMT-04:00 David Aldrich <David.Aldrich@emea.nec.com>:
> >>
> >> Hi
> >>
> >>
> >>
> >> I am new to tracing in Linux and to lttng. I have a multi-threaded user
> application and I want to see:
> >>
> >>
> >>
> >> 1)      When the threads are scheduled to run
> >>
> >> 2)      Which cores the threads are running on.
> >>
> >>
> >>
> >> I have installed lttng on Ubuntu 14.04 LTS.  I am expecting to
> visualise the trace using TraceCompass.
> >>
> >>
> >>
> >> I have read the following doc section:
> >>
> >>
> >>
> >> http://lttng.org/docs/#doc-tracing-your-own-user-application
> >>
> >>
> >>
> >> In order to collect my trace, must I define custom tracepoint
> definitions ( in a tracepoint provider header file ), and insert
> tracepoints into my user application, or is there a simpler way of
> achieving my goal?
> >>
> >>
> >>
> >> Best regards
> >>
> >>
> >>
> >> David
> >>
> >>
> >>
> >>
> >> _______________________________________________
> >> lttng-dev mailing list
> >> lttng-dev@lists.lttng.org
> >> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >>
> >
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
>



-- 
Jonathan Rajotte Julien

--94eb2c05c7d4db536e053ad3ebca
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Sorry had a sending problem.=C2=A0<div><br></div><div>Here=
 is the rest.</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote=
">On Wed, Aug 24, 2016 at 12:35 PM, Jonathan Rajotte <span dir=3D"ltr">&lt;=
<a href=3D"mailto:jonathan.r.julien@gmail.com" target=3D"_blank">jonathan.r=
.julien@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><=
div dir=3D"ltr"><p dir=3D"ltr">Hi,</p><span class=3D"">
<p dir=3D"ltr">On Aug 24, 2016 12:18 PM, &quot;Francis Deslauriers&quot; &l=
t;<a href=3D"mailto:francis.deslauriers@mail.utoronto.ca" target=3D"_blank"=
>francis.deslauriers@mail.utor<wbr>onto.ca</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi David,=C2=A0<br>
&gt; If you specifically want to trace the scheduling of the threads of you=
r app, you don&#39;t need custom tracepoints.<br>
&gt; Enabling the sched_switch kernel event will give you both of cpu id an=
d thread id. Look at the cpu_id and next_tid fields.<br>
&gt;<br>
&gt; You can enable the sched_switch event using : lttng enable-event -k sc=
hed_switch</p>
</span><p dir=3D"ltr">In TraceCompass you can inspect this data with the co=
ntrol flow view and the Ressource view under the Kernel analysis node under=
 the trace node in the project explorer.</p>
<p dir=3D"ltr">I&#39;m not sure of the base requirement for those views you=
 can use the safe enable-event:</p></div></blockquote><div><br></div><div>r=
eplace &quot;safe&quot; by &quot;easiest&quot;.</div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex"><div dir=3D"ltr">
<p dir=3D"ltr">lttng enable-event -k &#39;sched*&#39;</p><p dir=3D"ltr"><br=
></p><p>You can also use &quot;lttng track&quot; to limi the gathering of e=
vent to a certain pid.</p><p><br></p><p>Another way to reduce the scope wou=
ld be to filter per procname:</p><p><br></p><p>lttng create<br>lttng add-co=
ntext -k -t procname<br>lttng enable-event &#39;sched*&#39; --filter &#39;$=
ctx.procname =3D=3D &quot;PROCNAMEHERE&quot;&#39;</p></div></blockquote><di=
v>lttng start</div><div><br></div><div><br></div><div>PROCNAMEHERE can cont=
ain &#39;*&#39; wildcard. See the man page for more information.</div><div>=
<br></div><div>Cheers</div><div><br></div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex"><div dir=3D"ltr"><span class=3D""><p dir=3D"ltr">
&gt;<br>
&gt; Cheers,<br>
&gt; Francis<br>
&gt;<br>
&gt;<br>
&gt; 2016-08-24 3:17 GMT-04:00 David Aldrich &lt;<a href=3D"mailto:David.Al=
drich@emea.nec.com" target=3D"_blank">David.Aldrich@emea.nec.com</a>&gt;:<b=
r>
&gt;&gt;<br>
&gt;&gt; Hi<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0<br>
&gt;&gt;<br>
&gt;&gt; I am new to tracing in Linux and to lttng. I have a multi-threaded=
 user application and I want to see:<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0<br>
&gt;&gt;<br>
&gt;&gt; 1)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 When the threads are scheduled to=
 run<br>
&gt;&gt;<br>
&gt;&gt; 2)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Which cores the threads are runni=
ng on.<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0<br>
&gt;&gt;<br>
&gt;&gt; I have installed lttng on Ubuntu 14.04 LTS.=C2=A0 I am expecting t=
o visualise the trace using TraceCompass.<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0<br>
&gt;&gt;<br>
&gt;&gt; I have read the following doc section:<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0<br>
&gt;&gt;<br>
&gt;&gt; <a href=3D"http://lttng.org/docs/#doc-tracing-your-own-user-applic=
ation" target=3D"_blank">http://lttng.org/docs/#doc-tra<wbr>cing-your-own-u=
ser-application</a><br>
&gt;&gt;<br>
&gt;&gt; =C2=A0<br>
&gt;&gt;<br>
&gt;&gt; In order to collect my trace, must I define custom tracepoint defi=
nitions (=C2=A0in a tracepoint provider=C2=A0header file ), and insert trac=
epoints into my user application, or is there a simpler way of achieving my=
 goal?<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0<br>
&gt;&gt;<br>
&gt;&gt; Best regards<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0<br>
&gt;&gt;<br>
&gt;&gt; David<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; ______________________________<wbr>_________________<br>
&gt;&gt; lttng-dev mailing list<br>
&gt;&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">ltt=
ng-dev@lists.lttng.org</a><br>
&gt;&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-=
dev" target=3D"_blank">https://lists.lttng.org/cgi-bi<wbr>n/mailman/listinf=
o/lttng-dev</a><br>
&gt;&gt;<br>
&gt;<br>
&gt;<br>
&gt; ______________________________<wbr>_________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 target=3D"_blank">https://lists.lttng.org/cgi-bi<wbr>n/mailman/listinfo/lt=
tng-dev</a><br>
&gt;</p>
</span></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><d=
iv><div dir=3D"ltr">Jonathan Rajotte Julien<div><br></div></div></div></div=
></div>
</div></div>

--94eb2c05c7d4db536e053ad3ebca--

--===============0515356347014771057==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============0515356347014771057==--
