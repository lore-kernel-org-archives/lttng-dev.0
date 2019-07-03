From: Matthew Khouzam <matthew.khouzam@ericsson.com>
Subject: Re: Log semaphore, mutex in CTF
Date: Wed, 3 Jul 2019 17:07:17 +0000
Message-ID: <DM6PR15MB310048432747F1E473BA5AA79EFB0__47124.1517154098$1562179311$gmane$org@DM6PR15MB3100.namprd15.prod.outlook.com>
References: <CABRndgzEX9fyedWgWtoMo9v3VWZRJps3EcF4aetbY4iLDkeKmA@mail.gmail.com>,
 <20190702141517.GA10880@joraj-alpa>,
 <DM6PR15MB3100597C23D1117D12F8D87E9EF80@DM6PR15MB3100.namprd15.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7810859152277694634=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790059.outbound.protection.outlook.com [40.107.79.59])
 by lists.lttng.org (Postfix) with ESMTPS id 45f91S3Ffwzr4j
 for <lttng-dev@lists.lttng.org>; Wed,  3 Jul 2019 14:41:31 -0400 (EDT)
In-Reply-To: <DM6PR15MB3100597C23D1117D12F8D87E9EF80@DM6PR15MB3100.namprd15.prod.outlook.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>, Zvi Vered <veredz72@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============7810859152277694634==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR15MB310048432747F1E473BA5AA79EFB0DM6PR15MB3100namp_"

--_000_DM6PR15MB310048432747F1E473BA5AA79EFB0DM6PR15MB3100namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Trying a reply as the ML seems to have had an issue.

________________________________
From: Matthew Khouzam
Sent: Tuesday, July 2, 2019 10:26:05 AM
To: Jonathan Rajotte-Julien; Zvi Vered
Cc: lttng-dev
Subject: Re: [lttng-dev] Log semaphore, mutex in CTF


Please correct me if I'm wrong, I'm waaay out of my comfort zone here...


So I am assuming you are doing kernel tracing. If it's userspace tracing, y=
ou need to wrap the library yourself. I don't know how recommendable it is,=
 you may incur some performance impact.


In Linux, mutexes/semaphores are atomic and not logged, unless there is con=
tention on the resource. You can see this as a "sys_futex" so look up "utex=
" and you should be good.


Also, if you keep your trace in CTF, certain trace viewers can show your co=
ntention between threads[1].


Br,

Matthew


[1] https://wiki.eclipse.org/Trace_Compass/News/NewIn23



________________________________
From: lttng-dev <lttng-dev-bounces@lists.lttng.org> on behalf of Jonathan R=
ajotte-Julien <jonathan.rajotte-julien@efficios.com>
Sent: Tuesday, July 2, 2019 10:15:17 AM
To: Zvi Vered
Cc: lttng-dev
Subject: Re: [lttng-dev] Log semaphore, mutex in CTF

HI Zvika,

It all depends on what exactly you traced. Did you trace some userspace
application? Did you trace the kernel?

A trace is as good as its tracepoints. You can use lttng list to get the
available tracepoints for each tracing domain:

From "lttng-list" man page:

  With one or more of the --kernel, --userspace, --jul, --log4j, and --pyth=
on
  domain options, the command lists the available event sources of the sele=
cted
  domain on the system. The JUL, log4j, and Python domains list the names o=
f their
  available loggers. The --syscall option can be used alongside the --kerne=
l
  option to get a list of traceable Linux system calls. The --fields option=
 can be
  used to show the fields of the listed event sources.

AFAIK, lttng-modules does not instrument locking primitive.

lttng-ust does provides overwrite library for pthread_mutex_lock,
pthread_mutex_trylock and pthread_mutex_unlock. You will need to LD_PRELOAD=
 (application start) it.

