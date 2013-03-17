From: Amit Balboul <amit.balboul@shinesec.com>
Subject: Re: Fwd: compiling LTTng for android
Date: Sun, 17 Mar 2013 09:17:32 +0200
Message-ID: <CAHg4Oy_9p2Uvd5i99G+t044pKXwMqCYspchVDnX2cTuWxCTfWg__7159.82527840442$1363504713$gmane$org@mail.gmail.com>
References: <CA+umk=p=cc2r7P1dW3yAmwZWB1gW_d_zB+Ce-JS2RJoHObdjCw@mail.gmail.com>
	<CA+umk=qs6cR+LPuDpALtLpAUWL9dSmRzn5k-CdW0-vwDr+6S=Q@mail.gmail.com>
	<CAHg4Oy--R1jHhHAbQzTKgDNgTi7cnqPAdYyPoANct+sjVJP35A@mail.gmail.com>
	<CAHg4Oy875Z0T=nW=MQ3_xm-b3rhDDYfQFemjeVR68r9mqUu_VQ@mail.gmail.com>
	<CA+umk=r3F7C8zKvF2Bvjoh9FmuOU_Htf3P+VngRKyvo+PHbsQw@mail.gmail.com>
	<CAHg4Oy8LbkQT3yLeWMq7myty8t06brtrr9yyYwvDk8cjsmFx9A@mail.gmail.com>
	<CAHg4Oy_X-NhH5_JFXCBg-HsoZxyh+equV1O8vDnqAVv1QCroRw@mail.gmail.com>
	<CA+umk=qjGDo4O7NmhfKHQRM96pTz3X8TnveaShtWQJRBZ82X3A@mail.gmail.com>
	<CA+umk=pgM9BVebkXj2hrgi_LDBdwjm2ZGpS=PmT9DapPJ5kD0A@mail.gmail.com>
	<CA+umk=rVfxiSdSAkUCy2yDKbqdgtWW9zJ8O=ivSgOe828br+oQ@mail.gmail.com>
	<20130315150806.GA1467@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1865938290=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amit.balboul@shinesec.com>) id 1UH7qc-0003aF-C0
	for lttng-dev@lists.lttng.org; Sun, 17 Mar 2013 03:17:38 -0400
Received: by mail-pb0-f46.google.com with SMTP id uo15so5495248pbc.5
	for <lttng-dev@lists.lttng.org>; Sun, 17 Mar 2013 00:17:32 -0700 (PDT)
In-Reply-To: <20130315150806.GA1467@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, yannick.brosseau@polymtl.ca
List-Id: lttng-dev@lists.lttng.org

--===============1865938290==
Content-Type: multipart/alternative; boundary=047d7b5db0c276d1b504d819aa51

--047d7b5db0c276d1b504d819aa51
Content-Type: text/plain; charset=ISO-8859-1

That's great news !!!
Glad to hear that this is the last hurdle to pass,
Thanks,
Amit.


