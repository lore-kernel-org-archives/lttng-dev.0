From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: might_sleep warnings in overwrite mode
Date: Fri, 15 Nov 2013 02:34:09 +0000 (UTC)
Message-ID: <67652521.68027.1384482849638.JavaMail.zimbra__11747.5853687667$1384482905$gmane$org@efficios.com>
References: <52803E5D.3050109@mentor.com> <52851395.3010306@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1Vh9Ea-0001D4-P5
	for lttng-dev@lists.lttng.org; Thu, 14 Nov 2013 21:34:18 -0500
In-Reply-To: <52851395.3010306@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Nathan Lynch <Nathan_Lynch@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Nathan Lynch" <Nathan_Lynch@mentor.com>
> To: lttng-dev@lists.lttng.org
> Sent: Thursday, November 14, 2013 1:16:53 PM
> Subject: Re: [lttng-dev] might_sleep warnings in overwrite mode
> 
> On 11/10/2013 08:18 PM, Nathan Lynch wrote:
> > At this point I cannot trigger the issue without overwrite mode on
> > 3.11.6, but on a 3.8-based vendor kernel I can recreate it regardless of
> > the mode.
> 
> Some updates on this:
> - It's not specific to overwrite mode; I was able to provoke it on
> 3.11.6 without --overwrite.  Overwrite mode does seem to recreate the
> issue more readily.
> - It seems to be GCC version-dependent.  4.8.1 and 4.8.2 produce code
> which warns/bugs; 4.7.3 does not.

Allright! This info is really useful. Sorry for taking time to look into this, I was busy with preparation for 2.4-rc1.

Looking at:

fs/ext3/incode.c:

__ext3_get_inode_loc()

we can see that a use of the inlined sb_getblk() appears close to a tracepoint.

The tracepoint includes preempt disable/enable, exactly those:

include/linux/preempt.h:

#define preempt_disable_notrace() \
do { \
        inc_preempt_count_notrace(); \
        barrier(); \
} while (0)

#define preempt_enable_notrace() \
do { \
        preempt_enable_no_resched_notrace(); \
        barrier(); \
        preempt_check_resched_context(); \
} while (0)


Can you try wrapping the _outside_ of those macros with barrier(), e.g.


#define preempt_disable_notrace() \
do { \
        barrier(); \
        inc_preempt_count_notrace(); \
        barrier(); \
} while (0)

#define preempt_enable_notrace() \
do { \
        preempt_enable_no_resched_notrace(); \
        barrier(); \
        preempt_check_resched_context(); \
        barrier(); \
} while (0)

and try it out with the apparently buggy compiler to see if it helps ? It does look like the preempt inc or dec is slipping out and somehow triggers the might_sleep() warning. I don't see clearly how this could happen yet, since each of the inc/dec and the test are touching preempt_count(), but it's worth a try.

Maybe on ARM the current_thread_info() macro somehow hides important info from the compiler and it mistakenly reorders inc/dec vs the test. Another thing to try out (in addition to the first one) would be to try changing current_thread_info(), e.g., by turning asm ("sp") into a volatile inline assembly, and by adding "memory" clobbers to it.

Thoughts ?

Thanks,

Mathieu


> 
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
