From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 0/3] rculfhash: error checking fixes
Date: Thu, 31 Jul 2014 21:35:00 +0000
Message-ID: <20140731213500.GA662__7647.06908162243$1406842545$gmane$org@dcvr.yhbt.net>
References: <1403572832-9066-1-git-send-email-normalperson@yhbt.net>
 <1681102864.24131.1406840905204.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from dcvr.yhbt.net ([64.71.152.64] ident=normalperson)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <normalperson@yhbt.net>) id 1XCy05-0006bP-8r
 for lttng-dev@lists.lttng.org; Thu, 31 Jul 2014 17:35:02 -0400
Content-Disposition: inline
In-Reply-To: <1681102864.24131.1406840905204.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: e@80x24.org, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> All merged, thanks! Sorry for the delay, the past month has been quite busy.

No worries.  I've been sidetracked into other projects, too.

> Eric Wong <normalperson@yhbt.net> wrote:
> > In the future, it would also be nice if the alloc_bucket_table behavior
> > could fail gracefully on ENOMEM, but that would break ABI...
> 
> We could pull this into master for an eventual 0.9 release. We already
> have a few ABI breaking changes that require us to bump the ABI in
> master.

OK.  I'll try to work on that (unless you have more time now, I've
been sidetracked too :x)

While we're on ABI/API changes, there's also several other changes
I would like:

* Remove the pthread_mutex_t requirement in the wfcqueue and lfstack
  structures.

  I suppose we could implement limited new classes and layer the
  complete old ones on top to preserve ABI/API compatibility.

* cmpxchg_double (cmpxchg16b on x86-64) so lfstack can use
  a lock-free stack for single pop operations.  I'm currently using
  ck_stack from ConcurrencyKit, but generally prefer using the
  URCU APIs and it would be great if lfstack could support this
  on some arches.

Do you have any timeline for a 0.9 release?
