From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] tap-driver.sh: flush stdout
 after each test result
Date: Fri, 29 Mar 2019 14:31:36 -0400
Message-ID: <20190329183135.GD28162__33375.1171756134$1553884322$gmane$org@gmail.com>
References: <20190314154134.20191-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com
 [209.85.222.196])
 by lists.lttng.org (Postfix) with ESMTPS id 44W9LP4fvQz1KZm
 for <lttng-dev@lists.lttng.org>; Fri, 29 Mar 2019 14:31:41 -0400 (EDT)
Received: by mail-qk1-f196.google.com with SMTP id y5so1931389qkc.11
 for <lttng-dev@lists.lttng.org>; Fri, 29 Mar 2019 11:31:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20190314154134.20191-1-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev@lists.lttng.org, jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Merged in master, stable-2.11, stable-2.10, and stable-2.9.

Thanks!
J=E9r=E9mie

On Thu, Mar 14, 2019 at 11:41:34AM -0400, Michael Jeanson wrote:
> This is useful in a CI system where stdout is fully buffered and you
> look at the console output to see which test is hanging.
> =

> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
>  config/tap-driver.sh | 3 +++
>  1 file changed, 3 insertions(+)
> =

> diff --git a/config/tap-driver.sh b/config/tap-driver.sh
> index 32521614..65037ab6 100755
> --- a/config/tap-driver.sh
> +++ b/config/tap-driver.sh
> @@ -275,6 +275,9 @@ function report(result, details)
>      msg =3D msg " " details
>    # Output on console might be colorized.
>    print decorate_result(result) msg
> +  # Flush stdout after each test result, this is useful when stdout
> +  # is buffered, for example in a CI system.
> +  fflush()
>    # Log the result in the log file too, to help debugging (this is
>    # especially true when said result is a TAP error or "Bail out!").
>    print result msg | "cat >&3";
> -- =

> 2.17.1
> =
