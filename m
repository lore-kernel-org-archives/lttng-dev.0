From: Dilong Zheng <Dilong.Zheng@mitel.com>
Subject: SIGSEGV __event_probe, C++ application (static linking)
Date: Mon, 13 Jul 2015 20:37:01 +0000
Message-ID: <DM2PR12MB0314151E294EC13D1F7FF39A9B9C0__22933.277875609$1436819879$gmane$org@DM2PR12MB0314.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1392228042=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-bn1bon0091.outbound.protection.outlook.com
 ([157.56.111.91] helo=na01-bn1-obe.outbound.protection.outlook.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Dilong.Zheng@mitel.com>) id 1ZEkTL-0001yz-HX
 for lttng-dev@lists.lttng.org; Mon, 13 Jul 2015 16:37:10 -0400
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1392228042==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM2PR12MB0314151E294EC13D1F7FF39A9B9C0DM2PR12MB0314namp_"

--_000_DM2PR12MB0314151E294EC13D1F7FF39A9B9C0DM2PR12MB0314namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,


I have instrumented a C++ application with user space tracepoints. When I r=
un the application and do a: "lttng list -u" command, I am able to see all =
my available tracepoints for the application. However when I enable those u=
ser space tracepoints and then start the trace, a core gets dumped and exam=
ining the core file in gdb I see the following error:


Program terminated with signal SIGSEGV, Segmentation fault.
#0  0x00000000 in ?? ()

...

(gdb) bt
#0  0x00000000 in ?? ()
#1  0x08dd1088 in __event_probe__mike___sem_wait_entry (__tp_data=3D0xef92d=
818)
    at /localhome/zhengd/override_mcd/System/SS_Inc/./sem_wrapper.h:67
#2  0x08dd44d9 in __tracepoint_cb_mike___sem_wait_entry () at /localhome/zh=
engd/override_mc /System/SS_Inc/sem_wrapper.h:67
#3  __wrap_sem_wait (sem=3D0xf43014c8) at /localhome/zhengd/override_mcd/Sy=
stem/System_Services/SysServices_Linux/SystemLinux.cpp:1877


Contextual Information: I would like to trace all calls to sem_wait() in my=
 application. I am simply using a wrapper sem_wait function where I can pla=
ce tracepoint() calls. Here's what the sem_wait wrapper looks like:


extern "C" int __real_sem_wait(sem_t*);

extern "C" int __wrap_sem_wait(sem_t* sem)

{

    tracepoint(mike, sem_wait_entry);

    int ret =3D __real_sem_wait(sem);

    tracepoint(mike, sem_wait_exit, ret);


    return ret;

}


Here is the TRACEPOINT_EVENT macro found in my tracepoint provider header f=
ile (which was generated using lttng-gen-tp command line utility):


TRACEPOINT_EVENT(mike,

    sem_wait_entry,

    TP_ARGS(),

    TP_FIELDS()

)


And I am statically linking by using an existing CPP file (file with the __=
wrap_sem_wait() function) to create probes. I would just like to know any p=
ossible reasons why this error may be happening given the above mentioned c=
ircumstances and what I may be able to try in order to fix this.


Thanks,


Dilong

--_000_DM2PR12MB0314151E294EC13D1F7FF39A9B9C0DM2PR12MB0314namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt; color:#000000; ba=
ckground-color:#FFFFFF; font-family:Calibri,Arial,Helvetica,sans-serif">
<p>Hi,</p>
<p><br>
</p>
<p>I have instrumented a C&#43;&#43; application with user space tracepoint=
s. When I run the application and do a: &quot;lttng list -u&quot; command, =
I am able to see all my available tracepoints for the application. However =
when I&nbsp;enable&nbsp;those&nbsp;user space tracepoints&nbsp;and then
 start the trace, a core gets dumped and&nbsp;examining the core file in gd=
