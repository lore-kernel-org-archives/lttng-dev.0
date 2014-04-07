From: Anand Neeli <anand.neeli@gmail.com>
Subject: Re: instrumenting shared library
Date: Mon, 7 Apr 2014 20:07:02 +0530
Message-ID: <CAM5kDqykNCO_XVjg8bOzDLTZ06Cja2UwdS4ZkHLpJrs9GR_sqw__4777.4294893772$1396881493$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD35992F74@VAL-E-02.valcartier.drdc-rddc.gc.ca>
 <CAM5kDqy62zjzLddVkRvg94jAxSCSN0uFqxmJL7RwN6XN31x0Jw@mail.gmail.com>
 <48CF5AC71E61DB46B70D0F388054EFFD3599315B@VAL-E-02.valcartier.drdc-rddc.gc.ca>
 <CAM5kDqyCTjKLWhR5XXT9DvXHaniOnJy0SPSDOMPw3eCSD7Z6Uw@mail.gmail.com>
 <CACFGcbbmW0mc3GHa9VYBQLiS6zrm1gQB8bkYMBFadnvM7QKeeQ@mail.gmail.com>
 <CAM5kDqySXuNqYcdjy+kgs-h5cDdiQSioumUX449Gfrcgg+HUbw@mail.gmail.com>
 <48CF5AC71E61DB46B70D0F388054EFFD35993659@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0837943230=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anand.neeli@gmail.com>) id 1WXAfc-0008Tb-UW
 for lttng-dev@lists.lttng.org; Mon, 07 Apr 2014 10:37:12 -0400
Received: by mail-pd0-f173.google.com with SMTP id z10so6623323pdj.18
 for <lttng-dev@lists.lttng.org>; Mon, 07 Apr 2014 07:37:03 -0700 (PDT)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD35993659@VAL-E-02.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0837943230==
Content-Type: multipart/alternative; boundary=001a1133048a02980204f674cd67

--001a1133048a02980204f674cd67
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Daniel,
I had spend sometime and compiled
Non-Instrumented app with static instrumented library
Non-Instrumented app with dynamic instrumented library
Instrumented app with static instrumented library
Instrumented app with dynamic instrumented library

Thanks for your help.

- It doest matter if the tracepoints are static or dynamically loaded with
the app. Once there is a change in tracepoints the app should be reloaded
(even though not compiled). Even though the tracepoints can be shared, but
changing tracepoints we would need to restart all the app's which share the
tracepoints.
(Just trying to make a statement on procs and cons here)


- * Does static or dynamic inclusion make difference(in terms of
performance) if someone always want to run in tracing mode??

Now let me put some light on how someone would like to use lttngin huge
codebases. (this is my personal opinion)
- Normally tracepoints are made per component/daemon. And not shared across
daemons/components.
- Tracing should always be running. It should never be switched off.
(unless the application is not mission critical)
- I'm planning to always run memory(snapshot) tracing with some fixed size
buffer, which can capture last n-events or n-bytes
- Above memory tracing users can create another tracing session and dump
traces to files if needed.(with their own filters and context in
enable-event)


Thanks again for spending your time on these queries.
-Anand Neeli





On Mon, Apr 7, 2014 at 6:53 PM, Thibault, Daniel <
Daniel.Thibault@drdc-rddc.gc.ca> wrote:

>     You need to define your concept of operations carefully.
>
>
>
>    An instrumented application can include its tracepoint provider in
> several ways.
>
>
>
>    One is static inclusion: the application will always be traceable, but
> any change to the tracepoints requires a recompilation of the app, plus t=
he
> tracepoint events it produces should not be shared with any other
> application (I say 'should' because they can, but it's a bad idea to do s=
o).
>
>
>
>    Another is dynamic inclusion with static awareness: the application
> will always be traceable, but will refuse to run if does not find the
> tracepoint provider library (typically provided by LD_PRELOAD). The
> tracepoint events can be shared with other applications.
>
>
>
>    The third is dynamic inclusion without static awareness: this operates
> as the previous, except that when the app does not find the tracepoint
> provider it runs normally but is not traceable. Turning off traceability =
in
> this way does give you a very small gain in performance.
>
>
>
>    The last is fully dynamic inclusion: the app is responsible for its ow=
n
> traceability because it loads and unloads its tracepoint provider itself
> (using dlopen and dlclose). This is more intrusive as the app's code need=
s
> to include this aspect, possibly reflected in its user interface (by a me=
nu
> item, for instance). On the good side it does mean you get the slight
> performance gain on demand.
>
>
>
>    If the very slight loss of performance due to tracing doesn't bother
> you, your best bet is probably dynamic inclusion without static awareness
> (third option). LTTng can then be configured to capture your app's traces
> using an on-disc circular buffer (see the tracefile-size and
> tracefile-count options of the enable-channel command). When your app
> misbehaves, you suspend it, suspend tracing (lttng stop), and copy the
> trace to a working directory. You can then babeltrace it or use the Eclip=
se
> LTTng views to analyse the trace. This works even better if your app is r=
un
> multiple times, because then LTTng will capture each running separately
> (see the buffers-pid and buffers-uid options of the enable-channel
> command). You only need to remember to flush the older traces once you've
> decided you don't need them anymore.
>
>
>
> Daniel U. Thibault
> Protection des syst=E8mes et contremesures (PSC) | Systems Protection &
> Countermeasures (SPC)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critica=
l
> Cyber Security (MCCS)
> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R=
&D
> Canada - Valcartier (DRDC Valcartier)
> 2459 route de la Bravoure
> Qu=E9bec QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ> <*h=
ttp://www.travelgis.com/map.asp?addr=3D918V%20QSDJ
> <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>*>
> Gouvernement du Canada | Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
>

