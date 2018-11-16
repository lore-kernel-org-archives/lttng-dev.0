From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 2/2] Fix: typo 'convet' ->
 'convert'
Date: Fri, 16 Nov 2018 18:21:01 -0500
Message-ID: <20181116232059.GA2851__49914.5168964334$1542410351$gmane$org@gmail.com>
References: <20181115171637.3839-1-mjeanson@efficios.com>
 <20181115171637.3839-2-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com
 [209.85.222.194])
 by lists.lttng.org (Postfix) with ESMTPS id 42xZ3j5szszsPV
 for <lttng-dev@lists.lttng.org>; Fri, 16 Nov 2018 18:21:05 -0500 (EST)
Received: by mail-qk1-f194.google.com with SMTP id a132so40226741qkg.1
 for <lttng-dev@lists.lttng.org>; Fri, 16 Nov 2018 15:21:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20181115171637.3839-2-mjeanson@efficios.com>
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

All four typo fix patches were merged in master and stable-2.11.

Thanks!
J=E9r=E9mie

On Thu, Nov 15, 2018 at 12:16:37PM -0500, Michael Jeanson wrote:
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
>  src/common/lttng-elf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/src/common/lttng-elf.c b/src/common/lttng-elf.c
> index 52e05f0c6..cb01f7bb7 100644
> --- a/src/common/lttng-elf.c
> +++ b/src/common/lttng-elf.c
> @@ -861,7 +861,7 @@ int lttng_elf_get_symbol_offset(int fd, char *symbol,=
 uint64_t *offset)
>  	 */
>  	ret =3D lttng_elf_convert_addr_in_text_to_offset(elf, addr, offset);
>  	if (ret) {
> -		DBG("Cannot convet addr to offset.");
> +		DBG("Cannot convert addr to offset.");
>  		goto free_string_table_data;
>  	}
>  =

> -- =

> 2.17.1
> =