b I see&nbsp;the following error:</p>
<p><br>
</p>
<p><span style=3D"font-size: 10pt; color: rgb(255, 0, 0);"><span style=3D"f=
ont-family: &quot;Courier New&quot;,monospace; color: rgb(255, 0, 0);"><spa=
n style=3D"color: rgb(255, 0, 0);">Program terminated with signal SIGSEGV, =
Segmentation fault.</span></span><br style=3D"font-family: &quot;Courier Ne=
w&quot;,monospace; color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);"></span><span style=3D"font-family: &=
quot;Courier New&quot;,monospace; color: rgb(255, 0, 0);"><span style=3D"co=
lor: rgb(255, 0, 0);">#0&nbsp; 0x00000000 in ?? ()</span></span></span></p>
<p>...</p>
<p><span style=3D"font-family:&quot;Courier New&quot;,monospace; font-size:=
10pt">(gdb) bt</span><br style=3D"font-family:&quot;Courier New&quot;,monos=
pace; font-size:10pt">
<span style=3D"font-family: &quot;Courier New&quot;,monospace; font-size: 1=
0pt; color: rgb(255, 0, 0);"><span style=3D"color: rgb(255, 0, 0);">#0&nbsp=
; 0x00000000 in ?? ()</span></span><br style=3D"font-family: &quot;Courier =
New&quot;,monospace; font-size: 10pt; color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);"></span><span style=3D"font-family: &=
quot;Courier New&quot;,monospace; font-size: 10pt; color: rgb(255, 0, 0);">=
<span style=3D"color: rgb(255, 0, 0);">#1&nbsp; 0x08dd1088 in __event_probe=
__mike___sem_wait_entry (__tp_data=3D0xef92d818)</span></span><br style=3D"=
font-family: &quot;Courier New&quot;,monospace; font-size: 10pt; color: rgb=
(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);"></span><span style=3D"font-family: &=
quot;Courier New&quot;,monospace; font-size: 10pt; color: rgb(255, 0, 0);">=
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; at /localhome/zhe=
ngd/override_mcd/System/SS_Inc/./sem_wrapper.h:67</span></span><br style=3D=
"font-family: &quot;Courier New&quot;,monospace; font-size: 10pt; color: rg=
b(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);"></span><span style=3D"font-family: &=
quot;Courier New&quot;,monospace; font-size: 10pt; color: rgb(255, 0, 0);">=
<span style=3D"color: rgb(255, 0, 0);">#2&nbsp; 0x08dd44d9 in __tracepoint_=
cb_mike___sem_wait_entry () at /localhome/zhengd/override_mc
 /System/SS_Inc/sem_wrapper.h:67</span></span><br style=3D"font-family: &qu=
ot;Courier New&quot;,monospace; font-size: 10pt; color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);"></span><span style=3D"font-family: &=
quot;Courier New&quot;,monospace; font-size: 10pt; color: rgb(255, 0, 0);">=
<span style=3D"color: rgb(255, 0, 0);">#3&nbsp; __wrap_sem_wait (sem=3D0xf4=
3014c8) at /localhome/zhengd/override_mcd/System/System_Services/SysService=
s_Linux/SystemLinux.cpp:1877</span></span></p>
<p><br>
</p>
<p><b>Contextual Information:</b> I would like to trace all calls to <span =
style=3D"font-size:10pt; font-family:&quot;Courier New&quot;,monospace">
<span style=3D"font-family:&quot;Courier New&quot;,monospace">sem_wait()</s=
pan></span> in my application. I am simply using a wrapper sem_wait functio=
n where I can place
<span style=3D"font-family: &quot;Courier New&quot;,monospace; font-size: 1=
0pt;">tracepoint()</span> calls. Here's what the sem_wait wrapper looks lik=
e:</p>
<p><br>
</p>
<div>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" style=3D"color: rgb(0, 0, 0); background=
-color: rgb(255, 255, 255);">
<p><span style=3D"font-size: 10pt; font-family: &quot;Courier New&quot;,mon=
ospace;"><span style=3D"font-family: &quot;Courier New&quot;,monospace;">ex=
tern &quot;C&quot; int __real_sem_wait(sem_t*);</span></span></p>
<p><span style=3D"font-size: 10pt; font-family: &quot;Courier New&quot;,mon=
ospace;"><span style=3D"font-family: &quot;Courier New&quot;,monospace;">ex=
tern &quot;C&quot; int __wrap_sem_wait(sem_t* sem)&nbsp;</span></span></p>
<p><span style=3D"font-size: 10pt; font-family: &quot;Courier New&quot;,mon=
ospace;"><span style=3D"font-family: &quot;Courier New&quot;,monospace;">{<=
/span></span></p>
<p><span class=3D"x_Apple-tab-span" style=3D"white-space: pre; font-size: 1=
0pt; font-family: &quot;Courier New&quot;,monospace;"></span></p>
<p><span style=3D"font-size: 10pt; font-family: &quot;Courier New&quot;,mon=
ospace;"><span class=3D"x_Apple-tab-span" style=3D"white-space: pre; font-s=
ize: 10pt; font-family: &quot;Courier New&quot;,monospace;"></span><span st=
yle=3D"font-family: &quot;Courier New&quot;,monospace;">&nbsp;&nbsp;&nbsp;&=
nbsp;tracepoint(mike,
 sem_wait_entry); &nbsp;</span></span></p>
