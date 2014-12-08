From: David OShea <David.OShea@quantum.com>
Subject: Segfault at v_read() called from
 lib_ring_buffer_try_reserve_slow() in LTTng-UST traced app - CPU/VMware
 dependent
Date: Mon, 8 Dec 2014 03:30:04 +0000
Message-ID: <20998D40D9A2B7499CA5A3A2666CB1EB2D9DDA59__37837.7013876618$1418009466$gmane$org@ZURMSG1.QUANTUM.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0989734319=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx0b-000ceb01.pphosted.com ([67.231.152.126])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <prvs=241962d08c=david.oshea@quantum.com>)
 id 1Xxp1W-0000jN-2m
 for lttng-dev@lists.lttng.org; Sun, 07 Dec 2014 22:30:13 -0500
Received: from pps.filterd (m0001151 [127.0.0.1])
 by mx0b-000ceb01.pphosted.com (8.14.5/8.14.5) with SMTP id sB83U9Pt009423
 for <lttng-dev@lists.lttng.org>; Sun, 7 Dec 2014 19:30:09 -0800
Received: from ppoxedge2.quantum.com ([146.174.252.28])
 by mx0b-000ceb01.pphosted.com with ESMTP id 1r4nvt0est-1
 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Sun, 07 Dec 2014 19:30:09 -0800
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0989734319==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_20998D40D9A2B7499CA5A3A2666CB1EB2D9DDA59ZURMSG1QUANTUMc_"

--_000_20998D40D9A2B7499CA5A3A2666CB1EB2D9DDA59ZURMSG1QUANTUMc_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

We have encountered a problem with using LTTng-UST tracing with our applica=
tion, where on a particular VMware vCenter cluster we almost ways get segfa=
ults when tracepoints are enabled, whereas on another vCenter cluster, and =
on every other machine we've ever used, we don't hit this problem.

I can reproduce this using lttng-ust/tests/hello after using:

"""
lttng create
lttng enable-channel channel0 --userspace
lttng add-context --userspace -t vpid -t vtid -t procname
lttng enable-event --userspace "ust_tests_hello:*" -c channel0
lttng start
"""

In which case I get the following stack trace with an obvious NULL pointer =
dereference:

"""
Program terminated with signal SIGSEGV, Segmentation fault.
#0  v_read (config=3D<optimized out>, v_a=3D0x0) at vatomic.h:48
48              return uatomic_read(&v_a->a);
[...]
#0  v_read (config=3D<optimized out>, v_a=3D0x0) at vatomic.h:48
#1  0x00007f4aa10a4804 in lib_ring_buffer_try_reserve_slow (
    buf=3D0x7f4a98008a00, chan=3D0x7f4a98008a00, offsets=3D0x7fffef67c620,
    ctx=3D0x7fffef67ca40) at ring_buffer_frontend.c:1677
#2  0x00007f4aa10a6c9f in lib_ring_buffer_reserve_slow (ctx=3D0x7fffef67ca4=
0)
    at ring_buffer_frontend.c:1819
#3  0x00007f4aa1095b75 in lib_ring_buffer_reserve (ctx=3D0x7fffef67ca40,
    config=3D0x7f4aa12b8ae0 <client_config>)
    at ../libringbuffer/frontend_api.h:211
#4  lttng_event_reserve (ctx=3D0x7fffef67ca40, event_id=3D0)
    at lttng-ring-buffer-client.h:473
#5  0x000000000040135f in __event_probe__ust_tests_hello___tptest (
    __tp_data=3D0xed3410, anint=3D0, netint=3D0, values=3D0x7fffef67cb50,
    text=3D0x7fffef67cb70 "test", textlen=3D<optimized out>, doublearg=3D2,
    floatarg=3D2222, boolarg=3Dtrue) at ././ust_tests_hello.h:32
#6  0x0000000000400d2c in __tracepoint_cb_ust_tests_hello___tptest (
    boolarg=3Dtrue, floatarg=3D2222, doublearg=3D2, textlen=3D4,
    text=3D0x7fffef67cb70 "test", values=3D0x7fffef67cb50,
    netint=3D<optimized out>, anint=3D0) at ust_tests_hello.h:32
#7  main (argc=3D<optimized out>, argv=3D<optimized out>) at hello.c:92
"""

I hit this segfault 10 out of 10 times I ran "hello" on a VM on one vCenter=
 and 0 out of 10 times I ran it on the other, and the VMs otherwise had the=
 same software installed on them:

