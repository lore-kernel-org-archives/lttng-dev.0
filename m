From: Christian Babeux <christian.babeux@efficios.com>
Subject: Re: [PATCH lttng-tools 4/5] Tests: Add health check
	thread stall test
Date: Tue, 2 Oct 2012 14:00:30 -0400
Message-ID: <CAGDH53kOHt8C9-04dPOQFpvHj3grxza1YuH+yaJZqbU13k9a+w__18214.2806043432$1349200882$gmane$org@mail.gmail.com>
References: <1348770199-1618-1-git-send-email-christian.babeux@efficios.com>
	<1348770199-1618-4-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1TJ6lo-0003vU-Pz
	for lttng-dev@lists.lttng.org; Tue, 02 Oct 2012 14:00:37 -0400
Received: by lbcs4 with SMTP id s4so4387532lbc.35
	for <lttng-dev@lists.lttng.org>; Tue, 02 Oct 2012 11:00:30 -0700 (PDT)
In-Reply-To: <1348770199-1618-4-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Cc: lttng-dev@lists.lttng.org, dgoulet@efficios.com
List-Id: lttng-dev@lists.lttng.org

Hi,

Please disregard this patch because it's missing the env_val
declaration. A v2 will soon follow.

Thank you,

Christian

On Thu, Sep 27, 2012 at 2:23 PM, Christian Babeux
<christian.babeux@efficios.com> wrote:
> This test trigger a "code stall" in a specified thread using the
> testpoint mechanism. The testpoint behavior is implemented in
> health_stall.c. The testpoint code stall a specific thread processing
> by calling sleep(3).
>
> The test select the thread to be stalled by enabling a specific
> environment variable.
>
> The test ensure the threads can be succesfully stalled and that the
> health check feature is able to properly detect stalling in non-polling
> cases.
>
> Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
> ---
>  tests/tools/health/Makefile.am         |   6 +-
>  tests/tools/health/health_stall.c      |  66 +++++++++++++++++
>  tests/tools/health/health_thread_stall | 128 +++++++++++++++++++++++++++++++++
>  3 files changed, 199 insertions(+), 1 deletion(-)
>  create mode 100644 tests/tools/health/health_stall.c
>  create mode 100755 tests/tools/health/health_thread_stall
>
> diff --git a/tests/tools/health/Makefile.am b/tests/tools/health/Makefile.am
> index 0a3f6c5..9fab582 100644
> --- a/tests/tools/health/Makefile.am
> +++ b/tests/tools/health/Makefile.am
> @@ -10,12 +10,16 @@ endif
>
>  UTILS=
>
> -lib_LTLIBRARIES=libhealthexit.la
> +lib_LTLIBRARIES=libhealthexit.la libhealthstall.la
>
>  # Health thread exit ld_preloaded test lib
>  libhealthexit_la_SOURCES=health_exit.c
>  libhealthexit_la_LDFLAGS= -module
>
> +# Health thread stall ld_preloaded test lib
> +libhealthstall_la_SOURCES=health_stall.c
> +libhealthstall_la_LDFLAGS= -module
> +
>  noinst_PROGRAMS = health_check
>
>  health_check_SOURCES = health_check.c $(UTILS)
> diff --git a/tests/tools/health/health_stall.c b/tests/tools/health/health_stall.c
> new file mode 100644
> index 0000000..86b6986
> --- /dev/null
> +++ b/tests/tools/health/health_stall.c
> @@ -0,0 +1,66 @@
> +/*
> + * Copyright (C) 2012 - Christian Babeux <christian.babeux@efficios.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License, version 2 only, as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program; if not, write to the Free Software Foundation, Inc., 51
> + * Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +#include <stdlib.h>
> +#include <string.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +
> +#define STALL_TIME 60
> +
> +/*
> + * Check if the specified environment variable is set.
> + * Return 1 if set, otherwise 0.
> + */
> +int check_env_var(const char *env)
> +{
> +       if (env) {
> +               if (getenv(env) != NULL && (strncmp(env_val, "1", 1) == 0)) {
> +                       return 1;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +void __testpoint_thread_manage_clients_before_loop(void)
> +{
> +       const char *var = "LTTNG_THREAD_MANAGE_CLIENTS_STALL";
> +
> +       if (check_env_var(var)) {
> +               sleep(STALL_TIME);
> +       }
> +}
> +
> +void __testpoint_thread_manage_kernel_before_loop(void)
> +{
> +       const char *var = "LTTNG_THREAD_MANAGE_KERNEL_STALL";
> +
> +       if (check_env_var(var)) {
> +               sleep(STALL_TIME);
> +       }
> +}
> +
> +void __testpoint_thread_manage_apps_before_loop(void)
> +{
> +       const char *var = "LTTNG_THREAD_MANAGE_APPS_STALL";
> +
> +       if (check_env_var(var)) {
> +               sleep(STALL_TIME);
> +       }
> +}
> +
> diff --git a/tests/tools/health/health_thread_stall b/tests/tools/health/health_thread_stall
> new file mode 100755
> index 0000000..d870895
> --- /dev/null
> +++ b/tests/tools/health/health_thread_stall
> @@ -0,0 +1,128 @@
> +#!/bin/bash
> +#
> +# Copyright (C) - 2012 Christian Babeux <christian.babeux@efficios.com>
> +#
> +# This program is free software; you can redistribute it and/or modify it
> +# under the terms of the GNU General Public License, version 2 only, as
> +# published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope that it will be useful, but WITHOUT
> +# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> +# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> +# more details.
> +#
> +# You should have received a copy of the GNU General Public License along with
> +# this program; if not, write to the Free Software Foundation, Inc., 51
> +# Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +
> +TEST_DESC="Health check - Thread stall"
> +
> +CURDIR=$(dirname $0)/
> +TESTDIR=$CURDIR/../..
> +LTTNG_BIN="lttng"
> +SESSION_NAME="health_thread_stall"
> +EVENT_NAME="bogus"
> +HEALTH_CHECK_BIN="health_check"
> +SESSIOND_PRELOAD=".libs/libhealthstall.so"
> +
> +source $TESTDIR/utils.sh
> +
> +print_test_banner "$TEST_DESC"
> +
> +if [ ! -f "$SESSIOND_PRELOAD" ]; then
> +       echo -e "libhealthstall.so not available for this test. Skipping."
> +       exit 0
> +fi
> +
> +function test_thread_stall
> +{
> +       test_thread_stall_name="$1"
> +       test_thread_exit_code="$2"
> +
> +       echo ""
> +       echo -e "=== Testing health failure with ${test_thread_stall_name}"
> +
> +       # Activate testpoints
> +       export LTTNG_TESTPOINT_ENABLE=1
> +
> +       # Activate specific thread exit
> +       export ${test_thread_stall_name}_STALL=1
> +
> +       # Spawn sessiond with preload healthexit lib
> +       export LD_PRELOAD="$CURDIR/$SESSIOND_PRELOAD"
> +       start_lttng_sessiond
> +
> +       # Cleanup some env. var.
> +       unset LD_PRELOAD
> +       unset ${test_thread_stall_name}_STALL
> +
> +       # Check initial health status
> +       $CURDIR/$HEALTH_CHECK_BIN &> /dev/null
> +
> +       echo -n "Validating that ${test_thread_stall_name} is stalled... "
> +
> +       # Wait
> +       sleep 25
> +
> +       # Check health status, exit code should indicate failure
> +       $CURDIR/$HEALTH_CHECK_BIN &> /dev/null
> +
> +       health_check_exit_code=$?
> +
> +       if [ $health_check_exit_code -eq $test_thread_exit_code ]; then
> +               print_ok
> +       else
> +               print_fail
> +               echo -e "Health returned: $health_check_exit_code\n"
> +
> +               stop_lttng_sessiond
> +               return 1
> +       fi
> +
> +       echo -n "Validating that ${test_thread_stall_name} is no longer stalled... "
> +
> +       # Wait
> +       sleep 40
> +
> +       # Check health status, exit code should now pass
> +       $CURDIR/$HEALTH_CHECK_BIN &> /dev/null
> +
> +       health_check_exit_code=$?
> +
> +       if [ $health_check_exit_code -eq 0 ]; then
> +               print_ok
> +               stop_lttng_sessiond
> +       else
> +               print_fail
> +               echo -e "Health returned: $health_check_exit_code\n"
> +               stop_lttng_sessiond
> +               return 1
> +       fi
> +
> +
> +}
> +
> +THREAD=("LTTNG_THREAD_MANAGE_CLIENTS"
> +       "LTTNG_THREAD_MANAGE_APPS"
> +# This thread is a little bit tricky to stall,
> +# need to send some commands and setup an app.
> +#      "LTTNG_THREAD_REG_APPS"
> +       "LTTNG_THREAD_MANAGE_KERNEL")
> +
> +# Exit code value to indicate specific thread failure
> +EXIT_CODE=(1
> +          2
> +#         4
> +          8)
> +
> +THREAD_COUNT=${#THREAD[@]}
> +i=0
> +while [ "$i" -lt "$THREAD_COUNT" ]; do
> +       test_thread_stall "${THREAD[$i]}" "${EXIT_CODE[$i]}"
> +
> +       if [ $? -eq 1 ]; then
> +               exit 1
> +       fi
> +
> +       let "i++"
> +done
> --
> 1.7.12
>
