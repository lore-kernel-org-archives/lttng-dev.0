From: Jan Glauber <jan.glauber@gmail.com>
Subject: Re: [PATCH lttng-modules] Fix: Building the event list
 fails on fragmented memory
Date: Thu, 25 Jun 2015 15:50:58 +0200
Message-ID: <20150625135056.GB25618__5690.31546260721$1435240325$gmane$org@hal>
References: <55755E0D.7010902@leisener.de>
 <1586680029.1815.1434223948187.JavaMail.zimbra@efficios.com>
 <20150623134638.GA3944@hal>
 <1503217107.1784.1435088815111.JavaMail.zimbra@efficios.com>
 <1501535608.1867.1435090872005.JavaMail.zimbra@efficios.com>
 <600744376.2021.1435093458623.JavaMail.zimbra@efficios.com>
 <20150625080829.GA25618@hal>
 <2113931734.2873.1435237252759.JavaMail.zimbra@efficios.com>
 <165181671.2917.1435239449159.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jan.glauber@gmail.com>) id 1Z87Yb-0003Rl-CQ
 for lttng-dev@lists.lttng.org; Thu, 25 Jun 2015 09:51:15 -0400
Received: by wiwl6 with SMTP id l6so18730701wiw.0
 for <lttng-dev@lists.lttng.org>; Thu, 25 Jun 2015 06:51:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <165181671.2917.1435239449159.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

On Thu, Jun 25, 2015 at 01:37:29PM +0000, Mathieu Desnoyers wrote:
> ----- On Jun 25, 2015, at 9:00 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:
> 
> > ----- On Jun 25, 2015, at 4:08 AM, Jan Glauber jan.glauber@gmail.com wrote:
> > 
> >> On Tue, Jun 23, 2015 at 09:04:18PM +0000, Mathieu Desnoyers wrote:
> >>> Nope, it wasn't it. metadata_written is always <= cache_alloc, so the
> >>> current upstream code looks correct.
> >>> 
> >>> I've just tried after changing the CPU configuration from "hypervisor
> >>> default" to "copy host cpu config" on my machine, and was then unable
> >>> to reproduce. I wonder if there is not an issue with __memcpy implementation
> >>> for specific x86_64 processors (e.g. reading too many bytes from the vmalloc'd
> >>> area).
> >>> 
> >>> Thoughts ?
> >> 
> >> Just speculation without further debugging data from the hypervisor setup
> >> where it fails...
> >> 
> >> From my understanding memcpy should work regardless of kmalloc or
> >> vmalloc.
> >> 
> >> Maybe the length parameter of the memcpy is wrong?
> >> With kmalloc and the 1:1 mapping this wont matter but if the memcpy
> >> crosses a page it might fault if the next page is not vmalloc'ed.
> >> 
> >> But the fault address ffffc900038d995e looks more like src is completely
> >> messed up.
> >> 
> >> What is the difference between the CPU configurations you tried?
> > 
> > Actually, I just narrowed it down to a missing mutex around the metadata
> > cache accesses. The updater can reallocate the memory, and the reader
> > (which outputs from the cache to a ring buffer) assumes that it does not
> > have to lock the metadata cache because it only reads its content.
> > Unfortunately, this does not take into account that the memory backing
> > the cache can be reallocated.
> > 
> > I'll prepare a fix.

Nice catch!

--Jan
