From: Ravindra Kumar Meena <rmeena840@gmail.com>
Subject: Re: [tracecompass-dev]  Question related to LTTng
Date: Thu, 28 Mar 2019 00:19:25 +0530
Message-ID: <CAEWVvOTtN_sckmpsXn6w4JkfFo4HYcta_YzwnfBhmZt_OeUJtA__6201.5366436512$1553786134$gmane$org@mail.gmail.com>
References: <CAEWVvOTEJjw3kYfPfrcW68Ux6fy1g5utoHBpy=o++d71rxddbg@mail.gmail.com>
 <f0d5b7b4-dacc-ca93-10d5-cc3f7c88d320@versatic.net>
 <BN8PR15MB3090BB0C0E9FC7D9865EF2369E580@BN8PR15MB3090.namprd15.prod.outlook.com>
 <CAEWVvOT1EQ9aS3Ao5u-nypV2ZrsDyHHMh9fEguLDgG27w6=gRw@mail.gmail.com>
 <BN8PR15MB30907BD062BC346E35C2B7E09E580@BN8PR15MB3090.namprd15.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8294245999354528735=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by lists.lttng.org (Postfix) with ESMTPS id 44TxrQ48GSz1872
 for <lttng-dev@lists.lttng.org>; Wed, 27 Mar 2019 14:49:58 -0400 (EDT)
Received: by mail-wr1-x430.google.com with SMTP id s15so19822738wra.12
 for <lttng-dev@lists.lttng.org>; Wed, 27 Mar 2019 11:49:58 -0700 (PDT)
In-Reply-To: <BN8PR15MB30907BD062BC346E35C2B7E09E580@BN8PR15MB3090.namprd15.prod.outlook.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Matthew Khouzam <matthew.khouzam@ericsson.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "tracecompass-dev@eclipse.org" <tracecompass-dev@eclipse.org>
List-Id: lttng-dev@lists.lttng.org

--===============8294245999354528735==
Content-Type: multipart/alternative; boundary="0000000000006faa45058517e791"

--0000000000006faa45058517e791
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> > So you have a user space application that generates a trace. It is
> virtualized, and you want to open it in trace compass to analyze it.
>


> Yes. That's what I want to do but it has to in real-time manner.
>


> > I would like to know if there is a way to transfer CTF to Trace Compass
> in a real-time manner using TCP/UDP.
>
>
> >Would scp work? Just asking.
>


> I am supposed to transfer it through only TCP/UDP.
>


> >How can I convert CTF Trace Data to LTTng? Since TraceCompass already
> understands LTTng Trace Data.
>
>
> >The CTF trace should be openable in Trace Compass. You won't have as man=
y
> pretty graphs and whatnot, but you can get some basic analyses done with
> searching and filters. If you want some more advanced analyses, you can
> code an XML analysis, or use any language you want and parse it to make a
> LAMI report. Finally you can make your own analysis (and even commit it t=
o
> the incubator! =F0=9F=98=89 =F0=9F=98=89 ).
>
>
>     >The information that I want to analyze and display information
includes CPU usage, IRQ analysis(IRQ Statistics, IRQ Table, IRQ vs Count,
IRQ vs Time), Linux Kernel(Control Flow, Resources)


