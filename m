From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: Lttng filename
Date: Fri, 28 Jun 2013 20:00:38 -0400
Message-ID: <51CE23A6.5090900__37967.5555312589$1372464083$gmane$org@voxpopuli.im>
References: <CAOK8cx8jyCTzjZJ2mTmkye80kgxymtd+1vo-O1Y+WnyQR7yHHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.182])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <alexmonthy@voxpopuli.im>) id 1Usiaq-0001Ev-Ls
	for lttng-dev@lists.lttng.org; Fri, 28 Jun 2013 20:00:44 -0400
In-Reply-To: <CAOK8cx8jyCTzjZJ2mTmkye80kgxymtd+1vo-O1Y+WnyQR7yHHQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alex Mesa <mesalejo@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 13-06-28 10:13 AM, Alex Mesa wrote:
> Good Morning,
>
> I would like to know if it is possible to include filename as an added
> event or if there any way to output the filename (path) to the
> following system calls:
> sys_open, sys_write, sched_process_fork, and read.
> Thank you.

Hi,

"sys_open" should already have a "filename" field of type string,
doesn't it?

"sched_process_fork" does not specify a filename. When a process forks,
the newly created process will still have the same executable name as
its parent. In most cases, it will call exec() soon after. "sys_execve"
should have a filename field too.


As for sys_write and sys_read, those are a bit more complicated, since
they do not provide the file name directly.
When you see a sys_open, the following exit_syscall will carry the
return value of the call to open(), which is the file descriptor number
that was assigned to this particular file for this process. sys_read and
sys_write have a "fd" field, which indicates that file descriptor. So
you need to backtrack to the closest earlier sys_open to match the fd to
the file name.

In trace viewers, we use a state system to track this kind of
information, so that it is possible to know, at the timestamp of a
sys_read for example, which file is set to which fd, without having to
backtrack potentially up to the start of the trace. For reference, you
can look at the user guide for the Eclipse plugin viewer:
http://wiki.eclipse.org/Linux_Tools_Project/TMF/User_Guide#Generic_State_System


Cheers,
Alexandre

>
>
> Best regards,
> -AM
>
> Confidentiality Note: This message is intended only for the person or
> entity to which it is addressed. It may contain confidential and/or
> privileged material. Any review, transmission, dissemination or other
> use, or taking of any action in reliance upon this message by persons
> or entities other than the intended recipient is prohibited and may be
> unlawful. If you received this message in error, please contact the
> sender and delete it from your computer.
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
