From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: UST tracing problem on ARM/Android
Date: Sat, 24 Jan 2015 14:54:52 +0000 (UTC)
Message-ID: <2025041545.47062.1422111292883.JavaMail.zimbra__7026.14530823684$1422111343$gmane$org@efficios.com>
References: <1421273876.3881.68.camel@samsung.com>
 <1422040541.12886.146.camel@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YF26v-0007Bh-V0
 for lttng-dev@lists.lttng.org; Sat, 24 Jan 2015 09:54:56 -0500
In-Reply-To: <1422040541.12886.146.camel@samsung.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Charles Briere <c.briere@samsung.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Charles Briere" <c.briere@samsung.com>
> To: lttng-dev@lists.lttng.org
> Sent: Friday, January 23, 2015 2:15:40 PM
> Subject: Re: [lttng-dev] UST tracing problem on ARM/Android
> 
> So I just found out why this was hapenning and thought I would share my
> findings.
> 
> The Android linker will load a shared library twice in memory if it has
> a different path (even symbolic link). Therefore when
> dl_opening("lttng-ust-tracepoint.so.0", ...), even if that library is
> already loaded as it has been defined at link time, it will duplicate
> all it's symbols. The function add_calliste will populate the
> callsite_table which is local to the dl_open(ed) library while
> tracepoint_sync_callsites will try to read an unitialized one, local to
> it's own symbols.
> 
> That brings me to ask, why not passing "liblttng-ust-tracepoint.so" to
> dl_open()? What is the reason for versioning here as anyway at link
> time, liblttng-ust-tracepoint.so is the one beeing used?

Versioning would allow us to change the ABI if we really, really need
to do it in the future. Ideally we would never change it, but you
never know what the future has in store.

According to the opengroup POSIX spec:

http://pubs.opengroup.org/onlinepubs/009695399/functions/dlopen.html

"Only a single copy of an object file is brought into the address space, even if dlopen() is invoked multiple times in reference to the file, and even if different pathnames are used to reference the file."

So it appears to be a bug in Android's implementation of their libc.
You might want to report it to them.

One possible work-around we could implement in lttng-ust would be do
to a wrapper for Android dlopen (let's call it lttng_ust_dlopen_wrapper)
that first calls realpath(3) to first resolve the symlinks, and call
dlopen on the result. This wrapper could be directly built into
liblttng-ust.

Thoughts ?

Thanks,

Mathieu


> 
> Thanks,
> Charles
> 
> On Wed, 2015-01-14 at 14:17 -0800, Charles Briere wrote:
> > Hello world,
> > 
> > I've been running in some inssues lately with UST on ARM/Android. Using
> > the following to configure my session, I enable every ust event.
> > 
> > lttng create
> > lttng enable-event -ua
> > 
> > Although, when a tracepoint is called, its state ( struct
> > lttng_ust_tracepoint -> state) is 0.
> > 
> > My understanding of the whole registration process is limited, so the
> > following reasoning is probably flawed, so please correct me if that
> > happens.
> > 
> > I found out, that when registering the library
> > (tracepoint_register_lib), callsite_table is populated. But later on
> > when it comes to register the probes (lttng_prove_register),
> > callsite_table 's address is different and the list is empty. As a
> > result, when tracepoint_sync_callsite() is called, set_tracepoint() is
> > never executed as looping through an empty list.
> > 
> > What I don't understand in here, is that the callsite_table pointer is
> > not the same during the lib registration and probe registration. Both
> > are ran sequentially in the same thread and I can't figure what other
> > operation could affect the variable. Any hint/help would be much
> > appreciated.
> > 
> > Thanks,
> > Charles
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
