From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] lttng-abi.c: fix the error check
Date: Sat, 23 Mar 2013 12:03:34 -0400
Message-ID: <20130323160334.GB28816__31532.7651951977$1364054667$gmane$org@Krystal>
References: <20130322215745.GB18746@Krystal> <maxin.john@enea.com>
	<20130323143435.GA55460@sestofb10.enea.se>
	<20130323154658.GA28816@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UJQut-0002RO-TV
	for lttng-dev@lists.lttng.org; Sat, 23 Mar 2013 12:03:36 -0400
Content-Disposition: inline
In-Reply-To: <20130323154658.GA28816@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Maxin B. John" <maxin.john@enea.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
> * Maxin B. John (maxin.john@enea.com) wrote:
> > I was trying to fix a random problem happened in hawkboard with 
> > 3.9.0-rc3 kernel.
> >  
> > root@hawkboard:~# uname -a
> > Linux hawkboard 3.9.0-rc3-00244-g9217cbb #35 PREEMPT Fri Mar 22
> > 18:03:26 CET 2013 armv5tejl GNU/Linux
> >  
> > root@hawkboard:~# lttng create mysession
> > Session mysession created.
> > Traces will be written in
> > /home/root/lttng-traces/mysession-20130321-131130
> > root@hawkboard:~# lttng enable-event -a -k
> > lttng-sessiond: page allocation failure: order:10, mode:0x10c0d0
> > [<c001358c>] (unwind_backtrace+0x0/0xfc) from [<c037af14>]
> > (dump_stack+0x20/0x24)
> > [<c037af14>] (dump_stack+0x20/0x24) from [<c00b7de8>]
> > (warn_alloc_failed+0xd0/0x114)
> > [<c00b7de8>] (warn_alloc_failed+0xd0/0x114) from [<c00bad80>]
> > (__alloc_pages_nodemask+0x620/0x8bc)
> > [<c00bad80>] (__alloc_pages_nodemask+0x620/0x8bc) from [<c00bb03c>]
> > (__get_free_pages+0x20/0x5c)
> > [<c00bb03c>] (__get_free_pages+0x20/0x5c) from [<c00e9e50>]
> > (kmalloc_order_trace+0x34/0xf4)
> > [<c00e9e50>] (kmalloc_order_trace+0x34/0xf4) from [<bf09affc>]
> > (lttng_syscalls_register+0x1a4/0x244 [lttng_tracer])
> > [<bf09affc>] (lttng_syscalls_register+0x1a4/0x244 [lttng_tracer]) from
> 
> Oh! got it.
> 
> if we look at:
> 
> int lttng_syscalls_register(struct lttng_channel *chan, void *filter)
> 
>                 /* create syscall table mapping syscall to events */
>                 chan->sc_table = kzalloc(sizeof(struct lttng_event *)
>                                         * ARRAY_SIZE(sc_table), GFP_KERNEL);
> 
> we notice that if sc_table is huge (e.g. because some system call
> numbers would be really, really high), then we could possibly run out of
> memory when doing this allocation.
> 
> What is the range of system call numbers on your architecture ?

a look at:

arch/arm/include/uapi/asm/unistd.h

shows:

#define __NR_OABI_SYSCALL_BASE  0x900000

#if defined(__thumb__) || defined(__ARM_EABI__)
#define __NR_SYSCALL_BASE       0
#else
#define __NR_SYSCALL_BASE       __NR_OABI_SYSCALL_BASE
#endif

So this offset "base" might be causing the large allocation. Can you try
the following patch and see if it helps ?

---
diff --git a/lttng-syscalls.c b/lttng-syscalls.c
index 62ed24a..10449b9 100644
--- a/lttng-syscalls.c
+++ b/lttng-syscalls.c
@@ -35,6 +35,10 @@
 # endif
 #endif
 
+#ifndef __NR_SYSCALL_BASE
+#define __NR_SYSCALL_BASE	0
+#endif
+
 static
 void syscall_entry_probe(void *__data, struct pt_regs *regs, long id);
 
@@ -133,7 +137,7 @@ struct trace_syscall_entry {
 
 #undef TRACE_SYSCALL_TABLE
 #define TRACE_SYSCALL_TABLE(_template, _name, _nr, _nrargs)	\
-	[ _nr ] = {						\
+	[ (_nr) - __NR_SYSCALL_BASE ] = {			\
 		.func = __event_probe__##_template,		\
 		.nrargs = (_nrargs),				\
 		.fields = __event_fields___##_template,		\
@@ -147,7 +151,7 @@ static const struct trace_syscall_entry sc_table[] = {
 
 #undef TRACE_SYSCALL_TABLE
 #define TRACE_SYSCALL_TABLE(_template, _name, _nr, _nrargs)	\
-	[ _nr ] = {						\
+	[ (_nr) - __NR_SYSCALL_BASE] = {			\
 		.func = __event_probe__##compat_##_template,	\
 		.nrargs = (_nrargs),				\
 		.fields = __event_fields___##compat_##_template,\
@@ -180,7 +184,9 @@ void syscall_entry_probe(void *__data, struct pt_regs *regs, long id)
 	struct lttng_event *event, *unknown_event;
 	const struct trace_syscall_entry *table, *entry;
 	size_t table_len;
+	long syscall_offset;
 
+	syscall_offset = id - __NR_SYSCALL_BASE;
 	if (unlikely(is_compat_task())) {
 		table = compat_sc_table;
 		table_len = ARRAY_SIZE(compat_sc_table);
@@ -190,19 +196,19 @@ void syscall_entry_probe(void *__data, struct pt_regs *regs, long id)
 		table_len = ARRAY_SIZE(sc_table);
 		unknown_event = chan->sc_unknown;
 	}
-	if (unlikely(id >= table_len)) {
-		syscall_entry_unknown(unknown_event, regs, id);
+	if (unlikely(syscall_offset >= table_len)) {
+		syscall_entry_unknown(unknown_event, regs, syscall_offset);
 		return;
 	}
 	if (unlikely(is_compat_task()))
-		event = chan->compat_sc_table[id];
+		event = chan->compat_sc_table[syscall_offset];
 	else
-		event = chan->sc_table[id];
+		event = chan->sc_table[syscall_offset];
 	if (unlikely(!event)) {
-		syscall_entry_unknown(unknown_event, regs, id);
+		syscall_entry_unknown(unknown_event, regs, syscall_offset);
 		return;
 	}
-	entry = &table[id];
+	entry = &table[syscall_offset];
 	WARN_ON_ONCE(!entry);
 
 	switch (entry->nrargs) {


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
