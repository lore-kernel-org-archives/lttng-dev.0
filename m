From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: LTTng memory map
Date: Fri, 30 Sep 2016 01:24:41 +0000 (UTC)
Message-ID: <183868643.41213.1475198681743.JavaMail.zimbra__27581.4080880538$1475198656$gmane$org@efficios.com>
References: <CY4PR13MB14149C4EF327ABE7F53ED61AC7CC0@CY4PR13MB1414.namprd13.prod.outlook.com>
 <DM5PR13MB14195604280F866E14687DFCC7CF0@DM5PR13MB1419.namprd13.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3959218081127091956=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 9B926A2053
 for <lttng-dev@lists.lttng.org>; Fri, 30 Sep 2016 01:25:11 +0000 (UTC)
In-Reply-To: <DM5PR13MB14195604280F866E14687DFCC7CF0@DM5PR13MB1419.namprd13.prod.outlook.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jeffrey Chen <cpthk@live.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============3959218081127091956==
Content-Type: multipart/alternative;
	boundary="=_62bb428b-fd82-4d43-8e53-11109b07ddc9"

--=_62bb428b-fd82-4d43-8e53-11109b07ddc9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Yes, we open and then unlink the file in the shm within consumerd. 
Its inode stays reserved on the disk as long as we have at least 
one handle on it. 

We do file descriptor passing from consumerd to sessiond to 
the application over unix sockets. 

The reason why we unlink the file shortly after creation by consumerd 
is to make sure we teardown all resources cleanly even in case the 
consumerd would be killed by a SIGKILL. 

Thanks, 

Mathieu 

----- On Sep 28, 2016, at 7:38 PM, Jeffrey Chen <cpthk@live.com> wrote: 

> It looks like the code that called shm_open() is called at the lttng-consumerd
> daemon. But, somehow it show up in the pmap at my service process. I noticed
> all my processes that loads liblttng-ust would have this entry. Do you know
> what's the reason?

> From: lttng-dev <lttng-dev-bounces@lists.lttng.org> on behalf of Jeffrey Chen
> <cpthk@live.com>
> Sent: Tuesday, September 27, 2016 11:20 AM
> To: lttng-dev
> Subject: [lttng-dev] LTTng memory map

> Hi LTTng:

> Our service has been running overnight with LTTng enabled to do some memory
> consumption testing. We noticed the linux pmap output would have several memory
> map used by LTTng, and are marked as deleted. Do you know what are them? Why
> are they left in the system and marked as deleted? Thanks.

> 00007fc3017ee000 40968 592 592 rw-s- ust-shm-consumer-58905 (deleted)

> 00007fc3017ee000 0 0 0 rw-s- ust-shm-consumer-58905 (deleted)

> 00007fc303ff0000 40968 0 0 rw-s- ust-shm-consumer-58905 (deleted)

> 00007fc303ff0000 0 0 0 rw-s- ust-shm-consumer-58905 (deleted)

> 00007fc3067f2000 40968 0 0 rw-s- ust-shm-consumer-58905 (deleted)

> 00007fc3067f2000 0 0 0 rw-s- ust-shm-consumer-58905 (deleted)

> 00007fc308ff4000 40968 0 0 rw-s- ust-shm-consumer-58905 (deleted)

> 00007fc308ff4000 0 0 0 rw-s- ust-shm-consumer-58905 (deleted)

> 00007fc30b7f6000 40968 0 0 rw-s- ust-shm-consumer-58905 (deleted)

> 00007fc30b7f6000 0 0 0 rw-s- ust-shm-consumer-58905 (deleted)

> 00007fc30dff8000 40968 524 524 rw-s- ust-shm-consumer-58905 (deleted)

> 00007fc30dff8000 0 0 0 rw-s- ust-shm-consumer-58905 (deleted)

> 00007fc3107fa000 40968 0 0 rw-s- ust-shm-consumer-58905 (deleted)

> 00007fc3107fa000 0 0 0 rw-s- ust-shm-consumer-58905 (deleted)

> 00007fc312ffc000 40968 244 244 rw-s- ust-shm-consumer-58905 (deleted)

> 00007fc312ffc000 0 0 0 rw-s- ust-shm-consumer-58905 (deleted)

> 00007fc3157fe000 40968 396 396 rw-s- ust-shm-consumer-58905 (deleted)

> 00007fc3157fe000 0 0 0 rw-s- ust-shm-consumer-58905 (deleted)

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_62bb428b-fd82-4d43-8e53-11109b07ddc9
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><style style=3D"display:none;"><!-- P {marg=
in-top:0;margin-bottom:0;} --></style></div><div>Yes, we open and then unli=
nk the file in the shm within consumerd.<br></div><div>Its inode stays rese=
rved on the disk as long as we have at least<br data-mce-bogus=3D"1"></div>=
<div>one handle on it.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogu=
s=3D"1"></div><div>We do file descriptor passing from consumerd to sessiond=
 to<br data-mce-bogus=3D"1"></div><div>the application over unix sockets.<b=
r data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>The r=
eason why we unlink the file shortly after creation by consumerd<br data-mc=
e-bogus=3D"1"></div><div>is to make sure we teardown all resources cleanly =
even in case the<br data-mce-bogus=3D"1"></div><div>consumerd would be kill=
ed by a SIGKILL.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1=
"></div><div>Thanks,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=
=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br></div><div=
><span id=3D"zwchr" data-marker=3D"__DIVIDER__">----- On Sep 28, 2016, at 7=
:38 PM, Jeffrey Chen &lt;cpthk@live.com&gt; wrote:<br></span></div><div dat=
a-marker=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #10=
10FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-st=
yle:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font=
-size:12pt;">


