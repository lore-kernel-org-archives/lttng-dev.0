From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: System Hang
Date: Tue, 8 Jan 2013 11:36:03 -0500
Message-ID: <20130108163603.GA19358__39877.740541897$1357663026$gmane$org@Krystal>
References: <CAGRd_950e3k=8tK_PFTDrkrPADq0qminAu+7_odUh9r-koJ6ug@mail.gmail.com>
	<20130107191602.GA1342@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Tsc9l-0003pp-SQ
	for lttng-dev@lists.lttng.org; Tue, 08 Jan 2013 11:36:06 -0500
Content-Disposition: inline
In-Reply-To: <20130107191602.GA1342@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Phil Wilshire <sysdcs@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
> * Phil Wilshire (sysdcs@gmail.com) wrote:
> > Hi,
> > Just getting back into lttng after quite a few years
> > I need to set up a continuous trace on a system.
> > 
> > Every 10 seconds I stop one session and start another to give me individual
> > files for each 10 second segment.
> > I originally intended to start the next session before stopping the
> > previous but that was causing the sessond to hang.
> > 
> > Ever so often I can start the trace and the trace file is generated but
> > ongoing commands to lttng are ignored. The new trace file then grows until
> > all the disk space is used. sessiond seems to be hung
> > 
> > 
> > I have the kernel dmseg log attached and I also have the trace file if
> > needed
> > 
> > 
> >  [  345.223564] LTT state dump thread start
> > [  345.231033] LTT state dump end
> > [  353.586011] ring buffer relay-metadata: 3604 records written, 0 records
> > overrun
> > [  353.590023] ring buffer relay-discard, cpu 0: 408474 records written, 0
> > records overrun
> > [  353.590237] ring buffer relay-discard, cpu 1: 390793 records written, 0
> > records overrun
> > [  353.590237] ring buffer relay-discard, cpu 2: 363560 records written, 0
> > records overrun
> > [  353.590685] ring buffer relay-discard, cpu 3: 518867 records written, 0
> > records overrun
> > [  355.720753] LTTng: state dump begin
> > [  355.720753] LTT state dump thread start
> > [  355.732034] LTT state dump end
> > [  364.111388] ring buffer relay-metadata: 3604 records written, 0 records
> > overrun
> > [  364.120334] ring buffer relay-discard, cpu 0: 409693 records written, 0
> > records overrun
> > [  364.120334] ring buffer relay-discard, cpu 1: 401971 records written, 0
> > records overrun
> > [  364.121438] ring buffer relay-discard, cpu 2: 380074 records written, 0
> > records overrun
> > [  364.122187] ring buffer relay-discard, cpu 3: 524538 records written, 0
> > records overrun
> > [  366.259690] LTTng: state dump begin
> > [  366.259690] LTT state dump thread start
> > [  366.266253] LTT state dump end
> > [  374.633764] ring buffer relay-metadata: 3604 records written, 0 records
> > overrun
> > [  374.640024] ring buffer relay-discard, cpu 0: 430919 records written, 0
> > records overrun
> > [  374.640024] ring buffer relay-discard, cpu 1: 387021 records written, 0
> > records overrun
> > [  374.641033] ring buffer relay-discard, cpu 2: 370007 records written, 0
> > records overrun
> > [  374.641033] ring buffer relay-discard, cpu 3: 528606 records written, 0
> > records overrun
> > [  376.795384] LTTng: state dump begin
> > [  376.795384] LTT state dump thread start
> > [  601.060274] INFO: task lttng-sessiond:2885 blocked for more than 120
> > seconds.
> > [  601.069038] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> > this message.
> > [  601.077626] lttng-sessiond  D ffff880074456b18     0  2885      1
> > 0x10000000
> > [  601.085210]  ffff88006c0679f8 0000000000000082 0000000000000001
> > ffff88007b0a4140
> > [  601.094031]  ffff88006c0679a8 ffff880074456840 ffff88006c067fd8
> > ffff88006c067fd8
> > [  601.105026]  0000000000011c80 ffff880074456840 0000000000000000
> > ffff88006c067a68
> > [  601.112170] Call Trace:
> > [  601.116027]  [<ffffffff812dd423>] schedule+0x5b/0x5d
> 
> Hrm, the kernel seems to be stuck in the statedump. We added new stuff
> there in LTTng-modules 2.1, so there is probably something fishy.
> 
> This backtrace only tells us that the statedump is waiting for
> do_lttng_statedump to complete.
> 
> I would really like to see the backtrace of all tasks in your system at
> that point (SysRQ t). For more info, see Documentation/sysrq.txt from
> your Linux kernel sources. Also the dump of sysrq-l (all active cpus)
> would be useful. Also sysrq-d (all locks held) might help.


