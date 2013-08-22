From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [LTTNG][LTTng-ust] "Out of system" building	patches.
Date: Thu, 22 Aug 2013 08:55:24 -0400
Message-ID: <20130822125523.GB26852__26753.9773638875$1377176184$gmane$org@Krystal>
References: <1377160051-12449-1-git-send-email-jimmy.durand.wesolowski@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1VCUQG-0006Tb-DK
	for lttng-dev@lists.lttng.org; Thu, 22 Aug 2013 08:55:34 -0400
Content-Disposition: inline
In-Reply-To: <1377160051-12449-1-git-send-email-jimmy.durand.wesolowski@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jimmy Durand Wesolowski <jimmy.durand.wesolowski@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Jimmy Durand Wesolowski (jimmy.durand.wesolowski@gmail.com) wrote:
> Hi,
> 
> 
> Here are some patches to allow installing LTTng-ust out of the system
> directories, ie building with "./configure --prefix", without having to set
> C/CPP/LDFLAGS at both the configure and the make building steps.

Usually, setting CPPFLAGS/CFLAGS/LDFLAGS at configure time is enough,
e.g.:

LDFLAGS=/usr/local/lib ./configure

What feature is this patchset adding that is not covered by the usual
approach ? Or what is it fixing ?

Thanks,

Mathieu

> 
> The "--with-urcu-prefix" is introduced to allow passing the userspace-rcu
> build output directory, and CFLAGS are given to the lttng-gen-tp tool
> when building '.c', '.h' and '.o' files, which requires URCU and tracepoint
> headers.
> 
> Jimmy Durand Wesolowski (2):
>   Introduce configure --with-urcu-prefix
>   Add the CFLAGS for an "out of system" building of the gen-tp example
>     files.
> 
>  configure.ac                 |   42 ++++++++++++++++++++++++++++++++++++------
>  doc/examples/Makefile.am     |    2 +-
>  doc/examples/gen-tp/Makefile |    9 ++++++---
>  3 files changed, 43 insertions(+), 10 deletions(-)
> 
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
