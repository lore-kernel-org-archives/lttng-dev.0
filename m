From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Add pkgconfig support for
 liblttng-ust-ctl
Date: Wed, 23 Oct 2019 11:27:48 -0400 (EDT)
Message-ID: <1973992563.697.1571844468420.JavaMail.zimbra__43049.9759082281$1571844493$gmane$org@efficios.com>
References: <20191023151130.7321-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 46yvQH1RgjzqJs
 for <lttng-dev@lists.lttng.org>; Wed, 23 Oct 2019 11:27:51 -0400 (EDT)
In-Reply-To: <20191023151130.7321-1-mjeanson@efficios.com>
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Merged into master. Please let me know if it needs to be backported.

Thanks,

Mathieu

----- On Oct 23, 2019, at 11:11 AM, Michael Jeanson mjeanson@efficios.com wrote:

> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> Makefile.am         |  2 +-
> configure.ac        |  1 +
> lttng-ust-ctl.pc.in | 12 ++++++++++++
> 3 files changed, 14 insertions(+), 1 deletion(-)
> create mode 100644 lttng-ust-ctl.pc.in
> 
> diff --git a/Makefile.am b/Makefile.am
> index 73b51909..cc923c1d 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -32,7 +32,7 @@ SUBDIRS += tests doc
> # liblttng-ust-malloc
> 
> pkgconfigdir = $(libdir)/pkgconfig
> -pkgconfig_DATA = lttng-ust.pc
> +pkgconfig_DATA = lttng-ust.pc lttng-ust-ctl.pc
> 
> dist_doc_DATA = \
> 	ChangeLog \
> diff --git a/configure.ac b/configure.ac
> index 52fc3f68..580e0ee3 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -555,6 +555,7 @@ AC_CONFIG_FILES([
> 	tests/test-app-ctx/Makefile
> 	tests/gcc-weak-hidden/Makefile
> 	lttng-ust.pc
> +	lttng-ust-ctl.pc
> ])
> 
> # Create link for python agent for the VPATH guru.
> diff --git a/lttng-ust-ctl.pc.in b/lttng-ust-ctl.pc.in
> new file mode 100644
> index 00000000..3170b30a
> --- /dev/null
> +++ b/lttng-ust-ctl.pc.in
> @@ -0,0 +1,12 @@
> +prefix=@prefix@
> +exec_prefix=@exec_prefix@
> +libdir=@libdir@
> +includedir=@includedir@
> +
> +Name: LTTng Userspace Tracer control
> +Description: The LTTng Userspace Tracer (UST) is a library accompanied by a set
> of tools to trace userspace code.
> +Version: @PACKAGE_VERSION@
> +Requires:
> +Libs: -L${libdir} -llttng-ust-ctl
> +Cflags: -I${includedir}
> +
> --
> 2.17.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
