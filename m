From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [LTTng-ust patch] Added compatibilty for
	armv7l	(Panda Board)
Date: Mon, 12 Nov 2012 15:42:01 -0500
Message-ID: <20121112204201.GA2528__24335.4125800126$1352752976$gmane$org@Krystal>
References: <1352749842-3756-1-git-send-email-adrien.verge@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TY0pX-0007Oe-0r
	for lttng-dev@lists.lttng.org; Mon, 12 Nov 2012 15:42:03 -0500
Content-Disposition: inline
In-Reply-To: <1352749842-3756-1-git-send-email-adrien.verge@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Adrien =?iso-8859-1?Q?Verg=E9?= <adrien.verge@polymtl.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

The following master branch commit makes this patch unnecessary:

commit dca6e79f31143ffc08f8bd5ef832f820fe4546bf
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Mon Nov 12 15:40:15 2012 -0500

    Remove LIBFORMAT config declaration, unused
    =

    Remove leftover from UST 0.x. Not needed anymore.
    =

    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks,

Mathieu


* Adrien Verg=E9 (adrien.verge@polymtl.ca) wrote:
> Signed-off-by: Adrien Verg=E9 <adrien.verge@polymtl.ca>
> ---
>  configure.ac | 1 +
>  1 file changed, 1 insertion(+)
> =

> diff --git a/configure.ac b/configure.ac
> index 91ad8d9..9e94668 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -209,6 +209,7 @@ changequote([,])dnl
>  	s390) LIBFORMAT=3D"elf32-s390"; NO_UNALIGNED_ACCESS=3D1 ;;
>  	s390x) LIBFORMAT=3D"elf64-s390"; NO_UNALIGNED_ACCESS=3D1 ;;
>          armv5) LIBFORMAT=3D"elf32-littlearm"; NO_UNALIGNED_ACCESS=3D1 ;;
> +	armv7l) LIBFORMAT=3D"elf32-littlearm"; NO_UNALIGNED_ACCESS=3D1 ;;
>  	arm) LIBFORMAT=3D"elf32-littlearm"; NO_UNALIGNED_ACCESS=3D1 ;;
>  	mips*) LIBFORMAT=3D""; NO_UNALIGNED_ACCESS=3D1;;
>  	*) AC_MSG_ERROR([unable to detect library format (unsupported architect=
ure ($host_cpu)?)]) ;;
> -- =

> 1.7.11.7
> =

> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