On Fri, Mar 15, 2013 at 5:08 PM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> * Pierre-Luc St-Charles (pierre-luc.st-charles@polymtl.ca) wrote:
> > Good news!
> >
> > After peeking yesterday through the different glibc/SysV implementations
> > (wrappers...) of splice I could find, I realized that those are not
> > actually necessary for what we intend to do: from what I found out, they
> > only redefine/wrap/redeclare the sys_splice system call that's
> implemented
> > directly in the kernel (in any architecture). Considering we don't need
> > anything more than the default (kernel-space) splice, we can simply
> rewire
> > the 'splice' declaration we use/have to syscall(__NR_splice,...), just
> like
> > what was needed for epoll_create1 earlier.
> >
> > For example : (doing this from memory... I don't have access to the code
> > atm)
> > > in src/common/compat/fcntl.h, inside the linux ifdef, top of the file:
> >
> > #ifdef __ANDROID__
> > #define SPLICE_F_MOVE       0x01
> > #define SPLICE_F_NONBLOCK   0x02
> > #define SPLICE_F_MORE       0x04
> > #define SPLICE_F_GIFT       0x08
> > static inline ssize_t splice(int fd_in, loff_t *off_in, int fd_out,
> > loff_t *off_out,
> >         size_t len, unsigned int flags)
> > {
> >     return syscall(__NR_splice,fd_in,loff_in,fd_out,loff_out,len,flags);
> > }
> > #endif
> >
> >
> > Result? Boom, traces.
> >
> > The rest of the project seems to work without any other visible problem,
> > and we can finally obtain traces when asking the tools nicely. In fact,
> we
> > can obtain traces from any device without even having to modify the
> > kernel/system image at all (except to add module and tracepoints support,
> > which should already be there), which is pretty surprising, but also very
> > useful, considering we can just ship the required binaries anywhere and
> > start tracing.
> >
> > Once we confirm that the traces are actually good and we haven't broken
> > anything else (we're still not sure liburcu works 100%, we're trying to
> run
> > all the tests), we'll start sending in results for anyone who might be
> > interested.
>
> That's great news! So I understand that you got lttng-modules Linux
> kernel tracing to work on Android. I look forward to see patches we
> could merge into lttng-tools.
>
> I guess the next step will be to look into LTTng-UST user-space tracing.
>
> Thanks,
>
> Mathieu
>
> >
> > - PL
> >
> > On Tue, Mar 12, 2013 at 6:51 PM, Pierre-Luc St-Charles <
> > pierre-luc.st-charles@polymtl.ca> wrote:
> >
> > > Hey Amit,
> > >
> > > Here's a small update on my latest findings regarding the broken
> *splice*
> > > / bad Bionic impl problem:
> > >
> > > Although it didn't really cross my mind earlier, we had seen this exact
> > > problem before, but in another project; we had also investigated a bit
> at
> > > the time, but to no avail. It seems the issue is known by the
> > > Android/Bionic community, but it's simply not on their immediate todo
> list
> > > (and hasn't been for at least the past two years -- see
> > > https://code.google.com/p/android/issues/detail?id=11330). The
> solutions
> > > we are now considering are: adding splice support (and whatever else
> might
> > > also be needed) to Bionic ourselves (saving BILLIONS of broken lives
> in the
> > > process, IF the changes are accepted), or simply inserting glibc (and
> > > building against it) in our device images.
> > >
> > > In the next few days, we'll be studying how much time the first
> solution
> > > would actually take (as we're not really experts in that domain at
> all),
> > > but considering the nature/objective of this project, it might be the
> > > wisest decision (as it would not require too much swerving away from
> the
> > > default images people have on their devices for LTTng to actually
> work). If
> > > we deem it 'impossible/out of our league', we'll simply try to get a
> > > working tool asap using glibc, which should not be very complicated
> itself
> > > (many people have actually successfully done it before).
> > >
> > > In any case, I'll keep you updated, and I'll also post any big updates
> on
> > > the mailing list.
> > >
> > > -PL
> > >
> > > On Wed, Mar 6, 2013 at 8:04 PM, Pierre-Luc St-Charles <
> > > pierre-luc.st-charles@polymtl.ca> wrote:
> > >
> > >> Great findings!
> > >>
> > >> I'll also try to look into this new problem by next monday; I'm
> falling a
> > >> bit behind on my 'investigations', but I'll keep you updated if
> anything
> > >> comes up.
> > >>
> > >> -PL
> > >> On Mar 6, 2013 6:09 PM, "Amit Balboul" <amit.balboul@shinesec.com>
> wrote:
> > >>
> > >>> Hi All,
> > >>>
> > >>> Regarding the last mail about tracing system calls on Android using
> > >>> LTTng,
> > >>> The issue of not receiving enabled event to trace from the kernel
> can be
> > >>> fixed patching src/bin/lttng-sessiond/kernel.c (patch attached)
> > >>> In the function *kernel_list_events,* fscanf-ing the events exported
> by
> > >>> the kernel using the fp must not use the syntax *%m* as it is
> obsolete
> > >>> (in Android),
> > >>> thus the fscanf returns 0 and won't read the kernel events (first
> > >>> condition false).
> > >>> Instead I use a pre-allocated buffer for the string and use the
> *%[^;]*syntax, and omitting the memory free (attached is the patch).
> > >>>
> > >>> The resulting output is (sessiond is run with verbose debug prints):
> > >>>
> > >>> root@android:/data/lttng/bin # *./lttng list -k*
> > >>> DEBUG1 [10239/10290]: Wait for client response (in
> > >>> thread_manage_clients() at main.c:3242)
> > >>> DEBUG1 [10239/10290]: Receiving data from client ... (in
> > >>> thread_manage_clients() at main.c:3287)
> > >>> DEBUG1 [10239/10290]: Nothing recv() from client... continuing (in
> > >>> thread_manage_clients() at main.c:3291)
> > >>> DEBUG1 [10239/10290]: Clean command context structure (in
> > >>> clean_command_ctx() at main.c:482)
> > >>> DEBUG1 [10239/10290]: Accepting client command ... (in
> > >>> thread_manage_clients() at main.c:3200)
> > >>> DEBUG1 [10239/10290]: Wait for client response (in
> > >>> thread_manage_clients() at main.c:3242)
> > >>> DEBUG1 [10239/10290]: Receiving data from client ... (in
> > >>> thread_manage_clients() at main.c:3287)
> > >>> DEBUG1 [10239/10290]: Processing client command 14 (in
> > >>> process_client_msg() at main.c:2227)
> > >>> DEBUG1 [10239/10290]: Kernel list events done (61 events) (in
> > >>> kernel_list_events() at kernel.c:653)
> > >>> DEBUG1 [10239/10290]: Sending response (size: 35640, retcode:
> Success)
> > >>> (in thread_manage_clients() at main.c:3338)
> > >>> DEBUG1 [10239/10290]: Clean command context structure (in
> > >>> clean_command_ctx() at main.c:482)
> > >>> DEBUG1 [10239/10290]: Accepting client command ... (in
> > >>> thread_manage_clients() at main.c:3200)
> > >>> Kernel events:
> > >>> -------------
> > >>>       block_rq_abort (loglevel: TRACE_EMERG (0)) (type: tracepoint)
> > >>>       block_rq_requeue (loglevel: TRACE_EMERG (0)) (type: tracepoint)
> > >>>       block_rq_complete (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
> > >>>       block_rq_insert (loglevel: TRACE_EMERG (0)) (type: tracepoint)
> > >>>       block_rq_issue (loglevel: TRACE_EMERG (0)) (type: tracepoint)
> > >>>       block_bio_bounce (loglevel: TRACE_EMERG (0)) (type: tracepoint)
> > >>>       block_bio_complete (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
> > >>>       block_bio_backmerge (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
> > >>>       block_bio_frontmerge (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
> > >>>       block_bio_queue (loglevel: TRACE_EMERG (0)) (type: tracepoint)
> > >>>       block_getrq (loglevel: TRACE_EMERG (0)) (type: tracepoint)
> > >>>       block_sleeprq (loglevel: TRACE_EMERG (0)) (type: tracepoint)
> > >>>       block_plug (loglevel: TRACE_EMERG (0)) (type: tracepoint)
> > >>>       block_unplug (loglevel: TRACE_EMERG (0)) (type: tracepoint)
> > >>>       block_split (loglevel: TRACE_EMERG (0)) (type: tracepoint)
> > >>>       block_bio_remap (loglevel: TRACE_EMERG (0)) (type: tracepoint)
> > >>>       block_rq_remap (loglevel: TRACE_EMERG (0)) (type: tracepoint)
> > >>>       irq_handler_entry (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
> > >>>       irq_handler_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
> > >>>       softirq_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
> > >>>       softirq_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
> > >>>       softirq_raise (loglevel: TRACE_EMERG (0)) (type: tracepoint)
> > >>>       sched_kthread_stop (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
> > >>>       sched_kthread_stop_ret (loglevel: TRACE_EMERG (0)) (type:
> > >>> tracepoint)
> > >>>       sched_wakeup (loglevel: TRACE_EMERG (0)) (type: tracepoint)
> > >>>       sched_wakeup_new (loglevel: TRACE_EMERG (0)) (type: tracepoint)
> > >>>       sched_switch (loglevel: TRACE_EMERG (0)) (type: tracepoint)
> > >>>       sched_migrate_task (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
> > >>>       sched_process_free (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
> > >>>       sched_process_exit (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
> > >>>       sched_wait_task (loglevel: TRACE_EMERG (0)) (type: tracepoint)
> > >>>       sched_process_wait (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
> > >>>       sched_process_fork (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
> > >>>       sched_stat_wait (loglevel: TRACE_EMERG (0)) (type: tracepoint)
> > >>>       sched_stat_sleep (loglevel: TRACE_EMERG (0)) (type: tracepoint)
> > >>>       sched_stat_iowait (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
> > >>>       sched_stat_runtime (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
> > >>>       sched_pi_setprio (loglevel: TRACE_EMERG (0)) (type: tracepoint)
> > >>>       signal_generate (loglevel: TRACE_EMERG (0)) (type: tracepoint)
> > >>>       signal_deliver (loglevel: TRACE_EMERG (0)) (type: tracepoint)
> > >>>       signal_overflow_fail (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
> > >>>       signal_lose_info (loglevel: TRACE_EMERG (0)) (type: tracepoint)
> > >>>       lttng_statedump_start (loglevel: TRACE_EMERG (0)) (type:
> > >>> tracepoint)
> > >>>       lttng_statedump_end (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
> > >>>       lttng_statedump_process_state (loglevel: TRACE_EMERG (0))
> (type:
> > >>> tracepoint)
> > >>>       lttng_statedump_file_descriptor (loglevel: TRACE_EMERG (0))
> (type:
> > >>> tracepoint)
> > >>>       lttng_statedump_vm_map (loglevel: TRACE_EMERG (0)) (type:
> > >>> tracepoint)
> > >>>       lttng_statedump_network_interface (loglevel: TRACE_EMERG (0))
> > >>> (type: tracepoint)
> > >>>       lttng_statedump_interrupt (loglevel: TRACE_EMERG (0)) (type:
> > >>> tracepoint)
> > >>>       timer_init (loglevel: TRACE_EMERG (0)) (type: tracepoint)
> > >>>       timer_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
> > >>>       timer_expire_entry (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
> > >>>       timer_expire_exit (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
> > >>>       timer_cancel (loglevel: TRACE_EMERG (0)) (type: tracepoint)
> > >>>       hrtimer_init (loglevel: TRACE_EMERG (0)) (type: tracepoint)
> > >>>       hrtimer_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
> > >>>       hrtimer_expire_entry (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
> > >>>       hrtimer_expire_exit (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
> > >>>       hrtimer_cancel (loglevel: TRACE_EMERG (0)) (type: tracepoint)
> > >>>       itimer_state (loglevel: TRACE_EMERG (0)) (type: tracepoint)
> > >>>       itimer_expire (loglevel: TRACE_EMERG (0)) (type: tracepoint)
> > >>>
> > >>> root@android:/data/lttng/bin #
> > >>>
> > >>> Now I'm facing the issue of starting the traces:
> > >>> debugging the sessiond, consumerd and lttng I concluded that the
> issue
> > >>> is due to splice system call failure.
> > >>> even using a MMAP output type channel, the metadata channel is SPLICE
> > >>> type (hard-coded).
> > >>> Problem persists also when using relayd to pass the traces through
> the
> > >>> network.
> > >>> Ignoring the splice failure means closing of the metadata channel
> > >>> (maybe??) but need not affect the traces channel (right ?)
> > >>> Attached is a debug log of each thread of the sessiond, right after
> > >>> invoking "*./lttng start*". (with extra informative my prints)
> > >>>
> > >>> Please keep me in touch with any progress in this issue,
> > >>> Thank you,
> > >>> Amit.
> > >>>
> > >>>
> > >>>
> > >>>
> > >>>
> > >>>
> > >>> ---------- Forwarded message ----------
> > >>> From: Amit Balboul <amit.balboul@shinesec.com>
> > >>> Date: Wed, Feb 27, 2013 at 4:37 PM
> > >>> Subject: Re: [lttng-dev] compiling LTTng for android
> > >>> To: PLSTC <b0mb00z.it@gmail.com>
> > >>>
> > >>>
> > >>> Hey Pierre,
> > >>>
> > >>> Some major progress has been achieved, following is the summary:
> > >>>
> > >>> 1. Modules issue:
> > >>> I built (for ARM/Android) and installed latest stable version of
> busybox
> > >>> on the device.
> > >>> Seeing the code tries to run (hardcoded) /sbin/modprobe, made a soft
> > >>> link to busybox's modeprobe.
> > >>> Also, created /lib/modules/<version+build> directory and pushed the
> > >>> <version+build> directory from /lib/modules on the machine.
> > >>> Now session daemon modprobes the desired modules successfully, (some
> are
> > >>> not present though as mentioned before) - no need to use insmod.
> > >>>
> > >>> 2. epoll_create1 issue:
> > >>> epoll_create1 patch was OK, I accidentally defined  EPOLL_CLOEXEC as
> > >>> 0x02000000 instead of 02000000 (fixed).
> > >>>
> > >>> The running scenario:
> > >>>
> > >>> 1. Run ./lttng-sessiond -d -vvv
> > >>>
> > >>> Then: (commands are in bold, output is in blue for readability)
> > >>>
> > >>> root@android:/data/lttng/install_sysroot/bin # *./lttng create s1*
> > >>>
> > >>> Session s1 created.
> > >>> Traces will be written in /data/lttng-traces/s1-20130227-161145
> > >>> root@android:/data/lttng/install_sysroot/bin # *./lttng
> enable-channel
> > >>> ch -k*
> > >>> Kernel channel ch enabled for session s1
> > >>> root@android:/data/lttng/install_sysroot/bin # *./lttng
> enable-event ev
> > >>> -k -a*
> > >>> All kernel events are enabled in channel channel0
> > >>> root@android:/data/lttng/install_sysroot/bin # *./lttng list s1*
> > >>> Tracing session s1: [inactive]
> > >>>     Trace path: /data/lttng-traces/s1-20130227-161145
> > >>>
> > >>> === Domain: Kernel ===
> > >>>
> > >>> Channels:
> > >>> -------------
> > >>> - channel0: [enabled]
> > >>>
> > >>>     Attributes:
> > >>>       overwrite mode: 0
> > >>>       subbufers size: 262144
> > >>>       number of subbufers: 4
> > >>>       switch timer interval: 0
> > >>>       read timer interval: 200
> > >>>       output: splice()
> > >>>
> > >>>     Events:
> > >>>       None
> > >>>
> > >>> - ch: [enabled]
> > >>>
> > >>>      Attributes:
> > >>>       overwrite mode: 0
> > >>>       subbufers size: 262144
> > >>>       number of subbufers: 4
> > >>>       switch timer interval: 0
> > >>>       read timer interval: 200
> > >>>       output: splice()
> > >>>
> > >>>     Events:
> > >>>       None
> > >>>
> > >>> root@android:/data/lttng/install_sysroot/bin # *./lttng list -k *
> > >>>
> > >>> Kernel events:
> > >>> -------------
> > >>>
> > >>> root@android:/data/lttng/install_sysroot/bin # *./lttng start*
> > >>> Tracing started for session s1
> > >>> root@android:/data/lttng/install_sysroot/bin # *./lttng stop     *
> > >>>
> > >>> Waiting for data availability
> > >>> Tracing stopped for session s1
> > >>> root@android:/data/lttng/install_sysroot/bin #
> > >>>
> > >>> *Now: (this is not surprising because the kernel events list is
> > >>> empty...)*
> > >>> the folder /data/lttng-traces/s1-20130227-161145/kernel contains:
> > >>> total 0
> > >>> -rwxrwxrwx    1 0        0                0 Feb 27 14:18 ch_0
> > >>> -rwxrwxrwx    1 0        0                0 Feb 27 14:18 ch_1
> > >>> -rwxrwxrwx    1 0        0                0 Feb 27 14:18 channel0_0
> > >>> -rwxrwxrwx    1 0        0                0 Feb 27 14:18 channel0_1
> > >>> -rwxrwxrwx    1 0        0                0 Feb 27 14:18 metadata
> > >>>
> > >>> *By the way:*
> > >>> When running the same scenario but creating the channel with
> *--output
> > >>> mmap*, still no data but the size of the first two files in the
> traces
> > >>> directory are 4Kb (I didn't bother to investigate them as I assume
> it is
> > >>> just the header - not the traces payload).
> > >>>
> > >>> Another issue: at this point, listing the sessions gives:
> > >>> root@android:/data/lttng/install_sysroot/bin # *./lttng list s1 *
> > >>>
> > >>> Tracing session s1: [inactive]
> > >>>     Trace path: /data/lttng-traces/s1-20130227-161145
> > >>>
> > >>> === Domain: Kernel ===
> > >>>
> > >>> Error: No kernel consumer detected
> > >>> 99|root@android:/data/lttng/install_sysroot/bin # *./lttng list -k
>   *
> > >>>
> > >>> Error: Unable to list kernel events
> > >>> Error: Command error
> > >>> 1|root@android:/data/lttng/install_sysroot/bin #
> > >>>
> > >>> So currently I'm facing these issues:
> > >>> 1. Kernel events list is empty.
> > >>> 2. Listing the session/ kernel events after creating session,
> channel,
> > >>> event, start, stop - results in "no kernel consumer detected"
> > >>>
> > >>> If you have some insights please share them with me..
> > >>>
> > >>> Thanks
> > >>>
> > >>> Amit.
> > >>>
> > >>>
> > >>> On Tue, Feb 26, 2013 at 7:35 PM, PLSTC <b0mb00z.it@gmail.com> wrote:
> > >>>
> > >>>> The modules you can't find are the same I am also missing I
> believe; I
> > >>>> think they are only compiled when certain kernel config defines are
> met
> > >>>> (and those might simply be unavailable under ARM).
> > >>>>
> > >>>> As for what you pointed in your first mail, I believe modprobe isn't
> > >>>> available on ARM, did you mean that some modules were not found
> when using
> > >>>> insmod?
> > >>>>
> > >>>> For the epoll_create1 problem, what kind of patch did you apply to
> add
> > >>>> support for the epoll_create1 function?
> > >>>>
> > >>>>
> > >>>> On Tue, Feb 26, 2013 at 11:29 AM, Amit Balboul <
> > >>>> amit.balboul@shinesec.com> wrote:
> > >>>>
> > >>>>> Ok I got :
> > >>>>> lttng-kretprobes.ko
> > >>>>> lttng-kprobes.ko
> > >>>>> , the other two are missing.
> > >>>>>
> > >>>>>
> > >>>>> ---------- Forwarded message ----------
> > >>>>> From: Amit Balboul <amit.balboul@shinesec.com>
> > >>>>> Date: Tue, Feb 26, 2013 at 5:49 PM
> > >>>>> Subject: Re: [lttng-dev] compiling LTTng for android
> > >>>>> To: PLSTC <b0mb00z.it@gmail.com>
> > >>>>>
> > >>>>>
> > >>>>> One more thing:
> > >>>>>
> > >>>>> The list of modules you gave my is not identical to mine:
> > >>>>> a. I pushed the modules from my machine to my folder in the device
> > >>>>> (not to /system/lib) as you directed me, and insmoded them
> manually.
> > >>>>> b. I pushed the whole tree under /lib/modules/<KERNEL_VER_BUILD>/
> > >>>>> which includes the modules.* and the sub directories:
> > >>>>>
> > >>>>> /lib/modules/3.0.31-gd5a18e0/extra$ ll
> > >>>>> total 2464
> > >>>>> drwxr-xr-x 4 root root    4096 Feb 26 15:58 ./
> > >>>>> drwxr-xr-x 3 root root    4096 Feb 26 15:58 ../
> > >>>>> drwxr-xr-x 2 root root    4096 Feb 26 15:58 lib/
> > >>>>> -rw-r--r-- 1 root root  167184 Feb 26 15:58
> > >>>>> lttng-ring-buffer-client-discard.ko
> > >>>>> -rw-r--r-- 1 root root  167206 Feb 26 15:58
> > >>>>> lttng-ring-buffer-client-mmap-discard.ko
> > >>>>> -rw-r--r-- 1 root root  178586 Feb 26 15:58
> > >>>>> lttng-ring-buffer-client-mmap-overwrite.ko
> > >>>>> -rw-r--r-- 1 root root  178564 Feb 26 15:58
> > >>>>> lttng-ring-buffer-client-overwrite.ko
> > >>>>> -rw-r--r-- 1 root root  137179 Feb 26 15:58
> > >>>>> lttng-ring-buffer-metadata-client.ko
> > >>>>> -rw-r--r-- 1 root root  137233 Feb 26 15:58
> > >>>>> lttng-ring-buffer-metadata-mmap-client.ko
> > >>>>> -rw-r--r-- 1 root root  213451 Feb 26 15:58 lttng-statedump.ko
> > >>>>> -rw-r--r-- 1 root root 1314235 Feb 26 15:58 lttng-tracer.ko
> > >>>>> drwxr-xr-x 2 root root    4096 Feb 26 15:58 probes/
> > >>>>>
> > >>>>> /lib/modules/3.0.31-gd5a18e0/extra/lib$ ll
> > >>>>> total 732
> > >>>>> drwxr-xr-x 2 root root   4096 Feb 26 15:58 ./
> > >>>>> drwxr-xr-x 4 root root   4096 Feb 26 15:58 ../
> > >>>>> -rw-r--r-- 1 root root 738964 Feb 26 15:58 lttng-lib-ring-buffer.ko
> > >>>>>
> > >>>>> /lib/modules/3.0.31-gd5a18e0/extra/probes$ ll
> > >>>>> total 2872
> > >>>>> drwxr-xr-x 2 root root   4096 Feb 26 15:58 ./
> > >>>>> drwxr-xr-x 4 root root   4096 Feb 26 15:58 ../
> > >>>>> -rw-r--r-- 1 root root 162872 Feb 26 15:58 lttng-probe-asoc.ko
> > >>>>> -rw-r--r-- 1 root root 171049 Feb 26 15:58 lttng-probe-block.ko
> > >>>>> -rw-r--r-- 1 root root  81165 Feb 26 15:58
> lttng-probe-compaction.ko
> > >>>>> -rw-r--r-- 1 root root 333215 Feb 26 15:58 lttng-probe-ext4.ko
> > >>>>> -rw-r--r-- 1 root root  80413 Feb 26 15:58 lttng-probe-gpio.ko
> > >>>>> -rw-r--r-- 1 root root  84256 Feb 26 15:58 lttng-probe-irq.ko
> > >>>>> -rw-r--r-- 1 root root 135453 Feb 26 15:58 lttng-probe-jbd2.ko
> > >>>>> -rw-r--r-- 1 root root 105399 Feb 26 15:58 lttng-probe-kmem.ko
> > >>>>> -rw-r--r-- 1 root root  76240 Feb 26 15:58 lttng-probe-lttng.ko
> > >>>>> -rw-r--r-- 1 root root  88059 Feb 26 15:58 lttng-probe-module.ko
> > >>>>> -rw-r--r-- 1 root root 154032 Feb 26 15:58 lttng-probe-napi.ko
> > >>>>> -rw-r--r-- 1 root root 142038 Feb 26 15:58 lttng-probe-net.ko
> > >>>>> -rw-r--r-- 1 root root  93564 Feb 26 15:58 lttng-probe-power.ko
> > >>>>> -rw-r--r-- 1 root root  85530 Feb 26 15:58 lttng-probe-regulator.ko
> > >>>>> -rw-r--r-- 1 root root 138121 Feb 26 15:58 lttng-probe-sched.ko
> > >>>>> -rw-r--r-- 1 root root 152909 Feb 26 15:58 lttng-probe-scsi.ko
> > >>>>> -rw-r--r-- 1 root root 107491 Feb 26 15:58 lttng-probe-signal.ko
> > >>>>> -rw-r--r-- 1 root root 142711 Feb 26 15:58 lttng-probe-skb.ko
> > >>>>> -rw-r--r-- 1 root root 181983 Feb 26 15:58 lttng-probe-statedump.ko
> > >>>>> -rw-r--r-- 1 root root 126731 Feb 26 15:58 lttng-probe-timer.ko
> > >>>>> -rw-r--r-- 1 root root  86591 Feb 26 15:58 lttng-probe-workqueue.ko
> > >>>>> -rw-r--r-- 1 root root 133886 Feb 26 15:58 lttng-probe-writeback.ko
> > >>>>> -rw-r--r-- 1 root root  30863 Feb 26 15:58 lttng-types.ko
> > >>>>>
> > >>>>> Looking at the files shows I miss:
> > >>>>> lttng-kretprobes.ko
> > >>>>> lttng-kprobes.ko
> > >>>>> lttng-ftrace.ko
> > >>>>> lttng-probe-kvm.ko
> > >>>>>
> > >>>>>
> > >>>>> On Tue, Feb 26, 2013 at 3:56 PM, PLSTC <b0mb00z.it@gmail.com>
> wrote:
> > >>>>>
> > >>>>>> Back on the last email:
> > >>>>>>
> > >>>>>> Here's the insmod list I ended up building; you might not have
> > >>>>>> compiled all those modules, depending on your kernel config and
> on the
> > >>>>>> architecture used, so some might simply be absent from your output
> > >>>>>> directory.
> > >>>>>>
> > >>>>>> insmod /system/lib/modules/lttng-types.ko
> > >>>>>> insmod /system/lib/modules/lttng-kretprobes.ko
> > >>>>>> insmod /system/lib/modules/lttng-kprobes.ko
> > >>>>>> insmod /system/lib/modules/lttng-ftrace.ko
> > >>>>>> insmod /system/lib/modules/lttng-lib-ring-buffer.ko
> > >>>>>> insmod /system/lib/modules/lttng-statedump.ko
> > >>>>>> insmod /system/lib/modules/lttng-tracer.ko
> > >>>>>> insmod /system/lib/modules/lttng-probe-timer.ko
> > >>>>>> insmod /system/lib/modules/lttng-probe-statedump.ko
> > >>>>>> insmod /system/lib/modules/lttng-probe-signal.ko
> > >>>>>> insmod /system/lib/modules/lttng-probe-sched.ko
> > >>>>>> insmod /system/lib/modules/lttng-probe-lttng.ko
> > >>>>>> insmod /system/lib/modules/lttng-probe-kvm.ko
> > >>>>>> insmod /system/lib/modules/lttng-probe-irq.ko
> > >>>>>> insmod /system/lib/modules/lttng-probe-block.ko
> > >>>>>> insmod
> /system/lib/modules/lttng-ring-buffer-metadata-mmap-client.ko
> > >>>>>> insmod /system/lib/modules/lttng-ring-buffer-metadata-client.ko
> > >>>>>> insmod /system/lib/modules/lttng-ring-buffer-client-overwrite.ko
> > >>>>>> insmod
> /system/lib/modules/lttng-ring-buffer-client-mmap-overwrite.ko
> > >>>>>> insmod
> /system/lib/modules/lttng-ring-buffer-client-mmap-discard.ko
> > >>>>>> insmod /system/lib/modules/lttng-ring-buffer-client-discard.ko
> > >>>>>>
> > >>>>>>
> > >>>>>> We also haven't had time recently to test if the
> kprobes/kretprobes
> > >>>>>> worked, but they probably do; we decided to focus a bit more on
> the
> > >>>>>> 'tracepoints' aspect instead.
> > >>>>>>
> > >>>>>> Anyway, good luck with your exploration, and if you find something
> > >>>>>> interesting, I'd love to know more about it!
> > >>>>>>
> > >>>>>> -PL
> > >>>>>>
> > >>>>>> On Tue, Feb 26, 2013 at 8:06 AM, PLSTC <b0mb00z.it@gmail.com>
> wrote:
> > >>>>>>
> > >>>>>>> Hey Amit,
> > >>>>>>>
> > >>>>>>> Good news indeed it seems!
> > >>>>>>>
> > >>>>>>> When it comes to pushing the libs/bin, we haven't found any
> better
> > >>>>>>> way than using adb push yet; of course, if all the projects were
> included
> > >>>>>>> directly in Android's external, we would simply flash the device
> after each
> > >>>>>>> build, but currently we're still having trouble generating the
> correct
> > >>>>>>> Android makefiles.
> > >>>>>>>
> > >>>>>>> As for the modules, I might still have a dep load list somewhere
> I
> > >>>>>>> could send you in a few hours, I remember fighting to get the
> order right...
> > >>>>>>>
> > >>>>>>> Also, once everything loads, could you tell me what kind of
> output
> > >>>>>>> 'lttng list -k' provides you? Here, we're having trouble listing
> the
> > >>>>>>> 'default' kernel trace points provided by HAVE_TRACEPOINTS, and
> the
> > >>>>>>> returned list is simply empty (which is a bit strange).
> > >>>>>>>
> > >>>>>>> -PL
> > >>>>>>>
> > >>>>>>
> > >>>>>>
> > >>>>>
> > >>>>>
> > >>>>
> > >>>
> > >>>
> > >
>
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--047d7b5db0c276d1b504d819aa51
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">That&#39;s great news !!!<div style>Glad to hear that this=
 is the last hurdle to pass,<br></div><div style>Thanks,</div><div style>Am=
it.</div></div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote=
">On Fri, Mar 15, 2013 at 5:08 PM, Mathieu Desnoyers <span dir=3D"ltr">&lt;=
<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu=
.desnoyers@efficios.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">* Pi=
erre-Luc St-Charles (<a href=3D"mailto:pierre-luc.st-charles@polymtl.ca">pi=
erre-luc.st-charles@polymtl.ca</a>) wrote:<br>

&gt; Good news!<br>
&gt;<br>
&gt; After peeking yesterday through the different glibc/SysV implementatio=
ns<br>
&gt; (wrappers...) of splice I could find, I realized that those are not<br=
>
&gt; actually necessary for what we intend to do: from what I found out, th=
ey<br>
&gt; only redefine/wrap/redeclare the sys_splice system call that&#39;s imp=
lemented<br>
&gt; directly in the kernel (in any architecture). Considering we don&#39;t=
 need<br>
&gt; anything more than the default (kernel-space) splice, we can simply re=
wire<br>
&gt; the &#39;splice&#39; declaration we use/have to syscall(__NR_splice,..=
.), just like<br>
&gt; what was needed for epoll_create1 earlier.<br>
&gt;<br>
&gt; For example : (doing this from memory... I don&#39;t have access to th=
e code<br>
&gt; atm)<br>
&gt; &gt; in src/common/compat/fcntl.h, inside the linux ifdef, top of the =
file:<br>
&gt;<br>
&gt; #ifdef __ANDROID__<br>
&gt; #define SPLICE_F_MOVE =A0 =A0 =A0 0x01<br>
&gt; #define SPLICE_F_NONBLOCK =A0 0x02<br>
&gt; #define SPLICE_F_MORE =A0 =A0 =A0 0x04<br>
&gt; #define SPLICE_F_GIFT =A0 =A0 =A0 0x08<br>
&gt; static inline ssize_t splice(int fd_in, loff_t *off_in, int fd_out,<br=
>
&gt; loff_t *off_out,<br>
&gt; =A0 =A0 =A0 =A0 size_t len, unsigned int flags)<br>
&gt; {<br>
&gt; =A0 =A0 return syscall(__NR_splice,fd_in,loff_in,fd_out,loff_out,len,f=
lags);<br>
&gt; }<br>
&gt; #endif<br>
&gt;<br>
&gt;<br>
&gt; Result? Boom, traces.<br>
&gt;<br>
&gt; The rest of the project seems to work without any other visible proble=
m,<br>
&gt; and we can finally obtain traces when asking the tools nicely. In fact=
, we<br>
&gt; can obtain traces from any device without even having to modify the<br=
>
&gt; kernel/system image at all (except to add module and tracepoints suppo=
rt,<br>
&gt; which should already be there), which is pretty surprising, but also v=
ery<br>
&gt; useful, considering we can just ship the required binaries anywhere an=
d<br>
&gt; start tracing.<br>
&gt;<br>
&gt; Once we confirm that the traces are actually good and we haven&#39;t b=
roken<br>
&gt; anything else (we&#39;re still not sure liburcu works 100%, we&#39;re =
trying to run<br>
&gt; all the tests), we&#39;ll start sending in results for anyone who migh=
t be<br>
&gt; interested.<br>
<br>
</div></div>That&#39;s great news! So I understand that you got lttng-modul=
es Linux<br>
kernel tracing to work on Android. I look forward to see patches we<br>
could merge into lttng-tools.<br>
<br>
I guess the next step will be to look into LTTng-UST user-space tracing.<br=
>
<br>
Thanks,<br>
<br>
Mathieu<br>
<div><div class=3D"h5"><br>
&gt;<br>
&gt; - PL<br>
&gt;<br>
&gt; On Tue, Mar 12, 2013 at 6:51 PM, Pierre-Luc St-Charles &lt;<br>
&gt; <a href=3D"mailto:pierre-luc.st-charles@polymtl.ca">pierre-luc.st-char=
les@polymtl.ca</a>&gt; wrote:<br>
&gt;<br>
&gt; &gt; Hey Amit,<br>
&gt; &gt;<br>
&gt; &gt; Here&#39;s a small update on my latest findings regarding the bro=
ken *splice*<br>
&gt; &gt; / bad Bionic impl problem:<br>
&gt; &gt;<br>
&gt; &gt; Although it didn&#39;t really cross my mind earlier, we had seen =
this exact<br>
&gt; &gt; problem before, but in another project; we had also investigated =
a bit at<br>
&gt; &gt; the time, but to no avail. It seems the issue is known by the<br>
&gt; &gt; Android/Bionic community, but it&#39;s simply not on their immedi=
ate todo list<br>
&gt; &gt; (and hasn&#39;t been for at least the past two years -- see<br>
&gt; &gt; <a href=3D"https://code.google.com/p/android/issues/detail?id=3D1=
1330" target=3D"_blank">https://code.google.com/p/android/issues/detail?id=
=3D11330</a>). The solutions<br>
&gt; &gt; we are now considering are: adding splice support (and whatever e=
lse might<br>
&gt; &gt; also be needed) to Bionic ourselves (saving BILLIONS of broken li=
ves in the<br>
&gt; &gt; process, IF the changes are accepted), or simply inserting glibc =
(and<br>
&gt; &gt; building against it) in our device images.<br>
&gt; &gt;<br>
&gt; &gt; In the next few days, we&#39;ll be studying how much time the fir=
st solution<br>
&gt; &gt; would actually take (as we&#39;re not really experts in that doma=
in at all),<br>
&gt; &gt; but considering the nature/objective of this project, it might be=
 the<br>
&gt; &gt; wisest decision (as it would not require too much swerving away f=
rom the<br>
&gt; &gt; default images people have on their devices for LTTng to actually=
 work). If<br>
&gt; &gt; we deem it &#39;impossible/out of our league&#39;, we&#39;ll simp=
ly try to get a<br>
&gt; &gt; working tool asap using glibc, which should not be very complicat=
ed itself<br>
&gt; &gt; (many people have actually successfully done it before).<br>
&gt; &gt;<br>
&gt; &gt; In any case, I&#39;ll keep you updated, and I&#39;ll also post an=
y big updates on<br>
&gt; &gt; the mailing list.<br>
&gt; &gt;<br>
&gt; &gt; -PL<br>
&gt; &gt;<br>
&gt; &gt; On Wed, Mar 6, 2013 at 8:04 PM, Pierre-Luc St-Charles &lt;<br>
&gt; &gt; <a href=3D"mailto:pierre-luc.st-charles@polymtl.ca">pierre-luc.st=
-charles@polymtl.ca</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt;&gt; Great findings!<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I&#39;ll also try to look into this new problem by next monda=
y; I&#39;m falling a<br>
&gt; &gt;&gt; bit behind on my &#39;investigations&#39;, but I&#39;ll keep =
you updated if anything<br>
&gt; &gt;&gt; comes up.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; -PL<br>
&gt; &gt;&gt; On Mar 6, 2013 6:09 PM, &quot;Amit Balboul&quot; &lt;<a href=
=3D"mailto:amit.balboul@shinesec.com">amit.balboul@shinesec.com</a>&gt; wro=
te:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt; Hi All,<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Regarding the last mail about tracing system calls on And=
roid using<br>
&gt; &gt;&gt;&gt; LTTng,<br>
&gt; &gt;&gt;&gt; The issue of not receiving enabled event to trace from th=
e kernel can be<br>
&gt; &gt;&gt;&gt; fixed patching src/bin/lttng-sessiond/kernel.c (patch att=
ached)<br>
</div></div>&gt; &gt;&gt;&gt; In the function *kernel_list_events,* fscanf-=
ing the events exported by<br>
&gt; &gt;&gt;&gt; the kernel using the fp must not use the syntax *%m* as i=
t is obsolete<br>
<div class=3D"im">&gt; &gt;&gt;&gt; (in Android),<br>
&gt; &gt;&gt;&gt; thus the fscanf returns 0 and won&#39;t read the kernel e=
vents (first<br>
&gt; &gt;&gt;&gt; condition false).<br>
</div>&gt; &gt;&gt;&gt; Instead I use a pre-allocated buffer for the string=
 and use the *%[^;]*syntax, and omitting the memory free (attached is the p=
atch).<br>
<div class=3D"im">&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; The resulting output is (sessiond is run with verbose deb=
ug prints):<br>
&gt; &gt;&gt;&gt;<br>
</div>&gt; &gt;&gt;&gt; root@android:/data/lttng/bin # *./lttng list -k*<br=
>
<div><div class=3D"h5">&gt; &gt;&gt;&gt; DEBUG1 [10239/10290]: Wait for cli=
ent response (in<br>
&gt; &gt;&gt;&gt; thread_manage_clients() at main.c:3242)<br>
&gt; &gt;&gt;&gt; DEBUG1 [10239/10290]: Receiving data from client ... (in<=
br>
&gt; &gt;&gt;&gt; thread_manage_clients() at main.c:3287)<br>
&gt; &gt;&gt;&gt; DEBUG1 [10239/10290]: Nothing recv() from client... conti=
nuing (in<br>
&gt; &gt;&gt;&gt; thread_manage_clients() at main.c:3291)<br>
&gt; &gt;&gt;&gt; DEBUG1 [10239/10290]: Clean command context structure (in=
<br>
&gt; &gt;&gt;&gt; clean_command_ctx() at main.c:482)<br>
&gt; &gt;&gt;&gt; DEBUG1 [10239/10290]: Accepting client command ... (in<br=
>
&gt; &gt;&gt;&gt; thread_manage_clients() at main.c:3200)<br>
&gt; &gt;&gt;&gt; DEBUG1 [10239/10290]: Wait for client response (in<br>
&gt; &gt;&gt;&gt; thread_manage_clients() at main.c:3242)<br>
&gt; &gt;&gt;&gt; DEBUG1 [10239/10290]: Receiving data from client ... (in<=
br>
&gt; &gt;&gt;&gt; thread_manage_clients() at main.c:3287)<br>
&gt; &gt;&gt;&gt; DEBUG1 [10239/10290]: Processing client command 14 (in<br=
>
&gt; &gt;&gt;&gt; process_client_msg() at main.c:2227)<br>
&gt; &gt;&gt;&gt; DEBUG1 [10239/10290]: Kernel list events done (61 events)=
 (in<br>
&gt; &gt;&gt;&gt; kernel_list_events() at kernel.c:653)<br>
&gt; &gt;&gt;&gt; DEBUG1 [10239/10290]: Sending response (size: 35640, retc=
ode: Success)<br>
&gt; &gt;&gt;&gt; (in thread_manage_clients() at main.c:3338)<br>
&gt; &gt;&gt;&gt; DEBUG1 [10239/10290]: Clean command context structure (in=
<br>
&gt; &gt;&gt;&gt; clean_command_ctx() at main.c:482)<br>
&gt; &gt;&gt;&gt; DEBUG1 [10239/10290]: Accepting client command ... (in<br=
>
&gt; &gt;&gt;&gt; thread_manage_clients() at main.c:3200)<br>
&gt; &gt;&gt;&gt; Kernel events:<br>
&gt; &gt;&gt;&gt; -------------<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 block_rq_abort (loglevel: TRACE_EMERG (0)) (t=
ype: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 block_rq_requeue (loglevel: TRACE_EMERG (0)) =
(type: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 block_rq_complete (loglevel: TRACE_EMERG (0))=
 (type: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 block_rq_insert (loglevel: TRACE_EMERG (0)) (=
type: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 block_rq_issue (loglevel: TRACE_EMERG (0)) (t=
ype: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 block_bio_bounce (loglevel: TRACE_EMERG (0)) =
(type: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 block_bio_complete (loglevel: TRACE_EMERG (0)=
) (type: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 block_bio_backmerge (loglevel: TRACE_EMERG (0=
)) (type: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 block_bio_frontmerge (loglevel: TRACE_EMERG (=
0)) (type: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 block_bio_queue (loglevel: TRACE_EMERG (0)) (=
type: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 block_getrq (loglevel: TRACE_EMERG (0)) (type=
: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 block_sleeprq (loglevel: TRACE_EMERG (0)) (ty=
pe: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 block_plug (loglevel: TRACE_EMERG (0)) (type:=
 tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 block_unplug (loglevel: TRACE_EMERG (0)) (typ=
e: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 block_split (loglevel: TRACE_EMERG (0)) (type=
: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 block_bio_remap (loglevel: TRACE_EMERG (0)) (=
type: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 block_rq_remap (loglevel: TRACE_EMERG (0)) (t=
ype: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 irq_handler_entry (loglevel: TRACE_EMERG (0))=
 (type: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 irq_handler_exit (loglevel: TRACE_EMERG (0)) =
(type: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 softirq_entry (loglevel: TRACE_EMERG (0)) (ty=
pe: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 softirq_exit (loglevel: TRACE_EMERG (0)) (typ=
e: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 softirq_raise (loglevel: TRACE_EMERG (0)) (ty=
pe: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 sched_kthread_stop (loglevel: TRACE_EMERG (0)=
) (type: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 sched_kthread_stop_ret (loglevel: TRACE_EMERG=
 (0)) (type:<br>
&gt; &gt;&gt;&gt; tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 sched_wakeup (loglevel: TRACE_EMERG (0)) (typ=
e: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 sched_wakeup_new (loglevel: TRACE_EMERG (0)) =
(type: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 sched_switch (loglevel: TRACE_EMERG (0)) (typ=
e: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 sched_migrate_task (loglevel: TRACE_EMERG (0)=
) (type: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 sched_process_free (loglevel: TRACE_EMERG (0)=
) (type: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 sched_process_exit (loglevel: TRACE_EMERG (0)=
) (type: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 sched_wait_task (loglevel: TRACE_EMERG (0)) (=
type: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 sched_process_wait (loglevel: TRACE_EMERG (0)=
) (type: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 sched_process_fork (loglevel: TRACE_EMERG (0)=
) (type: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 sched_stat_wait (loglevel: TRACE_EMERG (0)) (=
type: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 sched_stat_sleep (loglevel: TRACE_EMERG (0)) =
(type: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 sched_stat_iowait (loglevel: TRACE_EMERG (0))=
 (type: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 sched_stat_runtime (loglevel: TRACE_EMERG (0)=
) (type: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 sched_pi_setprio (loglevel: TRACE_EMERG (0)) =
(type: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 signal_generate (loglevel: TRACE_EMERG (0)) (=
type: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 signal_deliver (loglevel: TRACE_EMERG (0)) (t=
ype: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 signal_overflow_fail (loglevel: TRACE_EMERG (=
0)) (type: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 signal_lose_info (loglevel: TRACE_EMERG (0)) =
(type: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 lttng_statedump_start (loglevel: TRACE_EMERG =
(0)) (type:<br>
&gt; &gt;&gt;&gt; tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 lttng_statedump_end (loglevel: TRACE_EMERG (0=
)) (type: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 lttng_statedump_process_state (loglevel: TRAC=
E_EMERG (0)) (type:<br>
&gt; &gt;&gt;&gt; tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 lttng_statedump_file_descriptor (loglevel: TR=
ACE_EMERG (0)) (type:<br>
&gt; &gt;&gt;&gt; tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 lttng_statedump_vm_map (loglevel: TRACE_EMERG=
 (0)) (type:<br>
&gt; &gt;&gt;&gt; tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 lttng_statedump_network_interface (loglevel: =
TRACE_EMERG (0))<br>
&gt; &gt;&gt;&gt; (type: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 lttng_statedump_interrupt (loglevel: TRACE_EM=
ERG (0)) (type:<br>
&gt; &gt;&gt;&gt; tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 timer_init (loglevel: TRACE_EMERG (0)) (type:=
 tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 timer_start (loglevel: TRACE_EMERG (0)) (type=
: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 timer_expire_entry (loglevel: TRACE_EMERG (0)=
) (type: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 timer_expire_exit (loglevel: TRACE_EMERG (0))=
 (type: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 timer_cancel (loglevel: TRACE_EMERG (0)) (typ=
e: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 hrtimer_init (loglevel: TRACE_EMERG (0)) (typ=
e: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 hrtimer_start (loglevel: TRACE_EMERG (0)) (ty=
pe: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 hrtimer_expire_entry (loglevel: TRACE_EMERG (=
0)) (type: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 hrtimer_expire_exit (loglevel: TRACE_EMERG (0=
)) (type: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 hrtimer_cancel (loglevel: TRACE_EMERG (0)) (t=
ype: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 itimer_state (loglevel: TRACE_EMERG (0)) (typ=
e: tracepoint)<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 itimer_expire (loglevel: TRACE_EMERG (0)) (ty=
pe: tracepoint)<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; root@android:/data/lttng/bin #<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Now I&#39;m facing the issue of starting the traces:<br>
&gt; &gt;&gt;&gt; debugging the sessiond, consumerd and lttng I concluded t=
hat the issue<br>
&gt; &gt;&gt;&gt; is due to splice system call failure.<br>
&gt; &gt;&gt;&gt; even using a MMAP output type channel, the metadata chann=
el is SPLICE<br>
&gt; &gt;&gt;&gt; type (hard-coded).<br>
&gt; &gt;&gt;&gt; Problem persists also when using relayd to pass the trace=
s through the<br>
&gt; &gt;&gt;&gt; network.<br>
&gt; &gt;&gt;&gt; Ignoring the splice failure means closing of the metadata=
 channel<br>
&gt; &gt;&gt;&gt; (maybe??) but need not affect the traces channel (right ?=
)<br>
&gt; &gt;&gt;&gt; Attached is a debug log of each thread of the sessiond, r=
ight after<br>
</div></div>&gt; &gt;&gt;&gt; invoking &quot;*./lttng start*&quot;. (with e=
xtra informative my prints)<br>
<div><div class=3D"h5">&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Please keep me in touch with any progress in this issue,<=
br>
&gt; &gt;&gt;&gt; Thank you,<br>
&gt; &gt;&gt;&gt; Amit.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; ---------- Forwarded message ----------<br>
&gt; &gt;&gt;&gt; From: Amit Balboul &lt;<a href=3D"mailto:amit.balboul@shi=
nesec.com">amit.balboul@shinesec.com</a>&gt;<br>
&gt; &gt;&gt;&gt; Date: Wed, Feb 27, 2013 at 4:37 PM<br>
&gt; &gt;&gt;&gt; Subject: Re: [lttng-dev] compiling LTTng for android<br>
&gt; &gt;&gt;&gt; To: PLSTC &lt;<a href=3D"mailto:b0mb00z.it@gmail.com">b0m=
b00z.it@gmail.com</a>&gt;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Hey Pierre,<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Some major progress has been achieved, following is the s=
ummary:<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; 1. Modules issue:<br>
&gt; &gt;&gt;&gt; I built (for ARM/Android) and installed latest stable ver=
sion of busybox<br>
&gt; &gt;&gt;&gt; on the device.<br>
&gt; &gt;&gt;&gt; Seeing the code tries to run (hardcoded) /sbin/modprobe, =
made a soft<br>
&gt; &gt;&gt;&gt; link to busybox&#39;s modeprobe.<br>
&gt; &gt;&gt;&gt; Also, created /lib/modules/&lt;version+build&gt; director=
y and pushed the<br>
&gt; &gt;&gt;&gt; &lt;version+build&gt; directory from /lib/modules on the =
machine.<br>
&gt; &gt;&gt;&gt; Now session daemon modprobes the desired modules successf=
ully, (some are<br>
&gt; &gt;&gt;&gt; not present though as mentioned before) - no need to use =
insmod.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; 2. epoll_create1 issue:<br>
&gt; &gt;&gt;&gt; epoll_create1 patch was OK, I accidentally defined =A0EPO=
LL_CLOEXEC as<br>
&gt; &gt;&gt;&gt; 0x02000000 instead of 02000000 (fixed).<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; The running scenario:<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; 1. Run ./lttng-sessiond -d -vvv<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Then: (commands are in bold, output is in blue for readab=
ility)<br>
&gt; &gt;&gt;&gt;<br>
</div></div>&gt; &gt;&gt;&gt; root@android:/data/lttng/install_sysroot/bin =
# *./lttng create s1*<br>
<div class=3D"im">&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Session s1 created.<br>
&gt; &gt;&gt;&gt; Traces will be written in /data/lttng-traces/s1-20130227-=
161145<br>
</div>&gt; &gt;&gt;&gt; root@android:/data/lttng/install_sysroot/bin # *./l=
ttng enable-channel<br>
&gt; &gt;&gt;&gt; ch -k*<br>
<div class=3D"im">&gt; &gt;&gt;&gt; Kernel channel ch enabled for session s=
1<br>
</div>&gt; &gt;&gt;&gt; root@android:/data/lttng/install_sysroot/bin # *./l=
ttng enable-event ev<br>
&gt; &gt;&gt;&gt; -k -a*<br>
<div class=3D"im">&gt; &gt;&gt;&gt; All kernel events are enabled in channe=
l channel0<br>
</div>&gt; &gt;&gt;&gt; root@android:/data/lttng/install_sysroot/bin # *./l=
ttng list s1*<br>
<div><div class=3D"h5">&gt; &gt;&gt;&gt; Tracing session s1: [inactive]<br>
&gt; &gt;&gt;&gt; =A0 =A0 Trace path: /data/lttng-traces/s1-20130227-161145=
<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; =3D=3D=3D Domain: Kernel =3D=3D=3D<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Channels:<br>
&gt; &gt;&gt;&gt; -------------<br>
&gt; &gt;&gt;&gt; - channel0: [enabled]<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; =A0 =A0 Attributes:<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 overwrite mode: 0<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 subbufers size: 262144<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 number of subbufers: 4<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 switch timer interval: 0<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 read timer interval: 200<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 output: splice()<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; =A0 =A0 Events:<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 None<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; - ch: [enabled]<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0Attributes:<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 overwrite mode: 0<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 subbufers size: 262144<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 number of subbufers: 4<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 switch timer interval: 0<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 read timer interval: 200<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 output: splice()<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; =A0 =A0 Events:<br>
&gt; &gt;&gt;&gt; =A0 =A0 =A0 None<br>
&gt; &gt;&gt;&gt;<br>
</div></div>&gt; &gt;&gt;&gt; root@android:/data/lttng/install_sysroot/bin =
# *./lttng list -k *<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Kernel events:<br>
&gt; &gt;&gt;&gt; -------------<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; root@android:/data/lttng/install_sysroot/bin # *./lttng s=
tart*<br>
<div class=3D"im">&gt; &gt;&gt;&gt; Tracing started for session s1<br>
</div>&gt; &gt;&gt;&gt; root@android:/data/lttng/install_sysroot/bin # *./l=
ttng stop =A0 =A0 *<br>
<div class=3D"im">&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Waiting for data availability<br>
&gt; &gt;&gt;&gt; Tracing stopped for session s1<br>
&gt; &gt;&gt;&gt; root@android:/data/lttng/install_sysroot/bin #<br>
&gt; &gt;&gt;&gt;<br>
</div>&gt; &gt;&gt;&gt; *Now: (this is not surprising because the kernel ev=
ents list is<br>
&gt; &gt;&gt;&gt; empty...)*<br>
<div class=3D"im">&gt; &gt;&gt;&gt; the folder /data/lttng-traces/s1-201302=
27-161145/kernel contains:<br>
&gt; &gt;&gt;&gt; total 0<br>
&gt; &gt;&gt;&gt; -rwxrwxrwx =A0 =A01 0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A00 Feb 27 14:18 ch_0<br>
&gt; &gt;&gt;&gt; -rwxrwxrwx =A0 =A01 0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A00 Feb 27 14:18 ch_1<br>
&gt; &gt;&gt;&gt; -rwxrwxrwx =A0 =A01 0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A00 Feb 27 14:18 channel0_0<br>
&gt; &gt;&gt;&gt; -rwxrwxrwx =A0 =A01 0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A00 Feb 27 14:18 channel0_1<br>
&gt; &gt;&gt;&gt; -rwxrwxrwx =A0 =A01 0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A00 Feb 27 14:18 metadata<br>
&gt; &gt;&gt;&gt;<br>
</div>&gt; &gt;&gt;&gt; *By the way:*<br>
&gt; &gt;&gt;&gt; When running the same scenario but creating the channel w=
ith *--output<br>
&gt; &gt;&gt;&gt; mmap*, still no data but the size of the first two files =
in the traces<br>
<div class=3D"im">&gt; &gt;&gt;&gt; directory are 4Kb (I didn&#39;t bother =
to investigate them as I assume it is<br>
&gt; &gt;&gt;&gt; just the header - not the traces payload).<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Another issue: at this point, listing the sessions gives:=
<br>
</div>&gt; &gt;&gt;&gt; root@android:/data/lttng/install_sysroot/bin # *./l=
ttng list s1 *<br>
<div class=3D"im">&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Tracing session s1: [inactive]<br>
&gt; &gt;&gt;&gt; =A0 =A0 Trace path: /data/lttng-traces/s1-20130227-161145=
<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; =3D=3D=3D Domain: Kernel =3D=3D=3D<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Error: No kernel consumer detected<br>
</div>&gt; &gt;&gt;&gt; 99|root@android:/data/lttng/install_sysroot/bin # *=
./lttng list -k =A0 *<br>
<div class=3D"HOEnZb"><div class=3D"h5">&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Error: Unable to list kernel events<br>
&gt; &gt;&gt;&gt; Error: Command error<br>
&gt; &gt;&gt;&gt; 1|root@android:/data/lttng/install_sysroot/bin #<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; So currently I&#39;m facing these issues:<br>
&gt; &gt;&gt;&gt; 1. Kernel events list is empty.<br>
&gt; &gt;&gt;&gt; 2. Listing the session/ kernel events after creating sess=
ion, channel,<br>
&gt; &gt;&gt;&gt; event, start, stop - results in &quot;no kernel consumer =
detected&quot;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; If you have some insights please share them with me..<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Thanks<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Amit.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; On Tue, Feb 26, 2013 at 7:35 PM, PLSTC &lt;<a href=3D"mai=
lto:b0mb00z.it@gmail.com">b0mb00z.it@gmail.com</a>&gt; wrote:<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; The modules you can&#39;t find are the same I am also=
 missing I believe; I<br>
&gt; &gt;&gt;&gt;&gt; think they are only compiled when certain kernel conf=
ig defines are met<br>
&gt; &gt;&gt;&gt;&gt; (and those might simply be unavailable under ARM).<br=
>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; As for what you pointed in your first mail, I believe=
 modprobe isn&#39;t<br>
&gt; &gt;&gt;&gt;&gt; available on ARM, did you mean that some modules were=
 not found when using<br>
&gt; &gt;&gt;&gt;&gt; insmod?<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; For the epoll_create1 problem, what kind of patch did=
 you apply to add<br>
&gt; &gt;&gt;&gt;&gt; support for the epoll_create1 function?<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; On Tue, Feb 26, 2013 at 11:29 AM, Amit Balboul &lt;<b=
r>
&gt; &gt;&gt;&gt;&gt; <a href=3D"mailto:amit.balboul@shinesec.com">amit.bal=
boul@shinesec.com</a>&gt; wrote:<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; Ok I got :<br>
&gt; &gt;&gt;&gt;&gt;&gt; lttng-kretprobes.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt; lttng-kprobes.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt; , the other two are missing.<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; ---------- Forwarded message ----------<br>
&gt; &gt;&gt;&gt;&gt;&gt; From: Amit Balboul &lt;<a href=3D"mailto:amit.bal=
boul@shinesec.com">amit.balboul@shinesec.com</a>&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; Date: Tue, Feb 26, 2013 at 5:49 PM<br>
&gt; &gt;&gt;&gt;&gt;&gt; Subject: Re: [lttng-dev] compiling LTTng for andr=
oid<br>
&gt; &gt;&gt;&gt;&gt;&gt; To: PLSTC &lt;<a href=3D"mailto:b0mb00z.it@gmail.=
com">b0mb00z.it@gmail.com</a>&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; One more thing:<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; The list of modules you gave my is not identical =
to mine:<br>
&gt; &gt;&gt;&gt;&gt;&gt; a. I pushed the modules from my machine to my fol=
der in the device<br>
&gt; &gt;&gt;&gt;&gt;&gt; (not to /system/lib) as you directed me, and insm=
oded them manually.<br>
&gt; &gt;&gt;&gt;&gt;&gt; b. I pushed the whole tree under /lib/modules/&lt=
;KERNEL_VER_BUILD&gt;/<br>
&gt; &gt;&gt;&gt;&gt;&gt; which includes the modules.* and the sub director=
ies:<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; /lib/modules/3.0.31-gd5a18e0/extra$ ll<br>
&gt; &gt;&gt;&gt;&gt;&gt; total 2464<br>
&gt; &gt;&gt;&gt;&gt;&gt; drwxr-xr-x 4 root root =A0 =A04096 Feb 26 15:58 .=
/<br>
&gt; &gt;&gt;&gt;&gt;&gt; drwxr-xr-x 3 root root =A0 =A04096 Feb 26 15:58 .=
./<br>
&gt; &gt;&gt;&gt;&gt;&gt; drwxr-xr-x 2 root root =A0 =A04096 Feb 26 15:58 l=
ib/<br>
&gt; &gt;&gt;&gt;&gt;&gt; -rw-r--r-- 1 root root =A0167184 Feb 26 15:58<br>
&gt; &gt;&gt;&gt;&gt;&gt; lttng-ring-buffer-client-discard.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt; -rw-r--r-- 1 root root =A0167206 Feb 26 15:58<br>
&gt; &gt;&gt;&gt;&gt;&gt; lttng-ring-buffer-client-mmap-discard.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt; -rw-r--r-- 1 root root =A0178586 Feb 26 15:58<br>
&gt; &gt;&gt;&gt;&gt;&gt; lttng-ring-buffer-client-mmap-overwrite.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt; -rw-r--r-- 1 root root =A0178564 Feb 26 15:58<br>
&gt; &gt;&gt;&gt;&gt;&gt; lttng-ring-buffer-client-overwrite.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt; -rw-r--r-- 1 root root =A0137179 Feb 26 15:58<br>
&gt; &gt;&gt;&gt;&gt;&gt; lttng-ring-buffer-metadata-client.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt; -rw-r--r-- 1 root root =A0137233 Feb 26 15:58<br>
&gt; &gt;&gt;&gt;&gt;&gt; lttng-ring-buffer-metadata-mmap-client.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt; -rw-r--r-- 1 root root =A0213451 Feb 26 15:58 ltt=
ng-statedump.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt; -rw-r--r-- 1 root root 1314235 Feb 26 15:58 lttng=
-tracer.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt; drwxr-xr-x 2 root root =A0 =A04096 Feb 26 15:58 p=
robes/<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; /lib/modules/3.0.31-gd5a18e0/extra/lib$ ll<br>
&gt; &gt;&gt;&gt;&gt;&gt; total 732<br>
&gt; &gt;&gt;&gt;&gt;&gt; drwxr-xr-x 2 root root =A0 4096 Feb 26 15:58 ./<b=
r>
&gt; &gt;&gt;&gt;&gt;&gt; drwxr-xr-x 4 root root =A0 4096 Feb 26 15:58 ../<=
br>
&gt; &gt;&gt;&gt;&gt;&gt; -rw-r--r-- 1 root root 738964 Feb 26 15:58 lttng-=
lib-ring-buffer.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; /lib/modules/3.0.31-gd5a18e0/extra/probes$ ll<br>
&gt; &gt;&gt;&gt;&gt;&gt; total 2872<br>
&gt; &gt;&gt;&gt;&gt;&gt; drwxr-xr-x 2 root root =A0 4096 Feb 26 15:58 ./<b=
r>
&gt; &gt;&gt;&gt;&gt;&gt; drwxr-xr-x 4 root root =A0 4096 Feb 26 15:58 ../<=
br>
&gt; &gt;&gt;&gt;&gt;&gt; -rw-r--r-- 1 root root 162872 Feb 26 15:58 lttng-=
probe-asoc.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt; -rw-r--r-- 1 root root 171049 Feb 26 15:58 lttng-=
probe-block.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt; -rw-r--r-- 1 root root =A081165 Feb 26 15:58 lttn=
g-probe-compaction.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt; -rw-r--r-- 1 root root 333215 Feb 26 15:58 lttng-=
probe-ext4.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt; -rw-r--r-- 1 root root =A080413 Feb 26 15:58 lttn=
g-probe-gpio.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt; -rw-r--r-- 1 root root =A084256 Feb 26 15:58 lttn=
g-probe-irq.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt; -rw-r--r-- 1 root root 135453 Feb 26 15:58 lttng-=
probe-jbd2.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt; -rw-r--r-- 1 root root 105399 Feb 26 15:58 lttng-=
probe-kmem.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt; -rw-r--r-- 1 root root =A076240 Feb 26 15:58 lttn=
g-probe-lttng.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt; -rw-r--r-- 1 root root =A088059 Feb 26 15:58 lttn=
g-probe-module.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt; -rw-r--r-- 1 root root 154032 Feb 26 15:58 lttng-=
probe-napi.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt; -rw-r--r-- 1 root root 142038 Feb 26 15:58 lttng-=
probe-net.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt; -rw-r--r-- 1 root root =A093564 Feb 26 15:58 lttn=
g-probe-power.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt; -rw-r--r-- 1 root root =A085530 Feb 26 15:58 lttn=
g-probe-regulator.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt; -rw-r--r-- 1 root root 138121 Feb 26 15:58 lttng-=
probe-sched.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt; -rw-r--r-- 1 root root 152909 Feb 26 15:58 lttng-=
probe-scsi.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt; -rw-r--r-- 1 root root 107491 Feb 26 15:58 lttng-=
probe-signal.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt; -rw-r--r-- 1 root root 142711 Feb 26 15:58 lttng-=
probe-skb.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt; -rw-r--r-- 1 root root 181983 Feb 26 15:58 lttng-=
probe-statedump.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt; -rw-r--r-- 1 root root 126731 Feb 26 15:58 lttng-=
probe-timer.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt; -rw-r--r-- 1 root root =A086591 Feb 26 15:58 lttn=
g-probe-workqueue.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt; -rw-r--r-- 1 root root 133886 Feb 26 15:58 lttng-=
probe-writeback.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt; -rw-r--r-- 1 root root =A030863 Feb 26 15:58 lttn=
g-types.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; Looking at the files shows I miss:<br>
&gt; &gt;&gt;&gt;&gt;&gt; lttng-kretprobes.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt; lttng-kprobes.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt; lttng-ftrace.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt; lttng-probe-kvm.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; On Tue, Feb 26, 2013 at 3:56 PM, PLSTC &lt;<a hre=
f=3D"mailto:b0mb00z.it@gmail.com">b0mb00z.it@gmail.com</a>&gt; wrote:<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; Back on the last email:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; Here&#39;s the insmod list I ended up buildin=
g; you might not have<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; compiled all those modules, depending on your=
 kernel config and on the<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; architecture used, so some might simply be ab=
sent from your output<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; directory.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; insmod /system/lib/modules/lttng-types.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; insmod /system/lib/modules/lttng-kretprobes.k=
o<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; insmod /system/lib/modules/lttng-kprobes.ko<b=
r>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; insmod /system/lib/modules/lttng-ftrace.ko<br=
>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; insmod /system/lib/modules/lttng-lib-ring-buf=
fer.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; insmod /system/lib/modules/lttng-statedump.ko=
<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; insmod /system/lib/modules/lttng-tracer.ko<br=
>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; insmod /system/lib/modules/lttng-probe-timer.=
ko<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; insmod /system/lib/modules/lttng-probe-stated=
ump.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; insmod /system/lib/modules/lttng-probe-signal=
.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; insmod /system/lib/modules/lttng-probe-sched.=
ko<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; insmod /system/lib/modules/lttng-probe-lttng.=
ko<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; insmod /system/lib/modules/lttng-probe-kvm.ko=
<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; insmod /system/lib/modules/lttng-probe-irq.ko=
<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; insmod /system/lib/modules/lttng-probe-block.=
ko<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; insmod /system/lib/modules/lttng-ring-buffer-=
metadata-mmap-client.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; insmod /system/lib/modules/lttng-ring-buffer-=
metadata-client.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; insmod /system/lib/modules/lttng-ring-buffer-=
client-overwrite.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; insmod /system/lib/modules/lttng-ring-buffer-=
client-mmap-overwrite.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; insmod /system/lib/modules/lttng-ring-buffer-=
client-mmap-discard.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; insmod /system/lib/modules/lttng-ring-buffer-=
client-discard.ko<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; We also haven&#39;t had time recently to test=
 if the kprobes/kretprobes<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; worked, but they probably do; we decided to f=
ocus a bit more on the<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; &#39;tracepoints&#39; aspect instead.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; Anyway, good luck with your exploration, and =
if you find something<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; interesting, I&#39;d love to know more about =
it!<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; -PL<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; On Tue, Feb 26, 2013 at 8:06 AM, PLSTC &lt;<a=
 href=3D"mailto:b0mb00z.it@gmail.com">b0mb00z.it@gmail.com</a>&gt; wrote:<b=
r>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; Hey Amit,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; Good news indeed it seems!<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; When it comes to pushing the libs/bin, we=
 haven&#39;t found any better<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; way than using adb push yet; of course, i=
f all the projects were included<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; directly in Android&#39;s external, we wo=
uld simply flash the device after each<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; build, but currently we&#39;re still havi=
ng trouble generating the correct<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; Android makefiles.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; As for the modules, I might still have a =
dep load list somewhere I<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; could send you in a few hours, I remember=
 fighting to get the order right...<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; Also, once everything loads, could you te=
ll me what kind of output<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; &#39;lttng list -k&#39; provides you? Her=
e, we&#39;re having trouble listing the<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; &#39;default&#39; kernel trace points pro=
vided by HAVE_TRACEPOINTS, and the<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; returned list is simply empty (which is a=
 bit strange).<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; -PL<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;<br>
<br>
</div></div><div class=3D"HOEnZb"><div class=3D"h5">&gt; __________________=
_____________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev=
</a><br>
<br>
<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">--<br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a><br>
</font></span></blockquote></div><br></div>

--047d7b5db0c276d1b504d819aa51--


--===============1865938290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1865938290==--
