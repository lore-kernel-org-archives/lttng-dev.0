From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH babeltrace 1/1] Fix: test_bitfield: extend
 coverage: 0-len signed write/read
Date: Wed, 29 May 2019 16:56:37 -0400
Message-ID: <20190529205637.GA31251__48937.529120461$1559163421$gmane$org@gmail.com>
References: <20190529193625.24465-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com
 [209.85.160.196])
 by lists.lttng.org (Postfix) with ESMTPS id 45DjgX6pcCz10rt
 for <lttng-dev@lists.lttng.org>; Wed, 29 May 2019 16:56:40 -0400 (EDT)
Received: by mail-qt1-f196.google.com with SMTP id l3so4368221qtj.5
 for <lttng-dev@lists.lttng.org>; Wed, 29 May 2019 13:56:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20190529193625.24465-1-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Merged in master and stable-2.0.

Thanks!
J=E9r=E9mie

On Wed, May 29, 2019 at 03:36:25PM -0400, Mathieu Desnoyers wrote:
> By convention, a 0-len bitfield write is a no-op, and a 0-len read
> sets the value of the output to 0.
> =

> So we can "encode" the value 0 over a length of 0 bit. Cover this
> in the test-cases for signed types. It is already covered for the
> unsigned test-cases.
> =

> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Change-Id: Ib6038b98167ef2cfa8c504d7ac29498e71827b38
> ---
>  tests/lib/test_bitfield.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> =

> diff --git a/tests/lib/test_bitfield.c b/tests/lib/test_bitfield.c
> index 5188335b..05547c07 100644
> --- a/tests/lib/test_bitfield.c
> +++ b/tests/lib/test_bitfield.c
> @@ -391,7 +391,9 @@ void run_test_signed_write(int src_i, long long src_l=
l)
>  	long long readval;
>  	unsigned int s, l;
>  =

> -	if (src_i & 0x80000000U)
> +	if (!src_i)
> +		nrbits_i =3D 0;			/* The number of bits needed to represent 0 is 0. */
> +	else if (src_i & 0x80000000U)
>  		nrbits_i =3D fls_u32(~src_i) + 1;	/* Find least significant bit convey=
ing sign */
>  	else
>  		nrbits_i =3D fls_u32(src_i) + 1;	/* Keep sign at 0 */
> @@ -442,7 +444,9 @@ void run_test_signed_write(int src_i, long long src_l=
l)
>  	}
>  	pass(SIGNED_INT_WRITE_TEST_DESC_FMT_STR, src_i);
>  =

> -	if (src_ll & 0x8000000000000000ULL)
> +	if (!src_ll)
> +		nrbits_ll =3D 0;				/* The number of bits needed to represent 0 is 0. =
*/
> +	else if (src_ll & 0x8000000000000000ULL)
>  		nrbits_ll =3D fls_u64(~src_ll) + 1;	/* Find least significant bit conv=
eying sign */
>  	else
>  		nrbits_ll =3D fls_u64(src_ll) + 1;	/* Keep sign at 0 */
> @@ -507,7 +511,9 @@ void run_test_signed_read(int src_i, long long src_ll)
>  	long long readval_ll;
>  	unsigned int s, l;
>  =

> -	if (src_i & 0x80000000U)
> +	if (!src_i)
> +		nrbits_i =3D 0;			/* The number of bits needed to represent 0 is 0. */
> +	else if (src_i & 0x80000000U)
>  		nrbits_i =3D fls_u32(~src_i) + 1;	/* Find least significant bit convey=
ing sign */
>  	else
>  		nrbits_i =3D fls_u32(src_i) + 1;	/* Keep sign at 0 */
> @@ -558,6 +564,8 @@ void run_test_signed_read(int src_i, long long src_ll)
>  	}
>  	pass(SIGNED_INT_READ_TEST_DESC_FMT_STR, src_i);
>  =

> +	if (!src_ll)
> +		nrbits_ll =3D 0;				/* The number of bits needed to represent 0 is 0. =
*/
>  	if (src_ll & 0x8000000000000000ULL)
>  		nrbits_ll =3D fls_u64(~src_ll) + 1;	/* Find least significant bit conv=
eying sign */
>  	else
> -- =

> 2.11.0
> =
