From: kumar s <skumar.m226@gmail.com>
Subject: Trace Streaming problem
Date: Tue, 11 Feb 2014 13:24:15 +0530
Message-ID: <CAO_ArvpaU2cGQ+9F=A+vHv9zNupXitvkSCr6RZh0LzTjLj9uMA__28550.8708250292$1392105305$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0704132346=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-la0-f41.google.com ([209.85.215.41])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <skumar.m226@gmail.com>) id 1WD8Af-0007Rr-Nt
	for lttng-dev@lists.lttng.org; Tue, 11 Feb 2014 02:54:23 -0500
Received: by mail-la0-f41.google.com with SMTP id mc6so5711886lab.0
	for <lttng-dev@lists.lttng.org>; Mon, 10 Feb 2014 23:54:15 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0704132346==
Content-Type: multipart/alternative; boundary=001a1137f67c38235c04f21cc3c5

--001a1137f67c38235c04f21cc3c5
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I am trying to start the trace on MIPS board and dump it remotely on PC.

The steps i do
On MIPS board:
lttng create -U net://192.168.233.207 newsession

lttng enable-event lttng_statedump_start -k

Error: Event lttng_statedump_start: Unable to connect to lttng-relayd
(channel channel0, session news)
Warning: Some command(s) went wrong

In lttng-sessiond -vvv log

[...]
DEBUG3 [1918/2019]: Consumer socket created (fd: 30) and added to output
(in consumer_create_socket() at consumer.c:300)
DEBUG1 [1918/2019]: Setting relayd for session news (in cmd_setup_relayd()
at cmd.c:722)
DEBUG3 [1918/2019]: Relayd connect ... (in relayd_connect() at relayd.c:466)
PERROR [1918/2019]: connect: Connection refused (in
lttcomm_connect_inet_sock() at inet.c:253)
Error: Unable to reach lttng-relayd
DEBUG1 [1918/2019]: Sending response (size: 16, retcode: Unable to connect
to lttng-relayd) (in thread_manage_clients() at main.c:3973)
DEBUG1 [1918/2019]: Clean command context structure (in clean_command_ctx()
at main.c:672)
DEBUG1 [1918/2019]: Accepting client command ... (in
thread_manage_clients() at main.c:3837)

On the linux pc
i have started lttng-relayd

lttng-relayd -vvv -C tcp://0.0.0.0:1234 -D tcp://0.0.0.0:5678 (as specified
in doc folder of lttng-tools)


Unfortunately i get error that lttng-relayd unable to connect. I also tried
started lttng-relayd on mips board and running the same, still i get same
error.

Can someone explain steps for lttng trace streaming or how i can dump the
trace live onto PC.

Thank you
Skumar

--001a1137f67c38235c04f21cc3c5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div><div><div><div><div>Hi,<br><=
br></div>I am trying to start the trace on MIPS board and dump it remotely =
on PC.<br><br></div>The steps i do <br></div>On MIPS board:<br>lttng create=
 -U net://<a href=3D"http://192.168.233.207">192.168.233.207</a> newsession=
<br>
<br>lttng enable-event lttng_statedump_start -k<br><br>Error: Event lttng_s=
tatedump_start: Unable to connect to lttng-relayd (channel channel0, sessio=
n news)<br>Warning: Some command(s) went wrong<br><br></div>In lttng-sessio=
nd -vvv log <br>
<br>[...]<br>DEBUG3 [1918/2019]: Consumer socket created (fd: 30) and added=
 to output (in consumer_create_socket() at consumer.c:300)<br>DEBUG1 [1918/=
2019]: Setting relayd for session news (in cmd_setup_relayd() at cmd.c:722)=
<br>
DEBUG3 [1918/2019]: Relayd connect ... (in relayd_connect() at relayd.c:466=
)<br>PERROR [1918/2019]: connect: Connection refused (in lttcomm_connect_in=
et_sock() at inet.c:253)<br>Error: Unable to reach lttng-relayd<br>DEBUG1 [=
1918/2019]: Sending response (size: 16, retcode: Unable to connect to lttng=
-relayd) (in thread_manage_clients() at main.c:3973)<br>
DEBUG1 [1918/2019]: Clean command context structure (in clean_command_ctx()=
 at main.c:672)<br>DEBUG1 [1918/2019]: Accepting client command ... (in thr=
ead_manage_clients() at main.c:3837)<br><br></div>On the linux pc<br></div>
i have started lttng-relayd<br><br></div>lttng-relayd -vvv -C tcp://<a href=
=3D"http://0.0.0.0:1234">0.0.0.0:1234</a> -D tcp://<a href=3D"http://0.0.0.=
0:5678">0.0.0.0:5678</a> (as specified in doc folder of lttng-tools)<br><br=
>
<br></div>Unfortunately i get error that lttng-relayd unable to connect. I =
also tried started lttng-relayd on mips board and running the same, still i=
 get same error.<br><br></div>Can someone explain steps for lttng trace str=
eaming or how i can dump the trace live onto PC.<br>
<br></div>Thank you<br>Skumar<br></div>

--001a1137f67c38235c04f21cc3c5--


--===============0704132346==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0704132346==--
