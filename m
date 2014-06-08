From: Pranith Kumar <bobby.prani@gmail.com>
Subject: Re: [RFC PATCH 1/1] check if set_schedaffinity works in
	configure.ac
Date: Sun, 08 Jun 2014 16:18:41 -0400
Message-ID: <5394C521.4040001__46432.6715017252$1402259276$gmane$org@gmail.com>
References: <5394C476.2050707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yh0-f45.google.com ([209.85.213.45])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <bobby.prani@gmail.com>) id 1WtjY8-0002eY-Mc
 for lttng-dev@lists.lttng.org; Sun, 08 Jun 2014 16:18:41 -0400
Received: by mail-yh0-f45.google.com with SMTP id t59so586007yho.32
 for <lttng-dev@lists.lttng.org>; Sun, 08 Jun 2014 13:18:35 -0700 (PDT)
In-Reply-To: <5394C476.2050707@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 06/08/2014 04:15 PM, Pranith Kumar wrote:
> On some systems set_schedaffinity exists but return "-1" when called. Tests fail in such cases ("test_urcu_hash")
>
> Check if we can call set_schedaffinity and define accordingly
I just realized that this is a common mailing list. This is for userspace-rcu library. I am trying to use it on an Nvidia Tegra K1 device.

>
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>  configure.ac | 37 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 35 insertions(+), 2 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index 008336c..3074bbc 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -269,7 +269,7 @@ AC_COMPILE_IFELSE([AC_LANG_SOURCE([[
>  ])
>  
>  # First check if the function is available at all.
> -AC_CHECK_FUNCS([sched_setaffinity],[
> +AC_CHECK_FUNC([sched_setaffinity],[
>      # Okay, we have it.  Check if also have cpu_set_t.  If we don't,
>      # then we have the first version using unsigned long, and no
>      # CPU_ZERO, etc. macros.  If we do have cpu_set_t, we may have the
> @@ -295,12 +295,45 @@ AC_CHECK_FUNCS([sched_setaffinity],[
>          [sched_set_affinity_args=2])
>          AC_DEFINE_UNQUOTED(SCHED_SETAFFINITY_ARGS,
>              $sched_set_affinity_args,
> -            [Defined to sched_setaffinity's number of arguments.])
> +            [Defined to number of arguments taken by sched_setaffinity.])
>          AC_MSG_RESULT([$sched_set_affinity_args])
>      ],[
>          # No cpu_set_t, always 3 args.
>          AC_DEFINE(SCHED_SETAFFINITY_ARGS, 3)
>      ])
> +    AS_IF([test "x$sched_set_affinity_args" = "x3"], [
> +        # test if sched_setaffinity works
> +        AC_MSG_CHECKING([if sched_setaffinity works])
> +        AC_RUN_IFELSE([AC_LANG_SOURCE([[
> +                #include <sched.h>
> +                int main()
> +                {
> +                    cpu_set_t foo;
> +                    return sched_setaffinity(0, sizeof (foo), &foo);
> +                }
> +            ]])
> +        ],
> +        [sched_set_affinity_works=1],
> +        [sched_set_affinity_works=0])
> +        AC_DEFINE_UNQUOTED(HAVE_SCHED_SETAFFINITY,
> +            $sched_set_affinity_works)
> +    ],[
> +        # test if sched_setaffinity works
> +        AC_MSG_CHECKING([if sched_setaffinity works])
> +        AC_RUN_IFELSE([AC_LANG_SOURCE([[
> +                #include <sched.h>
> +                int main()
> +                {
> +                    cpu_set_t foo;
> +                    return sched_setaffinity(0, &foo);
> +                }
> +            ]])
> +        ],
> +        [sched_set_affinity_works=1],
> +        [sched_set_affinity_works=0])
> +        AC_DEFINE_UNQUOTED(HAVE_SCHED_SETAFFINITY,
> +            $sched_set_affinity_works)
> +    ])
>  ])
>  
>  CFLAGS=$saved_CFLAGS
