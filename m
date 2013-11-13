From: kumar s <skumar.m226@gmail.com>
Subject: Unable start trace using tcf-agent / lttng-agent
Date: Wed, 13 Nov 2013 11:27:19 +0530
Message-ID: <CAO_Arvrt640Mm1Lq0L5G1HFdJyyzWhMON1qF_2gwiJALANJvXQ__26943.1585948498$1384322288$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1905368164=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <skumar.m226@gmail.com>) id 1VgTSA-0002FR-Cd
	for lttng-dev@lists.lttng.org; Wed, 13 Nov 2013 00:57:27 -0500
Received: by mail-lb0-f179.google.com with SMTP id w6so5307247lbh.24
	for <lttng-dev@lists.lttng.org>; Tue, 12 Nov 2013 21:57:20 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1905368164==
Content-Type: multipart/alternative; boundary=001a11c3cd845e6ba604eb08a3e8

--001a11c3cd845e6ba604eb08a3e8
Content-Type: text/plain; charset=ISO-8859-1

Hello,

I am using the following versions to setup lttng on kernel

Linux kernel -2.6.32.27

LTTV - 0.12.29

LTTng - 0.190

LTTControl - 0.81

This is for mips architecture. I have patched the linux kernel and i am
able to setup the trace on target board and copy the trace host pc to view
in LTTV / eclipse.

Now i am trying to setup tcf-agent and lttng-agent to start and control the
trace remotely.

I have cross compiled the tcf-agent and lttng-agent for mips. The client
side i have compiled it for pc.

When cross compiling tcf-agent the following services has been enabled -
Plugins Splice Zerocopy Cmdline Trace Discovery Locator Streams Terminals
in config.h and also specified in make.

Steps i did to start the ltt on target (Mips)

mount debugfs
export lttd
ltt-armall

start tcf-agent

On client PC

start tcf-client
connect ip address ( Connection established with TCP:)

tcf ltt_control setupTrace "kernel" "0" "traceTest"
Reply error 131097: Command is not recognized


I would like to know what steps i am missing to start the trace remotely.

Thank you
skumar

--001a11c3cd845e6ba604eb08a3e8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div>Hello,<br><br></div>I am using th=
e following versions to setup lttng on kernel<br><br>Linux kernel -2.6.32.2=
7<br><br>LTTV - 0.12.29<br><br>LTTng - 0.190<br><br>LTTControl - 0.81<br><b=
r>
</div>This is for mips architecture. I have patched the linux kernel and i =
am able to setup the trace on target board and copy the trace host pc to vi=
ew in LTTV / eclipse.<br><br></div>Now i am trying to setup tcf-agent and l=
ttng-agent to start and control the trace remotely.<br>
<br></div>I have cross compiled the tcf-agent and lttng-agent for mips. The=
 client side i have compiled it for pc.<br><br></div><div>When cross compil=
ing tcf-agent the following services has been enabled - Plugins Splice Zero=
copy Cmdline Trace Discovery Locator Streams Terminals in config.h and also=
 specified in make.<br>
</div><div><br></div><div>Steps i did to start the ltt on target (Mips)<br>=
<br></div><div>mount debugfs<br></div><div>export lttd<br></div><div>ltt-ar=
mall<br><br></div><div>start tcf-agent<br><br></div><div>On client PC<br>
<br></div><div>start tcf-client<br></div><div>connect ip address ( Connecti=
on established with TCP:)<br><br></div><div>tcf ltt_control setupTrace &quo=
t;kernel&quot; &quot;0&quot; &quot;traceTest&quot;<br></div><div>Reply erro=
r 131097: Command is not recognized<br>
<br><br></div><div>I would like to know what steps i am missing to start th=
e trace remotely.<br><br>Thank you<br></div><div>skumar<br></div><div><br><=
/div></div>

--001a11c3cd845e6ba604eb08a3e8--


--===============1905368164==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1905368164==--
