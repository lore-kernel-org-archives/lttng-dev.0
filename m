From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: lttng-crash: detect
 truncated files
Date: Wed, 25 Sep 2019 12:45:01 -0400
Message-ID: <20190925164501.GA41410__3819.9230375298$1569429920$gmane$org@gmail.com>
References: <20190923183133.18786-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com
 [209.85.160.196])
 by lists.lttng.org (Postfix) with ESMTPS id 46dkSL0QddzqRp
 for <lttng-dev@lists.lttng.org>; Wed, 25 Sep 2019 12:45:05 -0400 (EDT)
Received: by mail-qt1-f196.google.com with SMTP id u22so34962qtq.13
 for <lttng-dev@lists.lttng.org>; Wed, 25 Sep 2019 09:45:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20190923183133.18786-1-mathieu.desnoyers@efficios.com>
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

Merged in master, stable-2.11, stable-2.10, and stable-2.9. Thanks!

J=E9r=E9mie

On Mon, Sep 23, 2019 at 02:31:33PM -0400, Mathieu Desnoyers wrote:
> Detect truncated files which size is smaller than the ring buffer
> header.
> =

> This can be caused by a situation where sessiond is killed with SIGKILL
> while doing a metadata regenerate command.
> =

> Without this fix, lttng-crash is killed with a "Bus error" when
> encountering a truncated file.
> =

> Fixes: #1166
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  src/bin/lttng-crash/lttng-crash.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> =

> diff --git a/src/bin/lttng-crash/lttng-crash.c b/src/bin/lttng-crash/lttn=
g-crash.c
> index 298ed71a..47358df9 100644
> --- a/src/bin/lttng-crash/lttng-crash.c
> +++ b/src/bin/lttng-crash/lttng-crash.c
> @@ -498,7 +498,8 @@ int check_magic(const uint8_t *magic)
>  }
>  =

>  static
> -int get_crash_layout(struct lttng_crash_layout *layout, int fd)
> +int get_crash_layout(struct lttng_crash_layout *layout, int fd,
> +		const char *input_file)
>  {
>  	char *map;
>  	int ret =3D 0, unmapret;
> @@ -509,7 +510,17 @@ int get_crash_layout(struct lttng_crash_layout *layo=
ut, int fd)
>  	const struct crash_abi_unknown *abi;
>  	uint16_t endian;
>  	enum lttng_crash_type layout_type;
> +	struct stat stat;
>  =

> +	ret =3D fstat(fd, &stat);
> +	if (ret < 0) {
> +		PERROR("fstat");
> +		return -1;
> +	}
> +	if (stat.st_size < RB_CRASH_DUMP_ABI_LEN) {
> +		ERR("File: '%s' truncated", input_file);
> +		return -1;
> +	}
>  	map =3D mmap(NULL, RB_CRASH_DUMP_ABI_LEN, PROT_READ, MAP_PRIVATE,
>  		fd, 0);
>  	if (map =3D=3D MAP_FAILED) {
> @@ -838,7 +849,7 @@ int extract_file(int output_dir_fd, const char *outpu=
t_file,
>  	}
>  =

>  	/* Query the crash ABI layout */
> -	ret =3D get_crash_layout(&layout, fd_src);
> +	ret =3D get_crash_layout(&layout, fd_src, input_file);
>  	if (ret) {
>  		goto close_src;
>  	}
> -- =

> 2.11.0
> =
