From: J Lin <jmlin.jmlin@gmail.com>
Subject: Re: Strange result from LTTng porting to ARM
Date: Fri, 21 Nov 2014 15:29:24 +0800
Message-ID: <CACtA8QQQ1YZkNMqrzs6SLwAEuGpTk3Juiag4LcDsbZ8Oh7hujg__9909.84157328985$1416555022$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD6FBC890A@VAL-E-02.valcartier.drdc-rddc.gc.ca>
 <CACtA8QRE5Y70-Tiss4siDufPyoUzgKBR7BUWR_XYwNSL0UkKuQ@mail.gmail.com>
 <1715996455.14931.1416243216473.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0182881829=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jmlin.jmlin@gmail.com>) id 1Xrieo-0004jt-2H
 for lttng-dev@lists.lttng.org; Fri, 21 Nov 2014 02:29:35 -0500
Received: by mail-ie0-f175.google.com with SMTP id at20so4285093iec.6
 for <lttng-dev@lists.lttng.org>; Thu, 20 Nov 2014 23:29:24 -0800 (PST)
In-Reply-To: <1715996455.14931.1416243216473.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0182881829==
Content-Type: multipart/alternative; boundary=089e013cbd5e74f127050859676f

--089e013cbd5e74f127050859676f
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello Mathieu,

We have resolved the problem. It was a problem of IP protection that
prevented us from acessing certain memory addresses. Now investigating
problems with live tracing > Error: Unable to reach lttng-relayd. Will open
another thread if the problem persists.

Thanks,
MIKE

2014-11-18 0:53 GMT+08:00 Mathieu Desnoyers <mathieu.desnoyers@efficios.com=
>
:

> Hi,
>
> There is little we can do without information about the kernel
> customization that have been done in your use-case. Most likely,
> there might be one customization that breaks tracepoints located
> in the core kernel. It appears that only the tracepoints present in
> the lttng-module modules are traced.
>
> Just as a guess, do you have CONFIG_JUMP_LABEL=3Dy
> in your config ? Try setting it to "n'. Just in case they would
> happen to be broken on your specific kernel version/customization.
>
> Good luck!
>
> Mathieu
>
> ------------------------------
>
> *From: *"J Lin" <jmlin.jmlin@gmail.com>
> *To: *"Daniel Thibault" <Daniel.Thibault@drdc-rddc.gc.ca>
> *Cc: *lttng-dev@lists.lttng.org
> *Sent: *Thursday, November 13, 2014 6:12:14 AM
> *Subject: *Re: [lttng-dev] Strange result from LTTng porting to ARM
>
>
> Hello Daniel,
>
> I should correct myself and say cross compiled LTTng to run on ARM. We
> installed lttng-modules via insmod and verified with lsmod. Regarding
> lttng-modules, there was a problem compiling where duplicate definition
> occurred. We use kernel version 3.8 and in the source code saw the
> conflicting section "should be" guarded for version less than 3.15. So we
> added version check to work around it.
>
> We have not tested ust yet. But have compiled all three (lttng-ust,
> lttng-tools, lttng-modules) and placed on development board. Right now, w=
e
> are just doing a simple trace for a certain irq that triggers every 4ms.
> This is the most information we got:
> [00:01:36.985006316] (+0.001175688) (none) lttng_statedump_interrupt: {
> cpu_id =3D 0 }, { irq =3D 29, name =3D "GIC", action =3D "twd" }
>
> Also noticed this when creating a session:
> [ 2][   64.512057] ##### send signal SIG : 10,
> lttng-sessiond(373)->lttng(262) __send_signal
>
> Thanks,
> MIKE
>
> 2014-11-13 3:10 GMT+08:00 Thibault, Daniel <
> Daniel.Thibault@drdc-rddc.gc.ca>:
>
>> ----------------------------------------------------------------------
>> Date: Wed, 12 Nov 2014 23:26:41 +0800
>> From: J Lin <jmlin.jmlin@gmail.com>
>>
>> > I've recently ported LTTng to ARM and I can't seem to understand what
>> is going wrong with my results. I ran a typical session with "lttng
>> enable-event -k -a" for test. Here are the observations:
>> >
>> > 1. only "lttng_xxx (e.g, lttng_statedump_interrupts)" are recorded 2.
>> different sessions yield trace on different CPU (the system has 4) but n=
ot
>> for all 4, just 1 cpu 3. no recorded session span more than 1 second tho=
ugh
>> I would run sleep (i.e., 10s) between "start" and "stop"
>> >
>> > This leads me to believe LTTng might be dependent on something in the
>> system that isn't present. This is a customized kernel of a client. It h=
as
>> all required configs.
>> >
>> > If there is a trigger mechanism after running "lttng start", what woul=
d
>> it be? It seems it grabs items initially then doesn't continue. I read i=
n
>> one of the papers that LTTng is architecture dependent. Any help is
>> appreciated.
>> >
>> > Mike
>>
>>    How exactly did you "port" LTTng to ARM?  As far as I know, you need
>> only rebuild it there.  Your symptoms lead me to believe you may have no=
t
>> installed the requisite lttng-modules.  Did you test user-space tracing?
>>
>> Daniel U. Thibault
>> Protection des syst=C3=A8mes et contremesures (PSC) | Systems Protection=
 &
