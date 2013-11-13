From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Need Help in starting the trace remotely using TCF
	/ LttngAgent
Date: Wed, 13 Nov 2013 12:31:20 +0000 (UTC)
Message-ID: <42132560.66154.1384345880446.JavaMail.zimbra__7703.35488855398$1384345924$gmane$org@efficios.com>
References: <CAO_Arvpb43PNj-7ZH92py+V=T+swxFsqV_Z+3=9UuR+okQ+Ngg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0711650724=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VgZbO-0002ty-Eb
	for lttng-dev@lists.lttng.org; Wed, 13 Nov 2013 07:31:23 -0500
In-Reply-To: <CAO_Arvpb43PNj-7ZH92py+V=T+swxFsqV_Z+3=9UuR+okQ+Ngg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: kumar s <skumar.m226@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0711650724==
Content-Type: multipart/alternative;
	boundary="----=_Part_66153_1951482113.1384345880444"

------=_Part_66153_1951482113.1384345880444
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- Original Message -----

> From: "kumar s" <skumar.m226@gmail.com>
> To: "mathieu desnoyers" <mathieu.desnoyers@efficios.com>
> Sent: Wednesday, November 13, 2013 1:13:03 AM
> Subject: Need Help in starting the trace remotely using TCF / LttngAgent

> Hello,

> I am using the following versions to setup lttng on kernel

> Linux kernel -2.6.32.27

> LTTV - 0.12.29

> LTTng - 0.190

> LTTControl - 0.81

Hi, 

These old 0.x versions of lttng are not supported anymore. The TCF agent for those versions even less. I'm CCing lttng-dev just in case anyone has hints. 

Best regards, 

Mathieu 

> This is for mips architecture. I have patched the linux kernel and i am able
> to setup the trace on target board and copy the trace host pc to view in
> LTTV / eclipse.

> Now i am trying to setup tcf-agent and lttng-agent to start and control the
> trace remotely.

> I have cross compiled the tcf-agent and lttng-agent for mips. The client side
> i have compiled it for pc.

> When cross compiling tcf-agent the following services has been enabled -
> Plugins Splice Zerocopy Cmdline Trace Discovery Locator Streams Terminals in
> config.h and also specified in make.

> Steps i did to start the ltt on target (Mips)

> mount debugfs
> export lttd
> ltt-armall

> start tcf-agent

> On client PC

> start tcf-client
> connect ip address ( Connection established with TCP:)

> tcf ltt_control setupTrace "kernel" "0" "traceTest"
> Reply error 131097: Command is not recognized

> I would like to know what steps i am missing to start the trace remotely.

> Thank you
> skumar

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_66153_1951482113.1384345880444
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><hr id=3D"zwchr"><blockquote style=3D=
"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;=
font-weight:normal;font-style:normal;text-decoration:none;font-family:Helve=
tica,Arial,sans-serif;font-size:12pt;"><b>From: </b>"kumar s" &lt;skumar.m2=
26@gmail.com&gt;<br><b>To: </b>"mathieu desnoyers" &lt;mathieu.desnoyers@ef=
ficios.com&gt;<br><b>Sent: </b>Wednesday, November 13, 2013 1:13:03 AM<br><=
b>Subject: </b>Need Help in starting the trace remotely using TCF / LttngAg=
ent<br><div><br></div><div dir=3D"ltr"><div><div><div><div><div>Hello,<br><=
div><br></div></div>I am using the following versions to setup lttng on ker=
nel<br><div><br></div>Linux kernel -2.6.32.27<br><div><br></div>LTTV - 0.12=
.29<br><div><br></div>LTTng - 0.190<br><div><br></div>LTTControl - 0.81</di=
v></div></div></div></div></blockquote><div><br></div><div><div>Hi,</div><d=
iv><br></div><div>These old 0.x versions of lttng are not supported anymore=
. The TCF agent for those versions even less. I'm CCing lttng-dev just in c=
ase anyone has hints.</div><div><br></div><div>Best regards,</div><div><br>=
</div><div>Mathieu</div></div><div><br></div><blockquote style=3D"border-le=
ft:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weigh=
t:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial=
,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div><div><div><div><div><br>=
</div></div>This is for mips architecture. I have patched the linux kernel =
and
 i am able to setup the trace on target board and copy the trace host pc
 to view in LTTV / eclipse.<br><div><br></div></div>Now i am trying to setu=
p tcf-agent and lttng-agent to start and control the trace remotely.<br><br=
></div>I have cross compiled the tcf-agent and lttng-agent for mips. The cl=
ient side i have compiled it for pc.<br><div><br></div></div><div>When
 cross compiling tcf-agent the following services has been enabled -=20
Plugins Splice Zerocopy Cmdline Trace Discovery Locator Streams=20
Terminals in config.h and also specified in make.<br></div><div><br></div><=
div>Steps i did to start the ltt on target (Mips)<br><div><br></div></div><=
div>mount debugfs<br></div><div>export lttd<br></div><div>ltt-armall<br><di=
v><br></div></div><div>start tcf-agent<br><div><br></div></div><div>On clie=
nt PC<br><br></div><div>start tcf-client<br></div><div>connect ip address (=
 Connection established with TCP:)<br><div><br></div></div><div>tcf ltt_con=
trol setupTrace "kernel" "0" "traceTest"<br></div><div>Reply error 131097: =
Command is not recognized<br><br><div><br></div></div><div>I would like to =
know what steps i am missing to start the trace remotely.<br><div><br></div=
>Thank you<br></div>skumar</div></blockquote><div><br><br></div><div><br></=
div><div>-- <br></div><div><span name=3D"x"></span>Mathieu Desnoyers<br>Eff=
iciOS Inc.<br>http://www.efficios.com<span name=3D"x"></span><br></div></di=
v></body></html>
------=_Part_66153_1951482113.1384345880444--


--===============0711650724==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0711650724==--
