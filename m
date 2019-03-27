From: Ravindra Kumar Meena <rmeena840@gmail.com>
Subject: Re: [tracecompass-dev]  Question related to LTTng
Date: Wed, 27 Mar 2019 23:44:32 +0530
Message-ID: <CAEWVvOT1EQ9aS3Ao5u-nypV2ZrsDyHHMh9fEguLDgG27w6=gRw__33340.1899597206$1553786115$gmane$org@mail.gmail.com>
References: <CAEWVvOTEJjw3kYfPfrcW68Ux6fy1g5utoHBpy=o++d71rxddbg@mail.gmail.com>
 <f0d5b7b4-dacc-ca93-10d5-cc3f7c88d320@versatic.net>
 <BN8PR15MB3090BB0C0E9FC7D9865EF2369E580@BN8PR15MB3090.namprd15.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2125469657183271197=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by lists.lttng.org (Postfix) with ESMTPS id 44Tx4B61SLz185D
 for <lttng-dev@lists.lttng.org>; Wed, 27 Mar 2019 14:15:06 -0400 (EDT)
Received: by mail-wr1-x42e.google.com with SMTP id r4so12046464wrq.8
 for <lttng-dev@lists.lttng.org>; Wed, 27 Mar 2019 11:15:06 -0700 (PDT)
In-Reply-To: <BN8PR15MB3090BB0C0E9FC7D9865EF2369E580@BN8PR15MB3090.namprd15.prod.outlook.com>
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

--===============2125469657183271197==
Content-Type: multipart/alternative; boundary="000000000000c154430585176a40"

--000000000000c154430585176a40
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks to all for suggestions. Let me describe the problem in more detail.

I have a QEMU(it is virtualization software like VMware etc.) instance
which is running some applications. The QEMU application can generate Trace
Data in CTF format which I want to transfer it to Trace Compass for
analyzing it.

I would like to know if there is a way to transfer CTF to Trace Compass in
a real-time manner using TCP/UDP.

and

How can I convert CTF Trace Data to LTTng? Since TraceCompass already
understands LTTng Trace Data.

P.S: I am a student working on Tracing project at my University.

Thanks

On Wed, Mar 27, 2019 at 11:01 PM Matthew Khouzam <
matthew.khouzam@ericsson.com> wrote:

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


--=20
*Ravindra Kumar Meena*,
B. Tech. Computer Science and Engineering,
Indian Institute of Technology (Indian School of Mines)
<https://www.iitism.ac.in/>, Dhanbad

--000000000000c154430585176a40
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>Thanks to all for suggestions. Let =
me describe the problem in more detail.</div><div><br></div><div>I have a Q=
EMU(it is virtualization software like VMware etc.) instance which is runni=
ng some applications. The QEMU application can generate Trace Data in CTF f=
ormat which I want to transfer it to Trace Compass for analyzing it.=C2=A0<=
/div><div><br></div><div>I would like to know if there is a way to transfer=
 CTF to Trace Compass in a real-time manner using TCP/UDP.</div><div><br></=
div><div>and</div><div><br></div><div>How can I convert CTF Trace Data to L=
TTng? Since TraceCompass already understands LTTng Trace Data.</div><div><b=
r></div><div>P.S: I am a student=C2=A0working on Tracing project at my Univ=
ersity.</div><div><br></div><div>Thanks</div></div><br><div class=3D"gmail_=
quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 27, 2019 at 11:01 =
PM Matthew Khouzam &lt;<a href=3D"mailto:matthew.khouzam@ericsson.com">matt=
hew.khouzam@ericsson.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">




