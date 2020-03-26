From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: LTTng user-space callstacks
Date: Thu, 26 Mar 2020 15:41:17 -0400 (EDT)
Message-ID: <2022773652.13655.1585251677207.JavaMail.zimbra@efficios.com>
References: <CABhb4uuE2QD8Asejaa+mjLPEVQAZrCxU6pwLp=QFqb2N3vD9nw@mail.gmail.com>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6507115471348991421=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 48pFjH3HP9z1Thj
 for <lttng-dev@lists.lttng.org>; Thu, 26 Mar 2020 15:41:23 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 96A89279883
 for <lttng-dev@lists.lttng.org>; Thu, 26 Mar 2020 15:41:17 -0400 (EDT)
In-Reply-To: <CABhb4uuE2QD8Asejaa+mjLPEVQAZrCxU6pwLp=QFqb2N3vD9nw@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Valentin Grigorev <valentin.grigorev@jetbrains.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============6507115471348991421==
Content-Type: multipart/alternative;
	boundary="=_54626138-d6e6-456d-93fb-d5645f41ae4d"

--=_54626138-d6e6-456d-93fb-d5645f41ae4d
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Mar 26, 2020, at 1:39 PM, lttng-dev <lttng-dev@lists.lttng.org> wrote: 

> Hello!

> Currently, callstack collection in LTTng is only available for kernel-space
> events with context fields callstack-kernel and callstack-user .

> Is it expected that callstack collection for LTTng-UST will be added too? And if
> it is expected, then how soon?

Hi Valentin, 

It is something that would be interesting and useful, but a lot of work would 
be needed to have stack-walking this is fast enough and reentrant wrt signal 
handlers. Unfortunately, the backtrace(3) functions do not meet those 
requirements. 

Also, for gathering user-space callstacks from the kernel tracer, it only works if 
all user-space is compiled with frame pointers. This is also a limitation that would 
require a lot of work to overcome neatly. 

None of those features are currently on any roadmap due to lack of customers 
showing interest in getting this done. 

Thanks, 

Mathieu 

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_54626138-d6e6-456d-93fb-d5645f41ae4d
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Mar 26, 2020, at 1:39 PM, lttng-dev &lt;lttng-dev@lists.lttng.=
org&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><blockq=
uote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5p=
x;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font=
-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div d=
ir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div>Hello!</div><br><div>Curr=
ently, callstack collection  in LTTng&nbsp;is only available for kernel-spa=
ce events with context fields&nbsp;<i>callstack-kernel&nbsp;</i>and <i>call=
stack-user</i>.</div><br><div>Is it expected that callstack&nbsp;collection=
 for LTTng-UST will be added too? And if it is expected, then how soon?</di=
v></div></div></div></div></blockquote><div><br></div><div><div>Hi Valentin=
,<br></div><div><br></div><div>It is something that would be interesting an=
d useful, but a lot of work would</div><div>be needed to have stack-walking=
 this is fast enough and reentrant wrt signal</div><div>handlers. Unfortuna=
tely, the backtrace(3) functions do not meet those</div><div>requirements.<=
/div><div><br></div><div>Also, for gathering user-space callstacks from the=
 kernel tracer, it only works if</div><div>all user-space is compiled with =
frame pointers. This is also a limitation that would</div><div>require a lo=
t of work to overcome neatly.</div><div><br></div><div>None of those featur=
es are currently on any roadmap due to lack of customers</div><div>showing =
interest in getting this done.</div><div><br></div><div>Thanks,</div><div><=
br></div><div>Mathieu</div></div></div><div><br data-mce-bogus=3D"1"></div>=
<div data-marker=3D"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>Ef=
ficiOS Inc.<br>http://www.efficios.com</div></div></body></html>
--=_54626138-d6e6-456d-93fb-d5645f41ae4d--

--===============6507115471348991421==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6507115471348991421==--
