From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH RFC lttng-tools] Testpoint mechanism
Date: Tue, 11 Sep 2012 16:56:17 -0400
Message-ID: <1347396978-4661-1-git-send-email-christian.babeux__1040.70830061591$1347397034$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1TBXVh-0003WL-QK
	for lttng-dev@lists.lttng.org; Tue, 11 Sep 2012 16:56:42 -0400
Received: by qafk30 with SMTP id k30so2139350qaf.14
	for <lttng-dev@lists.lttng.org>; Tue, 11 Sep 2012 13:56:36 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com
List-Id: lttng-dev@lists.lttng.org

Hi,

This is a RFC for a testpoint mechanism to ease and improve testing
efforts of the LTTng codebase.

Motivation
----------

The main goal behind the testpoint mechanism is to be able to test and
validate failure cases in different portion of the LTTng codebase. It
could also be used by developers as a debugging aid.

By injecting code at runtime in the lttng daemons/processes/executables,
we can painlessly trigger faulty behavior, test errors paths or even
reproduce race conditions by introducing or exacerbating delays between
threads.

Requirements
------------

The testpoint mechanism should be able to be triggered via scripts to
automate testing efforts.

Ideally, the testpoint mechanism should *NOT* incur a significant
performance hit if we want to leave it always on, in a similar fashion
to the assert() macros.

By leaving it always on, any user is able to use our tests and validate
the behavior of his installation via a simple 'make check' execution.

Proposed solution
-----------------

This patch introduce two new macros: TESTPOINT_DECL(name)
and testpoint(name).

Here a quick example that shows how to use the testpoint mechanism:

file: main.c
#include <stdio.h>
#include <common/testpoint/testpoint/testpoint.h>

/* Testpoint declaration */
TESTPOINT_DECL(interesting_function)

void interesting_function(void)
{
	testpoint(interesting_function);
	/* Some processing that can fail */
	...
}

int main(int argc, char *argv[])
{
	interesting_function();
	...
	printf("End");
}

file: testpoint.c
#include <stdio.h>
void __testpoint_interesting_function(void)
{
	printf("In testpoint of interesting function!");
}

Compile:
gcc -o test main.c
gcc -fPIC -shared -o testpoint.so testpoint.c

Run:
> ./test
  End
> export LTTNG_TESTPOINT_ENABLE=1
> LD_PRELOAD=testpoint.so ./test
  In testpoint of interesting function!
  End
> export LTTNG_TESTPOINT_ENABLE=0
> LD_PRELOAD=testpoint.so ./test
  End

The testpoint mechanism is triggered via the preloading of a shared
object containing the appropriate testpoint symbols and by setting the
LTTNG_TESTPOINT_ENABLE environment variable.

The check on this environment variable is done on the application startup
with the help of a constructor (lttng_testpoint_check) which toggle a global
state variable indicating whether or not the testpoints should be activated.

When enabled, the testpoint() macro calls an underlying wrapper specific to
the testpoint and simply try to lookup the testpoint symbol via a dlsym()
call.

When disabled, the testpoint() call will only incur an additionnal test
per testpoint on a global variable. This performance 'hit' should be
acceptable for production use.

As stated previously, the testpoint mechanism should be *always on*.
It can be explicitly disabled via CFLAGS="-DNTESTPOINT" in a way similar
to NDEBUG and assert().

Comments, thoughts?

Thanks,

Christian Babeux (1):
  New testpoint mechanism to instrument LTTng binaries for testing
    purpose

 configure.ac                     |  1 +
 src/common/Makefile.am           |  2 +-
 src/common/testpoint/Makefile.am |  6 +++
 src/common/testpoint/testpoint.c | 43 +++++++++++++++++++++
 src/common/testpoint/testpoint.h | 81 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 132 insertions(+), 1 deletion(-)
 create mode 100644 src/common/testpoint/Makefile.am
 create mode 100644 src/common/testpoint/testpoint.c
 create mode 100644 src/common/testpoint/testpoint.h

-- 
1.7.11.4