- CentOS 6-based
- kernel-2.6.32-504.1.3.el6 with some minor changes made in networking
- userspace-rcu-0.8.3, lttng-ust-2.3.2 and lttng-tools-2.3.2 which might ha=
ve some minor patches backported, and leftovers of changes to get them to b=
uild on CentOS 5

On the "good" vCenter, I tested on two different VM hosts:

Processor Type: Intel(R) Xeon(R) CPU E5530 @ 2.40GHz
EVC Mode: Intel(R) "Nehalem" Generation
Image Profile: (Updated) ESXi-5.1.0-799733-standard

Processor Type: Intel(R) Core(TM) i7-3930K CPU @ 3.20GHz
EVC Mode: Intel(R) "Nehalem" Generation
Image Profile: (Updated) ESXi-5.1.0-799733-standard

The "bad" vCenter VM host that I tested on had this configuration:

ESX Version: VMware ESXi, 5.0.0, 469512
Processor Type: Intel(R) Xeon(R) CPU X7550 @ 2.00GHz

Any ideas?

Thanks in advance,
David

----------------------------------------------------------------------
The information contained in this transmission may be confidential. Any dis=
closure, copying, or further distribution of confidential information is no=
t permitted unless such privilege is explicitly granted in writing by Quant=
um. Quantum reserves the right to have electronic communications, including=
 email and attachments, sent across its networks filtered through anti viru=
s and spam software programs and retain such messages in order to comply wi=
th applicable data security and retention requirements. Quantum is not resp=
onsible for the proper and complete transmission of the substance of this c=
ommunication or for any delay in its receipt.

--_000_20998D40D9A2B7499CA5A3A2666CB1EB2D9DDA59ZURMSG1QUANTUMc_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii">
<meta name=3D"Generator" content=3D"Microsoft Word 12 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-AU" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi all,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">We have encountered a problem with using LTTng-UST t=
racing with our application, where on a particular VMware vCenter cluster w=
e almost ways get segfaults when tracepoints are enabled, whereas on anothe=
r vCenter cluster, and on every other
 machine we&#8217;ve ever used, we don&#8217;t hit this problem.<o:p></o:p>=
</p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I can reproduce this using lttng-ust/tests/hello aft=
er using:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&quot;&quot;&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">lttng create<o:p></o:p></p>
<p class=3D"MsoNormal">lttng enable-channel channel0 --userspace<o:p></o:p>=
</p>
<p class=3D"MsoNormal">lttng add-context --userspace -t vpid -t vtid -t pro=
cname<o:p></o:p></p>
<p class=3D"MsoNormal">lttng enable-event --userspace &quot;ust_tests_hello=
:*&quot; -c channel0<o:p></o:p></p>
<p class=3D"MsoNormal">lttng start<o:p></o:p></p>
<p class=3D"MsoNormal">&quot;&quot;&quot;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">In which case I get the following stack trace with a=
n obvious NULL pointer dereference:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&quot;&quot;&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">Program terminated with signal SIGSEGV, Segmentation=
 fault.<o:p></o:p></p>
