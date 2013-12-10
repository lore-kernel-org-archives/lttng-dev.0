From: Shariyar <syed.shariyar@gmail.com>
Subject: Re: What are sys calls starting with compat?
Date: Tue, 10 Dec 2013 11:39:40 -0800
Message-ID: <CAKQh6pg_TxhCSB4=Q2ku6uEs=c_Tx=t3vDGKb0sV-ER4dMonhA__38907.6463565745$1386704740$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1923645945=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <syed.shariyar@gmail.com>) id 1VqT9m-0008Gy-SE
	for lttng-dev@lists.lttng.org; Tue, 10 Dec 2013 14:39:52 -0500
Received: by mail-pb0-f46.google.com with SMTP id md12so8363183pbc.33
	for <lttng-dev@lists.lttng.org>; Tue, 10 Dec 2013 11:39:40 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1923645945==
Content-Type: multipart/alternative; boundary=047d7b5dbaac0240e504ed33464d

--047d7b5dbaac0240e504ed33464d
Content-Type: text/plain; charset=ISO-8859-1

What does sys_unknown mean and why doe it occur? Does it mean that LTTng
can not find the name of system call?

Regards,
Shariyar
------------------------------

Message: 2
Date: Tue, 10 Dec 2013 15:31:19 +0000 (UTC)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Daniel Thibault <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] What are sys calls starting with compat?
Message-ID:
        <1571110803.82672.1386689479225.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8

----- Original Message -----
> From: "Daniel Thibault" <Daniel.Thibault@drdc-rddc.gc.ca>
> To: lttng-dev@lists.lttng.org
> Cc: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Sent: Tuesday, December 10, 2013 9:57:21 AM
> Subject: Re: [lttng-dev] What are sys calls starting with compat?
>
> > Date: Tue, 10 Dec 2013 01:55:48 +0000 (UTC)
> >
> > System calls with "compat" prefix are for e.g. 32-bit processes running
on
> > a 64-bit kernel:
> > those processes are using a different system call table (ia32 for Intel)
> > than 64-bit processes,
> > and therefore those system calls are named "compat_*" by LTTng.
> >
> > Mathieu
>
>    I presume the LTTng event names will also be prefixed with "compat_".

Yes.

>  For
>    instance, "compat_sys_rmdir".

Yes.

>  Or would it be "sys_compat_rmdir"?

No.

>  And
>    what of the exit_syscall and sys_unknown events?

exit_syscall has no compat prefix as I recall.

compat_sys_unknown.

Thanks,

Mathieu

--047d7b5dbaac0240e504ed33464d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>What does sys_unknown mean and why doe it occur? Does=
 it mean that LTTng can not find the name of system call?<br><br></div>Rega=
rds,<br><div><div>Shariyar<br></div><div>------------------------------<br>

<br>
Message: 2<br>
Date: <span tabindex=3D"0" class=3D""><span class=3D"">Tue, 10 Dec 2013 15:=
31:19 +0000</span></span> (UTC)<br>
From: Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.co=
m">mathieu.desnoyers@efficios.com</a>&gt;<br>
To: Daniel Thibault &lt;<a href=3D"mailto:Daniel.Thibault@drdc-rddc.gc.ca">=
Daniel.Thibault@drdc-rddc.gc.ca</a>&gt;<br>
Cc: <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org<=
/a><br>
Subject: Re: [lttng-dev] What are sys calls starting with compat?<br>
Message-ID:<br>
=A0 =A0 =A0 =A0 &lt;<a href=3D"mailto:1571110803.82672.1386689479225.JavaMa=
il.zimbra@efficios.com">1571110803.82672.1386689479225.JavaMail.zimbra@effi=
cios.com</a>&gt;<br>
Content-Type: text/plain; charset=3Dutf-8<br>
<br>
----- Original Message -----<br>
&gt; From: &quot;Daniel Thibault&quot; &lt;<a href=3D"mailto:Daniel.Thibaul=
t@drdc-rddc.gc.ca">Daniel.Thibault@drdc-rddc.gc.ca</a>&gt;<br>
&gt; To: <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng=
.org</a><br>
&gt; Cc: &quot;Mathieu Desnoyers&quot; &lt;<a href=3D"mailto:mathieu.desnoy=
ers@efficios.com">mathieu.desnoyers@efficios.com</a>&gt;<br>
&gt; Sent: Tuesday, December 10, 2013 9:57:21 AM<br>
&gt; Subject: Re: [lttng-dev] What are sys calls starting with compat?<br>
&gt;<br>
&gt; &gt; Date: <span tabindex=3D"0" class=3D""><span class=3D"">Tue, 10 De=
c 2013 01:55:48 +0000</span></span> (UTC)<br>
&gt; &gt;<br>
&gt; &gt; System calls with &quot;compat&quot; prefix are for e.g. 32-bit p=
rocesses running on<br>
&gt; &gt; a 64-bit kernel:<br>
&gt; &gt; those processes are using a different system call table (ia32 for=
 Intel)<br>
&gt; &gt; than 64-bit processes,<br>
&gt; &gt; and therefore those system calls are named &quot;compat_*&quot; b=
y LTTng.<br>
&gt; &gt;<br>
&gt; &gt; Mathieu<br>
&gt;<br>
&gt; =A0 =A0I presume the LTTng event names will also be prefixed with &quo=
t;compat_&quot;.<br>
<br>
Yes.<br>
<br>
&gt; =A0For<br>
&gt; =A0 =A0instance, &quot;compat_sys_rmdir&quot;.<br>
<br>
Yes.<br>
<br>
&gt; =A0Or would it be &quot;sys_compat_rmdir&quot;?<br>
<br>
No.<br>
<br>
&gt; =A0And<br>
&gt; =A0 =A0what of the exit_syscall and sys_unknown events?<br>
<br>
exit_syscall has no compat prefix as I recall.<br>
<br>
compat_sys_unknown.<br>
<br>
Thanks,<br>
<br>
Mathieu</div></div></div>

--047d7b5dbaac0240e504ed33464d--


--===============1923645945==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1923645945==--