<p><span style=3D"font-size: 10pt; font-family: &quot;Courier New&quot;,mon=
ospace;"><span class=3D"x_Apple-tab-span" style=3D"white-space: pre; font-s=
ize: 10pt; font-family: &quot;Courier New&quot;,monospace;"></span><span st=
yle=3D"font-family: &quot;Courier New&quot;,monospace;">&nbsp;&nbsp;&nbsp;&=
nbsp;int ret =3D
 __real_sem_wait(sem);</span></span></p>
<p><span style=3D"font-size: 10pt; font-family: &quot;Courier New&quot;,mon=
ospace;"><span class=3D"x_Apple-tab-span" style=3D"white-space: pre; font-s=
ize: 10pt; font-family: &quot;Courier New&quot;,monospace;"></span><span st=
yle=3D"font-family: &quot;Courier New&quot;,monospace;">&nbsp;&nbsp;&nbsp;&=
nbsp;tracepoint(mike,
 sem_wait_exit, ret);</span></span></p>
<p><span class=3D"x_Apple-tab-span" style=3D"white-space: pre; font-size: 1=
0pt; font-family: &quot;Courier New&quot;,monospace;"></span></p>
<p><span style=3D"font-size: 10pt; font-family: &quot;Courier New&quot;,mon=
ospace;"><span class=3D"x_Apple-tab-span" style=3D"white-space: pre; font-s=
ize: 10pt; font-family: &quot;Courier New&quot;,monospace;"></span><span st=
yle=3D"font-family: &quot;Courier New&quot;,monospace;"></span><br style=3D=
"font-family: &quot;Courier New&quot;,monospace;">
<span style=3D"font-family: &quot;Courier New&quot;,monospace;"></span></sp=
an></p>
<p><span style=3D"font-size: 10pt; font-family: &quot;Courier New&quot;,mon=
ospace;"><span class=3D"x_Apple-tab-span" style=3D"white-space: pre; font-s=
ize: 10pt; font-family: &quot;Courier New&quot;,monospace;"></span><span st=
yle=3D"font-family: &quot;Courier New&quot;,monospace;">&nbsp;&nbsp;&nbsp;&=
nbsp;return ret;&nbsp;</span></span></p>
<p><span style=3D"font-size: 10pt; font-family: &quot;Courier New&quot;,mon=
ospace;"><span style=3D"font-family: &quot;Courier New&quot;,monospace;">}<=
/span></span></p>
</div>
</div>
</div>
<p></p>
<p><br>
</p>
<p>Here is the TRACEPOINT_EVENT macro found in my tracepoint provider heade=
r file (which was generated using lttng-gen-tp command line utility):</p>
<p><br>
</p>
<p><span style=3D"font-family: &quot;Courier New&quot;,monospace; font-size=
: 10pt;">TRACEPOINT_EVENT(mike,
</span></p>
<p><span style=3D"font-family: &quot;Courier New&quot;,monospace; font-size=
: 10pt;">&nbsp;&nbsp;&nbsp;&nbsp;sem_wait_entry,</span></p>
<p><span style=3D"font-family: &quot;Courier New&quot;,monospace; font-size=
: 10pt;">&nbsp;&nbsp;&nbsp;&nbsp;TP_ARGS(),</span></p>
<p><span style=3D"font-family: &quot;Courier New&quot;,monospace; font-size=
: 10pt;">&nbsp;&nbsp;&nbsp;&nbsp;TP_FIELDS()</span></p>
<p><span style=3D"font-family: &quot;Courier New&quot;,monospace; font-size=
: 10pt;">)</span><br>
</p>
<p><br>
</p>
<p>And I am statically linking by using an existing CPP file&nbsp;(file wit=
h the&nbsp;__wrap_sem_wait() function) to create probes. I would just like =
to know any possible reasons why this error may be happening given the abov=
e mentioned circumstances and what I may be
 able to try in order to fix this.</p>
<p><br>
</p>
<p>Thanks,</p>
<p><br>
</p>
<p>Dilong <br>
</p>
</div>
</body>
</html>

--_000_DM2PR12MB0314151E294EC13D1F7FF39A9B9C0DM2PR12MB0314namp_--


--===============1392228042==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1392228042==--