--001a1133048a02980204f674cd67
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Daniel,<div>I had spend sometime and compiled</div><div=
>Non-Instrumented app with static instrumented library</div><div>Non-Instru=
mented app with dynamic instrumented library<br></div><div>Instrumented app=
 with static instrumented library<br>
</div><div>Instrumented app with dynamic instrumented library<br></div><div=
><div><br class=3D"">Thanks for your help.</div></div><div><br></div><div>-=
 It doest matter if the tracepoints are static or dynamically loaded with t=
he app. Once there is a change in tracepoints the app should be reloaded (e=
ven though not compiled). Even though the tracepoints can be shared, but ch=
anging tracepoints we would need to restart all the app&#39;s which share t=
he tracepoints.</div>
<div>(Just trying to make a statement on procs and cons here)</div><div><br=
></div><div><div><br></div><div>- * Does static or dynamic inclusion make d=
ifference(in terms of performance) if someone always want to run in tracing=
 mode??</div>
<div><br></div></div><div>Now let me put some light on how someone would li=
ke to use lttngin huge codebases. (this is my personal opinion)<br></div><d=
iv>- Normally tracepoints are made per component/daemon. And not shared acr=
oss daemons/components.</div>
<div>- Tracing should always be running. It should never be switched off. (=
unless the application is not mission critical)</div><div>- I&#39;m plannin=
g to always run memory(snapshot) tracing with some fixed size buffer, which=
 can capture last n-events or n-bytes</div>
<div>- Above memory tracing users can create another tracing session and du=
mp traces to files if needed.(with their own filters and context in enable-=
event)</div><div><br></div><div><br></div><div>Thanks again for spending yo=
ur time on these queries.</div>
<div>-Anand Neeli</div><div><br></div><div><br></div><div><br></div></div><=
div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Mon, Apr 7,=
 2014 at 6:53 PM, Thibault, Daniel <span dir=3D"ltr">&lt;<a href=3D"mailto:=
Daniel.Thibault@drdc-rddc.gc.ca" target=3D"_blank">Daniel.Thibault@drdc-rdd=
c.gc.ca</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">





<div lang=3D"FR-CA" link=3D"blue" vlink=3D"purple">
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:10.5pt;font-=
family:Consolas;color:#1f497d">&nbsp;&nbsp; You need to define your concept=
 of operations carefully.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:10.5pt;font-=
family:Consolas;color:#1f497d"><u></u>&nbsp;<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:10.5pt;font-=
family:Consolas;color:#1f497d">&nbsp;&nbsp; An instrumented application can=
 include its tracepoint provider in several ways.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:10.5pt;font-=
family:Consolas;color:#1f497d"><u></u>&nbsp;<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:10.5pt;font-=
family:Consolas;color:#1f497d">&nbsp;&nbsp; One is static inclusion: the ap=
plication will always be traceable, but any change to the tracepoints requi=
res a recompilation of the app, plus the tracepoint
 events it produces should not be shared with any other application (I say =
&lsquo;should&rsquo; because they can, but it&rsquo;s a bad idea to do so).=
<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:10.5pt;font-=
family:Consolas;color:#1f497d"><u></u>&nbsp;<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:10.5pt;font-=
family:Consolas;color:#1f497d">&nbsp;&nbsp; Another is dynamic inclusion wi=
th static awareness: the application will always be traceable, but will ref=
use to run if does not find the tracepoint provider
 library (typically provided by LD_PRELOAD). The tracepoint events can be s=
hared with other applications.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:10.5pt;font-=
family:Consolas;color:#1f497d"><u></u>&nbsp;<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:10.5pt;font-=
family:Consolas;color:#1f497d">&nbsp;&nbsp; The third is dynamic inclusion =
without static awareness: this operates as the previous, except that when t=
he app does not find the tracepoint provider it
 runs normally but is not traceable. Turning off traceability in this way d=
