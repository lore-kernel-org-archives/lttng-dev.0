From: Matthew Khouzam <matthew.khouzam@ericsson.com>
Subject: Re: [tracecompass-dev]  Question related to LTTng
Date: Wed, 27 Mar 2019 17:31:44 +0000
Message-ID: <BN8PR15MB3090BB0C0E9FC7D9865EF2369E580__8194.10119890875$1553866993$gmane$org@BN8PR15MB3090.namprd15.prod.outlook.com>
References: <CAEWVvOTEJjw3kYfPfrcW68Ux6fy1g5utoHBpy=o++d71rxddbg@mail.gmail.com>,
 <f0d5b7b4-dacc-ca93-10d5-cc3f7c88d320@versatic.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0122364638835539058=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740058.outbound.protection.outlook.com [40.107.74.58])
 by lists.lttng.org (Postfix) with ESMTPS id 44W2vS2pQmz1KBx
 for <lttng-dev@lists.lttng.org>; Fri, 29 Mar 2019 09:41:23 -0400 (EDT)
In-Reply-To: <f0d5b7b4-dacc-ca93-10d5-cc3f7c88d320@versatic.net>
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Ravindra Kumar Meena <rmeena840@gmail.com>, "tracecompass-dev@eclipse.org" <tracecompass-dev@eclipse.org>
List-Id: lttng-dev@lists.lttng.org

--===============0122364638835539058==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN8PR15MB3090BB0C0E9FC7D9865EF2369E580BN8PR15MB3090namp_"

--_000_BN8PR15MB3090BB0C0E9FC7D9865EF2369E580BN8PR15MB3090namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Ravindra,


could you please detail what you want to do, there is a decent chance trace=
 compass supports that out of the box.


BR,

Matthew

________________________________
From: tracecompass-dev-bounces@eclipse.org <tracecompass-dev-bounces@eclips=
e.org> on behalf of Genevieve Bastien <gbastien@versatic.net>
Sent: Wednesday, March 27, 2019 1:03:08 PM
To: lttng-dev@lists.lttng.org; Ravindra Kumar Meena; tracecompass-dev@eclip=
se.org
Subject: Re: [tracecompass-dev] [lttng-dev] Question related to LTTng

Hi Ravindra,

I'm sending the reply also to the tracecompass mailing list, where it is
more on topic.

On 2019-03-27 7:23 a.m., Ravindra Kumar Meena wrote:
> Hi Developers,
>
> I am working on a project where I want Trace Compass to analyze and
> display some information. I wanna ask a few things:
>
> Q1. Is there any way to extend Trace Compass to work trace data in CTF
> format?

From what I understand, you have a CTF trace and would like to implement
a specific trace type from it, for example, to be able to add custom
analyses for this specific type. Right?

You can read the developer documentation on how to add new trace types
[1]. You may want to take a look at the LttngKernelTrace class for an
example of such extension of CTF Trace [2]. There are a few more around
the code, looking at the class hierarchy for CtfTmfTrace will show you
which ones.

>
> Q2. How trace data(CTF) can be converted to Linux kernel trace
> data(LTTng) which Trace Compass already understands?
Kernel traces need to implement IKernelTrace. This interface provides an
event layout (IKernelAnalysisEventLayout) which will define which events
in the trace correspond to common "concepts" of the kernel, like
sched_switches, syscalls, irqs, etc. That's how any kernel trace format
like ftrace, perf and lttng can use common analyses made for kernel. You
would need to implement this event layout for your own trace types.


[1]
http://archive.eclipse.org/tracecompass/doc/org.eclipse.tracecompass.doc.de=
v/Implementing-a-New-Trace-Type.html#Implementing_a_New_Trace_Type

[2]
https://git.eclipse.org/c/tracecompass/org.eclipse.tracecompass.git/tree/lt=
tng/org.eclipse.tracecompass.lttng2.kernel.core/src/org/eclipse/tracecompas=
s/lttng2/kernel/core/trace/LttngKernelTrace.java


Cheers,

Genevi=E8ve




_______________________________________________
tracecompass-dev mailing list
tracecompass-dev@eclipse.org
To change your delivery options, retrieve your password, or unsubscribe fro=
m this list, visit
https://www.eclipse.org/mailman/listinfo/tracecompass-dev

--_000_BN8PR15MB3090BB0C0E9FC7D9865EF2369E580BN8PR15MB3090namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Hi Ravindra, <br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">could you please detail what you =
want to do, there is a decent chance trace compass supports that out of the=
 box.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">BR,</p>
<p style=3D"margin-top:0;margin-bottom:0">Matthew<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> tracecompass-dev-boun=
ces@eclipse.org &lt;tracecompass-dev-bounces@eclipse.org&gt; on behalf of G=
enevieve Bastien &lt;gbastien@versatic.net&gt;<br>
<b>Sent:</b> Wednesday, March 27, 2019 1:03:08 PM<br>
<b>To:</b> lttng-dev@lists.lttng.org; Ravindra Kumar Meena; tracecompass-de=
v@eclipse.org<br>
<b>Subject:</b> Re: [tracecompass-dev] [lttng-dev] Question related to LTTn=
g</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi Ravindra,<br>
<br>
I'm sending the reply also to the tracecompass mailing list, where it is<br=
>
more on topic.<br>
<br>
On 2019-03-27 7:23 a.m., Ravindra Kumar Meena wrote:<br>
&gt; Hi Developers,<br>
&gt;<br>
&gt; I am working on a&nbsp;project where I want Trace Compass to analyze a=
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
sched_switches, syscalls, irqs, etc. That's how any kernel trace format<br>
like ftrace, perf and lttng can use common analyses made for kernel. You<br=
>
would need to implement this event layout for your own trace types.<br>
<br>
<br>
[1]<br>
<a href=3D"http://archive.eclipse.org/tracecompass/doc/org.eclipse.tracecom=
pass.doc.dev/Implementing-a-New-Trace-Type.html#Implementing_a_New_Trace_Ty=
pe">http://archive.eclipse.org/tracecompass/doc/org.eclipse.tracecompass.do=
c.dev/Implementing-a-New-Trace-Type.html#Implementing_a_New_Trace_Type</a><=
br>
<br>
[2]<br>
<a href=3D"https://git.eclipse.org/c/tracecompass/org.eclipse.tracecompass.=
git/tree/lttng/org.eclipse.tracecompass.lttng2.kernel.core/src/org/eclipse/=
tracecompass/lttng2/kernel/core/trace/LttngKernelTrace.java">https://git.ec=
lipse.org/c/tracecompass/org.eclipse.tracecompass.git/tree/lttng/org.eclips=
e.tracecompass.lttng2.kernel.core/src/org/eclipse/tracecompass/lttng2/kerne=
l/core/trace/LttngKernelTrace.java</a><br>
<br>
<br>
Cheers,<br>
<br>
Genevi=E8ve<br>
<br>
<br>
<br>
<br>
_______________________________________________<br>
tracecompass-dev mailing list<br>
tracecompass-dev@eclipse.org<br>
To change your delivery options, retrieve your password, or unsubscribe fro=
m this list, visit<br>
<a href=3D"https://www.eclipse.org/mailman/listinfo/tracecompass-dev">https=
://www.eclipse.org/mailman/listinfo/tracecompass-dev</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN8PR15MB3090BB0C0E9FC7D9865EF2369E580BN8PR15MB3090namp_--

--===============0122364638835539058==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0122364638835539058==--
