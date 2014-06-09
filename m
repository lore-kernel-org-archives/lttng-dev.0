From: Nathan Lynch <Nathan_Lynch@mentor.com>
Subject: Re: [RFC PATCH 1/1] check if set_schedaffinity works in
 configure.ac
Date: Mon, 9 Jun 2014 13:59:56 -0500
Message-ID: <5396042C.2010708__8714.06977898932$1402340479$gmane$org@mentor.com>
References: <5394C476.2050707@gmail.com> <5394C521.4040001@gmail.com>
 <5394C810.1000801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Nathan_Lynch@mentor.com>) id 1Wu4nc-0002BU-4L
 for lttng-dev@lists.lttng.org; Mon, 09 Jun 2014 15:00:09 -0400
In-Reply-To: <5394C810.1000801@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 06/08/2014 03:31 PM, Pranith Kumar wrote:
> +    AS_IF([test "x$sched_set_affinity_args" = "x3"], [
> +        # test if sched_setaffinity works
> +        AC_MSG_CHECKING([if sched_setaffinity works])
> +        AC_RUN_IFELSE([AC_LANG_SOURCE([[
> +                #include <sched.h>
> +                int main()
> +                {
> +                    cpu_set_t foo;
> +                    return sched_setaffinity(0, sizeof (foo), &foo);

This passes uninitialized stack memory to the system call; the return
value is unpredictable.

If it turns out that such a test is necessary, it should probably call
sched_getaffinity first and pass the result to sched_setaffinity.