<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Arial,Helvetica,sans-serif;">
<p>It looks like the code that called shm_open() is called at the lttng-con=
sumerd daemon. But, somehow it show up in the pmap at my service process. I=
 noticed all my processes that loads liblttng-ust would have this entry. Do=
 you know what's the reason?<br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><span style=3D"font-size: 11pt; color=
: #000000; font-family: Calibri,sans-serif;" data-mce-style=3D"font-size: 1=
1pt; color: #000000; font-family: Calibri,sans-serif;" color=3D"#000000" fa=
ce=3D"Calibri, sans-serif"><b>From:</b> lttng-dev &lt;lttng-dev-bounces@lis=
ts.lttng.org&gt; on behalf of Jeffrey Chen &lt;cpthk@live.com&gt;<br>
<b>Sent:</b> Tuesday, September 27, 2016 11:20 AM<br>
<b>To:</b> lttng-dev<br>
<b>Subject:</b> [lttng-dev] LTTng memory map</span>
<div>&nbsp;</div>
</div>
<div>
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt; color:#000000; fo=
nt-family:Calibri,Arial,Helvetica,sans-serif">
<p>Hi LTTng:</p>
<p><br>
</p>
<p>Our service has been running overnight with LTTng enabled to do some mem=
ory consumption testing. We noticed the linux pmap output would have severa=
l memory map used by LTTng, and are marked as deleted. Do you know what are=
 them? Why are they left in the
 system and marked as deleted? Thanks.<br>
</p>
<p><br>
</p>
<p><br>
</p>
<p></p>
<div>
<p class=3D"MsoNormal">00007fc3017ee000&nbsp;&nbsp; 40968&nbsp;&nbsp;&nbsp;=
&nbsp; 592&nbsp;&nbsp;&nbsp;&nbsp; 592 rw-s- ust-shm-consumer-58905 (delete=
d)</p>
<p class=3D"MsoNormal">00007fc3017ee000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 0 rw-s- ust-shm-consumer-58905 (deleted)</p>
<p class=3D"MsoNormal">00007fc303ff0000&nbsp;&nbsp; 40968&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 rw-s- ust-shm-co=
nsumer-58905 (deleted)</p>
<p class=3D"MsoNormal">00007fc303ff0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 0 rw-s- ust-shm-consumer-58905 (deleted)</p>
<p class=3D"MsoNormal">00007fc3067f2000&nbsp;&nbsp; 40968&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 rw-s- ust-shm-co=
nsumer-58905 (deleted)</p>
<p class=3D"MsoNormal">00007fc3067f2000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 0 rw-s- ust-shm-consumer-58905 (deleted)</p>
<p class=3D"MsoNormal">00007fc308ff4000&nbsp;&nbsp; 40968&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 rw-s- ust-shm-co=
nsumer-58905 (deleted)</p>
<p class=3D"MsoNormal">00007fc308ff4000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 0 rw-s- ust-shm-consumer-58905 (deleted)</p>
<p class=3D"MsoNormal">00007fc30b7f6000&nbsp;&nbsp; 40968&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 rw-s- ust-shm-co=
nsumer-58905 (deleted)</p>
<p class=3D"MsoNormal">00007fc30b7f6000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 0 rw-s- ust-shm-consumer-58905 (deleted)</p>
<p class=3D"MsoNormal">00007fc30dff8000&nbsp;&nbsp; 40968&nbsp;&nbsp;&nbsp;=
&nbsp; 524&nbsp;&nbsp;&nbsp;&nbsp; 524 rw-s- ust-shm-consumer-58905 (delete=
d)</p>
<p class=3D"MsoNormal">00007fc30dff8000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 0 rw-s- ust-shm-consumer-58905 (deleted)</p>
<p class=3D"MsoNormal">00007fc3107fa000&nbsp;&nbsp; 40968&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 rw-s- ust-shm-co=
nsumer-58905 (deleted)</p>
<p class=3D"MsoNormal">00007fc3107fa000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 0 rw-s- ust-shm-consumer-58905 (deleted)</p>
<p class=3D"MsoNormal">00007fc312ffc000&nbsp;&nbsp; 40968&nbsp;&nbsp;&nbsp;=
&nbsp; 244&nbsp;&nbsp;&nbsp;&nbsp; 244 rw-s- ust-shm-consumer-58905 (delete=
d)</p>
<p class=3D"MsoNormal">00007fc312ffc000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 0 rw-s- ust-shm-consumer-58905 (deleted)</p>
<p class=3D"MsoNormal">00007fc3157fe000&nbsp;&nbsp; 40968&nbsp;&nbsp;&nbsp;=
&nbsp; 396&nbsp;&nbsp;&nbsp;&nbsp; 396 rw-s- ust-shm-consumer-58905 (delete=
d)</p>
<p class=3D"MsoNormal">00007fc3157fe000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 0 rw-s- ust-shm-consumer-58905 (deleted)</p>
</div>
<br>
<p></p>
</div>
</div>
</div>
</div>


<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/=
listinfo/lttng-dev<br></blockquote></div><div><br></div><div data-marker=3D=
"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http=
://www.efficios.com</div></div></body></html>
--=_62bb428b-fd82-4d43-8e53-11109b07ddc9--

--===============3959218081127091956==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============3959218081127091956==--
