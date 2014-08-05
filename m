From: Jon Bernard <jbernard@tuxion.com>
Subject: Re: Bug#751337: [PATCH] tests: test_ctf_writer: replace
	HOST_NAME_MAX
Date: Tue, 5 Aug 2014 16:14:12 -0400
Message-ID: <20140805201412.GA11272__31680.1352928907$1407269718$gmane$org@helmut>
References: <20140805200251.GA17716@breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jbernard@tuxion.com>) id 1XEl7j-0003CC-Og
 for lttng-dev@lists.lttng.org; Tue, 05 Aug 2014 16:14:24 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by gateway1.nyi.internal (Postfix) with ESMTP id 0B01222A6C
 for <lttng-dev@lists.lttng.org>; Tue,  5 Aug 2014 16:14:13 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20140805200251.GA17716@breakpoint.cc>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>, 751337@bugs.debian.org
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Sebastian Andrzej Siewior <sebastian@breakpoint.cc> wrote:
> This patch replaces HOST_NAME_MAX by xgethostname() which is a wrapper
> around malloc() + gethostname() to get a large enough buffer to fit the
> hostname.
> xgethostname.c was stolen from coreutils and slightly changed so it
> works without xreallocte().
> 
> This should fix Debian #751337 where the package does not build KFreeBSD
> due to missing HOST_NAME_MAX.

This may also work as well:

    diff --git a/configure.ac b/configure.ac
    index 80eba33..248044e 100644
    --- a/configure.ac
    +++ b/configure.ac
    @@ -50,6 +50,17 @@ AC_C_INLINE
     AC_TYPE_PID_T
     AC_TYPE_SIZE_T

    +# FreeBSD does not define HOST_NAME_MAX
    +AC_CHECK_DECL(HOST_NAME_MAX,,
    +       [
    +        AC_CHECK_DECL(_POSIX_HOST_NAME_MAX,
    +                      AC_DEFINE(HOST_NAME_MAX, _POSIX_HOST_NAME_MAX, []),
    +                      AC_DEFINE(HOST_NAME_MAX, 256, [Define to 256 if neither have HOST_NAME_MAX nor _POSIX_HOST_NAME_MAX]),
    +                      [[#include <limits.h>]])
    +       ],
    +       [[#include <limits.h>]]
    +)
    +
     # Checks for library functions.
     AC_FUNC_MALLOC
     AC_FUNC_MMAP

-- 
Jon
