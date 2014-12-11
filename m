From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Segfault at v_read() called from
 lib_ring_buffer_try_reserve_slow() in LTTng-UST traced app - CPU/VMware
 dependent
Date: Thu, 11 Dec 2014 15:36:30 +0000 (UTC)
Message-ID: <1745838195.26177.1418312190246.JavaMail.zimbra__26068.6335307129$1418312254$gmane$org@efficios.com>
References: <20998D40D9A2B7499CA5A3A2666CB1EB2D9DDA59@ZURMSG1.QUANTUM.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0368744929=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Xz5n7-0001od-OE
 for lttng-dev@lists.lttng.org; Thu, 11 Dec 2014 10:36:35 -0500
In-Reply-To: <20998D40D9A2B7499CA5A3A2666CB1EB2D9DDA59@ZURMSG1.QUANTUM.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David OShea <David.OShea@quantum.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0368744929==
Content-Type: multipart/alternative;
	boundary="----=_Part_26176_843151243.1418312190245"

------=_Part_26176_843151243.1418312190245
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- Original Message -----

> From: "David OShea" <David.OShea@quantum.com>
> To: "lttng-dev" <lttng-dev@lists.lttng.org>
> Sent: Sunday, December 7, 2014 10:30:04 PM
> Subject: [lttng-dev] Segfault at v_read() called from
> lib_ring_buffer_try_reserve_slow() in LTTng-UST traced app - CPU/VMware
> dependent

> Hi all,

> We have encountered a problem with using LTTng-UST tracing with our
> application, where on a particular VMware vCenter cluster we almost ways =
get
> segfaults when tracepoints are enabled, whereas on another vCenter cluste=
r,
> and on every other machine we=E2=80=99ve ever used, we don=E2=80=99t hit =
this problem.

> I can reproduce this using lttng-ust/tests/hello after using:

> """

> lttng create

> lttng enable-channel channel0 --userspace

> lttng add-context --userspace -t vpid -t vtid -t procname

> lttng enable-event --userspace "ust_tests_hello:*" -c channel0

> lttng start

> """

> In which case I get the following stack trace with an obvious NULL pointe=
r
> dereference:

> """

> Program terminated with signal SIGSEGV, Segmentation fault.

> #0 v_read (config=3D<optimized out>, v_a=3D0x0) at vatomic.h:48

> 48 return uatomic_read(&v_a->a);

> [...]

> #0 v_read (config=3D<optimized out>, v_a=3D0x0) at vatomic.h:48

> #1 0x00007f4aa10a4804 in lib_ring_buffer_try_reserve_slow (

> buf=3D0x7f4a98008a00, chan=3D0x7f4a98008a00, offsets=3D0x7fffef67c620,

> ctx=3D0x7fffef67ca40) at ring_buffer_frontend.c:1677

> #2 0x00007f4aa10a6c9f in lib_ring_buffer_reserve_slow (ctx=3D0x7fffef67ca=
40)

> at ring_buffer_frontend.c:1819

> #3 0x00007f4aa1095b75 in lib_ring_buffer_reserve (ctx=3D0x7fffef67ca40,

> config=3D0x7f4aa12b8ae0 <client_config>)

> at ../libringbuffer/frontend_api.h:211

> #4 lttng_event_reserve (ctx=3D0x7fffef67ca40, event_id=3D0)

> at lttng-ring-buffer-client.h:473

> #5 0x000000000040135f in __event_probe__ust_tests_hello___tptest (

> __tp_data=3D0xed3410, anint=3D0, netint=3D0, values=3D0x7fffef67cb50,

> text=3D0x7fffef67cb70 "test", textlen=3D<optimized out>, doublearg=3D2,

> floatarg=3D2222, boolarg=3Dtrue) at ././ust_tests_hello.h:32

> #6 0x0000000000400d2c in __tracepoint_cb_ust_tests_hello___tptest (

> boolarg=3Dtrue, floatarg=3D2222, doublearg=3D2, textlen=3D4,

> text=3D0x7fffef67cb70 "test", values=3D0x7fffef67cb50,

> netint=3D<optimized out>, anint=3D0) at ust_tests_hello.h:32

> #7 main (argc=3D<optimized out>, argv=3D<optimized out>) at hello.c:92

> """