>> Countermeasures (SPC)
>> Cyber s=C3=A9curit=C3=A9 pour les missions essentielles (CME) | Mission =
Critical
>> Cyber Security (MCCS)
>> RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research
>> Centre
>> 2459 route de la Bravoure
>> Qu=C3=A9bec QC  G3J 1X5
>> CANADA
>> Vox : (418) 844-4000 x4245
>> Fax : (418) 844-4538
>> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
>> Gouvernement du Canada | Government of Canada
>> <http://www.valcartier.drdc-rddc.gc.ca/>
>>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--089e013cbd5e74f127050859676f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello Mathieu,<div><br></div><div>We have resolved the pro=
blem. It was a problem of IP protection that prevented us from acessing cer=
tain memory addresses. Now investigating problems with live tracing &gt; Er=
ror: Unable to reach lttng-relayd. Will open another thread if the problem =
persists.</div><div><br></div><div>Thanks,</div><div>MIKE</div></div><div c=
lass=3D"gmail_extra"><br><div class=3D"gmail_quote">2014-11-18 0:53 GMT+08:=
00 Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoy=
ers@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;<=
/span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex"><div><div style=3D"font-family:ti=
mes new roman,new york,times,serif;font-size:12pt;color:#000000"><div>Hi,<b=
r></div><div><br></div><div>There is little we can do without information a=
bout the kernel<br></div><div>customization that have been done in your use=
-case. Most likely,<br></div><div>there might be one customization that bre=
aks tracepoints located<br></div><div>in the core kernel. It appears that o=
nly the tracepoints present in<br></div><div>the lttng-module modules are t=
raced.<br></div><div><br></div><div>Just as a guess, do you have CONFIG_JUM=
P_LABEL=3Dy<br></div><div>in your config ? Try setting it to &quot;n&#39;. =
Just in case they would<br></div><div>happen to be broken on your specific =
kernel version/customization.<br></div><div><br></div><div>Good luck!<br></=
div><div><br></div><div>Mathieu<br></div><div><br></div><hr><blockquote sty=
le=3D"border-left:2px solid #1010ff;margin-left:5px;padding-left:5px;color:=
#000;font-weight:normal;font-style:normal;text-decoration:none;font-family:=
Helvetica,Arial,sans-serif;font-size:12pt"><b>From: </b>&quot;J Lin&quot; &=
lt;<a href=3D"mailto:jmlin.jmlin@gmail.com" target=3D"_blank">jmlin.jmlin@g=
mail.com</a>&gt;<br><b>To: </b>&quot;Daniel Thibault&quot; &lt;<a href=3D"m=
ailto:Daniel.Thibault@drdc-rddc.gc.ca" target=3D"_blank">Daniel.Thibault@dr=
dc-rddc.gc.ca</a>&gt;<br><b>Cc: </b><a href=3D"mailto:lttng-dev@lists.lttng=
.org" target=3D"_blank">lttng-dev@lists.lttng.org</a><br><b>Sent: </b>Thurs=
day, November 13, 2014 6:12:14 AM<br><b>Subject: </b>Re: [lttng-dev] Strang=
e result from LTTng porting to ARM<div><div class=3D"h5"><br><div><br></div=
><div dir=3D"ltr"><span style=3D"font-family:arial,sans-serif;font-size:14p=
x">Hello Daniel,</span><div style=3D"font-family:arial,sans-serif;font-size=
:14px"><br></div><div style=3D"font-family:arial,sans-serif;font-size:14px"=
>I should correct myself and say cross compiled LTTng to run on ARM. We ins=
talled lttng-modules via insmod and verified with lsmod. Regarding lttng-mo=
dules, there was a problem compiling where duplicate definition occurred. W=
e use kernel version 3.8 and in the source code saw the conflicting section=
 &quot;should be&quot; guarded for version less than 3.15. So we added vers=