> The important questions to ask in my opinion are :
>
>    - what are you looking to solve?
>    - what problem are you facing?
>
>
> Once those questions are solved, we can move on to selecting the form of
> solution that is ideal for you.
>
>
> Thanks for the interest,
>
> Matthew.
>
> ------------------------------
> *From:* Ravindra Kumar Meena <rmeena840@gmail.com>
> *Sent:* Wednesday, March 27, 2019 2:14:32 PM
> *To:* Matthew Khouzam
> *Cc:* lttng-dev@lists.lttng.org; tracecompass-dev@eclipse.org
> *Subject:* Re: [tracecompass-dev] [lttng-dev] Question related to LTTng
>
> Hi,
>
> Thanks to all for suggestions. Let me describe the problem in more detail=
.
>
> I have a QEMU(it is virtualization software like VMware etc.) instance
> which is running some applications. The QEMU application can generate Tra=
ce
> Data in CTF format which I want to transfer it to Trace Compass for
> analyzing it.
>
> I would like to know if there is a way to transfer CTF to Trace Compass i=
n
> a real-time manner using TCP/UDP.
>
> and
>
> How can I convert CTF Trace Data to LTTng? Since TraceCompass already
> understands LTTng Trace Data.
>
> P.S: I am a student working on Tracing project at my University.
>
> Thanks
>
> On Wed, Mar 27, 2019 at 11:01 PM Matthew Khouzam <
> matthew.khouzam@ericsson.com> wrote:
>
> Hi Ravindra,
>
>
> could you please detail what you want to do, there is a decent chance
> trace compass supports that out of the box.
>
>
> BR,
>
> Matthew
> ------------------------------
> *From:* tracecompass-dev-bounces@eclipse.org <
> tracecompass-dev-bounces@eclipse.org> on behalf of Genevieve Bastien <
> gbastien@versatic.net>
> *Sent:* Wednesday, March 27, 2019 1:03:08 PM
> *To:* lttng-dev@lists.lttng.org; Ravindra Kumar Meena;
> tracecompass-dev@eclipse.org
> *Subject:* Re: [tracecompass-dev] [lttng-dev] Question related to LTTng
>
> Hi Ravindra,
>
> I'm sending the reply also to the tracecompass mailing list, where it is
> more on topic.
>
> On 2019-03-27 7:23 a.m., Ravindra Kumar Meena wrote:
> > Hi Developers,
> >
> > I am working on a project where I want Trace Compass to analyze and
> > display some information. I wanna ask a few things:
> >
> > Q1. Is there any way to extend Trace Compass to work trace data in CTF
> > format?
>
> From what I understand, you have a CTF trace and would like to implement
> a specific trace type from it, for example, to be able to add custom
> analyses for this specific type. Right?
>
> You can read the developer documentation on how to add new trace types
> [1]. You may want to take a look at the LttngKernelTrace class for an
> example of such extension of CTF Trace [2]. There are a few more around
> the code, looking at the class hierarchy for CtfTmfTrace will show you
> which ones.
>
> >
> > Q2. How trace data(CTF) can be converted to Linux kernel trace
> > data(LTTng) which Trace Compass already understands?
> Kernel traces need to implement IKernelTrace. This interface provides an
> event layout (IKernelAnalysisEventLayout) which will define which events
> in the trace correspond to common "concepts" of the kernel, like
> sched_switches, syscalls, irqs, etc. That's how any kernel trace format
> like ftrace, perf and lttng can use common analyses made for kernel. You
> would need to implement this event layout for your own trace types.
>
>
> [1]
>
> http://archive.eclipse.org/tracecompass/doc/org.eclipse.tracecompass.doc.=
dev/Implementing-a-New-Trace-Type.html#Implementing_a_New_Trace_Type
>
> [2]
>
> https://git.eclipse.org/c/tracecompass/org.eclipse.tracecompass.git/tree/=
lttng/org.eclipse.tracecompass.lttng2.kernel.core/src/org/eclipse/tracecomp=
ass/lttng2/kernel/core/trace/LttngKernelTrace.java
>
>
> Cheers,
>
> Genevi=C3=A8ve
>
>
>
>
> _______________________________________________
> tracecompass-dev mailing list
> tracecompass-dev@eclipse.org
> To change your delivery options, retrieve your password, or unsubscribe
> from this list, visit
> https://www.eclipse.org/mailman/listinfo/tracecompass-dev
>
>
>
> --
> *Ravindra Kumar Meena*,
> B. Tech. Computer Science and Engineering,
> Indian Institute of Technology (Indian School of Mines)
> <https://www.iitism.ac.in/>, Dhanbad
>


