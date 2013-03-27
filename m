From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [lttng-ust PATCH] Add man page for
	lttng-ust-cyg-profile
Date: Wed, 27 Mar 2013 12:26:19 -0400
Message-ID: <20130327162619.GA8823__9400.11712159521$1364401637$gmane$org@Krystal>
References: <51531B00.1030302@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UKtB9-0006dn-An
	for lttng-dev@lists.lttng.org; Wed, 27 Mar 2013 12:26:23 -0400
Content-Disposition: inline
In-Reply-To: <51531B00.1030302@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Woegerer, Paul (Paul_Woegerer@mentor.com) wrote:
> As promised...

merged, with minor edits, thanks!

Mathieu

> =

> From acba8cd14abc7e61cf1346b5649972bac3ea0d53 Mon Sep 17 00:00:00 2001
> From: Paul Woegerer <paul_woegerer@mentor.com>
> Date: Wed, 27 Mar 2013 17:02:27 +0100
> Subject: [PATCH] Add man page for lttng-ust-cyg-profile
> =

> ---
>  doc/Makefile.am                 |    3 +-
>  doc/man/lttng-ust-cyg-profile.3 |   79 +++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 81 insertions(+), 1 deletion(-)
>  create mode 100644 doc/man/lttng-ust-cyg-profile.3
> =

> diff --git a/doc/Makefile.am b/doc/Makefile.am
> index 66c22fa..ccd6d18 100644
> --- a/doc/Makefile.am
> +++ b/doc/Makefile.am
> @@ -1,4 +1,5 @@
>  SUBDIRS =3D . examples
>  =

>  dist_man_MANS =3D man/lttng-gen-tp.1 \
> -	man/lttng-ust.3
> +	man/lttng-ust.3 \
> +	man/lttng-ust-cyg-profile.3
> diff --git a/doc/man/lttng-ust-cyg-profile.3 b/doc/man/lttng-ust-cyg-prof=
ile.3
> new file mode 100644
> index 0000000..58dbce8
> --- /dev/null
> +++ b/doc/man/lttng-ust-cyg-profile.3
> @@ -0,0 +1,79 @@
> +.TH "LTTNG-UST-CYG-PROFILE" "1" "March 26, 2013" "" ""
> +.SH "NAME"
> +lttng-ust-cyg-profile \(em LTTng UST 2.0 Function Tracing
> +.SH "SYNOPSIS"
> +Compile the application source code with option \fB-finstrument-function=
s\fP
> +and launch your application either with:
> +.TP
> +\fBLD_PRELOAD=3Dliblttng-ust-cyg-profile-fast.so\fP appname
> +.PP
> +or (to use verbose function tracing)
> +.TP
> +\fBLD_PRELOAD=3Dliblttng-ust-cyg-profile.so\fP appname
> +.PP
> +All events emitted for function tracing are provided on loglevel
> +TRACE_DEBUG_FUNCTION. The following command can be used to add
> +function tracing events in your trace session:
> +.TP
> +.B lttng enable-event -u -a --loglevel-only TRACE_DEBUG_FUNCTION
> +.SH "DESCRIPTION"
> +For compilers that provide code generation option
> +\fB-finstrument-functions\fP (e.g. GCC and LLVM/Clang) LTTng-UST provides
> +shared libraries that allow users to trace the function flow of their
> +applications.
> +
> +Function tracing comes in two flavors (each providing different trade-of=
fs):
> +.IP liblttng-ust-cyg-profile-fast.so
> +This is a lightweight variant that should only be used where it can be
> +guaranteed that the complete event stream is recorded without any missing
> +events. Any kind of duplicate information is left out.
> +
> +At each function entry the address of the called function is recored as
> +lttng_ust_cyg_profile_fast:func_entry. Function exit is recorded as
> +lttng_ust_cyg_profile_fast:func_exit (without any field data).
> +
> +.IP liblttng-ust-cyg-profile.so
> +This is a more robust variant which also works for use-cases where events
> +might get discarded or not recorded from application startup. In these c=
ases
> +the trace analyzer needs extra information to be able to reconstruct the
> +program flow.
> +
> +For each function entry and exit the address of the called function and =
the
> +call site address are recorded as lttng_ust_cyg_profile:func_entry and
> +lttng_ust_cyg_profile:func_exit.
> +.SH "USAGE"
> +To use function tracing you need to make sure the sources of your applic=
ation
> +are compiled with -finstrument-functions. It might be necessary to limit
> +the number of source files where this option is used to prevent excessive
> +amount of trace data to be generated during run time. Usually there are
> +additional compiler flags that allow you to specify more fine grained se=
lection
> +of function instrumentation.
> +
> +For each instrumented function the executable will contain calls to prof=
iling
> +function hooks (after function entry and just before function exit).
> +
> +By preloading (LD_PRELOAD) one of the provided shared libraries, these
> +profiling hooks get defined to emit LTTng events (as described above).
> +
> +Using this feature can result in massive amount trace data to be generat=
ed
> +by the instrumented application. Application runtime is also considerably
> +affected. Be careful on systems with limited resources.
> +.SH "SEE ALSO"
> +lttng-ust(3), lttng(1), gcc(1), ld.so(8)
> +.SH "BUGS"
> +If you encounter any issues or usability problem, please report it on
> +our mailing list <lttng-dev@lists.lttng.org> to help improve this
> +project.
> +.SH "CREDITS"
> +liblttng-ust is distributed under the GNU Lesser General Public License
> +version 2.1. The headers are distributed under the MIT license.
> +
> +See http://lttng.org for more information on the LTTng project.
> +
> +Mailing list for support and development: <lttng-dev@lists.lttng.org>.
> +
> +You can find us on IRC server irc.oftc.net (OFTC) in #lttng.
> +.SH "AUTHORS"
> +liblttng-ust was originally written by Mathieu Desnoyers, with additional
> +contributions from various other people. It is currently maintained by
> +Mathieu Desnoyers <mathieu.desnoyers@efficios.com>.
> -- =

> 1.7.10.4
> =

> =

> -- =

> Paul Woegerer | SW Development Engineer
> http://go.mentor.com/sourceryanalyzer
> =

> Mentor Embedded(tm) | Prinz Eugen Stra=DFe 72/2/4, Vienna, 1040 Austria
> Nucleus=AE | Linux=AE | Android(tm) | Services | UI | Multi-OS
> =

> Android is a trademark of Google Inc. Use of this trademark is subject to=
 Google Permissions.
> Linux is the registered trademark of Linus Torvalds in the U.S. and other=
 countries.

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
