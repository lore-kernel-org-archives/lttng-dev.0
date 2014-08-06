From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: Bug#751337: [PATCH] tests: test_ctf_writer: replace HOST_NAME_MAX
Date: Wed, 6 Aug 2014 09:03:24 +0200
Message-ID: <20140806070324.GA2888@breakpoint.cc>
References: <20140805200251.GA17716@breakpoint.cc>
 <20140805201412.GA11272@helmut>
Reply-To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>, 751337@bugs.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.751337.B751337.140730861224942@bugs.debian.org>
Content-Disposition: inline
In-Reply-To: <20140805201412.GA11272@helmut>
List-URL: <http://lists.debian.org/debian-bugs-dist/>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: 751337@bugs.debian.org, jeremie.galarneau@efficios.com, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 2014-08-05 16:14:12 [-0400], Jon Bernard wrote:
> This may also work as well:
> 
>     diff --git a/configure.ac b/configure.ac
>     index 80eba33..248044e 100644
>     --- a/configure.ac
>     +++ b/configure.ac
>     @@ -50,6 +50,17 @@ AC_C_INLINE
>      AC_TYPE_PID_T
>      AC_TYPE_SIZE_T
> 
>     +# FreeBSD does not define HOST_NAME_MAX
>     +AC_CHECK_DECL(HOST_NAME_MAX,,
>     +       [
>     +        AC_CHECK_DECL(_POSIX_HOST_NAME_MAX,
>     +                      AC_DEFINE(HOST_NAME_MAX, _POSIX_HOST_NAME_MAX, []),
>     +                      AC_DEFINE(HOST_NAME_MAX, 256, [Define to 256 if neither have HOST_NAME_MAX nor _POSIX_HOST_NAME_MAX]),
>     +                      [[#include <limits.h>]])
>     +       ],
>     +       [[#include <limits.h>]]
>     +)

Sure it will. I have no strong opinion on how it gets fixed :)

>     +
>      # Checks for library functions.
>      AC_FUNC_MALLOC
>      AC_FUNC_MMAP
> 

Sebastian
