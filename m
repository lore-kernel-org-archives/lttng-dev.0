From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Re: lttng-tools 2.2.0-rc1 build error, librt no symbols
Date: Sun, 31 Mar 2013 14:25:34 -0400
Message-ID: <CAFXXi0nx3rCccm1WnXnD7bTtmstSt7QksDNGoWuDbFo9=E2oPw__48569.5240473889$1364754418$gmane$org@mail.gmail.com>
References: <CAKPZSeDCSOBUJGuWPadVm4Q99mr_7R5PJdf9VZr_TdqP-101=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <thundersim@gmail.com>) id 1UMMxG-0001xU-DJ
	for lttng-dev@lists.lttng.org; Sun, 31 Mar 2013 14:26:10 -0400
Received: by mail-ie0-f171.google.com with SMTP id e14so1808744iej.16
	for <lttng-dev@lists.lttng.org>; Sun, 31 Mar 2013 11:26:05 -0700 (PDT)
In-Reply-To: <CAKPZSeDCSOBUJGuWPadVm4Q99mr_7R5PJdf9VZr_TdqP-101=g@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: yin sun <sunyin51@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Yin,

I get the same error. Try putting -lrt after the other arguments of
the LDADD. Since libconsumer.la uses timer_settime from librt, -lrt
has to be after it on the command line.

Simon

On 31 March 2013 13:14, yin sun <sunyin51@gmail.com> wrote:
> I am trying the latest git 2.2.0-rc1. seems the the librt is not resolved
> correctly on my ubuntu 12.10 64bit. Don't know why.
>
> I tried to build with static lib seems fine. here is my diff.
>
> diff --git a/src/bin/lttng-consumerd/Makefile.am
> b/src/bin/lttng-consumerd/Makefile.am
> index a418eb4..1711581 100644
> --- a/src/bin/lttng-consumerd/Makefile.am
> +++ b/src/bin/lttng-consumerd/Makefile.am
> @@ -4,7 +4,7 @@ lttnglibexec_PROGRAMS = lttng-consumerd
>
>  lttng_consumerd_SOURCES = lttng-consumerd.c lttng-consumerd.h
>
> -lttng_consumerd_LDADD = -lrt \
> +lttng_consumerd_LDADD = /usr/lib/x86_64-linux-gnu/librt.a \
>            $(top_builddir)/src/common/libconsumer.la \
>            $(top_builddir)/src/common/sessiond-comm/libsessiond-comm.la \
>            $(top_builddir)/src/common/libcommon.la
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