https://protect2.fireeye.com/url?k=3Dd4352e55-88e124c9-d4356ece-8631fc8bdea=
5-87f781b0b8299b36&q=3D1&u=3Dhttps%3A%2F%2Fgithub.com%2Flttng%2Flttng-ust%2=
Ftree%2F9d4d2a639afc19a1bd705ea560782917ac892596%2Fliblttng-ust-libc-wrappe=
r

Cheers.

On Mon, Jul 01, 2019 at 07:49:16AM +0300, Zvi Vered wrote:
> Hello,
>
> I converted CTF files created by ltt-ng to text file using babeltrace.
>
> Can you please tell how semaphore, mutex are logged in this text file ?
>
> I did not find the terms "sema" or "mutex".
>
> Thank you,
> Zvika

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://protect2.fireeye.com/url?k=3Def7159f6-b3a5536a-ef71196d-8631fc8bd=
ea5-094f48839611091d&q=3D1&u=3Dhttps%3A%2F%2Flists.lttng.org%2Fcgi-bin%2Fma=
ilman%2Flistinfo%2Flttng-dev


--
Jonathan Rajotte-Julien
EfficiOS
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://protect2.fireeye.com/url?k=3D9cb6213c-c0622ba0-9cb661a7-8631fc8bdea=
5-60f0dcbb0316005d&q=3D1&u=3Dhttps%3A%2F%2Flists.lttng.org%2Fcgi-bin%2Fmail=
man%2Flistinfo%2Flttng-dev

--_000_DM6PR15MB310048432747F1E473BA5AA79EFB0DM6PR15MB3100namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Trying a reply as the ML seems to=
 have had an issue.<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Matthew Khouzam<br>
<b>Sent:</b> Tuesday, July 2, 2019 10:26:05 AM<br>
<b>To:</b> Jonathan Rajotte-Julien; Zvi Vered<br>
<b>Cc:</b> lttng-dev<br>
<b>Subject:</b> Re: [lttng-dev] Log semaphore, mutex in CTF</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Helvetica,sans-serif">
<p style=3D"margin-top:0; margin-bottom:0">Please correct me if I'm wrong, =
I'm waaay out of my comfort zone here...</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0">So I am assuming you are doing k=
ernel tracing. If it's userspace tracing, you need to wrap the library your=
self. I don't know how recommendable it is, you may incur some performance =
impact.<br>
</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0">In Linux, mutexes/semaphores are=
 atomic and not logged, unless there is contention on the resource. You can=
 see this as a &quot;sys_futex&quot; so look up &quot;utex&quot; and you sh=
ould be good.</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0">Also, if you keep your trace in =
CTF, certain trace viewers can show your contention between threads[1].</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0">Br,</p>
<p style=3D"margin-top:0; margin-bottom:0">Matthew<br>
</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0">[1] <a href=3D"https://wiki.ecli=
pse.org/Trace_Compass/News/NewIn23" class=3D"x_OWAAutoLink" id=3D"LPlnk3655=
99">
https://wiki.eclipse.org/Trace_Compass/News/NewIn23</a><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> lttng-dev &lt;lttng=
-dev-bounces@lists.lttng.org&gt; on behalf of Jonathan Rajotte-Julien &lt;j=
onathan.rajotte-julien@efficios.com&gt;<br>
<b>Sent:</b> Tuesday, July 2, 2019 10:15:17 AM<br>
<b>To:</b> Zvi Vered<br>
<b>Cc:</b> lttng-dev<br>
<b>Subject:</b> Re: [lttng-dev] Log semaphore, mutex in CTF</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">HI Zvika,<br>
<br>
It all depends on what exactly you traced. Did you trace some userspace<br>
application? Did you trace the kernel?<br>
<br>
A trace is as good as its tracepoints. You can use lttng list to get the<br=
>
available tracepoints for each tracing domain:<br>
<br>
From &quot;lttng-list&quot; man page:<br>
<br>
&nbsp; With one or more of the --kernel, --userspace, --jul, --log4j, and -=
-python<br>
&nbsp; domain options, the command lists the available event sources of the=
 selected<br>