<p class=3D"MsoNormal">#0&nbsp; v_read (config=3D&lt;optimized out&gt;, v_a=
=3D0x0) at vatomic.h:48<o:p></o:p></p>
<p class=3D"MsoNormal">48&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; return uatomic_read(&amp;v_a-&gt;a);<o:p></o:p=
></p>
<p class=3D"MsoNormal">[...]<o:p></o:p></p>
<p class=3D"MsoNormal">#0&nbsp; v_read (config=3D&lt;optimized out&gt;, v_a=
=3D0x0) at vatomic.h:48<o:p></o:p></p>
<p class=3D"MsoNormal">#1&nbsp; 0x00007f4aa10a4804 in lib_ring_buffer_try_r=
eserve_slow (<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; buf=3D0x7f4a98008a00, chan=3D0x7f=
4a98008a00, offsets=3D0x7fffef67c620,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; ctx=3D0x7fffef67ca40) at ring_buf=
fer_frontend.c:1677<o:p></o:p></p>
<p class=3D"MsoNormal">#2&nbsp; 0x00007f4aa10a6c9f in lib_ring_buffer_reser=
ve_slow (ctx=3D0x7fffef67ca40)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; at ring_buffer_frontend.c:1819<o:=
p></o:p></p>
<p class=3D"MsoNormal">#3&nbsp; 0x00007f4aa1095b75 in lib_ring_buffer_reser=
ve (ctx=3D0x7fffef67ca40,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; config=3D0x7f4aa12b8ae0 &lt;clien=
t_config&gt;)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; at ../libringbuffer/frontend_api.=
h:211<o:p></o:p></p>
<p class=3D"MsoNormal">#4&nbsp; lttng_event_reserve (ctx=3D0x7fffef67ca40, =
event_id=3D0)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; at lttng-ring-buffer-client.h:473=
<o:p></o:p></p>
<p class=3D"MsoNormal">#5&nbsp; 0x000000000040135f in __event_probe__ust_te=
sts_hello___tptest (<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; __tp_data=3D0xed3410, anint=3D0, =
netint=3D0, values=3D0x7fffef67cb50,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; text=3D0x7fffef67cb70 &quot;test&=
quot;, textlen=3D&lt;optimized out&gt;, doublearg=3D2,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; floatarg=3D2222, boolarg=3Dtrue) =
at ././ust_tests_hello.h:32<o:p></o:p></p>
<p class=3D"MsoNormal">#6&nbsp; 0x0000000000400d2c in __tracepoint_cb_ust_t=
ests_hello___tptest (<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; boolarg=3Dtrue, floatarg=3D2222, =
doublearg=3D2, textlen=3D4,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; text=3D0x7fffef67cb70 &quot;test&=
quot;, values=3D0x7fffef67cb50,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; netint=3D&lt;optimized out&gt;, a=
nint=3D0) at ust_tests_hello.h:32<o:p></o:p></p>
<p class=3D"MsoNormal">#7&nbsp; main (argc=3D&lt;optimized out&gt;, argv=3D=
&lt;optimized out&gt;) at hello.c:92<o:p></o:p></p>
<p class=3D"MsoNormal">&quot;&quot;&quot;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I hit this segfault 10 out of 10 times I ran &#8220;=
hello&#8221; on a VM on one vCenter and 0 out of 10 times I ran it on the o=
ther, and the VMs otherwise had the same software installed on them:<o:p></=
o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">- CentOS 6-based<o:p></o:p></p>
<p class=3D"MsoNormal">- kernel-2.6.32-504.1.3.el6 with some minor changes =
made in networking<o:p></o:p></p>
<p class=3D"MsoNormal">- userspace-rcu-0.8.3, lttng-ust-2.3.2 and lttng-too=
ls-2.3.2 which might have some minor patches backported, and leftovers of c=
hanges to get them to build on CentOS 5<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">On the &#8220;good&#8221; vCenter, I tested on two d=
ifferent VM hosts:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Processor Type: Intel(R) Xeon(R) CPU E5530 @ 2.40GHz=
<o:p></o:p></p>
<p class=3D"MsoNormal">EVC Mode: Intel(R) &quot;Nehalem&quot; Generation<o:=
p></o:p></p>
<p class=3D"MsoNormal">Image Profile: (Updated) ESXi-5.1.0-799733-standard<=
o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Processor Type: Intel(R) Core(TM) i7-3930K CPU @ 3.2=
0GHz<o:p></o:p></p>
<p class=3D"MsoNormal">EVC Mode: Intel(R) &quot;Nehalem&quot; Generation<o:=
p></o:p></p>
<p class=3D"MsoNormal">Image Profile: (Updated) ESXi-5.1.0-799733-standard<=
o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The &#8220;bad&#8221; vCenter VM host that I tested =
on had this configuration:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">ESX Version: VMware ESXi, 5.0.0, 469512<o:p></o:p></=
p>
<p class=3D"MsoNormal">Processor Type: Intel(R) Xeon(R) CPU X7550 @ 2.00GHz=
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Any ideas?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks in advance,<br>
David<o:p></o:p></p>
</div>

<HR>The information contained in this transmission may be confidential. Any=
 disclosure, copying, or further distribution of confidential information i=
s not permitted unless such privilege is explicitly granted in writing by Q=
uantum. Quantum reserves the right to have electronic communications, inclu=
ding email and attachments, sent across its networks filtered through anti =
virus and spam software programs and retain such messages in order to compl=
y with applicable data security and retention requirements. Quantum is not =
responsible for the proper and complete transmission of the substance of th=
is communication or for any delay in its receipt.<BR>
</body>
</html>

--_000_20998D40D9A2B7499CA5A3A2666CB1EB2D9DDA59ZURMSG1QUANTUMc_--


--===============0989734319==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0989734319==--
