From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: SIG33
Date: Tue, 16 Apr 2019 13:37:16 -0400 (EDT)
Message-ID: <483683232.2036.1555436236748.JavaMail.zimbra__22350.2804221184$1555436260$gmane$org@efficios.com>
References: <CAHryLm7o6X3pvu+=7m2b6TMFUMXNYhJOW8cid5v-FFTD948oHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3326676507235264463=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44kCHS1Sgzz1Kb4
 for <lttng-dev@lists.lttng.org>; Tue, 16 Apr 2019 13:37:23 -0400 (EDT)
In-Reply-To: <CAHryLm7o6X3pvu+=7m2b6TMFUMXNYhJOW8cid5v-FFTD948oHA@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Joe Sutker <jomasu22@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============3326676507235264463==
Content-Type: multipart/alternative;
	boundary="=_aa65ff9e-abed-45e8-b5a2-67518921489d"

--=_aa65ff9e-abed-45e8-b5a2-67518921489d
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Apr 16, 2019, at 11:26 AM, Joe Sutker <jomasu22@gmail.com> wrote: 

> Hello LTTng Devs,
> I am working on a project that uses LTTng, and it seems that LTTng is throwing a
> SIG33 signal (Real-time event 33), which Eclipse does not seem to appreciate.
> Would you be able to direct me to the place in lttng-tools that this signal is
> thrown?

Hi, 

Based on the signal(7) man page, it appears that real-time signal 33 is used by the NPTL 
threading library from glibc. 

Indeed, lttng-ust creates 2 threads within the processes it's linked into, so 
your application needs to appropriately interact with glibc NPTL in order to link 
lttng-ust into it. 

Can you provide more details on the nature of your application ? When you 
say "which Eclipse does not seem to appreciate", what role is Eclipse having 
in this scenario ? It is simply used to launch your application under a debugger 
(e.g. gdb) ? If so, what debugger version is it, and on which architecture ? 

Thanks, 

Mathieu 

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_aa65ff9e-abed-45e8-b5a2-67518921489d
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br data-mce-bogus=3D"1"></div><div><span i=
d=3D"zwchr" data-marker=3D"__DIVIDER__">----- On Apr 16, 2019, at 11:26 AM,=
 Joe Sutker &lt;jomasu22@gmail.com&gt; wrote:<br></span></div><div data-mar=
ker=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF;=
margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:n=
ormal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size=
:12pt;"><div dir=3D"ltr">Hello LTTng Devs,<br><div>I am working on a projec=
t that uses LTTng, and it seems that LTTng is throwing a SIG33 signal (Real=
-time event 33), which Eclipse does not seem to appreciate. Would you be ab=
le to direct me to the place in lttng-tools that this signal is thrown?</di=
v></div></blockquote><div><div>Hi,</div><div><br></div><div>Based on the si=
gnal(7) man page, it appears that real-time signal 33 is used by the NPTL</=
div><div>threading library from glibc.</div><div><br></div><div>Indeed, ltt=
ng-ust creates 2 threads within the processes it's linked into, so</div><di=
v>your application needs to appropriately interact with glibc NPTL in order=
 to link</div><div>lttng-ust into it.</div><div><br></div><div>Can you prov=
ide more details on the nature of your application ? When you<br></div><div=
>say "which Eclipse does not seem to appreciate", what role is Eclipse havi=
ng<br data-mce-bogus=3D"1"></div><div>in this scenario ? It is simply used =
to launch your application under a debugger<br data-mce-bogus=3D"1"></div><=
div>(e.g. gdb) ? If so, what debugger version is it, and on which architect=
ure ?</div><div><br></div><div>Thanks,</div><div><br></div><div>Mathieu</di=
v></div></div><div><br data-mce-bogus=3D"1"></div><div data-marker=3D"__SIG=
_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www=
.efficios.com</div></div></body></html>
--=_aa65ff9e-abed-45e8-b5a2-67518921489d--

--===============3326676507235264463==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3326676507235264463==--
