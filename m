From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: What are sys calls starting with compat?
Date: Tue, 10 Dec 2013 21:10:37 +0000 (UTC)
Message-ID: <929801575.83300.1386709837137.JavaMail.zimbra__37047.2555434846$1386709897$gmane$org@efficios.com>
References: <CAKQh6pg_TxhCSB4=Q2ku6uEs=c_Tx=t3vDGKb0sV-ER4dMonhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0880202535=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VqUZh-0000YV-Bl
	for lttng-dev@lists.lttng.org; Tue, 10 Dec 2013 16:10:44 -0500
In-Reply-To: <CAKQh6pg_TxhCSB4=Q2ku6uEs=c_Tx=t3vDGKb0sV-ER4dMonhA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Shariyar <syed.shariyar@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0880202535==
Content-Type: multipart/alternative;
	boundary="----=_Part_83299_1328768504.1386709837136"

------=_Part_83299_1328768504.1386709837136
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- Original Message -----

> From: "Shariyar" <syed.shariyar@gmail.com>
> To: lttng-dev@lists.lttng.org
> Sent: Tuesday, December 10, 2013 2:39:40 PM
> Subject: Re: [lttng-dev] What are sys calls starting with compat?

> What does sys_unknown mean and why doe it occur? Does it mean that LTTng can
> not find the name of system call?

Yes. It means the ID of the system call is unknown to LTTng (e.g. kernel newer than LTTng system call instrumentation). 

Thanks, 

Mathieu 

> Regards,
> Shariyar
> ------------------------------

> Message: 2
> Date: Tue, 10 Dec 2013 15:31:19 +0000 (UTC)
> From: Mathieu Desnoyers < mathieu.desnoyers@efficios.com >
> To: Daniel Thibault < Daniel.Thibault@drdc-rddc.gc.ca >
> Cc: lttng-dev@lists.lttng.org
> Subject: Re: [lttng-dev] What are sys calls starting with compat?
> Message-ID:
> < 1571110803.82672.1386689479225.JavaMail.zimbra@efficios.com >
> Content-Type: text/plain; charset=utf-8

> ----- Original Message -----
> > From: "Daniel Thibault" < Daniel.Thibault@drdc-rddc.gc.ca >
> > To: lttng-dev@lists.lttng.org
> > Cc: "Mathieu Desnoyers" < mathieu.desnoyers@efficios.com >
> > Sent: Tuesday, December 10, 2013 9:57:21 AM
> > Subject: Re: [lttng-dev] What are sys calls starting with compat?
> >
> > > Date: Tue, 10 Dec 2013 01:55:48 +0000 (UTC)
> > >
> > > System calls with "compat" prefix are for e.g. 32-bit processes running
> > > on
> > > a 64-bit kernel:
> > > those processes are using a different system call table (ia32 for Intel)
> > > than 64-bit processes,
> > > and therefore those system calls are named "compat_*" by LTTng.
> > >
> > > Mathieu
> >
> > I presume the LTTng event names will also be prefixed with "compat_".

> Yes.

> > For
> > instance, "compat_sys_rmdir".

> Yes.

> > Or would it be "sys_compat_rmdir"?

> No.

> > And
> > what of the exit_syscall and sys_unknown events?

> exit_syscall has no compat prefix as I recall.

> compat_sys_unknown.

> Thanks,

> Mathieu

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_83299_1328768504.1386709837136
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><hr id=3D"zwchr"><blockquote style=3D=
"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;=
font-weight:normal;font-style:normal;text-decoration:none;font-family:Helve=
tica,Arial,sans-serif;font-size:12pt;"><b>From: </b>"Shariyar" &lt;syed.sha=
riyar@gmail.com&gt;<br><b>To: </b>lttng-dev@lists.lttng.org<br><b>Sent: </b=
>Tuesday, December 10, 2013 2:39:40 PM<br><b>Subject: </b>Re: [lttng-dev] W=
hat are sys calls starting with compat?<br><div><br></div><div dir=3D"ltr">=
<div>What does sys_unknown mean and why doe it occur? Does it mean that LTT=
ng can not find the name of system call?</div></div></blockquote><div><br><=
/div><div>Yes. It means the ID of the system call is unknown to LTTng (e.g.=
 kernel newer than LTTng system call instrumentation).<br></div><div><br></=