oes give you a very small gain in performance.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:10.5pt;font-=
family:Consolas;color:#1f497d"><u></u>&nbsp;<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:10.5pt;font-=
family:Consolas;color:#1f497d">&nbsp;&nbsp; The last is fully dynamic inclu=
sion: the app is responsible for its own traceability because it loads and =
unloads its tracepoint provider itself (using dlopen
 and dlclose). This is more intrusive as the app&rsquo;s code needs to incl=
ude this aspect, possibly reflected in its user interface (by a menu item, =
for instance). On the good side it does mean you get the slight performance=
 gain on demand.<u></u><u></u></span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:10.5pt;font-=
family:Consolas;color:#1f497d"><u></u>&nbsp;<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:10.5pt;font-=
family:Consolas;color:#1f497d">&nbsp;&nbsp; If the very slight loss of perf=
ormance due to tracing doesn&rsquo;t bother you, your best bet is probably =
dynamic inclusion without static awareness (third option).
 LTTng can then be configured to capture your app&rsquo;s traces using an o=
n-disc circular buffer (see the tracefile-size and tracefile-count options =
of the enable-channel command). When your app misbehaves, you suspend it, s=
uspend tracing (lttng stop), and copy
 the trace to a working directory. You can then babeltrace it or use the Ec=
lipse LTTng views to analyse the trace. This works even better if your app =
is run multiple times, because then LTTng will capture each running separat=
ely (see the buffers-pid and buffers-uid
 options of the enable-channel command). You only need to remember to flush=
 the older traces once you&rsquo;ve decided you don&rsquo;t need them anymo=
re.<u></u><u></u></span></p><div class=3D"">
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:10.5pt;font-=
family:Consolas;color:#1f497d"><u></u>&nbsp;<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:Consolas=
;color:#1f497d">Daniel U. Thibault<br>
Protection des syst=E8mes et contremesures (PSC) | Systems Protection &amp;=
 Countermeasures (SPC)<br>
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)<br>
R &amp; D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence=
 R&amp;D Canada - Valcartier (DRDC Valcartier)<br>
2459 route de la Bravoure<br>
Qu=E9bec QC&nbsp; G3J 1X5<br>
CANADA<br>
Vox</span><span style=3D"font-size:10.5pt;font-family:Consolas;color:#1f497=
d">&nbsp;</span><span style=3D"font-size:11.0pt;font-family:Consolas;color:=
#1f497d">: (418) 844-4000 x4245<br>
Fax</span><span style=3D"font-size:10.5pt;font-family:Consolas;color:#1f497=
d">&nbsp;</span><span style=3D"font-size:11.0pt;font-family:Consolas;color:=
#1f497d">: (418) 844-4538<br>
</span><span style=3D"font-size:11.0pt;font-family:Consolas;color:#1f497d">=
NAC&nbsp;: </span>
<span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-family:&quot;Calibri&qu=
ot;,&quot;sans-serif&quot;;color:#1f497d"><a href=3D"http://www.travelgis.c=
om/map.asp?addr=3D918V%20QSDJ" target=3D"_blank"><span lang=3D"FR-CA" style=
=3D"font-size:10.0pt;font-family:&quot;Courier New&quot;">918V QSDJ</span><=
/a></span><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-family:&quot;=
Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">
</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;;color:#1f497d">&lt;</span><u><span style=3D"font-size:10=
.0pt;font-family:&quot;Courier New&quot;;color:blue"><a href=3D"http://www.=
travelgis.com/map.asp?addr=3D918V%20QSDJ" target=3D"_blank">http://www.trav=
elgis.com/map.asp?addr=3D918V%20QSDJ</a></span></u><span style=3D"font-size=
:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497=
d">&gt;</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quo=
t;,&quot;sans-serif&quot;;color:#1f497d"><br>

</span><span style=3D"font-size:11.0pt;font-family:Consolas;color:#1f497d">=
Gouvernement du Canada&nbsp;| Government of Canada<br>
</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;;color:#1f497d">&lt;</span><span lang=3D"EN-CA" style=3D"=
font-size:10.0pt;font-family:&quot;Courier New&quot;;color:blue"><a href=3D=
"http://www.valcartier.drdc-rddc.gc.ca/" target=3D"_blank"><span lang=3D"FR=
-CA">http://www.valcartier.drdc-rddc.gc.ca/</span></a></span><span style=3D=
"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:#1f497d">&gt;</span><span style=3D"font-size:10.5pt;font-family:Consola=
s;color:#1f497d"><u></u><u></u></span></p>

</div></div>
</div>

</blockquote></div><br></div>

--001a1133048a02980204f674cd67--


--===============0837943230==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0837943230==--