--=20
*Ravindra Kumar Meena*,
B. Tech. Computer Science and Engineering,
Indian Institute of Technology (Indian School of Mines)
<https://www.iitism.ac.in/>, Dhanbad

--0000000000006faa45058517e791
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex"><div dir=3D"ltr"><div id=3D"m_7752166956455312320gmail-m=
_6403026334017903746divtagdefaultwrapper" style=3D"font-size:12pt;font-fami=
ly:Calibri,Helvetica,sans-serif" dir=3D"ltr"><p style=3D"margin-top:0px;mar=
gin-bottom:0px"><span style=3D"font-size:12pt"><font color=3D"#ff0000">&gt;=
 So you have a user space application that generates a trace. It is virtual=
ized, and you want to open it in trace compass to analyze it.</font></span>=
</p></div></div></blockquote><div>=C2=A0=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex"><div dir=3D"ltr"><div id=3D"m_775216695645531232=
0gmail-m_6403026334017903746divtagdefaultwrapper" style=3D"font-size:12pt;c=
olor:rgb(0,0,0);font-family:Calibri,Helvetica,sans-serif" dir=3D"ltr">
<p style=3D"margin-top:0px;margin-bottom:0px">Yes. That&#39;s what I want t=
o do but it has to in real-time manner.</p></div></div></blockquote><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"l=
tr"><div id=3D"m_7752166956455312320gmail-m_6403026334017903746divtagdefaul=
twrapper" style=3D"font-size:12pt;font-family:Calibri,Helvetica,sans-serif"=
 dir=3D"ltr">
<p style=3D"margin-top:0px;margin-bottom:0px"><font color=3D"#ff0000">&gt; =
I would like to know if there is a way to transfer CTF to Trace Compass in =
a real-time manner using TCP/UDP.</font></p>
<p style=3D"color:rgb(0,0,0);margin-top:0px;margin-bottom:0px"><br>
</p>
<p style=3D"margin-top:0px;margin-bottom:0px"><font color=3D"#ff0000">&gt;W=
ould scp work? Just asking.</font></p></div></div></blockquote><div>=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><di=
v id=3D"m_7752166956455312320gmail-m_6403026334017903746divtagdefaultwrappe=
r" style=3D"font-size:12pt;color:rgb(0,0,0);font-family:Calibri,Helvetica,s=
ans-serif" dir=3D"ltr">
<p style=3D"margin-top:0px;margin-bottom:0px">I am supposed to transfer it =
through only TCP/UDP.</p></div></div></blockquote><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div id=3D"m_775=
2166956455312320gmail-m_6403026334017903746divtagdefaultwrapper" style=3D"f=
ont-size:12pt;font-family:Calibri,Helvetica,sans-serif" dir=3D"ltr">
<p style=3D"margin-top:0px;margin-bottom:0px"><font color=3D"#ff0000">&gt;H=
ow can I convert CTF Trace Data to LTTng? Since TraceCompass already unders=
tands LTTng Trace Data.</font></p>
<p style=3D"margin-top:0px;margin-bottom:0px"><font color=3D"#ff0000"><br>
</font></p>
<p style=3D"margin-top:0px;margin-bottom:0px"><font color=3D"#ff0000">&gt;T=
he CTF trace should be openable in Trace Compass. You won&#39;t have as man=
y pretty graphs and whatnot, but you can get some basic analyses done with =
searching and filters. If you want some more advanced analyses, you can cod=
e an XML analysis, or use any language you want and parse it to make a LAMI=
 report. Finally you can make your own analysis (and even commit it to the =
incubator! =F0=9F=98=89 =F0=9F=98=89 ).</font></p>
<p style=3D"color:rgb(0,0,0);margin-top:0px;margin-bottom:0px"><br></p></di=
v></div></blockquote><div>=C2=A0 =C2=A0 &gt;<span style=3D"background-color=
:transparent;color:rgb(0,0,0);font-family:Arial;font-size:12pt;white-space:=
pre-wrap">The information that I want to analyze and display information in=
cludes CPU usage, IRQ analysis(IRQ Statistics, IRQ Table, IRQ vs Count, IRQ=
 vs Time), Linux Kernel(Control Flow, Resources)</span></div><div>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div =