div><div>Thanks,<br></div><div><br></div><div>Mathieu<br></div><div><br></d=
iv><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;paddi=
ng-left:5px;color:#000;font-weight:normal;font-style:normal;text-decoration=
:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"l=
tr"><div><div><br></div></div>Regards,<br><div><div>Shariyar<br></div><div>=
------------------------------<br><br>
Message: 2<br>
Date: <span class=3D""><span class=3D"">Tue, 10 Dec 2013 15:31:19 +0000</sp=
an></span> (UTC)<br>
From: Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.co=
m" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;<br>
To: Daniel Thibault &lt;<a href=3D"mailto:Daniel.Thibault@drdc-rddc.gc.ca" =
target=3D"_blank">Daniel.Thibault@drdc-rddc.gc.ca</a>&gt;<br>
Cc: <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-de=
v@lists.lttng.org</a><br>
Subject: Re: [lttng-dev] What are sys calls starting with compat?<br>
Message-ID:<br>
&nbsp; &nbsp; &nbsp; &nbsp; &lt;<a href=3D"mailto:1571110803.82672.13866894=
79225.JavaMail.zimbra@efficios.com" target=3D"_blank">1571110803.82672.1386=
689479225.JavaMail.zimbra@efficios.com</a>&gt;<br>
Content-Type: text/plain; charset=3Dutf-8<br><br>
----- Original Message -----<br>
&gt; From: "Daniel Thibault" &lt;<a href=3D"mailto:Daniel.Thibault@drdc-rdd=
c.gc.ca" target=3D"_blank">Daniel.Thibault@drdc-rddc.gc.ca</a>&gt;<br>
&gt; To: <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">ltt=
ng-dev@lists.lttng.org</a><br>
&gt; Cc: "Mathieu Desnoyers" &lt;<a href=3D"mailto:mathieu.desnoyers@effici=
os.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;<br>
&gt; Sent: Tuesday, December 10, 2013 9:57:21 AM<br>
&gt; Subject: Re: [lttng-dev] What are sys calls starting with compat?<br>
&gt;<br>
&gt; &gt; Date: <span class=3D""><span class=3D"">Tue, 10 Dec 2013 01:55:48=
 +0000</span></span> (UTC)<br>
&gt; &gt;<br>
&gt; &gt; System calls with "compat" prefix are for e.g. 32-bit processes r=
unning on<br>
&gt; &gt; a 64-bit kernel:<br>
&gt; &gt; those processes are using a different system call table (ia32 for=
 Intel)<br>
&gt; &gt; than 64-bit processes,<br>
&gt; &gt; and therefore those system calls are named "compat_*" by LTTng.<b=
r>
&gt; &gt;<br>
&gt; &gt; Mathieu<br>
&gt;<br>
&gt; &nbsp; &nbsp;I presume the LTTng event names will also be prefixed wit=
h "compat_".<br><br>
Yes.<br><br>
&gt; &nbsp;For<br>
&gt; &nbsp; &nbsp;instance, "compat_sys_rmdir".<br><br>
Yes.<br><br>
&gt; &nbsp;Or would it be "sys_compat_rmdir"?<br><br>
No.<br><br>
&gt; &nbsp;And<br>
&gt; &nbsp; &nbsp;what of the exit_syscall and sys_unknown events?<br><br>
exit_syscall has no compat prefix as I recall.<br><br>
compat_sys_unknown.<br><br>
Thanks,<br><br>
Mathieu</div></div></div><br>______________________________________________=
_<br>lttng-dev mailing list<br>lttng-dev@lists.lttng.org<br>http://lists.lt=
tng.org/cgi-bin/mailman/listinfo/lttng-dev<br></blockquote><div><br><br></d=
iv><div><br></div><div>-- <br></div><div><span name=3D"x"></span>Mathieu De=
snoyers<br>EfficiOS Inc.<br>http://www.efficios.com<span name=3D"x"></span>=
<br></div></div></body></html>
------=_Part_83299_1328768504.1386709837136--


--===============0880202535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0880202535==--
