From: Samuel Martin <s.martin49@gmail.com>
Subject: Re: [PATCH lttng-tools] configure.ac: use $withval with
	AC_ARG_WITH
Date: Fri, 27 Nov 2015 22:20:19 +0100
Message-ID: <CAHXCMMJhOK9ELj=aKNGiGw_fmgTH46=6hedEXNaX0rvrOBdgmw__9791.34735321186$1448659314$gmane$org@mail.gmail.com>
References: <1448231881-7988-1-git-send-email-s.martin49@gmail.com>
 <1448231881-7988-2-git-send-email-s.martin49@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <s.martin49@gmail.com>) id 1a2QS0-0003tP-Ri
 for lttng-dev@lists.lttng.org; Fri, 27 Nov 2015 16:21:14 -0500
Received: by pacdm15 with SMTP id dm15so123307693pac.3
 for <lttng-dev@lists.lttng.org>; Fri, 27 Nov 2015 13:20:59 -0800 (PST)
In-Reply-To: <1448231881-7988-2-git-send-email-s.martin49@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi all,

On Sun, Nov 22, 2015 at 11:38 PM, Samuel Martin <s.martin49@gmail.com> wrote:
> Signed-off-by: Samuel Martin <s.martin49@gmail.com>
 ---
>  configure.ac | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/configure.ac b/configure.ac
> index fad4de6..978e3bc 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -315,7 +315,7 @@ AC_ARG_WITH(lttng-ust-prefix,
>  # Check liblttng-ust-ctl library
>  AC_ARG_WITH(lttng-ust,
>         AS_HELP_STRING([--without-lttng-ust],[build without LTTng-UST (Userspace Tracing) support]),
> -       lttng_ust_support=$enableval, lttng_ust_support=yes)
> +       lttng_ust_support=$withval, lttng_ust_support=yes)
>
>  AS_IF([test "x$lttng_ust_support" = "xyes"], [
>         AC_CHECK_LIB([lttng-ust-ctl], [ustctl_recv_channel_from_consumer],
> --
> 2.6.2
>

For the record, I just file a bug:
https://bugs.lttng.org/issues/980

Cheers,

-- 
Samuel
