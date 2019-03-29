From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Tests: check for lttng-modules
 presence
Date: Fri, 29 Mar 2019 14:15:56 -0400
Message-ID: <20190329181555.GB28162__3778.43380426697$1553883380$gmane$org@gmail.com>
References: <20190325184939.24845-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com
 [209.85.160.196])
 by lists.lttng.org (Postfix) with ESMTPS id 44W90J5CsQz1KXq
 for <lttng-dev@lists.lttng.org>; Fri, 29 Mar 2019 14:15:59 -0400 (EDT)
Received: by mail-qt1-f196.google.com with SMTP id h39so3689407qte.2
 for <lttng-dev@lists.lttng.org>; Fri, 29 Mar 2019 11:15:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20190325184939.24845-1-jonathan.rajotte-julien@efficios.com>
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

Merged in master, stable-2.11, and stable-2.10.

Thanks!
J=E9r=E9mie

On Mon, Mar 25, 2019 at 02:49:39PM -0400, Jonathan Rajotte wrote:
> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
>  tests/regression/tools/notification/test_notification_kernel | 1 +
>  1 file changed, 1 insertion(+)
> =

> diff --git a/tests/regression/tools/notification/test_notification_kernel=
 b/tests/regression/tools/notification/test_notification_kernel
> index 6d7f256ae..e7368df26 100755
> --- a/tests/regression/tools/notification/test_notification_kernel
> +++ b/tests/regression/tools/notification/test_notification_kernel
> @@ -108,6 +108,7 @@ function kernel_test
>  }
>  =

>  if [ "$(id -u)" =3D=3D "0" ]; then
> +	validate_lttng_modules_present
>  	kernel_test
>  else
>  	# Kernel tests are skipped.
> -- =

> 2.17.1
> =