I've been able to reproduce the issue on my setup. More to come soon.

Thanks,

Mathieu

> 
> More below,
> 
> > [  601.121025]  [<ffffffffa01b46cb>] lttng_statedump_start+0x5aa/0x623
> > [lttng_statedump]
> > [  601.129035]  [<ffffffff810543c7>] ? abort_exclusive_wait+0x8f/0x8f
> > [  601.136030]  [<ffffffffa01c03bb>] lttng_session_enable+0x52d/0x55b
> > [lttng_tracer]
> > [  601.144034]  [<ffffffff810543c7>] ? abort_exclusive_wait+0x8f/0x8f
> > [  601.150039]  [<ffffffffa01c0de8>] lttng_session_ioctl+0x15f/0x225
> > [lttng_tracer]
> > [  601.158042]  [<ffffffff8123a1c3>] ? sock_recvmsg+0xa4/0xb9
> > [  601.163185]  [<ffffffff810f37b7>] ? lookup_page_cgroup+0x36/0x4d
> > [  601.169453]  [<ffffffff81186cf9>] ? cpumask_any_but+0x29/0x38
> > [  601.175508]  [<ffffffff8109984b>] ? trace_preempt_on+0x12/0x2f
> > [  601.182031]  [<ffffffff812e15eb>] ? sub_preempt_count+0x97/0xc0
> > [  601.187735]  [<ffffffff812de9a1>] ? _raw_spin_unlock+0x2a/0x35
> > [  601.193922]  [<ffffffff810c9767>] ? spin_unlock+0xe/0x10
> > [  601.200027]  [<ffffffff810caa44>] ? do_wp_page+0x26f/0x563
> > [  601.206028]  [<ffffffff8109987a>] ? trace_preempt_off+0x12/0x30
> > [  601.212031]  [<ffffffff812e16c8>] ? add_preempt_count+0xb4/0xcf
> > [  601.218043]  [<ffffffff810cc320>] ? handle_pte_fault+0x6c6/0x76c
> > [  601.223737]  [<ffffffff812443a7>] ? verify_iovec+0x52/0xa3
> > [  601.229426]  [<ffffffff810cc6cc>] ? handle_mm_fault+0x199/0x1a9
> > [  601.236033]  [<ffffffff812e14d3>] ? do_page_fault+0x2f6/0x377
> > [  601.242034]  [<ffffffffa01c4f8d>] ?
> > __event_probe__sys_mprotect+0xf5/0xf5 [lttng_tracer]
> > [  601.251031]  [<ffffffff8110332a>] vfs_ioctl+0x22/0x3a
> > [  601.256029]  [<ffffffff81103bb7>] do_vfs_ioctl+0x3c4/0x407
> > [  601.261188]  [<ffffffff810f6e8e>] ? fget_light+0x91/0x9d
> > [  601.267026]  [<ffffffff81103c41>] sys_ioctl+0x47/0x6a
> > [  601.272050]  [<ffffffff812e377f>] tracesys+0xd9/0xde
> > 
> > 
> > cat /proc/cpuinfo
> > 
> > processor : 0
> > vendor_id : GenuineIntel
> > cpu family : 6
> > model : 28
> > model name : Intel(R) Atom(TM) CPU D525   @ 1.80GHz
> > stepping : 10
> > microcode : 0x107
> > cpu MHz : 1799.823
> > cache size : 512 KB
> > physical id : 0
> > siblings : 4
> > core id : 0
> > cpu cores : 2
> > apicid : 0
> > initial apicid : 0
> > fpu : yes
> > fpu_exception : yes
> > cpuid level : 10
> > wp : yes
> > flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat
> > pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx lm
> > constant_tsc arch_perfmon pebs bts rep_good nopl aperfmperf pni dtes64
> > monitor ds_cpl tm2 ssse3 cx16 xtpr pdcm movbe lahf_lm dts
> > bogomips : 1775.61
> > clflush size : 64
> > cache_alignment : 64
> > address sizes : 36 bits physical, 48 bits virtual
> > power management:
> > 
> > (repeated for 3 other cpus )
> > 
> >  uname -a
> > Linux  3.2.21-x510v1 #1 SMP PREEMPT Thu Dec 20 11:24:36 EST 2012 x86_64
> > GNU/Linux
> > 
> > Script used to run trace
> > =================================================
> > #!/bin/sh
> > 
> > xx=`/bin/date +"%s"`
> > yy="yy"
> > zz="zz"
> > log_xx=/home/pswuser/trace/log/psw-${xx}.log
> > log_yy=/home/pswuser/trace/log/psw-${yy}.log
> > log_zz=/home/pswuser/trace/log/psw-${zz}.log
> > #depmod
> > mkdir -p /home/pswuser/trace
> > mount -t tmpfs -o size=500M tmpfs /home/pswuser/trace
> > mkdir -p /home/pswuser/trace/log
> > touch /home/pswuser/trace/run_trace
> > sleep 20
> > if [ -f /home/pswuser/trace/run_trace ] ; then
> > 
> >    echo "lttng create" > ${log_xx}
> >    lttng create psw-${xx} \
> >       -o /home/pswuser/trace/psw-${xx} >> ${log_xx} 2>&1
> >    echo "lttng enable-event" >> ${log_xx}
> >    sleep 1
> >    lttng enable-event -a -k  -s psw-${xx} >> ${log_xx} 2>&1
> >    sleep 1
> >    echo "lttng start" >> ${log_xx}
> >    lttng start psw-${xx} >> ${log_xx} 2>&1
> >    sleep 1
> > 
> > fi
> > 
> > while [ 1 -gt 0 ] ; do
> >    sleep 7
> >    yy=`/bin/date +"%s"`
> >    log_yy=/home/pswuser/trace/log/psw-${yy}.log
> > 
> > 
> > #stop xx
> >    if [ -d /home/pswuser/trace/psw-${xx} ] ; then
> >       echo "lttng stop" >> ${log_xx}
> >       lttng stop psw-${xx} >> ${log_xx} 2>&1
> >       sleep 1
> >       echo "lttng destroy" >> ${log_xx}
> >       lttng destroy psw-${xx} >> ${log_xx} 2>&1
> >       echo "lttng done" >> ${log_xx}
> >    fi
> > 
> > # start yy after stopping xx
> >    if [ -f /home/pswuser/trace/run_trace ] ; then
> >       echo "lttng create ${yy} after closing ${xx}" > ${log_yy}
> >       lttng create psw-${yy} \
> >          -o /home/pswuser/trace/psw-${yy} >> ${log_yy} 2>&1
> >       sleep 1
> >       echo "lttng enable_event" >> ${log_yy}
> >       lttng enable-event -a -k -s psw-${yy} >> ${log_yy} 2>&1
> >       sleep 1
> >       echo "lttng start" >> ${log_yy}
> >       lttng start psw-${yy} >> ${log_yy} 2>&1
> >    fi
> > # check zz
> > # delete unless detected or detected2 is present
> >    if [ ! -f /home/pswuser/bin/delay-detected ] &&
> >       [ ! -f /home/pswuser/bin/delay-detected2 ] ; then
> >       echo "lttng delete files" >> ${log_zz}
> >      rm -rf /home/pswuser/trace/psw-${zz}* >> ${log_zz} 2>&1
> >      #if [ $? -eq 0 ] ; then rm ${log_zz} ; fi
> >    fi
> > # delete second snapshot
> >    if [ -f /home/pswuser/bin/delay-detected2 ] ; then
> >      rm -f /home/pswuser/bin/delay-detected2
> > 
> > # no more tracing once event detected
> >      rm -f /home/pswuser/trace/run_trace
> >    fi
> > # trigger second snapshot delete first snapshot
> >    if [ -f /home/pswuser/bin/delay-detected ] ; then
> >      rm -f /home/pswuser/bin/delay-detected
> >      touch /home/pswuser/bin/delay-detected2
> >    fi
> > 
> > #   ls -l /lttng-traces/psw-*
> >    # zz (delete candidate) is old xx
> >    echo "xx ${xx} yy ${yy} zz ${zz}"
> >    zz=${xx}
> >    log_zz=$log_xx
> > 
> >   # xx is now the new one
> >    xx=${yy}
> >    log_xx=$log_yy
> > 
> > # check disk use
> >    if [ -d /home/pswuser/trace ] ; then
> >      du -h /home/pswuser/trace
> >    fi
> > 
> > 
> > done
> > ----------------------------------------
> > 
> > Any clues are welcome.
> > 
> > Another question.
> > 
> > Would it be possible to do this by setting up a ring buffer that will wrap
> > around after a certain time. I can easily timestamp the event I am looking
> > for and then capture the buffer containing the event.
> 
> Stay tuned for 2013 lttng releases. This will likely be implemented this
> year (flight recorder and snapshots).
> 
> Thanks,
> 
> Mathieu
> 
> > 
> > 
> > Regards
> >    Phil Wilshire
> 
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
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
