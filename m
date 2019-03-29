From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 1/2] Fix: test: skip
 test_getcpu_override on single thread system
Date: Fri, 29 Mar 2019 14:33:43 -0400
Message-ID: <20190329183341.GE28162__16440.9305829153$1553884441$gmane$org@gmail.com>
References: <20190312183031.20265-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com
 [209.85.222.194])
 by lists.lttng.org (Postfix) with ESMTPS id 44W9Nq0Rdbz1KbZ
 for <lttng-dev@lists.lttng.org>; Fri, 29 Mar 2019 14:33:46 -0400 (EDT)
Received: by mail-qk1-f194.google.com with SMTP id w20so1952821qka.7
 for <lttng-dev@lists.lttng.org>; Fri, 29 Mar 2019 11:33:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20190312183031.20265-1-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev@lists.lttng.org, jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Both patches were merged in master, stable-2.11, stable-2.10, and
stable-2.9.

Thanks!
J=E9r=E9mie

On Tue, Mar 12, 2019 at 02:30:30PM -0400, Jonathan Rajotte wrote:
> There is no value in performing this test on single thread system
> since the only valid value for the cpu field is 0.
> =

> This test currently fails on single thread system (i.e yocto runquemu)
> on the test_getcpu_override_fail test case.
> =

> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
>  .../ust/getcpu-override/test_getcpu_override     | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> =

> diff --git a/tests/regression/ust/getcpu-override/test_getcpu_override b/=
tests/regression/ust/getcpu-override/test_getcpu_override
> index 4ca385aeb..ee3e31953 100755
> --- a/tests/regression/ust/getcpu-override/test_getcpu_override
> +++ b/tests/regression/ust/getcpu-override/test_getcpu_override
> @@ -157,13 +157,19 @@ plan_tests $NUM_TESTS
>  =

>  print_test_banner "$TEST_DESC"
>  =

> -if [ -x "$CURDIR/.libs/lttng-ust-getcpu-override-test.so" ]; then
> -	foundobj=3D1
> -else
> -	foundobj=3D0
> +if [ ! -x "$CURDIR/.libs/lttng-ust-getcpu-override-test.so" ]; then
> +	skip 0 "No shared object generated. Skipping all tests." $NUM_TESTS && =
exit 0
> +fi
> +
> +if [ "$num_cpus" -eq "1" ]; then
> +	# Skip the test since we cannot perform it as designed since N mod 1
> +	# is always equals to zero. There is no point testing this on a system
> +	# with a single thread. LTTng-UST limits the get_cpu function to return
> +	# value inside the [0, NUM_CPU - 1] range for a valid event (present in
> +	# trace).
> +	skip 0 "Test system only have a single thread. Skipping all tests." $NU=
M_TESTS && exit 0
>  fi
>  =

> -skip $foundobj "No shared object generated. Skipping all tests." $NUM_TE=
STS && exit 0
>  =

>  TESTS=3D(
>  	test_getcpu_override_fail
> -- =

> 2.17.1
> =
