From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: check for lttng modules
 presence before testing
Date: Thu, 5 Sep 2019 17:00:26 -0400
Message-ID: <20190905210026.GC20141__35192.3624913738$1567717244$gmane$org@gmail.com>
References: <20190522204901.26380-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com
 [209.85.222.194])
 by lists.lttng.org (Postfix) with ESMTPS id 46PY4F6ctzzsNb
 for <lttng-dev@lists.lttng.org>; Thu,  5 Sep 2019 17:00:29 -0400 (EDT)
Received: by mail-qk1-f194.google.com with SMTP id s18so3630516qkj.3
 for <lttng-dev@lists.lttng.org>; Thu, 05 Sep 2019 14:00:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20190522204901.26380-1-jonathan.rajotte-julien@efficios.com>
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

On Wed, May 22, 2019 at 04:49:01PM -0400, Jonathan Rajotte wrote:
> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
>  tests/regression/tools/notification/test_notification_multi_app | 1 +
>  1 file changed, 1 insertion(+)
> =

> diff --git a/tests/regression/tools/notification/test_notification_multi_=
app b/tests/regression/tools/notification/test_notification_multi_app
> index 7465a83f8..b68067924 100755
> --- a/tests/regression/tools/notification/test_notification_multi_app
> +++ b/tests/regression/tools/notification/test_notification_multi_app
> @@ -474,6 +474,7 @@ TESTS=3D(
>  )
>  =

>  if [ "$(id -u)" =3D=3D "0" ]; then
> +	validate_lttng_modules_present
>  	TESTS+=3D(
>  	test_multi_app_kernel
>  	test_on_register_evaluation_kernel
> -- =

> 2.17.1
> =
