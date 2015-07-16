From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: SIGSEGV __event_probe,
 C++ application (static linking)
Date: Thu, 16 Jul 2015 04:00:47 +0000 (UTC)
Message-ID: <1746034392.1239.1437019247456.JavaMail.zimbra__6869.51978500492$1437019305$gmane$org@efficios.com>
References: <DM2PR12MB0314151E294EC13D1F7FF39A9B9C0@DM2PR12MB0314.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1526455519=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZFaLz-0001lX-U4
 for lttng-dev@lists.lttng.org; Thu, 16 Jul 2015 00:01:01 -0400
In-Reply-To: <DM2PR12MB0314151E294EC13D1F7FF39A9B9C0@DM2PR12MB0314.namprd12.prod.outlook.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Dilong Zheng <Dilong.Zheng@mitel.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1526455519==
Content-Type: multipart/alternative;
	boundary="----=_Part_1238_231110638.1437019247453"

------=_Part_1238_231110638.1437019247453
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Jul 13, 2015, at 4:37 PM, Dilong Zheng <Dilong.Zheng@mitel.com> wrote: 

> Hi,

> I have instrumented a C++ application with user space tracepoints. When I run
> the application and do a: "lttng list -u" command, I am able to see all my
> available tracepoints for the application. However when I enable those user
> space tracepoints and then start the trace, a core gets dumped and examining
> the core file in gdb I see the following error:

> Program terminated with signal SIGSEGV, Segmentation fault.
> #0 0x00000000 in ?? ()

> ...

> (gdb) bt
> #0 0x00000000 in ?? ()
> #1 0x08dd1088 in __event_probe__mike___sem_wait_entry (__tp_data=0xef92d818)
> at /localhome/zhengd/override_mcd/System/SS_Inc/./sem_wrapper.h:67
> #2 0x08dd44d9 in __tracepoint_cb_mike___sem_wait_entry () at
> /localhome/zhengd/override_mc /System/SS_Inc/sem_wrapper.h:67
> #3 __wrap_sem_wait (sem=0xf43014c8) at
> /localhome/zhengd/override_mcd/System/System_Services/SysServices_Linux/SystemLinux.cpp:1877

> Contextual Information: I would like to trace all calls to sem_wait() in my
> application. I am simply using a wrapper sem_wait function where I can place
> tracepoint() calls. Here's what the sem_wait wrapper looks like:

> extern "C" int __real_sem_wait(sem_t*);

> extern "C" int __wrap_sem_wait(sem_t* sem)

> {

> tracepoint(mike, sem_wait_entry);

> int ret = __real_sem_wait(sem);

> tracepoint(mike, sem_wait_exit, ret);

> return ret;

> }

> Here is the TRACEPOINT_EVENT macro found in my tracepoint provider header file
> (which was generated using lttng-gen-tp command line utility):

> TRACEPOINT_EVENT(mike,

> sem_wait_entry,

> TP_ARGS(),

> TP_FIELDS()

> )

> And I am statically linking by using an existing CPP file (file with the
> __wrap_sem_wait() function) to create probes. I would just like to know any
> possible reasons why this error may be happening given the above mentioned
> circumstances and what I may be able to try in order to fix this.

Which UST version do you use ? Make sure you upgrade to latest, 
since we have fixed a similar segfault issue with probes compiled in 
C++ not so long ago. 

Thanks, 

Mathieu 

> Thanks,

> Dilong

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_1238_231110638.1437019247453
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Jul 13, 2015, at 4:37 PM, Dilong Zheng &lt;Dilong.Zheng@mitel.=
com&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><blockq=
uote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5p=
x;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font=
-family:Helvetica,Arial,sans-serif;font-size:12pt;"><style style=3D"display=
:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style><div id=3D"divtag=
defaultwrapper" style=3D"font-size:12pt; color:#000000; background-color:#F=
FFFFF; font-family:Calibri,Arial,Helvetica,sans-serif"><p>Hi,</p><p><br></p=
><p>I have instrumented a C++ application with user space tracepoints. When=
 I run the application and do a: "lttng list -u" command, I am able to see =
all my available tracepoints for the application. However when I&nbsp;enabl=
e&nbsp;those&nbsp;user space tracepoints&nbsp;and then
 start the trace, a core gets dumped and&nbsp;examining the core file in gd=
