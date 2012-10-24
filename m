From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Wrong procname for userspace trace of app
	with	different thread names
Date: Wed, 24 Oct 2012 09:06:01 -0400
Message-ID: <20121024130601.GA10310__1869.73845488883$1351083996$gmane$org@Krystal>
References: <20998D40D9A2B7499CA5A3A2666CB1EB19F7CBC4@ZURMSG1.QUANTUM.com>
	<20121024123207.GA9568@Krystal> <20121024123551.GB9568@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TR0ep-0000Ny-8D
	for lttng-dev@lists.lttng.org; Wed, 24 Oct 2012 09:06:03 -0400
Content-Disposition: inline
In-Reply-To: <20121024123551.GB9568@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David OShea <David.OShea@quantum.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
> * Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
> > * David OShea (David.OShea@quantum.com) wrote:
> > > Hi all,
> > > 
> > > I performed a userspace trace of a multi-threaded application that
> > > uses prctl(PR_SET_NAME, ...) to give its threads names.  From the
> > > output of 'lttng view' below (I removed timestamps to make it
> > > shorter), it appears that UST is populating the "procname" by getting
> > > the process/thread name from the first thread it sees for a given PID,
> > > then assuming that name applies to all threads in the process:
> > 
> > Yes, this is right.
> > 
> > > 
> > > mydaemon:22593 mydaemon:start: { <cpu_id> }, { pthread_id = 1496398144, procname = "mythread31", vtid = 22761, vpid = 22593 }, { <payload> }
> > > mydaemon:22593 mydaemon:end: { <cpu_id> }, { pthread_id = 1496398144, procname = "mythread31", vtid = 22761, vpid = 22593 }, { <payload> }
> > > myclient:28277 myclient:end: { <cpu_id> }, { pthread_id = 47216641758592, vtid = 28277, vpid = 28277, procname = "myclient" }, { <payload> }
> > > myclient:28277 myclient:start: { <cpu_id> }, { pthread_id = 47216641758592, vtid = 28277, vpid = 28277, procname = "myclient" }, { <payload> }
> > > mydaemon:22593 mydaemon:start: { <cpu_id> }, { pthread_id = 1485908288, procname = "mythread31", vtid = 22760, vpid = 22593 }, { <payload> }
> > > 
> > > On the first line, the procname contains the thread name for vtid =
> > > 22761.  On the last line, the procname is still shown as "mythread31",
> > > but the vtid is different, and I can see from
> > > /proc/22593/task/22760/stat that the thread's name is "mythread30".
> > > However, the <process name>:<PID> at the start of each line - the pair
> > > before the <trace provider>:<tracepoint name> - does show the actual
> > > process name rather than any thread name.
> > > 
> > > I'm using LTTng 2.0.4 and babeltrace 1.0.0.rc5.  I set up my trace
> > > using these steps:
> > > 
> > > lttng create
> > > lttng enable-channel channel0 --userspace
> > > lttng add-context --userspace -t vpid -t vtid -t procname -t pthread_id
> > > lttng enable-event --userspace --all
> > > 
> > > It would be great if "procname" was replaced by "threadname" and
> > > showed each thread's name correctly, since the process's name is
> > > already shown, but the thread names would be very useful.  Otherwise,
> > > at the very least, "procname" should probably show the same thing that
> > > is shown at the start of the line rather than incorrectly using the
> > > name of one of the threads.
> > 
> > We currently choose to get the process name only once and cache it
> > for performance reasons: we don't want to call prctl (and thus pay a
> > round-trip to the kernel) each and every time an event is traced.
> > 
> > I agree with you, though, that maybe this shortcut is not strictly right
> > semantically speaking.
> > 
> > One approach we could take would be to do like liblttng-ust-fork, and
> > provide a way to override prctl(), and keep a procname per-thread value
> > cached in user-space. This could fit in liblttng-ust-libc, which can be
> > optionally loaded. When available, the procname context in UST would use
> > this cached information instead of the info cached per process. However,
> > this change is quite intrusive at this point of the -rc cycle.
> > 
> > Given that getting the process name into a context can be expected to be
> > an operation that might degrade performances (lttng offers no guarantees
> > about how fast it is to grab each context), we could start by simply
> > disabling the procname cache in user-space to get the semantic right.
> > Somewhere in the future, we can then proceed to do the libc override to
> > improve performance again. Thoughts ?
> 
> Now that I come to think of it, maybe there would be a middle-ground
> here: we could save the procname into a thread-local storage rather than
> a global variable. Therefore, as long as you issue prctl() on your
> thread before the first event is logged for that thread, you'll cache
> the appropriate thread name.
> 
> I expect that typical use-cases involve calling prctl right after the
> thread starts, so it might just work (this would need to be documented
> though).

Please try with lttng-ust HEAD, which includes:

commit 009745db8ca05f7a3abbb37558b08eae0107f7e1
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Wed Oct 24 09:04:14 2012 -0400

    Fix: procname context semantic
    
    Cache the procname per-thread rather than per-process to take into
    account that prctl() can be used to set thread names.
    
    prctl() should be issued before tracing each thread's first event if we
    care about the thread name.
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>




> 
> Thoughts ?
> 
> Thanks,
> 
> Mathieu
> 
> > 
> > > 
> > > Incidentally, why do I have to do "enable-channel" to get the context
> > > to actually appear?  If I don't do this, the "add-context" still says
> > > that each of the four contexts was "added to all channels", but they
> > > don't appear in 'lttng view'.
> > 
> > Please provide the full list of commands you do to reproduce a "good"
> > and "bad" behavior.
> > 
> > Thanks,
> > 
> > Mathieu
> > 
> > 
> > > 
> > > Thanks in advance,
> > > David
> > > 
> > > ----------------------------------------------------------------------
> > > The information contained in this transmission may be confidential. Any disclosure, copying, or further distribution of confidential information is not permitted unless such privilege is explicitly granted in writing by Quantum. Quantum reserves the right to have electronic communications, including email and attachments, sent across its networks filtered through anti virus and spam software programs and retain such messages in order to comply with applicable data security and retention requirements. Quantum is not responsible for the proper and complete transmission of the substance of this communication or for any delay in its receipt.
> > > 
> > > _______________________________________________
> > > lttng-dev mailing list
> > > lttng-dev@lists.lttng.org
> > > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > 
> > -- 
> > Mathieu Desnoyers
> > Operating System Efficiency R&D Consultant
> > EfficiOS Inc.
> > http://www.efficios.com
> > 
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
> -- 
> Mathieu Desnoyers
> Operating System Efficiency R&D Consultant
> EfficiOS Inc.
> http://www.efficios.com
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
