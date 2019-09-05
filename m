From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools stable-2.9/2.10] Fix: initialize
 syscall table when kernel tracer is lazily initialized
Date: Thu, 5 Sep 2019 17:02:26 -0400
Message-ID: <20190905210226.GD20141__14628.9647019998$1567717368$gmane$org@gmail.com>
References: <20190523165657.19454-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com
 [209.85.160.195])
 by lists.lttng.org (Postfix) with ESMTPS id 46PY6Z1Rr6zsPG
 for <lttng-dev@lists.lttng.org>; Thu,  5 Sep 2019 17:02:29 -0400 (EDT)
Received: by mail-qt1-f195.google.com with SMTP id b2so4592109qtq.5
 for <lttng-dev@lists.lttng.org>; Thu, 05 Sep 2019 14:02:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20190523165657.19454-1-mathieu.desnoyers@efficios.com>
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

Merged in stable-2.10 and stable-2.9.

Thanks!
J=E9r=E9mie

On Thu, May 23, 2019 at 12:56:57PM -0400, Mathieu Desnoyers wrote:
> How to reproduce:
> =

> start lttng-sessiond while lttng-modules are not installed, then install
> lttng-modules. Then issue "lttng list --syscall -k". It will show an
> empty syscall list because the system call list has not been
> initialized.
> =

> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  src/bin/lttng-sessiond/main.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> =

> diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
> index 577936a8..d559306c 100644
> --- a/src/bin/lttng-sessiond/main.c
> +++ b/src/bin/lttng-sessiond/main.c
> @@ -2652,6 +2652,12 @@ static int init_kernel_tracer(void)
>  	}
>  =

>  	DBG("Kernel tracer fd %d", kernel_tracer_fd);
> +
> +	ret =3D syscall_init_table();
> +	if (ret < 0) {
> +		ERR("Unable to populate syscall table. Syscall tracing won't "
> +			"work for this session daemon.");
> +	}
>  	return 0;
>  =

>  error_version:
> @@ -5771,14 +5777,6 @@ int main(int argc, char **argv)
>  		/* Setup kernel tracer */
>  		if (!config.no_kernel) {
>  			init_kernel_tracer();
> -			if (kernel_tracer_fd >=3D 0) {
> -				ret =3D syscall_init_table();
> -				if (ret < 0) {
> -					ERR("Unable to populate syscall table. "
> -						"Syscall tracing won't work "
> -						"for this session daemon.");
> -				}
> -			}
>  		}
>  =

>  		/* Set ulimit for open files */
> -- =

> 2.11.0
> =