b I see&nbsp;the following error:</p><p><br></p><p><span style=3D"font-size=
: 10pt; color: rgb(255, 0, 0);"><span style=3D"font-family: &quot;Courier N=
ew&quot;,monospace; color: rgb(255, 0, 0);"><span style=3D"color: rgb(255, =
0, 0);">Program terminated with signal SIGSEGV, Segmentation fault.</span><=
/span><br style=3D"font-family: &quot;Courier New&quot;,monospace; color: r=
gb(255, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;,monospace; color: rgb(2=
55, 0, 0);"><span style=3D"color: rgb(255, 0, 0);">#0&nbsp; 0x00000000 in ?=
? ()</span></span></span></p><p>...</p><p><span style=3D"font-family:&quot;=
Courier New&quot;,monospace; font-size:10pt">(gdb) bt</span><br style=3D"fo=
nt-family:&quot;Courier New&quot;,monospace; font-size:10pt"><span style=3D=
"font-family: &quot;Courier New&quot;,monospace; font-size: 10pt; color: rg=
b(255, 0, 0);"><span style=3D"color: rgb(255, 0, 0);">#0&nbsp; 0x00000000 i=
n ?? ()</span></span><br style=3D"font-family: &quot;Courier New&quot;,mono=
space; font-size: 10pt; color: rgb(255, 0, 0);"><span style=3D"font-family:=
 &quot;Courier New&quot;,monospace; font-size: 10pt; color: rgb(255, 0, 0);=
"><span style=3D"color: rgb(255, 0, 0);">#1&nbsp; 0x08dd1088 in __event_pro=
be__mike___sem_wait_entry (__tp_data=3D0xef92d818)</span></span><br style=
=3D"font-family: &quot;Courier New&quot;,monospace; font-size: 10pt; color:=
 rgb(255, 0, 0);"><span style=3D"font-family: &quot;Courier New&quot;,monos=
pace; font-size: 10pt; color: rgb(255, 0, 0);"><span style=3D"color: rgb(25=
5, 0, 0);">&nbsp;&nbsp;&nbsp; at /localhome/zhengd/override_mcd/System/SS_I=
nc/./sem_wrapper.h:67</span></span><br style=3D"font-family: &quot;Courier =
New&quot;,monospace; font-size: 10pt; color: rgb(255, 0, 0);"><span style=
=3D"font-family: &quot;Courier New&quot;,monospace; font-size: 10pt; color:=
 rgb(255, 0, 0);"><span style=3D"color: rgb(255, 0, 0);">#2&nbsp; 0x08dd44d=
9 in __tracepoint_cb_mike___sem_wait_entry () at /localhome/zhengd/override=
_mc
 /System/SS_Inc/sem_wrapper.h:67</span></span><br style=3D"font-family: &qu=
ot;Courier New&quot;,monospace; font-size: 10pt; color: rgb(255, 0, 0);"><s=
pan style=3D"font-family: &quot;Courier New&quot;,monospace; font-size: 10p=
t; color: rgb(255, 0, 0);"><span style=3D"color: rgb(255, 0, 0);">#3&nbsp; =
__wrap_sem_wait (sem=3D0xf43014c8) at /localhome/zhengd/override_mcd/System=
/System_Services/SysServices_Linux/SystemLinux.cpp:1877</span></span></p><p=
><br></p><p><b>Contextual Information:</b> I would like to trace all calls =
to <span style=3D"font-size:10pt; font-family:&quot;Courier New&quot;,monos=
pace">
<span style=3D"font-family:&quot;Courier New&quot;,monospace">sem_wait()</s=
pan></span> in my application. I am simply using a wrapper sem_wait functio=
n where I can place
<span style=3D"font-family: &quot;Courier New&quot;,monospace; font-size: 1=
0pt;">tracepoint()</span> calls. Here's what the sem_wait wrapper looks lik=
e:</p><p><br></p><div><div dir=3D"ltr"><div id=3D"x_divtagdefaultwrapper" s=
tyle=3D"color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);"><p><spa=
n style=3D"font-size: 10pt; font-family: &quot;Courier New&quot;,monospace;=
"><span style=3D"font-family: &quot;Courier New&quot;,monospace;">extern "C=
" int __real_sem_wait(sem_t*);</span></span></p><p><span style=3D"font-size=
: 10pt; font-family: &quot;Courier New&quot;,monospace;"><span style=3D"fon=
t-family: &quot;Courier New&quot;,monospace;">extern "C" int __wrap_sem_wai=
t(sem_t* sem)&nbsp;</span></span></p><p><span style=3D"font-size: 10pt; fon=
t-family: &quot;Courier New&quot;,monospace;"><span style=3D"font-family: &=
quot;Courier New&quot;,monospace;">{</span></span></p><p><span style=3D"fon=
t-size: 10pt; font-family: &quot;Courier New&quot;,monospace;"><span style=
=3D"font-family: &quot;Courier New&quot;,monospace;">&nbsp;&nbsp;&nbsp;&nbs=
p;tracepoint(mike,
 sem_wait_entry); &nbsp;</span></span></p><p><span style=3D"font-size: 10pt=
; font-family: &quot;Courier New&quot;,monospace;"><span style=3D"font-fami=
ly: &quot;Courier New&quot;,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;int ret =3D
 __real_sem_wait(sem);</span></span></p><p><span style=3D"font-size: 10pt; =
font-family: &quot;Courier New&quot;,monospace;"><span style=3D"font-family=
: &quot;Courier New&quot;,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;tracepoint(mi=
ke,
 sem_wait_exit, ret);</span></span></p><p><span style=3D"font-size: 10pt; f=
ont-family: &quot;Courier New&quot;,monospace;"><br style=3D"font-family: &=
quot;Courier New&quot;,monospace;">
</span></p><p><span style=3D"font-size: 10pt; font-family: &quot;Courier Ne=
w&quot;,monospace;"><span style=3D"font-family: &quot;Courier New&quot;,mon=
ospace;">&nbsp;&nbsp;&nbsp;&nbsp;return ret;&nbsp;</span></span></p><p><spa=
n style=3D"font-size: 10pt; font-family: &quot;Courier New&quot;,monospace;=
"><span style=3D"font-family: &quot;Courier New&quot;,monospace;">}</span><=
/span></p></div></div></div><p><br></p><p>Here is the TRACEPOINT_EVENT macr=
o found in my tracepoint provider header file (which was generated using lt=
tng-gen-tp command line utility):</p><p><br></p><p><span style=3D"font-fami=
ly: &quot;Courier New&quot;,monospace; font-size: 10pt;">TRACEPOINT_EVENT(m=
ike,
</span></p><p><span style=3D"font-family: &quot;Courier New&quot;,monospace=
; font-size: 10pt;">&nbsp;&nbsp;&nbsp;&nbsp;sem_wait_entry,</span></p><p><s=
pan style=3D"font-family: &quot;Courier New&quot;,monospace; font-size: 10p=
t;">&nbsp;&nbsp;&nbsp;&nbsp;TP_ARGS(),</span></p><p><span style=3D"font-fam=
ily: &quot;Courier New&quot;,monospace; font-size: 10pt;">&nbsp;&nbsp;&nbsp=
;&nbsp;TP_FIELDS()</span></p><p><span style=3D"font-family: &quot;Courier N=
ew&quot;,monospace; font-size: 10pt;">)</span><br></p><p><br></p><p>And I a=
m statically linking by using an existing CPP file&nbsp;(file with the&nbsp=
;__wrap_sem_wait() function) to create probes. I would just like to know an=
y possible reasons why this error may be happening given the above mentione=
d circumstances and what I may be
 able to try in order to fix this.</p></div></blockquote><div>Which UST ver=
sion do you use ? Make sure you upgrade to latest,<br></div><div>since we h=
ave fixed a similar segfault issue with probes compiled in<br data-mce-bogu=
s=3D"1"></div><div>C++ not so long ago.<br data-mce-bogus=3D"1"></div><div>=
<br data-mce-bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></div><=
div><br data-mce-bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></d=
iv><div><br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div>=
<blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-=
left:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:no=
ne;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div id=3D"divta=
gdefaultwrapper" style=3D"font-size:12pt; color:#000000; background-color:#=
FFFFFF; font-family:Calibri,Arial,Helvetica,sans-serif"><p><br></p><p>Thank=
s,</p><p><br></p><p>Dilong <br></p></div><br>______________________________=
_________________<br>lttng-dev mailing list<br>lttng-dev@lists.lttng.org<br=
>http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br></blockquote>=
</div><div><br></div><div data-marker=3D"__SIG_POST__">-- <br></div><div>Ma=
thieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com</div></div></bo=
dy></html>
------=_Part_1238_231110638.1437019247453--


--===============1526455519==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1526455519==--
