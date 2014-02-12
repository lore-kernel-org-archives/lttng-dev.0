From: kumar s <skumar.m226@gmail.com>
Subject: Re: Trace Streaming problem
Date: Wed, 12 Feb 2014 17:25:36 +0530
Message-ID: <CAO_Arvrc=0xpP+Uc4p2pqq251Akh_uHFb1Ww2eJHVbYZewrK3w__37993.6847639785$1392206205$gmane$org@mail.gmail.com>
References: <CAO_ArvpaU2cGQ+9F=A+vHv9zNupXitvkSCr6RZh0LzTjLj9uMA@mail.gmail.com>
	<20140211145713.GA7091@thessa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1651233829=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-la0-f50.google.com ([209.85.215.50])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <skumar.m226@gmail.com>) id 1WDYPm-0004OW-Mq
	for lttng-dev@lists.lttng.org; Wed, 12 Feb 2014 06:55:44 -0500
Received: by mail-la0-f50.google.com with SMTP id ec20so6920817lab.37
	for <lttng-dev@lists.lttng.org>; Wed, 12 Feb 2014 03:55:36 -0800 (PST)
In-Reply-To: <20140211145713.GA7091@thessa>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1651233829==
Content-Type: multipart/alternative; boundary=089e011836be3465c504f23440b4

--089e011836be3465c504f23440b4
Content-Type: text/plain; charset=ISO-8859-1

Hello,

Thanks a lot, It worked, i am able stream and save the trace on the remote
PC.

However out of curiosity i am also trying to do live tracing,

On Mips Board

lttng-relayd -vvv

lttng create --live 10000000 -U  net://localhost remotetes

lttng enable-event -a -k

lttng start

On linux PC

lttngtop -r net://192.168.233.39

net://192.168.233.39/1 : remotetes on host Linux_Mips(timer = 10000000, 4
stream(s), 0 client(s) connected)

Segmentation fault (core dumped)

What is the exact steps i need to follow for live tracing,

Thank you
Skumar





On Tue, Feb 11, 2014 at 8:27 PM, David Goulet <dgoulet@efficios.com> wrote:

> On 11 Feb (13:24:15), kumar s wrote:
> > Hi,
> >
> > I am trying to start the trace on MIPS board and dump it remotely on PC.
> >
> > The steps i do
> > On MIPS board:
> > lttng create -U net://192.168.233.207 newsession
> >
> > lttng enable-event lttng_statedump_start -k
> >
> > Error: Event lttng_statedump_start: Unable to connect to lttng-relayd
> > (channel channel0, session news)
> > Warning: Some command(s) went wrong
> >
> > In lttng-sessiond -vvv log
> >
> > [...]
> > DEBUG3 [1918/2019]: Consumer socket created (fd: 30) and added to output
> > (in consumer_create_socket() at consumer.c:300)
> > DEBUG1 [1918/2019]: Setting relayd for session news (in
> cmd_setup_relayd()
> > at cmd.c:722)
> > DEBUG3 [1918/2019]: Relayd connect ... (in relayd_connect() at
> relayd.c:466)
> > PERROR [1918/2019]: connect: Connection refused (in
> > lttcomm_connect_inet_sock() at inet.c:253)
> > Error: Unable to reach lttng-relayd
> > DEBUG1 [1918/2019]: Sending response (size: 16, retcode: Unable to
> connect
> > to lttng-relayd) (in thread_manage_clients() at main.c:3973)
> > DEBUG1 [1918/2019]: Clean command context structure (in
> clean_command_ctx()
> > at main.c:672)
> > DEBUG1 [1918/2019]: Accepting client command ... (in
> > thread_manage_clients() at main.c:3837)
> >
> > On the linux pc
> > i have started lttng-relayd
> >
> > lttng-relayd -vvv -C tcp://0.0.0.0:1234 -D tcp://0.0.0.0:5678 (as
> specified
> > in doc folder of lttng-tools)
>
> The relayd is started with different ports here so the session creation
> should also specify those like so:
>
> $ lttng create -U net://192.168.233.207:1234:5678
>
> (or use -C/-D).
>
> David
>
> >
> >
> > Unfortunately i get error that lttng-relayd unable to connect. I also
> tried
> > started lttng-relayd on mips board and running the same, still i get same
> > error.
> >
> > Can someone explain steps for lttng trace streaming or how i can dump the
> > trace live onto PC.
> >
> > Thank you
> > Skumar
>
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>

