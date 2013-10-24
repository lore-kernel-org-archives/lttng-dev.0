From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Some corrections to the
 lttng man page
Date: Thu, 24 Oct 2013 07:30:58 -0400
Message-ID: <20131024113058.GB26036__3440.22586145929$1382614318$gmane$org@dalia>
References: <1382544527-10607-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1644254950=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1VZJ8B-0001iW-Cq
	for lttng-dev@lists.lttng.org; Thu, 24 Oct 2013 07:31:12 -0400
In-Reply-To: <1382544527-10607-1-git-send-email-jeremie.galarneau@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============1644254950==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
Content-Disposition: inline


--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged! Thanks

I've also backported this one to stable-2.3.

On 23 Oct (12:08:47), J=E9r=E9mie Galarneau wrote:
> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  doc/man/lttng.1 | 54 +++++++++++++++++++++++++++------------------------=
---
>  1 file changed, 27 insertions(+), 27 deletions(-)
>=20
> diff --git a/doc/man/lttng.1 b/doc/man/lttng.1
> index 42f25e4..a16c7c3 100644
> --- a/doc/man/lttng.1
> +++ b/doc/man/lttng.1
> @@ -11,13 +11,13 @@ lttng [OPTIONS] <COMMAND>
> =20
>  .PP
>  The LTTng project aims at providing highly efficient tracing tools for L=
inux.
> -It's tracers help tracking down performance issues and debugging problems
> +Its tracers help track down performance issues and debug problems
>  involving multiple concurrent processes and threads. Tracing across mult=
iple
>  systems is also possible.
> =20
>  The \fBlttng\fP command line tool from the lttng-tools package is used t=
o control
> -both kernel and user-space tracing. Every interactions with the tracer s=
hould
> -be done by this tool or by the liblttng-ctl provided with the lttng-tools
> +both kernel and user-space tracing. Every interaction with the tracer sh=
ould
> +be done by this tool or by the liblttng-ctl library provided by the lttn=
g-tools
>  package.
> =20
>  LTTng uses a session daemon (lttng-sessiond(8)), acting as a tracing reg=
istry,
> @@ -29,19 +29,18 @@ those traces is done using the babeltrace(1) text vie=
wer.
>  We introduce the notion of \fBtracing domains\fP which is essentially a =
type of
>  tracer (kernel or user space for now). In the future, we could see a thi=
rd
>  tracer being for instance an hypervisor. For some commands, you'll need =
to
> -specify on which domain the command applies (-u or -k). For instance, en=
abling
> -a kernel event, you must specify the kernel domain to the command so we =
know
> -for which tracer this event is for.
> +specify on which domain the command operates (-u or -k). For instance, t=
he
> +kernel domain must be specified when enabling a kernel event.
> =20
>  In order to trace the kernel, the session daemon needs to be running as =
root.
>  LTTng provides the use of a \fBtracing group\fP (default: tracing). Whom=
ever is
>  in that group can interact with the root session daemon and thus trace t=
he
> -kernel. Session daemons can co-exist meaning that you can have a session=
 daemon
> +kernel. Session daemons can co-exist, meaning that you can have a sessio=
n daemon
>  running as Alice that can be used to trace her applications along side w=
ith a
> -root daemon or even a Bob daemon. We highly recommend to start the sessi=
on
> +root daemon or even a Bob daemon. We highly recommend starting the sessi=
on
>  daemon at boot time for stable and long term tracing.
> =20
> -Every user-space applications instrumented with lttng-ust(3), will
> +All user-space applications instrumented with lttng-ust(3) will
>  automatically register to the session daemon. This feature gives you the
>  ability to list available traceable applications and tracepoints on a pe=
r user
>  basis. (See \fBlist\fP command).
> @@ -219,7 +218,7 @@ Dynamic function entry/return probe (default)
>  Create tracing session.
> =20
>  A tracing session contains channel(s) which contains event(s). It is dom=
ain
> -agnostic meaning that you can enable channels and events for either the
> +agnostic, meaning that channels and events can be enabled for the
>  user-space tracer and/or the kernel tracer. It acts like a container
>  aggregating multiple tracing sources.
> =20
> @@ -247,11 +246,11 @@ Simple listing of options
>  Specify output path for traces
>  .TP
>  .BR "\-\-no-output"
> -Traces will not be outputted
> +Traces will not be output
>  .TP
>  .BR "\-\-snapshot"
>  Set the session in snapshot mode. Created in no-output mode and uses the
> -URL, if one, as the default snapshot output.  Every channel will be set
> +URL, if one is specified, as the default snapshot output.  Every channel=
 will be set
