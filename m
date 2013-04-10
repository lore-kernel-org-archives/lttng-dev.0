From: Jan Glauber <jan.glauber@gmail.com>
Subject: Re: LTTng system call tracing on ARM
Date: Wed, 10 Apr 2013 15:02:47 +0200
Message-ID: <20130410130246.GA12801__6932.864271994$1365599004$gmane$org@hal>
References: <20130410084053.GB25958@hal>
	<CA+umk=pX-4t74XQqsP+vLsDGF1atWzUi75gmSyoVGsDkqQcB7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-bk0-f50.google.com ([209.85.214.50])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jan.glauber@gmail.com>) id 1UPufx-00046f-Ar
	for lttng-dev@lists.lttng.org; Wed, 10 Apr 2013 09:02:57 -0400
Received: by mail-bk0-f50.google.com with SMTP id jg1so217104bkc.23
	for <lttng-dev@lists.lttng.org>; Wed, 10 Apr 2013 06:02:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CA+umk=pX-4t74XQqsP+vLsDGF1atWzUi75gmSyoVGsDkqQcB7g@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: PLSTC <b0mb00z.it@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On Wed, Apr 10, 2013 at 08:37:18AM -0400, PLSTC wrote:
> Hey Jan,
> 
> I cannot speak on behalf of everyone here, but during our attempt to port
> LTTng to Android, we also noticed that the kernels we were using (3.0.x)
> were nowhere near the requirements for syscall tracepoints support. I
> believe such support was added on x86/64 way earlier (early 3.x) than on
> ARM, which is why it was included in LTTng's modules a while ago. Simply
> put, the ARM kernel is late.

OK, so for ARM kernel version 3.6 is the minimum unless the syscall tracepoint
support is backported.
 
> There are a few actuals ways to 'enable' syscall tracepoints support on
> early ARM kernels, but they all including a bit of kernel hacking/patching.
> I could send you some links if you're interested in that.

Yes, sure!

--Jan

> -PL
> On Apr 10, 2013 4:40 AM, "Jan Glauber" <jan.glauber@gmail.com> wrote:
> 
> > Hi,
> >
> > I want to use LTTng for system call tracing on ARM. Now lttng-modules seems
> > to support system call tracing on ARM already since
> > "8f4f80e LTTng Modules ARM syscall instrumentation".
> >
> > But I wonder how that worked since lttng-syscalls.c is only build under
> > CONFIG_HAVE_SYSCALL_TRACEPOINTS and that was added to ARM only with kernel
> > 3.6
> > (much after than the lttng-modules commit).
> >
> > Am I missing something? Is system call tracing working on ARM with the
> > upstream
> > LTTng version?
> >
> > thanks,
> > Jan
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