> I hit this segfault 10 out of 10 times I ran =E2=80=9Chello=E2=80=9D on a=
 VM on one vCenter
> and 0 out of 10 times I ran it on the other, and the VMs otherwise had th=
e
> same software installed on them:

> - CentOS 6-based

> - kernel-2.6.32-504.1.3.el6 with some minor changes made in networking

> - userspace-rcu-0.8.3, lttng-ust-2.3.2 and lttng-tools-2.3.2 which might =
have
> some minor patches backported, and leftovers of changes to get them to bu=
ild
> on CentOS 5

> On the =E2=80=9Cgood=E2=80=9D vCenter, I tested on two different VM hosts=
:

> Processor Type: Intel(R) Xeon(R) CPU E5530 @ 2.40GHz

> EVC Mode: Intel(R) "Nehalem" Generation

> Image Profile: (Updated) ESXi-5.1.0-799733-standard

> Processor Type: Intel(R) Core(TM) i7-3930K CPU @ 3.20GHz

> EVC Mode: Intel(R) "Nehalem" Generation

> Image Profile: (Updated) ESXi-5.1.0-799733-standard

> The =E2=80=9Cbad=E2=80=9D vCenter VM host that I tested on had this confi=
guration:

> ESX Version: VMware ESXi, 5.0.0, 469512

> Processor Type: Intel(R) Xeon(R) CPU X7550 @ 2.00GHz

> Any ideas?

My bet would be that the OS is lying to userspace about the=20
number of possible CPUs. I wonder what liblttng-ust=20
libringbuffer/shm.h num_possible_cpus() is returning compared=20
to what lib_ring_buffer_get_cpu() returns.=20

Can you check this out ?=20

Thanks,=20

Mathieu=20

> Thanks in advance,
> David

> The information contained in this transmission may be confidential. Any
> disclosure, copying, or further distribution of confidential information =
is
> not permitted unless such privilege is explicitly granted in writing by
> Quantum. Quantum reserves the right to have electronic communications,
> including email and attachments, sent across its networks filtered throug=
h
> anti virus and spam software programs and retain such messages in order t=
o
> comply with applicable data security and retention requirements. Quantum =
is
> not responsible for the proper and complete transmission of the substance=
 of
> this communication or for any delay in its receipt.

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_26176_843151243.1418312190245
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><hr id=3D"zwchr"><blockquote style=3D=
"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;=
font-weight:normal;font-style:normal;text-decoration:none;font-family:Helve=
tica,Arial,sans-serif;font-size:12pt;" data-mce-style=3D"border-left: 2px s=
olid #1010FF; margin-left: 5px; padding-left: 5px; color: #000; font-weight=
: normal; font-style: normal; text-decoration: none; font-family: Helvetica=
,Arial,sans-serif; font-size: 12pt;"><b>From: </b>"David OShea" &lt;David.O=
Shea@quantum.com&gt;<br><b>To: </b>"lttng-dev" &lt;lttng-dev@lists.lttng.or=
g&gt;<br><b>Sent: </b>Sunday, December 7, 2014 10:30:04 PM<br><b>Subject: <=
/b>[lttng-dev] Segfault at v_read() called from lib_ring_buffer_try_reserve=
_slow() in LTTng-UST traced app - CPU/VMware dependent<br><div><br></div><s=
tyle><!--