<div dir=3D"ltr">
<div id=3D"gmail-m_-14738379410950796divtagdefaultwrapper" style=3D"font-si=
ze:12pt;color:rgb(0,0,0);font-family:Calibri,Helvetica,sans-serif" dir=3D"l=
tr">
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
<div id=3D"gmail-m_-14738379410950796divRplyFwdMsg" dir=3D"ltr"><font face=
=3D"Calibri, sans-serif" style=3D"font-size:11pt" color=3D"#000000"><b>From=
:</b> <a href=3D"mailto:tracecompass-dev-bounces@eclipse.org" target=3D"_bl=
ank">tracecompass-dev-bounces@eclipse.org</a> &lt;<a href=3D"mailto:traceco=
mpass-dev-bounces@eclipse.org" target=3D"_blank">tracecompass-dev-bounces@e=
clipse.org</a>&gt; on behalf of Genevieve Bastien &lt;<a href=3D"mailto:gba=
stien@versatic.net" target=3D"_blank">gbastien@versatic.net</a>&gt;<br>
<b>Sent:</b> Wednesday, March 27, 2019 1:03:08 PM<br>
<b>To:</b> <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">l=
ttng-dev@lists.lttng.org</a>; Ravindra Kumar Meena; <a href=3D"mailto:trace=
compass-dev@eclipse.org" target=3D"_blank">tracecompass-dev@eclipse.org</a>=
<br>
<b>Subject:</b> Re: [tracecompass-dev] [lttng-dev] Question related to LTTn=
g</font>
<div>=C2=A0</div>
</div>
<div class=3D"gmail-m_-14738379410950796BodyFragment"><font size=3D"2"><spa=
n style=3D"font-size:11pt">
<div class=3D"gmail-m_-14738379410950796PlainText">Hi Ravindra,<br>
<br>
I&#39;m sending the reply also to the tracecompass mailing list, where it i=
s<br>
more on topic.<br>
<br>
On 2019-03-27 7:23 a.m., Ravindra Kumar Meena wrote:<br>
&gt; Hi Developers,<br>
&gt;<br>
&gt; I am working on a=C2=A0project where I want Trace Compass to analyze a=
nd<br>
&gt; display some information. I wanna ask a few things:<br>
&gt;<br>
&gt; Q1. Is there any way to extend Trace Compass to work trace data in CTF=
<br>
&gt; format?<br>
<br>
From what I understand, you have a CTF trace and would like to implement<br=
>
a specific trace type from it, for example, to be able to add custom<br>
analyses for this specific type. Right?<br>
<br>
You can read the developer documentation on how to add new trace types<br>
[1]. You may want to take a look at the LttngKernelTrace class for an<br>
example of such extension of CTF Trace [2]. There are a few more around<br>
the code, looking at the class hierarchy for CtfTmfTrace will show you<br>
which ones.<br>
<br>
&gt;<br>
&gt; Q2. How trace data(CTF) can be converted to Linux kernel trace<br>
&gt; data(LTTng) which Trace Compass already understands?<br>
Kernel traces need to implement IKernelTrace. This interface provides an<br=
>
event layout (IKernelAnalysisEventLayout) which will define which events<br=
>
in the trace correspond to common &quot;concepts&quot; of the kernel, like<=
br>
sched_switches, syscalls, irqs, etc. That&#39;s how any kernel trace format=
<br>
like ftrace, perf and lttng can use common analyses made for kernel. You<br=
>
would need to implement this event layout for your own trace types.<br>
<br>
<br>
[1]<br>
<a href=3D"http://archive.eclipse.org/tracecompass/doc/org.eclipse.tracecom=
pass.doc.dev/Implementing-a-New-Trace-Type.html#Implementing_a_New_Trace_Ty=
pe" target=3D"_blank">http://archive.eclipse.org/tracecompass/doc/org.eclip=
se.tracecompass.doc.dev/Implementing-a-New-Trace-Type.html#Implementing_a_N=
ew_Trace_Type</a><br>
<br>
[2]<br>
<a href=3D"https://git.eclipse.org/c/tracecompass/org.eclipse.tracecompass.=
git/tree/lttng/org.eclipse.tracecompass.lttng2.kernel.core/src/org/eclipse/=
tracecompass/lttng2/kernel/core/trace/LttngKernelTrace.java" target=3D"_bla=
nk">https://git.eclipse.org/c/tracecompass/org.eclipse.tracecompass.git/tre=
e/lttng/org.eclipse.tracecompass.lttng2.kernel.core/src/org/eclipse/traceco=
mpass/lttng2/kernel/core/trace/LttngKernelTrace.java</a><br>
<br>
<br>
Cheers,<br>
<br>
Genevi=C3=A8ve<br>
<br>
<br>
<br>
<br>
_______________________________________________<br>
tracecompass-dev mailing list<br>
<a href=3D"mailto:tracecompass-dev@eclipse.org" target=3D"_blank">tracecomp=
ass-dev@eclipse.org</a><br>
To change your delivery options, retrieve your password, or unsubscribe fro=
m this list, visit<br>
<a href=3D"https://www.eclipse.org/mailman/listinfo/tracecompass-dev" targe=
t=3D"_blank">https://www.eclipse.org/mailman/listinfo/tracecompass-dev</a><=
br>
</div>
</span></font></div>
</div>

</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><font siz=
e=3D"4"><b>Ravindra Kumar Meena</b></font>,<div><span style=3D"color:rgb(10=
2,102,102)">B. Tech. Computer Science and Engineering,<br></span></div><div=
><span style=3D"color:rgb(102,102,102)"><a href=3D"https://www.iitism.ac.in=
/" style=3D"color:rgb(17,85,204)" target=3D"_blank">Indian Institute of Tec=
hnology (Indian School of Mines)</a>, Dhanbad</span></div></div></div></div=
></div>

--000000000000c154430585176a40--

--===============2125469657183271197==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2125469657183271197==--