ion check to work around it.</div><div style=3D"font-family:arial,sans-seri=
f;font-size:14px"><br></div><div style=3D"font-family:arial,sans-serif;font=
-size:14px">We have not tested ust yet. But have compiled all three (lttng-=
ust, lttng-tools, lttng-modules) and placed on development board. Right now=
, we are just doing a simple trace for a certain irq that triggers every 4m=
s. This is the most information we got:<br></div><div style=3D"font-family:=
arial,sans-serif;font-size:14px">[00:01:36.985006316] (+0.001175688) (none)=
 lttng_statedump_interrupt: { cpu_id =3D 0 }, { irq =3D 29, name =3D &quot;=
GIC&quot;, action =3D &quot;twd&quot; }<br></div><div style=3D"font-family:=
arial,sans-serif;font-size:14px"><br></div><div style=3D"font-family:arial,=
sans-serif;font-size:14px">Also noticed this when creating a session:</div>=
<div style=3D"font-family:arial,sans-serif;font-size:14px">[ 2][ =C2=A0 64.=
512057] ##### send signal SIG : 10, lttng-sessiond(373)-&gt;lttng(262) __se=
nd_signal</div><div style=3D"font-family:arial,sans-serif;font-size:14px"><=
br></div><div style=3D"font-family:arial,sans-serif;font-size:14px">Thanks,=
</div><div style=3D"font-family:arial,sans-serif;font-size:14px">MIKE</div>=
<div class=3D"gmail_extra"><br><div class=3D"gmail_quote">2014-11-13 3:10 G=
MT+08:00 Thibault, Daniel <span dir=3D"ltr">&lt;<a href=3D"mailto:Daniel.Th=
ibault@drdc-rddc.gc.ca" target=3D"_blank">Daniel.Thibault@drdc-rddc.gc.ca</=
a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">--------------------------=
--------------------------------------------<br> Date: Wed, 12 Nov 2014 23:=
26:41 +0800<br> From: J Lin &lt;<a href=3D"mailto:jmlin.jmlin@gmail.com" ta=
rget=3D"_blank">jmlin.jmlin@gmail.com</a>&gt;<br><div><div><br> &gt; I&#39;=
ve recently ported LTTng to ARM and I can&#39;t seem to understand what is =
going wrong with my results. I ran a typical session with &quot;lttng enabl=
e-event -k -a&quot; for test. Here are the observations:<br> &gt;<br> &gt; =
1. only &quot;lttng_xxx (e.g, lttng_statedump_interrupts)&quot; are recorde=
d 2. different sessions yield trace on different CPU (the system has 4) but=
 not for all 4, just 1 cpu 3. no recorded session span more than 1 second t=
hough I would run sleep (i.e., 10s) between &quot;start&quot; and &quot;sto=
p&quot;<br> &gt;<br> &gt; This leads me to believe LTTng might be dependent=
 on something in the system that isn&#39;t present. This is a customized ke=
rnel of a client. It has all required configs.<br> &gt;<br> &gt; If there i=
s a trigger mechanism after running &quot;lttng start&quot;, what would it =
be? It seems it grabs items initially then doesn&#39;t continue. I read in =
one of the papers that LTTng is architecture dependent. Any help is appreci=
ated.<br> &gt;<br></div></div>&gt; Mike<br> <br> =C2=A0 =C2=A0How exactly d=
id you &quot;port&quot; LTTng to ARM?=C2=A0 As far as I know, you need only=
 rebuild it there.=C2=A0 Your symptoms lead me to believe you may have not =
installed the requisite lttng-modules.=C2=A0 Did you test user-space tracin=
g?<br> <br> Daniel U. Thibault<br> Protection des syst=C3=A8mes et contreme=
sures (PSC) | Systems Protection &amp; Countermeasures (SPC)<br> Cyber s=C3=
=A9curit=C3=A9 pour les missions essentielles (CME) | Mission Critical Cybe=
r Security (MCCS)<br> RDDC - Centre de recherches de Valcartier | DRDC - Va=
lcartier Research Centre<br> 2459 route de la Bravoure<br> Qu=C3=A9bec QC=
=C2=A0 G3J 1X5<br> CANADA<br> Vox : <a href=3D"tel:%28418%29%20844-4000%20x=
4245" target=3D"_blank">(418) 844-4000 x4245</a><br> Fax : <a href=3D"tel:%=
28418%29%20844-4538" target=3D"_blank">(418) 844-4538</a><br> NAC : 918V QS=
DJ &lt;<a href=3D"http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ" targ=
et=3D"_blank">http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ</a>&gt;<b=
r> Gouvernement du Canada | Government of Canada<br> &lt;<a href=3D"http://=
www.valcartier.drdc-rddc.gc.ca/" target=3D"_blank">http://www.valcartier.dr=
dc-rddc.gc.ca/</a>&gt;<br></blockquote></div><br></div></div><br></div></di=
v>_______________________________________________<br>lttng-dev mailing list=
<br><a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-de=
v@lists.lttng.org</a><br><a href=3D"http://lists.lttng.org/cgi-bin/mailman/=
listinfo/lttng-dev" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailma=
n/listinfo/lttng-dev</a><span class=3D"HOEnZb"><font color=3D"#888888"><br>=
</font></span></blockquote><span class=3D"HOEnZb"><font color=3D"#888888"><=
div><br><br></div><div><br></div><div>-- <br></div><div><span name=3D"x"></=
span>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.c=
om" target=3D"_blank">http://www.efficios.com</a><span name=3D"x"></span><b=
r></div></font></span></div></div></blockquote></div><br></div>

--089e013cbd5e74f127050859676f--


--===============0182881829==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0182881829==--
