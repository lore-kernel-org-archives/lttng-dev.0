From: Jeffrey Chen <cpthk@live.com>
Subject: Re: Segfault during process exit
Date: Wed, 2 Mar 2016 22:13:23 +0000
Message-ID: <DM3PR13MB078236DB9E87094C58A69437C7BC0__35447.3660154783$1456956871$gmane$org@DM3PR13MB0782.namprd13.prod.outlook.com>
References: <DM3PR13MB07829B1DB9D8EEE29BE9124BC7BC0@DM3PR13MB0782.namprd13.prod.outlook.com>
 <56D73D48.3070700@efficios.com>
 <DM3PR13MB0782CC28E9FE90AA3B35B8E9C7BC0@DM3PR13MB0782.namprd13.prod.outlook.com>,
 <56D74E7B.3090901@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1435519382=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from col004-omc3s7.hotmail.com ([65.55.34.145])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <cpthk@live.com>) id 1abF1O-00054r-TC
 for lttng-dev@lists.lttng.org; Wed, 02 Mar 2016 17:13:32 -0500
In-Reply-To: <56D74E7B.3090901@efficios.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1435519382==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM3PR13MB078236DB9E87094C58A69437C7BC0DM3PR13MB0782namp_"

--_000_DM3PR13MB078236DB9E87094C58A69437C7BC0DM3PR13MB0782namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks!

I will try to get a sample executable. But, just from the theory point of v=
iew, this issue is possible, right?



________________________________
From: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Sent: Wednesday, March 2, 2016 12:35 PM
To: Jeffrey Chen
Cc: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] Segfault during process exit

Hi,

Don't forget to cc the mailing list.

On 2016-03-02 02:42 PM, Jeffrey Chen wrote:

Even I share our executable, you will not be able to run on your machine, a=
s it depends on our environment.

This is expected, it's also why I asked you if you could provide a reproduc=
er, a simpler version of your problem that reproduce the behavior even spor=
adically.


The idea is that, if you spawn some threads, and these threads keep writing=
 traces through LTTng. Then, exit the main thread, as in return main() func=
tion. LTTng's logic will do cleanup itself, but my other threads are still =
writing to LTTng. This would cause segfault. It would try to reference addr=
ess 0x0.

This could be a good start for a simple reproducer.

Cheers


#0  0x0000000000000000 in ?? ()
#1  0x00007f7e31fdfd78 in __tracepoint_cb_processor___tracepoint_info (
    taskNameArg=3D0x1cf3c30 "BackgroundTask", dataArg=3D0x1fd5200 "S")

...

________________________________
From: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com><mailto=
:Jonathan.rajotte-julien@efficios.com>
Sent: Wednesday, March 2, 2016 11:21 AM
To: Jeffrey Chen
Cc: lttng-dev@lists.lttng.org<mailto:lttng-dev@lists.lttng.org>
Subject: Re: [lttng-dev] Segfault during process exit

Hi,

Could you provide a reproducer ?

Could you give us some context ?

Thanks

On 2016-03-02 02:07 PM, Jeffrey Chen wrote:

Hi:


Our system process will spawn several background threads to do tasks. Durin=
g the process exit, there is no guarantee that these background threads are=
 finished. I have noticed several times that the execution would segfault d=
uring exiting. The stacktrace is showing that the segfault happened at the =
call to write trace, tracepoint(). My guess is that LTTng cleaned up the tr=
acing connection, and the background thread was still running. Has anyone n=
oticed this issue? I thought about trying wait for all the background threa=
ds to complete, but this is very difficult to do in a complex system, as th=
e background thread could spawn more threads during the process. Is there a=
ny way to solve this? Thanks.



_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org<mailto:lttng-dev@lists.lttng.org>
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev



--
Jonathan R. Julien
Efficios


--
Jonathan R. Julien
Efficios

