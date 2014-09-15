From: Alexander Grigoryev <grig0403@gmail.com>
Subject: Problem with perf:thread in 2.5.0
Date: Mon, 15 Sep 2014 18:20:02 +0400
Message-ID: <CACAPQqH-QTZB0RJ7oTwH4-EY5cabizXeB0y-2C5jqVW3_yNYiA__3951.11602633751$1410790877$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0821913456=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <grig0403@gmail.com>) id 1XTX8S-0003KT-QJ
 for lttng-dev@lists.lttng.org; Mon, 15 Sep 2014 10:20:14 -0400
Received: by mail-oi0-f41.google.com with SMTP id a3so1761710oib.14
 for <lttng-dev@lists.lttng.org>; Mon, 15 Sep 2014 07:20:03 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0821913456==
Content-Type: multipart/alternative; boundary=047d7b5d4882a7d95b05031b5486

--047d7b5d4882a7d95b05031b5486
Content-Type: text/plain; charset=UTF-8

Hi!

I use lttng-2.5.0 and linux-3.8.13.


When I try to add context for performance counters I get the following error:


> lttng create o ; lttng add-context -u  -t perf:thread:cache-references  -t perf:thread:cache-misses  -t perf:thread:bus-cycles  -t vpid -s o ; lttng destroy -a
Session o created.
Traces will be written in /home/alexgri/lttng-traces/o-20140915-155906
UST context perf:thread:cache-references added to all channels
Error: Context failed for channel channel0
Error: perf:thread:cache-misses: UST context already exist
Error: Context failed for channel channel0
Error: perf:thread:bus-cycles: UST context already exist
UST context vpid added to all channels
Warning: Some command(s) went wrong
Session o destroyed


If I kill lttng-sessiond:


> lttng create o ; lttng add-context -u  -t perf:thread:cache-references  -t perf:thread:cache-misses  -t perf:thread:bus-cycles  -t vpid -s o ; lttng destroy -a
Spawning a session daemon
PERROR - 15:59:01.250528 [13848/13856]: bind inet: Address already in
use (in lttcomm_bind_inet_sock() at inet.c:109)
Warning: Another session daemon is using this JUL port. JUL support
will be deactivated to prevent interfering with the tracing.
Session o created.
Traces will be written in /home/alexgri/lttng-traces/o-20140915-155901
UST context perf:thread:cache-references added to all channels
UST context perf:thread:cache-misses added to all channels
UST context perf:thread:bus-cycles added to all channels
UST context vpid added to all channels
Session o destroyed


and run this command n times (or run program with lttng tracepoints) ....


> lttng create o ; lttng add-context -u  -t perf:thread:cache-references  -t perf:thread:cache-misses  -t perf:thread:bus-cycles  -t vpid -s o ; lttng destroy -a
Session o created.
Traces will be written in /home/alexgri/lttng-traces/o-20140915-155906
UST context perf:thread:cache-references added to all channels
Error: Context failed for channel channel0
Error: perf:thread:cache-misses: UST context already exist
Error: Context failed for channel channel0
Error: perf:thread:bus-cycles: UST context already exist
UST context vpid added to all channels
Warning: Some command(s) went wrong
Session o destroyed


thanks, Alex

--047d7b5d4882a7d95b05031b5486
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><pre style=3D"font-family:courier,&#39;courier new&#39;,mo=
nospace;font-size:14px;white-space:pre-wrap;word-wrap:break-word;margin-top=
:0px;margin-bottom:0px;color:rgb(0,0,0);line-height:19.6000003814697px">Hi!

I use lttng-2.5.0 and linux-3.8.13.=C2=A0</pre><pre style=3D"font-family:co=
urier,&#39;courier new&#39;,monospace;font-size:14px;white-space:pre-wrap;w=
ord-wrap:break-word;margin-top:0px;margin-bottom:0px;color:rgb(0,0,0);line-=
height:19.6000003814697px"><br></pre><pre style=3D"font-family:courier,&#39=
;courier new&#39;,monospace;font-size:14px;white-space:pre-wrap;word-wrap:b=
reak-word;margin-top:0px;margin-bottom:0px;color:rgb(0,0,0);line-height:19.=
6000003814697px">When I try to add context for performance counters I get t=
he following error:</pre><pre style=3D"font-family:courier,&#39;courier new=
&#39;,monospace;font-size:14px;white-space:pre-wrap;word-wrap:break-word;ma=
rgin-top:0px;margin-bottom:0px;color:rgb(0,0,0);line-height:19.600000381469=
7px"><br></pre><pre style=3D"word-wrap:break-word;margin-top:0px;margin-bot=
tom:0px"><font color=3D"#000000" face=3D"courier, courier new, monospace"><=
span style=3D"font-size:14px;line-height:19.6000003814697px;white-space:pre=
-wrap">&gt; lttng create o ; lttng add-context -u  -t perf:thread:cache-ref=
erences  -t perf:thread:cache-misses  -t perf:thread:bus-cycles  -t vpid -s=
 o ; lttng destroy -a