id=3D"m_7752166956455312320gmail-m_6403026334017903746divtagdefaultwrapper"=
 style=3D"font-size:12pt;font-family:Calibri,Helvetica,sans-serif" dir=3D"l=
tr"><p style=3D"color:rgb(0,0,0);margin-top:0px;margin-bottom:0px">
</p>
<p style=3D"margin-top:0px;margin-bottom:0px"><font color=3D"#ff0000">The i=
mportant questions to ask in my opinion are :</font></p>
<ul style=3D"margin-bottom:0px;margin-top:0px">
<li><font color=3D"#ff0000">what are you looking to solve?</font></li><li><=
font color=3D"#ff0000">what problem are you facing?</font></li></ul>
<p style=3D"margin-top:0px;margin-bottom:0px"><font color=3D"#ff0000"><br>
</font></p>
<p style=3D"margin-top:0px;margin-bottom:0px"><font color=3D"#ff0000">Once =
those questions are solved, we can move on to selecting the form of solutio=
n that is ideal for you.</font></p>
<p style=3D"margin-top:0px;margin-bottom:0px"><font color=3D"#ff0000"><br>
</font></p>
<p style=3D"margin-top:0px;margin-bottom:0px"><font color=3D"#ff0000">Thank=
s for the interest,</font></p>
<p style=3D"margin-top:0px;margin-bottom:0px"><font color=3D"#ff0000">Matth=
ew.</font><br>
</p>
<br>
</div>
<hr style=3D"display:inline-block;width:98%">
<div id=3D"m_7752166956455312320gmail-m_6403026334017903746divRplyFwdMsg" d=
ir=3D"ltr"><font face=3D"Calibri, sans-serif" style=3D"font-size:11pt" colo=
r=3D"#000000"><b>From:</b> Ravindra Kumar Meena &lt;<a href=3D"mailto:rmeen=
a840@gmail.com" target=3D"_blank">rmeena840@gmail.com</a>&gt;<br>
<b>Sent:</b> Wednesday, March 27, 2019 2:14:32 PM<br>
<b>To:</b> Matthew Khouzam<br>
<b>Cc:</b> <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">l=
ttng-dev@lists.lttng.org</a>; <a href=3D"mailto:tracecompass-dev@eclipse.or=
g" target=3D"_blank">tracecompass-dev@eclipse.org</a><br>
<b>Subject:</b> Re: [tracecompass-dev] [lttng-dev] Question related to LTTn=
g</font>
<div>=C2=A0</div>
</div>
<div>
<div dir=3D"ltr">Hi,<div><br>
</div>
<div>Thanks to all for suggestions. Let me describe the problem in more det=
ail.</div>
<div><br>
</div>
<div>I have a QEMU(it is virtualization software like VMware etc.) instance=
 which is running some applications. The QEMU application can generate Trac=
