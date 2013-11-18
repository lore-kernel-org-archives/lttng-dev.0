From: kumar s <skumar.m226@gmail.com>
Subject: Re: Need Help in saving the trace on the remote machine.
Date: Mon, 18 Nov 2013 13:04:22 +0530
Message-ID: <CAO_ArvoQPQcFbgqdgHFcoOwrT=6VmyHQV7cRMiGoS8cak_bx5w__3798.46683140404$1384760112$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0097698872=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <skumar.m226@gmail.com>) id 1ViJLp-0006oL-2M
	for lttng-dev@lists.lttng.org; Mon, 18 Nov 2013 02:34:31 -0500
Received: by mail-lb0-f181.google.com with SMTP id q8so3369821lbi.12
	for <lttng-dev@lists.lttng.org>; Sun, 17 Nov 2013 23:34:22 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0097698872==
Content-Type: multipart/alternative; boundary=001a11c36f44a238e904eb6e9344

--001a11c36f44a238e904eb6e9344
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I can start , stop , pause the trace remotely. I am also able to save the
trace on local machine (target-mips board). I am unable to save the trace
on remote machine. I get the following error.

> lttctl_client ltt_control writeTraceNetwork "kernel" "0" "traceTest"
"/home/techie/Desktop/tracetest" 2 false false false
Reply error 131077: Channel closed


Thank you
skumar

On Wed, Nov 13, 2013 at 6:01 PM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> ------------------------------
>
> *From: *"kumar s" <skumar.m226@gmail.com>
> *To: *"mathieu desnoyers" <mathieu.desnoyers@efficios.com>
> *Sent: *Wednesday, November 13, 2013 1:13:03 AM
> *Subject: *Need Help in starting the trace remotely using TCF / LttngAgent
>
>
> Hello,
>
> I am using the following versions to setup lttng on kernel
>
> Linux kernel -2.6.32.27
>
> LTTV - 0.12.29
>
> LTTng - 0.190
>
> LTTControl - 0.81
>
>
> Hi,
>
> These old 0.x versions of lttng are not supported anymore. The TCF agent
> for those versions even less. I'm CCing lttng-dev just in case anyone has
> hints.
>
> Best regards,
>
> Mathieu
>
>
> This is for mips architecture. I have patched the linux kernel and i am
> able to setup the trace on target board and copy the trace host pc to view
> in LTTV / eclipse.
>
> Now i am trying to setup tcf-agent and lttng-agent to start and control
> the trace remotely.
>
> I have cross compiled the tcf-agent and lttng-agent for mips. The client
> side i have compiled it for pc.
>
> When cross compiling tcf-agent the following services has been enabled -
> Plugins Splice Zerocopy Cmdline Trace Discovery Locator Streams Terminals
> in config.h and also specified in make.
>
> Steps i did to start the ltt on target (Mips)
>
> mount debugfs
> export lttd
> ltt-armall
>
> start tcf-agent
>
> On client PC
>
> start tcf-client
> connect ip address ( Connection established with TCP:)
>
> tcf ltt_control setupTrace "kernel" "0" "traceTest"
> Reply error 131097: Command is not recognized
>
>
> I would like to know what steps i am missing to start the trace remotely.
>
> Thank you
> skumar
>
>
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--001a11c36f44a238e904eb6e9344
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I can start , stop , pause the trac=
e remotely. I am also able to save the trace on local machine (target-mips =
board). I am unable to save the trace on remote machine. I get the followin=
g error.</div>
<div><br></div><div><div>&gt; lttctl_client ltt_control writeTraceNetwork &=
quot;kernel&quot; &quot;0&quot; &quot;traceTest&quot; &quot;/home/techie/De=
sktop/tracetest&quot; 2 false false false</div><div>Reply error 131077: Cha=
nnel closed</div>
</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra"><br><=
/div><div class=3D"gmail_extra">Thank you</div><div class=3D"gmail_extra">s=
kumar<br><br><div class=3D"gmail_quote">On Wed, Nov 13, 2013 at 6:01 PM, Ma=
thieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoyers@e=
fficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;</span=
> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex"><div><div style=3D"font-size:12pt;font-family:&#39;times n=
ew roman&#39;,&#39;new york&#39;,times,serif">
<hr><blockquote style=3D"padding-left:5px;font-size:12pt;font-style:normal;=
margin-left:5px;font-family:Helvetica,Arial,sans-serif;text-decoration:none=
;font-weight:normal;border-left-width:2px;border-left-style:solid;border-le=
ft-color:rgb(16,16,255)">
<b>From: </b>&quot;kumar s&quot; &lt;<a href=3D"mailto:skumar.m226@gmail.co=
m" target=3D"_blank">skumar.m226@gmail.com</a>&gt;<br><b>To: </b>&quot;math=
ieu desnoyers&quot; &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" t=
arget=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;<br>
<b>Sent: </b>Wednesday, November 13, 2013 1:13:03 AM<br><b>Subject: </b>Nee=
d Help in starting the trace remotely using TCF / LttngAgent<div class=3D"i=
m"><br><div><br></div><div dir=3D"ltr"><div><div><div><div><div>Hello,<br><=
div>
<br></div></div>I am using the following versions to setup lttng on kernel<=
br><div><br></div>Linux kernel -2.6.32.27<br><div><br></div>LTTV - 0.12.29<=
br><div><br></div>LTTng - 0.190<br><div><br></div>LTTControl - 0.81</div>
</div></div></div></div></div></blockquote><div><br></div><div><div>Hi,</di=
v><div><br></div><div>These old 0.x versions of lttng are not supported any=
more. The TCF agent for those versions even less. I&#39;m CCing lttng-dev j=
ust in case anyone has hints.</div>
<div><br></div><div>Best regards,</div><div><br></div><div>Mathieu</div></d=
iv><div class=3D"im"><div><br></div><blockquote style=3D"padding-left:5px;f=
ont-size:12pt;font-style:normal;margin-left:5px;font-family:Helvetica,Arial=
,sans-serif;text-decoration:none;font-weight:normal;border-left-width:2px;b=
order-left-style:solid;border-left-color:rgb(16,16,255)">
<div dir=3D"ltr"><div><div><div><div><div><br></div></div>This is for mips =
architecture. I have patched the linux kernel and
 i am able to setup the trace on target board and copy the trace host pc
 to view in LTTV / eclipse.<br><div><br></div></div>Now i am trying to setu=
