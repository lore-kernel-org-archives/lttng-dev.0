From: Christian Babeux <christian.babeux@efficios.com>
Subject: Re: [PATCH lttng-tools 2/2] Fix: Missing libs
 dependencies in configure check for lttng-ust-ctl
Date: Thu, 9 Aug 2012 11:24:54 -0400
Message-ID: <CAGDH53kD9rkBbzj416QRDpCH0Je5iwfmwzdGOvf_54RRXG8jtQ__12440.4519833208$1344525935$gmane$org@mail.gmail.com>
References: <cover.1344025572.git.christian.babeux@efficios.com>
	<884d75d90550f85492dfcaac2b0088f78ced542b.1344025572.git.christian.babeux@efficios.com>
	<20120809134621.GG8382@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lpp01m010-f48.google.com ([209.85.215.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1SzUbc-0003Ht-Fz
	for lttng-dev@lists.lttng.org; Thu, 09 Aug 2012 11:25:00 -0400
Received: by lagr15 with SMTP id r15so339166lag.35
	for <lttng-dev@lists.lttng.org>; Thu, 09 Aug 2012 08:24:54 -0700 (PDT)
In-Reply-To: <20120809134621.GG8382@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, dgoulet@efficios.com
List-Id: lttng-dev@lists.lttng.org

Hi Mathieu,

> not sure I understand why all the changes you are doing are needed. What
> happens if you just do:
>
> -             [AC_MSG_ERROR([Cannot find LTTng-UST. Use [LDFLAGS]=-Ldir to specify its location, or specify --disable-lttng-ust to build lttng-tools without LTTng-UST support.])]
> +             [AC_MSG_ERROR([Cannot find LTTng-UST. Use [LDFLAGS]=-Ldir to specify its location, or specify --disable-lttng-ust to build lttng-tools without LTTng-UST support.])],
> +             [-lurcu-common -lurcu-bp -lurcu-cds]
>
> ?

If we only change the other-lib case of the AC_CHECK_LIB, subsequent
calls to this macro will fail unexpectedly. For example, the next call
to this macro is the check for dlopen in the dl lib. Since the previous
call (the check for lttng-ust-ctl) succeeded, -llttng-ust-ctl has been
prepended to the $LIBS variable.

The problem arise when trying to link a test program
(the actual test of AC_CHECK_LIB) to check for the dl lib. The linking
will fail for the same reason, because the dependencies to
urcu-{common,bp,cds} have not been manually specified and lttng-ust-ctl
has been added to the $LIBS flags passed to the linker. Hence,
the test for the dl lib will fail, not because it can't find the dl lib,
but because the linking fail as a side effect of adding the lttng-ust-ctl lib.

There is possibly three other ways to fix this issue that I know of:

- The check for lttng-ust-ctl lib should be the last AC_CHECK_LIB.
  This is exactly the situation I was trying to avoid. Someone could
  inadvertently add one after and silently break cross-compilation
  builds.

- Add AC_CHECK_LIB checks for the dependents URCU libs.
  This will add a -lurcu-{common,bp,cds} when linking.
  I'm not fully aware of the repercussions this could have.

- Use PKG_CONFIG support in configure.ac.
  This might be a more elegant and long-term solution so we don't have
  to rely on these kind of trickery to check for libraries
  and correctly support cross-compilation builds.


>> +     AC_CHECK_LIB([lttng-ust-ctl], [ustctl_create_session],
>> +             [
>> +                     AC_DEFINE([HAVE_LIBLTTNG_UST_CTL], [1], [has LTTng-UST control support])
>
> wasn't HAVE_LIBLTTNG_UST_CTL already defined by the AM_CONDITIONAL below ?
>
>> +                     lttng_ust_ctl_found=yes
>
> why are you adding this ?
>

The default behavior of the action-if-found in AC_CHECK_LIB is to
prepend '-llibrary' and defining 'HAVE_LIBlibrary' [1].
Since we don't want to prepend -llttng-ust-ctl, we must manually define
HAVE_LIBlibrary.

The AM_CONDITIONAL does not define the HAVE_LIBLTTNG_UST_CTL
(as in the preprocessor sense) it is the AC_CHECK_LIB check
that normally does (via an underlying call to AC_DEFINE).
AM_CONDITIONAL only make the HAVE_LIBLTTNG_UST_CTL variable
available to use in Makefile.am [2].

>> -
>> -AM_CONDITIONAL([HAVE_LIBLTTNG_UST_CTL], [ test "x$ac_cv_lib_lttng_ust_ctl_ustctl_create_session" = "xyes" ])
>> -
>> +AM_CONDITIONAL([HAVE_LIBLTTNG_UST_CTL], [test "x$lttng_ust_ctl_found" = xyes])
>
> why are you changing this line ?
>

I only changed the test flag to lttng_ust_ctl_found for clarity sake.
It might not be obvious to everyone that the
$ac_cv_lib_lttng_ust_ctl_ustctl_create_session variable is a cached
test result by autoconf.

I think this patch is not the most obvious. I would like to know
if anyone has any other ideas to resolve this issue.

Thoughts?

Thanks,

Christian

1 - https://www.gnu.org/savannah-checkouts/gnu/autoconf/manual/autoconf-2.69/html_node/Libraries.html#Libraries
2 - https://www.gnu.org/software/automake/manual/html_node/Usage-of-Conditionals.html
