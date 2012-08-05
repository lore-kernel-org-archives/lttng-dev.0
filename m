From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: ERROR: No buffer space available
Date: Sun, 5 Aug 2012 13:03:10 -0400
Message-ID: <20120805170310.GA22267__40298.9252158024$1344186221$gmane$org@Krystal>
References: <CABy43G8ANPh0ZM_3y5hHAQdsDYjt+UbZMsdJDeZxFHWRizXngQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Sy4ER-0002VO-AU
	for lttng-dev@lists.lttng.org; Sun, 05 Aug 2012 13:03:11 -0400
Content-Disposition: inline
In-Reply-To: <CABy43G8ANPh0ZM_3y5hHAQdsDYjt+UbZMsdJDeZxFHWRizXngQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Rui Han <r.han@umiami.edu>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Rui Han (r.han@umiami.edu) wrote:
> Hi,
> 
> I try to modified the lttng2.0 source code for my research. For example, I
> try to log the "comm" for the write system call, I add the following filed
> in the file x86-64-syscalls-3.0.4_pointers.h located at the path
> lttng-modules-2.0.3/instrumentation/syscalls/headers. I modify the
> TRACE_EVENTS() macro from the original one:
> 
> #ifndef OVERRIDE_64_sys_write
> SC_TRACE_EVENT(sys_write,
> TP_PROTO(unsigned int fd, const char * buf, size_t count),
> TP_ARGS(fd, buf, count),
> TP_STRUCT__entry(__field(unsigned int, fd) __field_hex(const char *, buf)
> __field(size_t, count)),
> TP_fast_assign(tp_assign(fd, fd) tp_assign(buf, buf) tp_assign(count,
> count)),
> TP_printk()
> )
> #endif
> 
> to the following one:
> 
> #ifndef OVERRIDE_64_sys_write
> SC_TRACE_EVENT(sys_write,
> TP_PROTO(unsigned int fd, const char * buf, size_t count, struct
> task_struct *p),
> TP_ARGS(fd, buf, count, p),
> TP_STRUCT__entry( __field(unsigned int, fd) __field_hex(const char *,
> buf) __field(size_t,
> count) __array_text(char, comm, TASK_COMM_LEN)),
> TP_fast_assign( tp_assign(fd, fd) tp_assign(buf, buf) tp_assign(count,
> 2064) tp_memcpy(comm,
> p->comm, TASK_COMM_LEN)),
> TP_printk()
> )
> #endif
> 
> I add one argument *p and one filed "comm"  for the macro. It was able to
> be compiled, however, after reload the lttng modules, It will show the
> following error messages when I start lttng.
> 
> PERROR: ioctl start session: No buffer space available [in
> kernel_start_session() at kernel.c:397]
> Error: Starting kernel trace failed

I don't see how modifying the system call tracing macro would trigger
this error at start. Try restarting lttng-sessiond. Try unloading the
lttng modules, and, maybe, as last resort, rebooting your system.

Thanks,

Mathieu

> 
> It won't work. Please help me out with this. My next step is try to add
> extra fields in the sys_connect macros to enable the logging of the
> connected IP/port from the socket. Is this method right? what are other
> possible solutions in order to logging the details of the socket
> information?
> 
> Thank you very much.
> 
> Regards,
> Rui

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
