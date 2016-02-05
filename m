From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules 1/2] Add RT patch version
	macros
Date: Fri, 5 Feb 2016 23:41:13 +0000 (UTC)
Message-ID: <1182581177.13386.1454715673150.JavaMail.zimbra__38988.7539124631$1454715740$gmane$org@efficios.com>
References: <1454712787-7944-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1aRq0B-00070Z-V8
 for lttng-dev@lists.lttng.org; Fri, 05 Feb 2016 18:41:25 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id B57FB340321
 for <lttng-dev@lists.lttng.org>; Fri,  5 Feb 2016 23:41:18 +0000 (UTC)
In-Reply-To: <1454712787-7944-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Both patches merged, thanks!

Mathieu

----- On Feb 5, 2016, at 5:53 PM, Michael Jeanson mjeanson@efficios.com wrote:

> ---
> Makefile.ABI.workarounds |  8 +++++++-
> lttng-kernel-version.h   | 17 +++++++++++++++++
> rt-patch-version.sh      | 25 +++++++++++++++++++++++++
> 3 files changed, 49 insertions(+), 1 deletion(-)
> create mode 100755 rt-patch-version.sh
> 
> diff --git a/Makefile.ABI.workarounds b/Makefile.ABI.workarounds
> index d553ee4..e8cf520 100644
> --- a/Makefile.ABI.workarounds
> +++ b/Makefile.ABI.workarounds
> @@ -4,8 +4,14 @@
> # the kernel EXTRAVERSION to figure it out. Translate this information
> # into a define visible from the C preprocessor.
> 
> -DEB_API_VERSION=$(shell $(MAKEFILEDIR)/abi-debian-version.sh $(KERNELDIR))
> +DEB_API_VERSION:=$(shell $(MAKEFILEDIR)/abi-debian-version.sh $(KERNELDIR))
> 
> ifneq ($(DEB_API_VERSION), 0)
>   ccflags-y += -DDEBIAN_API_VERSION=$(DEB_API_VERSION)
> endif
> +
> +RT_PATCH_VERSION:=$(shell $(MAKEFILEDIR)/rt-patch-version.sh $(KERNELDIR))
> +
> +ifneq ($(RT_PATCH_VERSION), 0)
> +  ccflags-y += -DRT_PATCH_VERSION=$(RT_PATCH_VERSION)
> +endif
> diff --git a/lttng-kernel-version.h b/lttng-kernel-version.h
> index f98a192..ac61739 100644
> --- a/lttng-kernel-version.h
> +++ b/lttng-kernel-version.h
> @@ -90,4 +90,21 @@
> 		LTTNG_RHEL_VERSION_CODE < \
> 		LTTNG_RHEL_KERNEL_VERSION(a_high, b_high, c_high, d_high, e_high))
> 
> +#define LTTNG_RT_KERNEL_VERSION(a, b, c, d) \
> +	(((a) << 24) + ((b) << 16) + ((c) << 8) + (d))
> +
> +#ifdef RT_PATCH_VERSION
> +#define LTTNG_RT_VERSION_CODE \
> +	((LINUX_VERSION_CODE << 8) + RT_PATCH_VERSION)
> +#else
> +#define LTTNG_RT_VERSION_CODE 	0
> +#endif
> +
> +#define LTTNG_RT_KERNEL_RANGE(a_low, b_low, c_low, d_low, \
> +		a_high, b_high, c_high, d_high) \
> +	(LTTNG_RT_VERSION_CODE >= \
> +		LTTNG_RT_KERNEL_VERSION(a_low, b_low, c_low, d_low) && \
> +		LTTNG_RT_VERSION_CODE < \
> +		LTTNG_RT_KERNEL_VERSION(a_high, b_high, c_high, d_high))
> +
> #endif /* _LTTNG_KERNEL_VERSION_H */
> diff --git a/rt-patch-version.sh b/rt-patch-version.sh
> new file mode 100755
> index 0000000..89c7755
> --- /dev/null
> +++ b/rt-patch-version.sh
> @@ -0,0 +1,25 @@
> +#!/bin/sh
> +
> +# First argument is the path to the kernel headers.
> +KPATH=$1
> +
> +VERSIONFILE=""
> +
> +if [ -f "${KPATH}/localversion-rt" ]; then
> +	VERSIONFILE="${KPATH}/localversion-rt"
> +
> +elif [ -f "${KPATH}/source/localversion-rt" ]; then
> +	VERSIONFILE="${KPATH}/source/localversion-rt"
> +else
> +	echo 0
> +	exit 0
> +fi
> +
> +RT_PATCH_VERSION=$(sed -rn 's/^-rt([0-9]+)$/\1/p' "${VERSIONFILE}")
> +
> +if [ "x${RT_PATCH_VERSION}" = "x" ]; then
> +	echo 0
> +	exit 0
> +fi
> +
> +echo ${RT_PATCH_VERSION}
> --
> 2.7.0

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