--089e011836be3465c504f23440b4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hello,<br><br></div>Thanks a lot, It worked=
, i am able stream and save the trace on the remote PC.<br><br></div>Howeve=
r out of curiosity i am also trying to do live tracing,<br><br></div>On Mip=
s Board<br>
<div><br>lttng-relayd -vvv<br><br>lttng create --live 10000000 -U=A0 net://=
localhost remotetes<br><br>lttng enable-event -a -k<br><br>lttng start <br>=
<br></div><div>On linux PC<br><br>lttngtop -r net://<a href=3D"http://192.1=
68.233.39">192.168.233.39</a><br>
<br>net://<a href=3D"http://192.168.233.39/1">192.168.233.39/1</a> : remote=
tes on host Linux_Mips(timer =3D 10000000, 4 stream(s), 0 client(s) connect=
ed)<br><br>Segmentation fault (core dumped)<br><br></div><div>What is the e=
xact steps i need to follow for live tracing, <br>
<br></div><div>Thank you<br>Skumar<br></div><div><br><br><br></div></div><d=
iv class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Tue, Feb 11,=
 2014 at 8:27 PM, David Goulet <span dir=3D"ltr">&lt;<a href=3D"mailto:dgou=
let@efficios.com" target=3D"_blank">dgoulet@efficios.com</a>&gt;</span> wro=
te:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On 1=
1 Feb (13:24:15), kumar s wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; I am trying to start the trace on MIPS board and dump it remotely on P=
C.<br>
&gt;<br>
&gt; The steps i do<br>
&gt; On MIPS board:<br>
&gt; lttng create -U net://<a href=3D"http://192.168.233.207" target=3D"_bl=
ank">192.168.233.207</a> newsession<br>
&gt;<br>
&gt; lttng enable-event lttng_statedump_start -k<br>
&gt;<br>
&gt; Error: Event lttng_statedump_start: Unable to connect to lttng-relayd<=
br>
&gt; (channel channel0, session news)<br>
&gt; Warning: Some command(s) went wrong<br>
&gt;<br>
&gt; In lttng-sessiond -vvv log<br>
&gt;<br>
&gt; [...]<br>
&gt; DEBUG3 [1918/2019]: Consumer socket created (fd: 30) and added to outp=
ut<br>
&gt; (in consumer_create_socket() at consumer.c:300)<br>
&gt; DEBUG1 [1918/2019]: Setting relayd for session news (in cmd_setup_rela=
yd()<br>
&gt; at cmd.c:722)<br>
&gt; DEBUG3 [1918/2019]: Relayd connect ... (in relayd_connect() at relayd.=
c:466)<br>
&gt; PERROR [1918/2019]: connect: Connection refused (in<br>
&gt; lttcomm_connect_inet_sock() at inet.c:253)<br>
&gt; Error: Unable to reach lttng-relayd<br>
&gt; DEBUG1 [1918/2019]: Sending response (size: 16, retcode: Unable to con=
nect<br>
&gt; to lttng-relayd) (in thread_manage_clients() at main.c:3973)<br>
&gt; DEBUG1 [1918/2019]: Clean command context structure (in clean_command_=
ctx()<br>
&gt; at main.c:672)<br>
&gt; DEBUG1 [1918/2019]: Accepting client command ... (in<br>
&gt; thread_manage_clients() at main.c:3837)<br>
&gt;<br>
&gt; On the linux pc<br>
&gt; i have started lttng-relayd<br>
&gt;<br>
&gt; lttng-relayd -vvv -C tcp://<a href=3D"http://0.0.0.0:1234" target=3D"_=
blank">0.0.0.0:1234</a> -D tcp://<a href=3D"http://0.0.0.0:5678" target=3D"=
_blank">0.0.0.0:5678</a> (as specified<br>
&gt; in doc folder of lttng-tools)<br>
<br>
</div></div>The relayd is started with different ports here so the session =
creation<br>
should also specify those like so:<br>
<br>
$ lttng create -U net://192.168.233.207:1234:5678<br>
<br>
(or use -C/-D).<br>
<br>
David<br>
<div class=3D""><br>
&gt;<br>
&gt;<br>
&gt; Unfortunately i get error that lttng-relayd unable to connect. I also =
tried<br>
&gt; started lttng-relayd on mips board and running the same, still i get s=
ame<br>
&gt; error.<br>
&gt;<br>
&gt; Can someone explain steps for lttng trace streaming or how i can dump =
the<br>
&gt; trace live onto PC.<br>
&gt;<br>
&gt; Thank you<br>
&gt; Skumar<br>
<br>
</div>&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev=
</a><br>
<br>
</blockquote></div><br></div>

--089e011836be3465c504f23440b4--


--===============1651233829==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1651233829==--
