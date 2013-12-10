From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: What are sys calls starting with compat?
Date: Tue, 10 Dec 2013 15:31:19 +0000 (UTC)
Message-ID: <1571110803.82672.1386689479225.JavaMail.zimbra__6198.222624562$1386689531$gmane$org@efficios.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD267B340B@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VqPHN-0006Kb-VT
	for lttng-dev@lists.lttng.org; Tue, 10 Dec 2013 10:31:26 -0500
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD267B340B@VAL-E-02.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Daniel Thibault <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Daniel Thibault" <Daniel.Thibault@drdc-rddc.gc.ca>
> To: lttng-dev@lists.lttng.org
> Cc: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Sent: Tuesday, December 10, 2013 9:57:21 AM
> Subject: Re: [lttng-dev] What are sys calls starting with compat?
> 
> > Date: Tue, 10 Dec 2013 01:55:48 +0000 (UTC)
> >
> > System calls with "compat" prefix are for e.g. 32-bit processes running on
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



-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