e Data in CTF format which I want to transfer it to Trace Compass for analy=
zing it.=C2=A0</div>
<div><br>
</div>
<div>I would like to know if there is a way to transfer CTF to Trace Compas=
s in a real-time manner using TCP/UDP.</div>
<div><br>
</div>
<div>and</div>
<div><br>
</div>
<div>How can I convert CTF Trace Data to LTTng? Since TraceCompass already =
understands LTTng Trace Data.</div>
<div><br>
</div>
<div>P.S: I am a student=C2=A0working on Tracing project at my University.<=
/div>
<div><br>
</div>
<div>Thanks</div>
</div>
<br>
<div class=3D"m_7752166956455312320gmail-m_6403026334017903746x_gmail_quote=
">
<div dir=3D"ltr" class=3D"m_7752166956455312320gmail-m_6403026334017903746x=
_gmail_attr">On Wed, Mar 27, 2019 at 11:01 PM Matthew Khouzam &lt;<a href=
=3D"mailto:matthew.khouzam@ericsson.com" target=3D"_blank">matthew.khouzam@=
ericsson.com</a>&gt; wrote:<br>
</div>
<blockquote class=3D"m_7752166956455312320gmail-m_6403026334017903746x_gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
<div dir=3D"ltr">
<div id=3D"m_7752166956455312320gmail-m_6403026334017903746x_gmail-m_-14738=
379410950796divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt;color=
:rgb(0,0,0);font-family:Calibri,Helvetica,sans-serif">
<p style=3D"margin-top:0px;margin-bottom:0px">Hi Ravindra, <br>
</p>
<p style=3D"margin-top:0px;margin-bottom:0px"><br>
</p>
<p style=3D"margin-top:0px;margin-bottom:0px">could you please detail what =
you want to do, there is a decent chance trace compass supports that out of=
 the box.</p>
<p style=3D"margin-top:0px;margin-bottom:0px"><br>
</p>
<p style=3D"margin-top:0px;margin-bottom:0px">BR,</p>
<p style=3D"margin-top:0px;margin-bottom:0px">Matthew<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%">
<div id=3D"m_7752166956455312320gmail-m_6403026334017903746x_gmail-m_-14738=
379410950796divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" c=
olor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> <a href=3D"mailto:tr=
acecompass-dev-bounces@eclipse.org" target=3D"_blank">tracecompass-dev-boun=
ces@eclipse.org</a> &lt;<a href=3D"mailto:tracecompass-dev-bounces@eclipse.=
org" target=3D"_blank">tracecompass-dev-bounces@eclipse.org</a>&gt; on beha=
lf of Genevieve Bastien &lt;<a href=3D"mailto:gbastien@versatic.net" target=
=3D"_blank">gbastien@versatic.net</a>&gt;<br>
<b>Sent:</b> Wednesday, March 27, 2019 1:03:08 PM<br>
<b>To:</b> <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">l=
ttng-dev@lists.lttng.org</a>; Ravindra Kumar Meena; <a href=3D"mailto:trace=
compass-dev@eclipse.org" target=3D"_blank">tracecompass-dev@eclipse.org</a>=
<br>
<b>Subject:</b> Re: [tracecompass-dev] [lttng-dev] Question related to LTTn=
g</font>
<div>=C2=A0</div>
</div>
<div class=3D"m_7752166956455312320gmail-m_6403026334017903746x_gmail-m_-14=
738379410950796BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt=
"> <div class=3D"m_7752166956455312320gmail-m_6403026334017903746x_gmail-m_=
-14738379410950796PlainText">Hi Ravindra,<br>
<br>I&#39;m sending the reply also to the tracecompass mailing list, where =
it is<br>more on topic.<br>
<br>On 2019-03-27 7:23 a.m., Ravindra Kumar Meena wrote:<br>&gt; Hi Develop=
ers,<br>&gt;<br>&gt; I am working on a=C2=A0project where I want Trace Comp=
ass to analyze and<br>&gt; display some information. I wanna ask a few thin=
gs:<br>&gt;<br>&gt; Q1. Is there any way to extend Trace Compass to work tr=
ace data in CTF<br>&gt; format?<br>
<br>From what I understand, you have a CTF trace and would like to implemen=
t<br>a specific trace type from it, for example, to be able to add custom<b=
r>analyses for this specific type. Right?<br>
<br>You can read the developer documentation on how to add new trace types<=
br>[1]. You may want to take a look at the LttngKernelTrace class for an<br=
>example of such extension of CTF Trace [2]. There are a few more around<br=
>the code, looking at the class hierarchy for CtfTmfTrace will show you<br>=
which ones.<br>
<br>&gt;<br>&gt; Q2. How trace data(CTF) can be converted to Linux kernel t=
race<br>&gt; data(LTTng) which Trace Compass already understands?<br>Kernel=
 traces need to implement IKernelTrace. This interface provides an<br>event=
 layout (IKernelAnalysisEventLayout) which will define which events<br>in t=
