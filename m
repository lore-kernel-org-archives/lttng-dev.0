From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Crash on first run of target using
 liblttng-ust-cyg-profile.so, but subsequent runs succeed
Date: Wed, 2 Mar 2016 10:36:21 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1603021031190.3638__19944.4563863382$1456911516$gmane$org@nanos>
References: <CAL90rL8u1_3ifDL2QzrqrQMp3+68PhOsMfgdsYhceoLX__MAJw@mail.gmail.com>
 <1762935886.18108.1455296549954.JavaMail.zimbra@efficios.com>
 <609823872.18327.1455308463772.JavaMail.zimbra@efficios.com>
 <98246560.18416.1455310030702.JavaMail.zimbra@efficios.com>
 <loom.20160301T172035-353@post.gmane.org>
 <1933334349.12963.1456854319891.JavaMail.zimbra@efficios.com>
 <CY1PR0301MB07635CCFD4971647764B76F18DBB0@CY1PR0301MB0763.namprd03.prod.outlook.com>
 <735015272.14286.1456881983409.JavaMail.zimbra@efficios.com>
 <2125231072.14430.1456911118257.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from www.linutronix.de ([62.245.132.108] helo=Galois.linutronix.de)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <tglx@linutronix.de>) id 1ab3Dz-0000f2-2k
 for lttng-dev@lists.lttng.org; Wed, 02 Mar 2016 04:37:44 -0500
In-Reply-To: <2125231072.14430.1456911118257.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Michael Simons <Michael.Simons@microsoft.com>
List-Id: lttng-dev@lists.lttng.org

Mathieu,

On Wed, 2 Mar 2016, Mathieu Desnoyers wrote:
> > The difference here is that with a positive LTTNG_UST_REGISTER_TIMEOUT
> > value, we use sem_timedwait(), which behaves differently than
> > sem_wait() with respect to restarting when hit by a signal:
> > it uses sys_restart_syscall() (which is used when ERESTART_RESTARTBLOCK
> > is received).
> > 
> > Unfortunately, docker decided to blacklist this core system call:
> > https://github.com/docker/docker/blob/master/docs/security/seccomp.md
> > 
> > restart_syscall 	Don't allow containers to restart a syscall. Possible seccomp
> > bypass see: https://code.google.com/p/chromium/issues/detail?id=408827.
> > 
> > Someone should ask them why they really have to blacklist this, since it
> > will lead to various races with respect to signal handling in tons
> > of applications. It looks like the wrong fix for a security concern.

Well, it's not a fix. It's just silly. The chromium bug is closed as:

      Closing as WontFix -- no PoC, looks to be unreachable.

Find below my analysis from back then when google reported that. This resulted
in the commit 849151dd5481b "compat: nanosleep: Clarify error handling" in
mainline.

So nothing to see here than securuty folks being silly.

Thanks,

	tglx

8<----------------------

> > You're looking at the non-compat case.
> > COMPAT_SYSCALL_DEFINE2(nanosleep,... in kernel/compat.c only sets up
> > fn and .compat_rmtp.
> 
> Well, it actually sets all fields for the real restart case - because
> it calls (and depends on) hrtimer_nanosleep() doing the rest.
> 
> The problem is that hrtimer_nanosleep() doesn't actually set any of
> the restart block stuff for the non-restart cases.

Indeed, but it's subtly correct nevertheless for the compat nanosleep
case.

COMPAT_SYSCALL_DEFINE2(nanosleep, struct compat_timespec __user *, rqtp,
		       struct compat_timespec __user *, rmtp)
{
	struct timespec tu, rmt;
	long ret;

	if (compat_get_timespec(&tu, rqtp))
		return -EFAULT;

	ret = hrtimer_nanosleep(&tu,
				rmtp ? (struct timespec __user *)&rmt : NULL,
				HRTIMER_MODE_REL, CLOCK_MONOTONIC);

Here is the important stuff:

     hrtimer_nanosleep() is called with two variables on the kernel
     stack of the calling task: tu and rmt.

     And what's further important it's called with HRTIMER_MODE_REL.

And hrtimer_nanosleep() does:

	if (do_nanosleep())
	   return 0;

The timer expired, nothing to worry about.

	if (mode == HRTIMER_MODE_ABS) 
	   return -ERESTARTNOHAND;
  
Irrelevant for the compat case, due to mode = HRTIMER_MODE_REL. This
return code CANNOT happen if called from compat_sys_nanosleep(). If it
happens, we really don't have to worry about the rest anymore.
 	   
	if (rmtp && update_rmtp())
	   return -EFAULT;

If that update fails, then we have a way bigger problem than the half
filled in restart block because "rmtp" is on the kernel stack of the
calling task.

	fill_restart_block_completely();

	return -ERESTART_RESTARTBLOCK;

So we either return 0 or -ERESTART_RESTARTBLOCK with a completely
filled in restart block. So the below is correct:

	if (ret) {
		struct restart_block *restart
			= &current_thread_info()->restart_block;

		restart->fn = compat_nanosleep_restart;
		restart->nanosleep.compat_rmtp = rmtp;

		if (rmtp && compat_put_timespec(&rmt, rmtp))
			return -EFAULT;
	}

I admit, it's not really obvious, so a cosmetic documentary change is
definitely due.

Thanks,

	Thomas
	
