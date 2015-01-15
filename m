From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Segfault at v_read() called from
 lib_ring_buffer_try_reserve_slow() in LTTng-UST traced app - CPU/VMware
 dependent
Date: Thu, 15 Jan 2015 02:50:46 +0000 (UTC)
Message-ID: <214724236.41002.1421290246531.JavaMail.zimbra__17053.5870748155$1421290289$gmane$org@efficios.com>
References: <20998D40D9A2B7499CA5A3A2666CB1EB2D9DDA59@ZURMSG1.QUANTUM.com>
 <1745838195.26177.1418312190246.JavaMail.zimbra@efficios.com>
 <20998D40D9A2B7499CA5A3A2666CB1EB2D9E464C@ZURMSG1.QUANTUM.com>
 <1205251820.37907.1421076877053.JavaMail.zimbra@efficios.com>
 <1686087516.37913.1421076968595.JavaMail.zimbra@efficios.com>
 <20998D40D9A2B7499CA5A3A2666CB1EB2D9E72E6@ZURMSG1.QUANTUM.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YBaWG-0004nu-7c
 for lttng-dev@lists.lttng.org; Wed, 14 Jan 2015 21:50:52 -0500
In-Reply-To: <20998D40D9A2B7499CA5A3A2666CB1EB2D9E72E6@ZURMSG1.QUANTUM.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David OShea <David.OShea@quantum.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "David OShea" <David.OShea@quantum.com>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: "lttng-dev" <lttng-dev@lists.lttng.org>
> Sent: Wednesday, January 14, 2015 9:45:01 PM
> Subject: RE: [lttng-dev] Segfault at v_read() called from lib_ring_buffer_try_reserve_slow() in LTTng-UST traced app
> - CPU/VMware dependent
> 
> Hi Mathieu,
> 
> > -----Original Message-----
> > From: Mathieu Desnoyers [mailto:mathieu.desnoyers@efficios.com]
> > Sent: Tuesday, 13 January 2015 2:06 AM
> > To: David OShea
> > Cc: lttng-dev
> > Subject: Re: [lttng-dev] Segfault at v_read() called from
> > lib_ring_buffer_try_reserve_slow() in LTTng-UST traced app - CPU/VMware
> > dependent
> [...]
> > > > Is it possible that this is an issue in LTTng, or should I work out
> > how the
> > > > kernel works out which CPU it is running on and then look into
> > whether
> > > > there
> > > > are any VMware bugs in this area?
> > >
> > > This appears to be very likely a VMware bug. /proc/cpuinfo should
> > show
> > > 4 CPUs (and sysconf(_SC_NPROCESSORS_CONF) should return 4) if the
> > current
> > > CPU number can be 0, 1, 2, 3 throughout execution.
> 
> /proc/cpuinfo shows two CPUs:
> 
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 26
> model name      : Intel(R) Xeon(R) CPU           X7550  @ 2.00GHz
> stepping        : 4
> microcode       : 8
> cpu MHz         : 1995.000
> cache size      : 18432 KB
> physical id     : 0
> siblings        : 1
> core id         : 0
> cpu cores       : 1
> apicid          : 0
> initial apicid  : 0
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 11
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss syscall nx rdtscp lm
> constant_tsc arch_perfmon pebs bts xtopology tsc_reliable nonstop_tsc
> aperfmperf unfair_spinlock pni ssse3 cx16 sse4_1 sse4_2 popcnt hypervisor
> lahf_lm ida dts
> bogomips        : 3990.00
> clflush size    : 64
> cache_alignment : 64
> address sizes   : 40 bits physical, 48 bits virtual
> power management:
> 
> processor       : 1
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 26
> model name      : Intel(R) Xeon(R) CPU           X7550  @ 2.00GHz
> stepping        : 4
> microcode       : 8
> cpu MHz         : 1995.000
> cache size      : 18432 KB
> physical id     : 2
> siblings        : 1
> core id         : 0
> cpu cores       : 1
> apicid          : 2
> initial apicid  : 2
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 11
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss syscall nx rdtscp lm
> constant_tsc arch_perfmon pebs bts xtopology tsc_reliable nonstop_tsc
> aperfmperf unfair_spinlock pni ssse3 cx16 sse4_1 sse4_2 popcnt hypervisor
> lahf_lm ida dts
> bogomips        : 3990.00
> clflush size    : 64
> cache_alignment : 64
> address sizes   : 40 bits physical, 48 bits virtual
> power management:
> 
> > You might want to look at the sysconf(3) manpage, especially the parts
> > about
> > _SC_NPROCESSORS_CONF and _SC_NPROCESSORS_ONLN. My guess is that vmware
> > is lying
> > about the number of "possible" CPUs (_SC_NPROCESSORS_CONF).
> 
> _SC_NPROCESSORS_CONF = 2
> _SC_NPROCESSORS_ONLN = 2
> 
> Thanks for the pointers, I will look into possible VMware bugs.
> 
> Out of curiosity, what happens if I happened to have a system with
> hot-pluggable CPUs - does _SC_NPROCESSORS_CONF reflect the maximum number of
> CPUs I can insert, and that is how many LTTng will support?

Yes, exactly.

Thanks,

Mathieu

> 
> Thanks,
> David
> 
> ----------------------------------------------------------------------
> The information contained in this transmission may be confidential. Any
> disclosure, copying, or further distribution of confidential information is
> not permitted unless such privilege is explicitly granted in writing by
> Quantum. Quantum reserves the right to have electronic communications,
> including email and attachments, sent across its networks filtered through
> anti virus and spam software programs and retain such messages in order to
> comply with applicable data security and retention requirements. Quantum is
> not responsible for the proper and complete transmission of the substance of
> this communication or for any delay in its receipt.
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