he trace correspond to common &quot;concepts&quot; of the kernel, like<br>s=
ched_switches, syscalls, irqs, etc. That&#39;s how any kernel trace format<=
br>like ftrace, perf and lttng can use common analyses made for kernel. You=
<br>would need to implement this event layout for your own trace types.<br>
<br>
<br>[1]<br>
<a href=3D"http://archive.eclipse.org/tracecompass/doc/org.eclipse.tracecom=
pass.doc.dev/Implementing-a-New-Trace-Type.html#Implementing_a_New_Trace_Ty=
pe" target=3D"_blank">http://archive.eclipse.org/tracecompass/doc/org.eclip=
se.tracecompass.doc.dev/Implementing-a-New-Trace-Type.html#Implementing_a_N=
ew_Trace_Type</a><br>
<br>[2]<br>
<a href=3D"https://git.eclipse.org/c/tracecompass/org.eclipse.tracecompass.=
git/tree/lttng/org.eclipse.tracecompass.lttng2.kernel.core/src/org/eclipse/=
tracecompass/lttng2/kernel/core/trace/LttngKernelTrace.java" target=3D"_bla=
nk">https://git.eclipse.org/c/tracecompass/org.eclipse.tracecompass.git/tre=
e/lttng/org.eclipse.tracecompass.lttng2.kernel.core/src/org/eclipse/traceco=
mpass/lttng2/kernel/core/trace/LttngKernelTrace.java</a><br>
<br>
<br>Cheers,<br>
<br>Genevi=C3=A8ve<br>
<br>
<br>
<br>
<br>_______________________________________________<br>tracecompass-dev mai=
ling list<br>
<a href=3D"mailto:tracecompass-dev@eclipse.org" target=3D"_blank">tracecomp=
ass-dev@eclipse.org</a><br>To change your delivery options, retrieve your p=
assword, or unsubscribe from this list, visit<br>
<a href=3D"https://www.eclipse.org/mailman/listinfo/tracecompass-dev" targe=
t=3D"_blank">https://www.eclipse.org/mailman/listinfo/tracecompass-dev</a><=
br>
</div> </span></font></div>
</div>
</blockquote>
</div>
<br clear=3D"all">
<div><br>
</div>-- <br>
<div dir=3D"ltr" class=3D"m_7752166956455312320gmail-m_6403026334017903746x=
_gmail_signature">
<div dir=3D"ltr">
<div>
<div dir=3D"ltr"><font size=3D"4"><b>Ravindra Kumar Meena</b></font>,<div><=
span style=3D"color:rgb(102,102,102)">B. Tech. Computer Science and Enginee=
ring,<br>
</span></div>
<div><span style=3D"color:rgb(102,102,102)"><a href=3D"https://www.iitism.a=
c.in/" style=3D"color:rgb(17,85,204)" target=3D"_blank">Indian Institute of=
 Technology (Indian School of Mines)</a>, Dhanbad</span></div>
</div>
</div>
</div>
</div>
</div>
</div>

</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"m_7752166956455312320gmail_signature"><div dir=3D"ltr"><div><div =
dir=3D"ltr"><font size=3D"4"><b>Ravindra Kumar Meena</b></font>,<div><span =
style=3D"color:rgb(102,102,102)">B. Tech. Computer Science and Engineering,=
<br></span></div><div><span style=3D"color:rgb(102,102,102)"><a href=3D"htt=
ps://www.iitism.ac.in/" style=3D"color:rgb(17,85,204)" target=3D"_blank">In=
dian Institute of Technology (Indian School of Mines)</a>, Dhanbad</span></=
div></div></div></div></div></div>

--0000000000006faa45058517e791--

--===============8294245999354528735==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8294245999354528735==--
