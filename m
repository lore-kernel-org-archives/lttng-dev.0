From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: generation of man pages with
 multiple refnames
Date: Mon, 17 Feb 2020 14:48:19 -0500 (EST)
Message-ID: <1741364420.5941.1581968899658.JavaMail.zimbra@efficios.com>
References: <20200206150645.6654-1-simon.marchi@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 48Lvfs1b2hz18TS
 for <lttng-dev@lists.lttng.org>; Mon, 17 Feb 2020 14:48:20 -0500 (EST)
In-Reply-To: <20200206150645.6654-1-simon.marchi@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Simon Marchi <simon.marchi@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Merged into lttng-ust master branch, thanks!

Mathieu

----- On Feb 6, 2020, at 10:06 AM, Simon Marchi simon.marchi@efficios.com wrote:

> In this proposed patch [1], we're trying to make a man page with two
> command names in the NAME section, like this:
> 
>  tracef, vtracef - LTTng-UST printf(3)-like interface
> 
> Doing so causes the intermediary XML (what asciidoc outputs) to contain
> this:
> 
>    <refnamediv>
>      <refname>tracef, vtracef</refname>
>      <refpurpose>LTTng-UST printf(3)-like interface</refpurpose>
>    </refnamediv>
> 
> The refname is used by the docbook XSL to determine the output
> filename.  This therefore results in an output file named
> `tracef,_vtracef.3`, which is not desirable.
> 
> The problem is in the asciidoc pass, more specifically the part of
> asciidoc.conf removed by this patch.  Is is there to override the
> `source`, `version` and `manual` fields, but it also inadvertently
> affects the refname generation.
> 
> Instead of playing with the asciidoc output template, this patch sets
> the same `source`, `version` and `manual` attributes on the asciidoc
> command line.  With the present patch applied, the XML output contains:
> 
>    <refnamediv>
>        <refname>tracef</refname>
>        <refname>vtracef</refname>
>        <refpurpose>LTTng-UST printf(3)-like interface</refpurpose>
>    </refnamediv>
> 
> The xmlto pass (docbook XML -> man page) then generates two files,
> `tracef.3` and `vtracef.3`, where `vtracef.3` simply sources `tracef.3`
> (which is what we want).
> 
> [1] https://lists.lttng.org/pipermail/lttng-dev/2020-February/029524.html
> 
> Signed-off-by: Simon Marchi <simon.marchi@efficios.com>
> Signed-off-by: Philippe Proulx <eeppeliteloop@gmail.com>
> ---
> doc/man/Makefile.am   |  6 ++++--
> doc/man/asciidoc.conf | 20 --------------------
> 2 files changed, 4 insertions(+), 22 deletions(-)
> 
> diff --git a/doc/man/Makefile.am b/doc/man/Makefile.am
> index f562bfd13a66..14aa4be7c82d 100644
> --- a/doc/man/Makefile.am
> +++ b/doc/man/Makefile.am
> @@ -58,8 +58,10 @@ xmlto_verbose_0 = @echo "  XMLTO     " $@;
> 
> # Tools to execute:
> ADOC = $(asciidoc_verbose)$(ASCIIDOC) -f $(ASCIIDOC_CONF) -d manpage \
> -	-a lttng_version="$(PACKAGE_VERSION)" \
> -	-a lttng_ust_register_timeout="@LTTNG_UST_DEFAULT_CONSTRUCTOR_TIMEOUT_MS@"
> +	-a lttng_ust_register_timeout="@LTTNG_UST_DEFAULT_CONSTRUCTOR_TIMEOUT_MS@" \
> +	-a mansource="LTTng" \
> +	-a manmanual="LTTng Manual" \
> +	-a manversion="$(PACKAGE_VERSION)"
> 
> ADOC_DOCBOOK = $(ADOC) -b docbook
> XTO = $(xmlto_verbose)$(XMLTO) -m $(XSL_FILE) man
> diff --git a/doc/man/asciidoc.conf b/doc/man/asciidoc.conf
> index e3c8016dc3ff..b3c8709d5ead 100644
> --- a/doc/man/asciidoc.conf
> +++ b/doc/man/asciidoc.conf
> @@ -57,23 +57,3 @@ ifdef::backend-docbook[]
> NOT
> endif::backend-docbook[]
> endif::doctype-manpage[]
> -
> -# configure XML man page header
> -ifdef::doctype-manpage[]
> -ifdef::backend-docbook[]
> -[header]
> -template::[header-declarations]
> -<refentry>
> -<refmeta>
> -<refentrytitle>{mantitle}</refentrytitle>
> -<manvolnum>{manvolnum}</manvolnum>
> -<refmiscinfo class="source">LTTng</refmiscinfo>
> -<refmiscinfo class="version">{lttng_version}</refmiscinfo>
> -<refmiscinfo class="manual">LTTng Manual</refmiscinfo>
> -</refmeta>
> -<refnamediv>
> -  <refname>{manname}</refname>
> -  <refpurpose>{manpurpose}</refpurpose>
> -</refnamediv>
> -endif::backend-docbook[]
> -endif::doctype-manpage[]
> --
> 2.25.0
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