--_000_DM3PR13MB078236DB9E87094C58A69437C7BC0DM3PR13MB0782namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;back=
ground-color:#FFFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
<p>Thanks!</p>
<p>I will try to get a sample executable. But, just from the theory point o=
f view, this issue is possible, right?<br>
</p>
<p><br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Jonathan Rajotte Ju=
lien &lt;Jonathan.rajotte-julien@efficios.com&gt;<br>
<b>Sent:</b> Wednesday, March 2, 2016 12:35 PM<br>
<b>To:</b> Jeffrey Chen<br>
<b>Cc:</b> lttng-dev@lists.lttng.org<br>
<b>Subject:</b> Re: [lttng-dev] Segfault during process exit</font>
<div>&nbsp;</div>
</div>
<div>Hi,<br>
<br>
Don't forget to cc the mailing list.<br>
<br>
<div class=3D"moz-cite-prefix">On 2016-03-02 02:42 PM, Jeffrey Chen wrote:<=
br>
</div>
<blockquote type=3D"cite"></blockquote>
<blockquote type=3D"cite">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt; color:#000000; ba=
ckground-color:#FFFFFF; font-family:Calibri,Arial,Helvetica,sans-serif">
<p>Even I share our executable, you will not be able to run on your machine=
, as it depends on our environment.</p>
</div>
</blockquote>
This is expected, it's also why I asked you if you could provide a reproduc=
er, a simpler version of your problem that reproduce the behavior even spor=
adically.<br>
<br>
<blockquote type=3D"cite">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt; color:#000000; ba=
ckground-color:#FFFFFF; font-family:Calibri,Arial,Helvetica,sans-serif">
<p>The idea is that, if you spawn some threads, and these threads keep writ=
ing traces through LTTng. Then, exit the main thread, as in return main() f=
unction. LTTng's logic will do cleanup itself, but my other threads are sti=
ll writing to LTTng. This would
 cause segfault. It would try to reference address 0x0.<br>
</p>
</div>
</blockquote>
This could be a good start for a simple reproducer. <br>
<br>
Cheers<br>
<blockquote type=3D"cite">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt; color:#000000; ba=
ckground-color:#FFFFFF; font-family:Calibri,Arial,Helvetica,sans-serif">
<p></p>
<p><br>
</p>
<p><span style=3D"background-color:rgb(255,255,0)">#0&nbsp; 0x0000000000000=
000 in ?? ()</span><br>
#1&nbsp; 0x00007f7e31fdfd78 in __tracepoint_cb_processor___tracepoint_info =
(<br>
&nbsp;&nbsp;&nbsp; taskNameArg=3D0x1cf3c30 &quot;BackgroundTask&quot;, data=
Arg=3D0x1fd5200 &quot;S&quot;)<br>
</p>
...<br>
<br>
<div style=3D"color:rgb(0,0,0)">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Jonathan Rajotte Ju=
lien
<a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:Jonathan.rajotte-julien@e=
fficios.com">
&lt;Jonathan.rajotte-julien@efficios.com&gt;</a><br>
<b>Sent:</b> Wednesday, March 2, 2016 11:21 AM<br>
<b>To:</b> Jeffrey Chen<br>
<b>Cc:</b> <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:lttng-dev@l=
ists.lttng.org">
lttng-dev@lists.lttng.org</a><br>
<b>Subject:</b> Re: [lttng-dev] Segfault during process exit</font>
<div>&nbsp;</div>
</div>
<div>Hi,<br>
<br>
Could you provide a reproducer ?<br>
<br>
Could you give us some context ?<br>
<br>
Thanks<br>
<br>
<div class=3D"moz-cite-prefix">On 2016-03-02 02:07 PM, Jeffrey Chen wrote:<=
br>
</div>
<blockquote type=3D"cite">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt; color:#000000; ba=
ckground-color:#FFFFFF; font-family:Calibri,Arial,Helvetica,sans-serif">
<p>Hi:</p>
<p><br>
</p>
<p>Our system process will spawn several background threads to do tasks. Du=
ring the process exit, there is no guarantee that these background threads =
are finished. I have noticed several times that the execution would segfaul=
t during exiting. The stacktrace
 is showing that the segfault happened at the call to write trace, tracepoi=
nt(). My guess is that LTTng cleaned up the tracing connection, and the bac=
kground thread was still running. Has anyone noticed this issue?&nbsp;I tho=
ught about trying wait for all the background
 threads to complete, but this is very difficult to do in a complex system,=
 as the background thread could spawn more threads during the process. Is t=
here any way to solve this? Thanks.<br>
</p>
</div>
<br>
<fieldset class=3D"mimeAttachmentHeader"></fieldset> <br>
<pre>_______________________________________________=0A=
lttng-dev mailing list=0A=
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:lttng-dev@lists.lttng.=
org">lttng-dev@lists.lttng.org</a>=0A=
<a title=3D"Ctrl&#43;Click or tap to follow the link" class=3D"moz-txt-link=
-freetext" href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-de=
v">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a>=0A=
</pre>
</blockquote>
<br>
<pre class=3D"moz-signature" cols=3D"72">-- =0A=
Jonathan R. Julien=0A=
Efficios</pre>
</div>
</div>
</div>
</blockquote>
<br>
<pre class=3D"moz-signature" cols=3D"72">-- =0A=
Jonathan R. Julien=0A=
Efficios</pre>
</div>
</div>
</div>
</body>
</html>

--_000_DM3PR13MB078236DB9E87094C58A69437C7BC0DM3PR13MB0782namp_--


--===============1435519382==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1435519382==--