p tcf-agent and lttng-agent to start and control the trace remotely.<br><br=
></div>I have cross compiled the tcf-agent and lttng-agent for mips. The cl=
ient side i have compiled it for pc.<br>
<div><br></div></div><div>When
 cross compiling tcf-agent the following services has been enabled -=20
Plugins Splice Zerocopy Cmdline Trace Discovery Locator Streams=20
Terminals in config.h and also specified in make.<br></div><div><br></div><=
div>Steps i did to start the ltt on target (Mips)<br><div><br></div></div><=
div>mount debugfs<br></div><div>export lttd<br></div><div>ltt-armall<br>
<div><br></div></div><div>start tcf-agent<br><div><br></div></div><div>On c=
lient PC<br><br></div><div>start tcf-client<br></div><div>connect ip addres=
s ( Connection established with TCP:)<br><div><br></div></div><div>tcf ltt_=
control setupTrace &quot;kernel&quot; &quot;0&quot; &quot;traceTest&quot;<b=
r>
</div><div>Reply error 131097: Command is not recognized<br><br><div><br></=
div></div><div>I would like to know what steps i am missing to start the tr=
ace remotely.<br><div><br></div>Thank you<br></div>skumar</div></blockquote=
>
<div><br><br></div><div><br></div></div><span class=3D""><font color=3D"#88=
8888"><div>-- <br></div><div><span name=3D"x"></span>Mathieu Desnoyers<br>E=
fficiOS Inc.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http:=
//www.efficios.com</a><span name=3D"x"></span><br>
</div></font></span></div></div></blockquote></div><br></div></div>

--001a11c36f44a238e904eb6e9344--


--===============0097698872==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0097698872==--
