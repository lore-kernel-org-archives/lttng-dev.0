From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 3/3] urcu: declare
	test_urcu_multiflavor	functions
Date: Fri, 7 Dec 2012 11:38:00 -0500
Message-ID: <20121207163800.GD11975__2362.36943533203$1354898319$gmane$org@Krystal>
References: <1354872295-32371-1-git-send-email-laijs@cn.fujitsu.com>
	<1354872295-32371-3-git-send-email-laijs@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Th0w7-0002v4-2U
	for lttng-dev@lists.lttng.org; Fri, 07 Dec 2012 11:38:03 -0500
Content-Disposition: inline
In-Reply-To: <1354872295-32371-3-git-send-email-laijs@cn.fujitsu.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Lai Jiangshan <laijs@cn.fujitsu.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Lai Jiangshan (laijs@cn.fujitsu.com) wrote:
> Signed-off-by: Lai Jiangshan <laijs@cn.fujitsu.com>

Merged, with Makefile.am edit:

diff --git a/tests/Makefile.am b/tests/Makefile.am
index b029377..f8b4c67 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -21,7 +21,7 @@ noinst_PROGRAMS = test_urcu test_urcu_dynamic_link test_urcu_timing \
 	test_urcu_lfq_dynlink test_urcu_lfs_dynlink test_urcu_hash \
 	test_urcu_lfs_rcu_dynlink \
 	test_urcu_multiflavor test_urcu_multiflavor_dynlink
-noinst_HEADERS = rcutorture.h
+noinst_HEADERS = rcutorture.h test_urcu_multiflavor.h
 
 if COMPAT_ARCH
 COMPAT=$(top_srcdir)/compat_arch_@ARCHTYPE@.c

Thanks!

Mathieu

> ---
>  tests/test_urcu_multiflavor-bp.c     |    1 +
>  tests/test_urcu_multiflavor-mb.c     |    1 +
>  tests/test_urcu_multiflavor-memb.c   |    1 +
>  tests/test_urcu_multiflavor-qsbr.c   |    1 +
>  tests/test_urcu_multiflavor-signal.c |    1 +
>  tests/test_urcu_multiflavor.c        |    1 +
>  tests/test_urcu_multiflavor.h        |   29 +++++++++++++++++++++++++++++
>  7 files changed, 35 insertions(+), 0 deletions(-)
>  create mode 100644 tests/test_urcu_multiflavor.h
> 
> diff --git a/tests/test_urcu_multiflavor-bp.c b/tests/test_urcu_multiflavor-bp.c
> index c9f00a3..199818b 100644
> --- a/tests/test_urcu_multiflavor-bp.c
> +++ b/tests/test_urcu_multiflavor-bp.c
> @@ -26,6 +26,7 @@
>  
>  #define RCU_SIGNAL
>  #include <urcu-bp.h>
> +#include "test_urcu_multiflavor.h"
>  
>  int test_mf_bp(void)
>  {
> diff --git a/tests/test_urcu_multiflavor-mb.c b/tests/test_urcu_multiflavor-mb.c
> index 5b5d7e4..e4ba6a4 100644
> --- a/tests/test_urcu_multiflavor-mb.c
> +++ b/tests/test_urcu_multiflavor-mb.c
> @@ -26,6 +26,7 @@
>  
>  #define RCU_MB
>  #include <urcu.h>
> +#include "test_urcu_multiflavor.h"
>  
>  int test_mf_mb(void)
>  {
> diff --git a/tests/test_urcu_multiflavor-memb.c b/tests/test_urcu_multiflavor-memb.c
> index c3a0128..583f2e1 100644
> --- a/tests/test_urcu_multiflavor-memb.c
> +++ b/tests/test_urcu_multiflavor-memb.c
> @@ -25,6 +25,7 @@
>  #endif
>  
>  #include <urcu.h>
> +#include "test_urcu_multiflavor.h"
>  
>  int test_mf_memb(void)
>  {
> diff --git a/tests/test_urcu_multiflavor-qsbr.c b/tests/test_urcu_multiflavor-qsbr.c
> index f4fb145..64f32f4 100644
> --- a/tests/test_urcu_multiflavor-qsbr.c
> +++ b/tests/test_urcu_multiflavor-qsbr.c
> @@ -25,6 +25,7 @@
>  #endif
>  
>  #include <urcu-qsbr.h>
> +#include "test_urcu_multiflavor.h"
>  
>  int test_mf_qsbr(void)
>  {
> diff --git a/tests/test_urcu_multiflavor-signal.c b/tests/test_urcu_multiflavor-signal.c
> index 5519d36..816c615 100644
> --- a/tests/test_urcu_multiflavor-signal.c
> +++ b/tests/test_urcu_multiflavor-signal.c
> @@ -26,6 +26,7 @@
>  
>  #define RCU_SIGNAL
>  #include <urcu.h>
> +#include "test_urcu_multiflavor.h"
>  
>  int test_mf_signal(void)
>  {
> diff --git a/tests/test_urcu_multiflavor.c b/tests/test_urcu_multiflavor.c
> index 825333e..cd573ca 100644
> --- a/tests/test_urcu_multiflavor.c
> +++ b/tests/test_urcu_multiflavor.c
> @@ -21,6 +21,7 @@
>   */
>  
>  #include <stdlib.h>
> +#include "test_urcu_multiflavor.h"
>  
>  int main(int argc, char **argv)
>  {
> diff --git a/tests/test_urcu_multiflavor.h b/tests/test_urcu_multiflavor.h
> new file mode 100644
> index 0000000..419ad5d
> --- /dev/null
> +++ b/tests/test_urcu_multiflavor.h
> @@ -0,0 +1,29 @@
> +/*
> + * test_urcu_multiflavor.h
> + *
> + * Userspace RCU library - test multiple RCU flavors into one program
> + *
> + * Copyright February 2012 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> + * Copyright February 2012 - Lai Jiangshan <laijs@cn.fujitsu.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +extern int test_mf_memb(void);
> +extern int test_mf_mb(void);
> +extern int test_mf_signal(void);
> +extern int test_mf_qsbr(void);
> +extern int test_mf_bp(void);
> +
> -- 
> 1.7.4.4
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
