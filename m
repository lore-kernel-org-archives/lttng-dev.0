From: Jon Bernard <jbernard@tuxion.com>
Subject: Bug#751337: [PATCH] tests: test_ctf_writer: replace HOST_NAME_MAX
Date: Tue, 5 Aug 2014 16:14:12 -0400
Message-ID: <20140805201412.GA11272__45532.272445462$1407269729$gmane$org@helmut>
References: <20140805200251.GA17716@breakpoint.cc>
Reply-To: Jon Bernard <jbernard@tuxion.com>, 751337@bugs.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.751337.B751337.140726966021081@bugs.debian.org>
Content-Disposition: inline
In-Reply-To: <20140805200251.GA17716@breakpoint.cc>
List-URL: <http://lists.debian.org/debian-bugs-dist/>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>, 751337@bugs.debian.org
Cc: jeremie.galarneau@efficios.com, lttng-dev@lists.lttng.org
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