>  in overwrite mode and with mmap output (splice not supported).
>  .TP
>  .BR "\-\-live USEC"
> @@ -445,7 +444,7 @@ created to the specified count. 0 means unlimited. (d=
efault: 0)
>  .nf
>  $ lttng enable-channel -k -C 4096 -W 32 chan1
>  .fi
> -For each stream, the maximum size of each trace file will be 4096 bytes,=
 and
> +For each stream, the maximum size of each trace file will be 4096 bytes =
and
>  there will be a maximum of 32 different files. The file count is appende=
d after
>  the stream number as seen in the following example. The last trace file =
is
>  smaller than 4096 since it was not completely filled.
> @@ -497,7 +496,7 @@ Apply on session name
>  Apply on channel name
>  .TP
>  .BR "\-a, \-\-all"
> -Enable all tracepoints and syscalls. This actually enable a single
> +Enable all tracepoints and syscalls. This actually enables a single
>  wildcard event "*".
>  .TP
>  .BR "\-k, \-\-kernel"
> @@ -507,7 +506,7 @@ Apply for the kernel tracer
>  Apply for the user-space tracer
>  .TP
>  .BR "\-\-tracepoint"
> -Tracepoint event (default). Userspace tracer supports wildcards at end
> +Tracepoint event (default). Userspace tracer supports wildcards at the e=
nd
>  of string. Don't forget to quote to deal with bash expansion.
>  e.g.:
>  .nf
> @@ -538,12 +537,13 @@ limitation. You can disable the entire channel to d=
o the trick.
>  .TP
>  .BR "\-\-filter 'expression'"
>  Set a filter on a newly enabled event. Filter expression on event
> -fields and context. Event recording depends on evaluation. Only
> -specify on first activation of a given event within a session.
> -Filter only allowed when enabling events within a session before
> +fields and context. The event will be recorded if the filter's
> +expression evaluates to TRUE. Only specify on first activation of a
> +given event within a session.
> +Specifying a filter is only allowed when enabling events within a sessio=
n before
>  tracing is started. If the filter fails to link with the event
>  within the traced domain, the event will be discarded.
> -Currently, filter is only implemented for the user-space tracer.
> +Filtering is currently only implemented for the user-space tracer.
> =20
>  Expression examples:
> =20
> @@ -556,13 +556,13 @@ Expression examples:
>  Wildcards are allowed at the end of strings:
>    'seqfield1 =3D=3D "te*"'
>  In string literals, the escape character is a '\\'. Use '\\*' for
> -the '*' character, and '\\\\' for the '\\' character. Wildcard
> -match any sequence of characters, including an empty sub-string
> -(match 0 or more characters).
> +the '*' character, and '\\\\' for the '\\' character sequence. Wildcard
> +matches any sequence of characters, including an empty sub-string
> +(matches 0 or more characters).
> =20
> -Context information can be used for filtering. The examples below show
> -usage of context filtering on process name (with a wildcard), process ID
> -range, and unique thread ID for filtering.  The process and thread ID of
> +Context information can be used for filtering. The examples below shows
> +usage of context filtering on the process name (using a wildcard), proce=
ss ID
> +range, and unique thread ID. The process and thread IDs of
>  running applications can be found under columns "PID" and "LWP" of the
>  "ps -eLf" command.
> =20
> @@ -580,8 +580,8 @@ running applications can be found under columns "PID"=
 and "LWP" of the
>  .RS
>  Disable tracing channel
> =20
> -Disabling a channel makes all event(s) in that channel to stop tracing. =
You can
> -enable it back by calling \fBlttng enable-channel NAME\fP again.
> +Disabling a channel disables the tracing of all of the channel's events.=
 A channel
> +can be reenabled by calling \fBlttng enable-channel NAME\fP again.
> =20
>  If \fB\-s, \-\-session\fP is omitted, the session name is taken from the=
 .lttngrc
>  file.
> --=20
> 1.8.4
>=20
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQF8BAEBAgBmBQJSaQTyXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02f0EIAI6xv1xE26gAxh3X6M0/kxSp
ximQHSWm75IMWqCVHiZqFUv/ffGvYpwicEQmIbMDQfleDLBC+/0AvgfV/YtO4dSW
CMb+atWEpSjSY2q3h0NFO4xWiSge2nWGxUtMMZTOdoL5/CEiNcV0XwCd3kako+sS
hpl7JPs/m3ITPr3+R7idVFooodkjhFlNivw6X0vm3r4/6sas9uqOBtTEwmZmsIKX
3zsbtixoOaVRWUXGLS6bVKuI9xA7iOXJx/58eNCm/l5l4D42gFjw3l5dc5KITa9p
eS1snteUnPjiHa7JRaU3SnW8KmDCYqhimuOxqcE3ZHkgaT8T+nBFsmpaGA8Zago=
=E4FH
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--


--===============1644254950==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1644254950==--
