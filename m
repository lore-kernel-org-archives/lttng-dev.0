From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 0/3] rculfhash: error checking fixes
Date: Thu, 31 Jul 2014 21:08:25 +0000 (UTC)
Message-ID: <1681102864.24131.1406840905204.JavaMail.zimbra__42605.6633740247$1406840959$gmane$org@efficios.com>
References: <1403572832-9066-1-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1XCxaM-0006JV-Ch
 for lttng-dev@lists.lttng.org; Thu, 31 Jul 2014 17:08:32 -0400
In-Reply-To: <1403572832-9066-1-git-send-email-normalperson@yhbt.net>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Eric Wong <normalperson@yhbt.net>
Cc: e@80x24.org, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Eric Wong" <normalperson@yhbt.net>
> To: lttng-dev@lists.lttng.org
> Cc: e@80x24.org
> Sent: Monday, June 23, 2014 9:20:29 PM
> Subject: [lttng-dev] [PATCH 0/3] rculfhash: error checking fixes
> 
> Hi Mathieu, I noticed the pthread_create handling is a bit dangerous in
> rculfhash since it may kill the process long after the process is up and
> running.  I also fixed the calloc failure handling since I was in the
> area.

All merged, thanks! Sorry for the delay, the past month has been quite busy.

> 
> In the future, it would also be nice if the alloc_bucket_table behavior
> could fail gracefully on ENOMEM, but that would break ABI...

We could pull this into master for an eventual 0.9 release. We already
have a few ABI breaking changes that require us to bump the ABI in
master.

Thoughts ?

Thanks,

Mathieu

> 
> The following changes since commit d863e15371666dff14e7f3191de5ff91d9b24d7f:
> 
>   Cleanup: tests: cast console write return value as void (2014-05-13
>   09:27:36 -0400)
> 
> are available in the git repository at:
> 
>   git://80x24.org/urcu rculfhash-errcheck
> 
> for you to fetch changes up to d54dd3e6ada2edf4599fc0f26e647a6942a73a39:
> 
>   rculfhash: remove duplicated code (2014-06-24 00:39:26 +0000)
> 
> ----------------------------------------------------------------
> Eric Wong (3):
>       rculfhash: fall back to single-threaded resize on calloc failure
>       rculfhash: handle pthread_create failures
>       rculfhash: remove duplicated code
> 
>  rculfhash.c | 49 +++++++++++++++++++++++++++++++++----------------
>  1 file changed, 33 insertions(+), 16 deletions(-)
> 
> P.S. I still hope to resume the wfcqueue-related epoll improvements
>      we started on last year in the kernel.
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