@font-face
=09{font-family:"Cambria Math";
=09panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
=09{font-family:Calibri;
=09panose-1:2 15 5 2 2 2 4 3 2 4;}

p.MsoNormal, li.MsoNormal, div.MsoNormal
=09{margin:0cm;
=09margin-bottom:.0001pt;
=09font-size:11.0pt;
=09font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
=09{mso-style-priority:99;
=09color:blue;
=09text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
=09{mso-style-priority:99;
=09color:purple;
=09text-decoration:underline;}
span.EmailStyle17
=09{mso-style-type:personal-compose;
=09font-family:"Calibri","sans-serif";
=09color:windowtext;}
.MsoChpDefault
=09{mso-style-type:export-only;}
@page WordSection1
=09{size:612.0pt 792.0pt;
=09margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
=09{page:WordSection1;}
--></style><div class=3D"WordSection1"><p class=3D"MsoNormal">Hi all,</p><p=
 class=3D"MsoNormal">We have encountered a problem with using LTTng-UST tra=
cing with our application, where on a particular VMware vCenter cluster we =
almost ways get segfaults when tracepoints are enabled, whereas on another =
vCenter cluster, and on every other machine we=E2=80=99ve ever used, we don=
=E2=80=99t hit this problem.</p><p class=3D"MsoNormal">I can reproduce this=
 using lttng-ust/tests/hello after using:</p><p class=3D"MsoNormal">"""</p>=
<p class=3D"MsoNormal">lttng create</p><p class=3D"MsoNormal">lttng enable-=
channel channel0 --userspace</p><p class=3D"MsoNormal">lttng add-context --=
userspace -t vpid -t vtid -t procname</p><p class=3D"MsoNormal">lttng enabl=
e-event --userspace "ust_tests_hello:*" -c channel0</p><p class=3D"MsoNorma=
l">lttng start</p><p class=3D"MsoNormal">"""</p><p class=3D"MsoNormal">In w=
hich case I get the following stack trace with an obvious NULL pointer dere=
ference:</p><p class=3D"MsoNormal">"""</p><p class=3D"MsoNormal">Program te=
rminated with signal SIGSEGV, Segmentation fault.</p><p class=3D"MsoNormal"=
>#0&nbsp; v_read (config=3D&lt;optimized out&gt;, v_a=3D0x0) at vatomic.h:4=
8</p><p class=3D"MsoNormal">48&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return uatomic_read(&amp;v_a-&gt;a);</p><=
p class=3D"MsoNormal">[...]</p><p class=3D"MsoNormal">#0&nbsp; v_read (conf=
ig=3D&lt;optimized out&gt;, v_a=3D0x0) at vatomic.h:48</p><p class=3D"MsoNo=
rmal">#1&nbsp; 0x00007f4aa10a4804 in lib_ring_buffer_try_reserve_slow (</p>=
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; buf=3D0x7f4a98008a00, chan=3D0x7f=
4a98008a00, offsets=3D0x7fffef67c620,</p><p class=3D"MsoNormal">&nbsp;&nbsp=
;&nbsp; ctx=3D0x7fffef67ca40) at ring_buffer_frontend.c:1677</p><p class=3D=
"MsoNormal">#2&nbsp; 0x00007f4aa10a6c9f in lib_ring_buffer_reserve_slow (ct=
x=3D0x7fffef67ca40)</p><p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; at ring_bu=
ffer_frontend.c:1819</p><p class=3D"MsoNormal">#3&nbsp; 0x00007f4aa1095b75 =
in lib_ring_buffer_reserve (ctx=3D0x7fffef67ca40,</p><p class=3D"MsoNormal"=
>&nbsp;&nbsp;&nbsp; config=3D0x7f4aa12b8ae0 &lt;client_config&gt;)</p><p cl=
ass=3D"MsoNormal">&nbsp;&nbsp;&nbsp; at ../libringbuffer/frontend_api.h:211=
</p><p class=3D"MsoNormal">#4&nbsp; lttng_event_reserve (ctx=3D0x7fffef67ca=
40, event_id=3D0)</p><p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; at lttng-rin=
g-buffer-client.h:473</p><p class=3D"MsoNormal">#5&nbsp; 0x000000000040135f=
 in __event_probe__ust_tests_hello___tptest (</p><p class=3D"MsoNormal">&nb=
sp;&nbsp;&nbsp; __tp_data=3D0xed3410, anint=3D0, netint=3D0, values=3D0x7ff=
fef67cb50,</p><p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; text=3D0x7fffef67cb=
70 "test", textlen=3D&lt;optimized out&gt;, doublearg=3D2,</p><p class=3D"M=
soNormal">&nbsp;&nbsp;&nbsp; floatarg=3D2222, boolarg=3Dtrue) at ././ust_te=
sts_hello.h:32</p><p class=3D"MsoNormal">#6&nbsp; 0x0000000000400d2c in __t=
racepoint_cb_ust_tests_hello___tptest (</p><p class=3D"MsoNormal">&nbsp;&nb=
sp;&nbsp; boolarg=3Dtrue, floatarg=3D2222, doublearg=3D2, textlen=3D4,</p><=
p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; text=3D0x7fffef67cb70 "test", valu=
es=3D0x7fffef67cb50,</p><p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; netint=3D=
&lt;optimized out&gt;, anint=3D0) at ust_tests_hello.h:32</p><p class=3D"Ms=
oNormal">#7&nbsp; main (argc=3D&lt;optimized out&gt;, argv=3D&lt;optimized =
out&gt;) at hello.c:92</p><p class=3D"MsoNormal">"""</p><p class=3D"MsoNorm=
al">I hit this segfault 10 out of 10 times I ran =E2=80=9Chello=E2=80=9D on=
 a VM on one vCenter and 0 out of 10 times I ran it on the other, and the V=
Ms otherwise had the same software installed on them:</p><p class=3D"MsoNor=
mal">- CentOS 6-based</p><p class=3D"MsoNormal">- kernel-2.6.32-504.1.3.el6=
 with some minor changes made in networking</p><p class=3D"MsoNormal">- use=
rspace-rcu-0.8.3, lttng-ust-2.3.2 and lttng-tools-2.3.2 which might have so=
me minor patches backported, and leftovers of changes to get them to build =
on CentOS 5</p><p class=3D"MsoNormal">On the =E2=80=9Cgood=E2=80=9D vCenter=
, I tested on two different VM hosts:</p><p class=3D"MsoNormal">Processor T=
ype: Intel(R) Xeon(R) CPU E5530 @ 2.40GHz</p><p class=3D"MsoNormal">EVC Mod=
e: Intel(R) "Nehalem" Generation</p><p class=3D"MsoNormal">Image Profile: (=
Updated) ESXi-5.1.0-799733-standard</p><p class=3D"MsoNormal">Processor Typ=
e: Intel(R) Core(TM) i7-3930K CPU @ 3.20GHz</p><p class=3D"MsoNormal">EVC M=
ode: Intel(R) "Nehalem" Generation</p><p class=3D"MsoNormal">Image Profile:=
 (Updated) ESXi-5.1.0-799733-standard</p><p class=3D"MsoNormal">The =E2=80=
=9Cbad=E2=80=9D vCenter VM host that I tested on had this configuration:</p=
><p class=3D"MsoNormal">ESX Version: VMware ESXi, 5.0.0, 469512</p><p class=
=3D"MsoNormal">Processor Type: Intel(R) Xeon(R) CPU X7550 @ 2.00GHz</p><p c=
lass=3D"MsoNormal">Any ideas?</p></div></blockquote><div><br></div><div>My =
bet would be that the OS is lying to userspace about the<br></div><div>numb=
er of possible CPUs. I wonder what liblttng-ust<br></div><div>libringbuffer=
/shm.h num_possible_cpus() is returning compared<br></div><div>to what lib_=
ring_buffer_get_cpu() returns.<br></div><div><br></div><div>Can you check t=
his out ?<br></div><div><br></div><div>Thanks,<br></div><div><br></div><div=
>Mathieu<br></div><div><br></div><div><br></div><div><br></div><div><br></d=
iv><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;paddi=
ng-left:5px;color:#000;font-weight:normal;font-style:normal;text-decoration=
:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;" data-mce-styl=
e=3D"border-left: 2px solid #1010FF; margin-left: 5px; padding-left: 5px; c=
olor: #000; font-weight: normal; font-style: normal; text-decoration: none;=
 font-family: Helvetica,Arial,sans-serif; font-size: 12pt;"><div class=3D"W=
ordSection1"><p class=3D"MsoNormal">Thanks in advance,<br> David</p></div><=
hr>The information contained in this transmission may be confidential. Any =
disclosure, copying, or further distribution of confidential information is=
 not permitted unless such privilege is explicitly granted in writing by Qu=
antum. Quantum reserves the right to have electronic communications, includ=
ing email and attachments, sent across its networks filtered through anti v=
irus and spam software programs and retain such messages in order to comply=
 with applicable data security and retention requirements. Quantum is not r=
esponsible for the proper and complete transmission of the substance of thi=
s communication or for any delay in its receipt.<br><br>___________________=
____________________________<br>lttng-dev mailing list<br>lttng-dev@lists.l=
ttng.org<br>http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br></=
blockquote><div><br><br></div><div><br></div><div>-- <br></div><div><span n=
ame=3D"x"></span>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.=
com<span name=3D"x"></span><br></div></div></body></html>
------=_Part_26176_843151243.1418312190245--


--===============0368744929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0368744929==--
