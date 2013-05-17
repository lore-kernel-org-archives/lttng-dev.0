From: =?ISO-8859-1?Q?St=E9phane_ANCELOT?= <sancelot@free.fr>
Subject: newbie and kernel trace
Date: Fri, 17 May 2013 16:58:58 +0200
Message-ID: <519645B2.5090709__33337.8066462048$1368802783$gmane$org@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp1-g21.free.fr ([212.27.42.1])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <sancelot@free.fr>) id 1UdM7d-0003zV-A1
	for lttng-dev@lists.lttng.org; Fri, 17 May 2013 10:59:05 -0400
Received: from [192.168.1.242] (num-trut.pck.nerim.net [62.212.97.179])
	(Authenticated sender: sancelot)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 62E279400E5
	for <lttng-dev@lists.lttng.org>; Fri, 17 May 2013 16:59:00 +0200 (CEST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

I am trying to reimplement LTTNG 2. in xenomai api.

the main problem is that I do not sea any of my new events available in 
lttng 2.


my kernel compiles fine and  here is what I done to set it up :

file include/trace/events/pod.h :

#undef TRACE_SYSTEM
#define TRACE_SYSTEM xenotrace

#if !defined(_XENOTRACE_H) || defined(TRACE_HEADER_MULTI_READ)

#define _XENOTRACE_H

#include <linux/tracepoint.h>


TRACE_EVENT(    xn_nucleus_thread_init,
                 TP_PROTO(struct xnthread *thread,char 
*thread_name,xnflags_t flags,const char *class,int prio),
                 TP_ARGS(thread,thread_name,flags,class,prio),

                 TP_STRUCT__entry(
                  __field(struct xnthread *,thread)
                  __array(char ,thread_name,      XNOBJECT_NAME_LEN   )
                  __field(xnflags_t,flags)
                  __array(char,class,      XNOBJECT_NAME_LEN  )
                  __field(int,    prio                       )
                 ),

               TP_fast_assign(
                __entry->thread   = thread;
                memcpy(__entry->thread_name,thread_name, XNOBJECT_NAME_LEN);
                __entry->flags   = flags;
                memcpy(__entry->class,class, XNOBJECT_NAME_LEN);
                __entry->prio   = prio;
                 ),

                TP_printk("thread %p thread_name %s flags %lu class %s 
prio %d",
                __entry->thread, __entry->thread_name, 
__entry->flags,__entry->class,
                __entry->prio)
);

#endif

/* This part must be outside protection */
#include <trace/define_trace.h>



in pod.h :
#define CREATE_TRACE_POINTS
#include <trace/events/pod.h>