Session o created.
Traces will be written in /home/alexgri/lttng-traces/o-20140915-155906
UST context perf:thread:cache-references added to all channels
Error: Context failed for channel channel0
Error: perf:thread:cache-misses: UST context already exist
Error: Context failed for channel channel0
Error: perf:thread:bus-cycles: UST context already exist
UST context vpid added to all channels
Warning: Some command(s) went wrong
Session o destroyed</span></font></pre><pre style=3D"word-wrap:break-word;m=
argin-top:0px;margin-bottom:0px"><font color=3D"#000000" face=3D"courier, c=
ourier new, monospace"><span style=3D"font-size:14px;line-height:19.6000003=
814697px;white-space:pre-wrap"><br></span></font></pre><pre style=3D"word-w=
rap:break-word;margin-top:0px;margin-bottom:0px"><font color=3D"#000000" fa=
ce=3D"courier, courier new, monospace"><span style=3D"font-size:14px;line-h=
eight:19.6000003814697px;white-space:pre-wrap">If I kill lttng-sessiond:</s=
pan></font></pre><pre style=3D"word-wrap:break-word;margin-top:0px;margin-b=
ottom:0px"><font color=3D"#000000" face=3D"courier, courier new, monospace"=
><span style=3D"font-size:14px;line-height:19.6000003814697px;white-space:p=
re-wrap"><br></span></font></pre><pre style=3D"word-wrap:break-word;margin-=
top:0px;margin-bottom:0px"><font color=3D"#000000" face=3D"courier, courier=
 new, monospace"><span style=3D"font-size:14px;line-height:19.6000003814697=
px;white-space:pre-wrap">&gt; lttng create o ; lttng add-context -u  -t per=
f:thread:cache-references  -t perf:thread:cache-misses  -t perf:thread:bus-=
cycles  -t vpid -s o ; lttng destroy -a
Spawning a session daemon
PERROR - 15:59:01.250528 [13848/13856]: bind inet: Address already in use (=
in lttcomm_bind_inet_sock() at inet.c:109)
Warning: Another session daemon is using this JUL port. JUL support will be=
 deactivated to prevent interfering with the tracing.
Session o created.
Traces will be written in /home/alexgri/lttng-traces/o-20140915-155901
UST context perf:thread:cache-references added to all channels
UST context perf:thread:cache-misses added to all channels
UST context perf:thread:bus-cycles added to all channels
UST context vpid added to all channels
Session o destroyed<br></span></font></pre><pre style=3D"word-wrap:break-wo=
rd;margin-top:0px;margin-bottom:0px"><font color=3D"#000000" face=3D"courie=
r, courier new, monospace"><span style=3D"font-size:14px;line-height:19.600=
0003814697px;white-space:pre-wrap"><br></span></font></pre><pre style=3D"wo=
rd-wrap:break-word;margin-top:0px;margin-bottom:0px"><font color=3D"#000000=
" face=3D"courier, courier new, monospace"><span style=3D"font-size:14px;li=
ne-height:19.6000003814697px;white-space:pre-wrap">and run this command</sp=
an></font><span style=3D"font-size:14px;line-height:19.6000003814697px;whit=
e-space:pre-wrap;color:rgb(0,0,0);font-family:courier,&#39;courier new&#39;=
,monospace"> n times (or run program with lttng tracepoints) ....</span></p=
re><pre style=3D"word-wrap:break-word;margin-top:0px;margin-bottom:0px"><fo=
nt color=3D"#000000" face=3D"courier, courier new, monospace"><span style=
=3D"font-size:14px;line-height:19.6000003814697px;white-space:pre-wrap"><br=
></span></font></pre><pre style=3D"word-wrap:break-word;margin-top:0px;marg=
in-bottom:0px"><font color=3D"#000000" face=3D"courier, courier new, monosp=
ace"><span style=3D"font-size:14px;line-height:19.6000003814697px;white-spa=
ce:pre-wrap">&gt; lttng create o ; lttng add-context -u  -t perf:thread:cac=
he-references  -t perf:thread:cache-misses  -t perf:thread:bus-cycles  -t v=
pid -s o ; lttng destroy -a
Session o created.
Traces will be written in /home/alexgri/lttng-traces/o-20140915-155906
UST context perf:thread:cache-references added to all channels
Error: Context failed for channel channel0
Error: perf:thread:cache-misses: UST context already exist
Error: Context failed for channel channel0
Error: perf:thread:bus-cycles: UST context already exist
UST context vpid added to all channels
Warning: Some command(s) went wrong
Session o destroyed<br></span></font></pre><pre style=3D"word-wrap:break-wo=
rd;margin-top:0px;margin-bottom:0px"><font color=3D"#000000" face=3D"courie=
r, courier new, monospace"><span style=3D"font-size:14px;line-height:19.600=
0003814697px;white-space:pre-wrap"><br></span></font></pre><pre style=3D"wo=
rd-wrap:break-word;margin-top:0px;margin-bottom:0px"><span style=3D"color:r=
gb(0,0,0);font-family:courier,&#39;courier new&#39;,monospace;font-size:14p=
x;line-height:19.6000003814697px;white-space:pre-wrap">thanks, </span><font=
 color=3D"#000000" face=3D"courier, courier new, monospace"><span style=3D"=
font-size:14px;line-height:19.6000003814697px;white-space:pre-wrap">Alex</s=
pan></font></pre></div>

--047d7b5d4882a7d95b05031b5486--


--===============0821913456==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0821913456==--