&nbsp; domain on the system. The JUL, log4j, and Python domains list the na=
mes of their<br>
&nbsp; available loggers. The --syscall option can be used alongside the --=
kernel<br>
&nbsp; option to get a list of traceable Linux system calls. The --fields o=
ption can be<br>
&nbsp; used to show the fields of the listed event sources.<br>
<br>
AFAIK, lttng-modules does not instrument locking primitive.<br>
<br>
lttng-ust does provides overwrite library for pthread_mutex_lock,<br>
pthread_mutex_trylock and pthread_mutex_unlock. You will need to LD_PRELOAD=
 (application start) it.<br>
<br>
<a href=3D"https://protect2.fireeye.com/url?k=3Dd4352e55-88e124c9-d4356ece-=
8631fc8bdea5-87f781b0b8299b36&amp;q=3D1&amp;u=3Dhttps%3A%2F%2Fgithub.com%2F=
lttng%2Flttng-ust%2Ftree%2F9d4d2a639afc19a1bd705ea560782917ac892596%2Fliblt=
tng-ust-libc-wrapper">https://protect2.fireeye.com/url?k=3Dd4352e55-88e124c=
9-d4356ece-8631fc8bdea5-87f781b0b8299b36&amp;q=3D1&amp;u=3Dhttps%3A%2F%2Fgi=
thub.com%2Flttng%2Flttng-ust%2Ftree%2F9d4d2a639afc19a1bd705ea560782917ac892=
596%2Fliblttng-ust-libc-wrapper</a><br>
<br>
Cheers.<br>
<br>
On Mon, Jul 01, 2019 at 07:49:16AM &#43;0300, Zvi Vered wrote:<br>
&gt; Hello,<br>
&gt; <br>
&gt; I converted CTF files created by ltt-ng to text file using babeltrace.=
<br>
&gt; <br>
&gt; Can you please tell how semaphore, mutex are logged in this text file =
?<br>
&gt; <br>
&gt; I did not find the terms &quot;sema&quot; or &quot;mutex&quot;.<br>
&gt; <br>
&gt; Thank you,<br>
&gt; Zvika<br>
<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; lttng-dev@lists.lttng.org<br>
&gt; <a href=3D"https://protect2.fireeye.com/url?k=3Def7159f6-b3a5536a-ef71=
196d-8631fc8bdea5-094f48839611091d&amp;q=3D1&amp;u=3Dhttps%3A%2F%2Flists.lt=
tng.org%2Fcgi-bin%2Fmailman%2Flistinfo%2Flttng-dev">
https://protect2.fireeye.com/url?k=3Def7159f6-b3a5536a-ef71196d-8631fc8bdea=
5-094f48839611091d&amp;q=3D1&amp;u=3Dhttps%3A%2F%2Flists.lttng.org%2Fcgi-bi=
n%2Fmailman%2Flistinfo%2Flttng-dev</a><br>
<br>
<br>
-- <br>
Jonathan Rajotte-Julien<br>
EfficiOS<br>
_______________________________________________<br>
lttng-dev mailing list<br>
lttng-dev@lists.lttng.org<br>
<a href=3D"https://protect2.fireeye.com/url?k=3D9cb6213c-c0622ba0-9cb661a7-=
8631fc8bdea5-60f0dcbb0316005d&amp;q=3D1&amp;u=3Dhttps%3A%2F%2Flists.lttng.o=
rg%2Fcgi-bin%2Fmailman%2Flistinfo%2Flttng-dev">https://protect2.fireeye.com=
/url?k=3D9cb6213c-c0622ba0-9cb661a7-8631fc8bdea5-60f0dcbb0316005d&amp;q=3D1=
&amp;u=3Dhttps%3A%2F%2Flists.lttng.org%2Fcgi-bin%2Fmailman%2Flistinfo%2Fltt=
ng-dev</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR15MB310048432747F1E473BA5AA79EFB0DM6PR15MB3100namp_--

--===============7810859152277694634==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============7810859152277694634==--
