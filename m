From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: Re: [RFC PATCH lttng-ust] Implement register_done
 waiting via LD_AUDIT
Date: Wed, 2 Jul 2014 09:42:49 +0200
Message-ID: <53B3B7F9.6050505__42278.7635623992$1404287037$gmane$org@mentor.com>
References: <1404226029-9092-1-git-send-email-paul_woegerer@mentor.com>
 <alpine.LNX.2.00.1407011902580.15415@monopod.intra.ispras.ru>
 <53B2DDDB.3090102@mentor.com>
 <alpine.LNX.2.00.1407012102010.15415@monopod.intra.ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Paul_Woegerer@mentor.com>) id 1X2FC6-0003Bb-3f
 for lttng-dev@lists.lttng.org; Wed, 02 Jul 2014 03:43:10 -0400
In-Reply-To: <alpine.LNX.2.00.1407012102010.15415@monopod.intra.ispras.ru>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexander Monakov <amonakov@ispras.ru>, mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 07/01/2014 07:14 PM, Alexander Monakov wrote:
> On Tue, 1 Jul 2014, Woegerer, Paul wrote:
>> Unfortunately the current approach of delaying execution of main until
>> lttng-ust is available has several drawbacks. E.g. the dynamic linker
>> lock is taken during the execution the static ctor. Using glibc
>> functions that also require the same lock as part of the lttng-ust
>> initialization easily gets us into a deadlock situation.
> 
> That's surprising; in my experience dlopen/dlsym from a static DSO ctor work,
> so I wonder what functions are causing a deadlock for you.

Base address state tracing, see liblttng-ust/lttng-ust-baddr.c:189

       dl_iterate_phdr(extract_soinfo_events, &data);

>> This patch is trying to delay execution of main with a different
>> technique (using a named semaphore in la_preinit to wait for lttng-ust
>> initialization).
> 
> Frankly I don't think LD_AUDIT is the right tool for the job in this case,
> even ignoring its flakiness in glibc; better to fix your current approach if
> possible.

This is just an RFC. I'm not saying it should be merged as it is. I just
want to discuss the situation so that we find a better solution.

The current approach is to delay the execution of the application by
putting a sem_wait into the static ctor of lttng-ust (lttng_ust_init).

If you gave a better idea how to make the application wait on the
initialization of lttng-ust (handle_register_done) that does not prevent
the static ctor from completing please share it with me.

>> Having a stable LD_AUDIT interface would be extremely valuable in the
>> context of tracing.
> 
> Oh, but the interface is extremely stable, it was unchanging for a long time
> now; it's just the implementation... ;)  (sorry, could not resist)

Being cynic won't help us either. I just saw your comments on
https://sourceware.org/bugzilla/show_bug.cgi?id=15533
It's a shame that your patch is not in mainline.

> Also note that LD_AUDIT on Linux is glibc-specific, not available on other
> libcs that are otherwise quite useful, such as Bionic.

That's a problem. I agree.


--
Thanks for your comments,
Paul


-- 
Paul Woegerer, SW Development Engineer
Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
Mentor Graphics, Embedded Software Division
