From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH babeltrace 1/2] Add missing shebangs
	to	Python examples.
Date: Wed, 23 Jan 2013 09:45:50 -0500
Message-ID: <20130123144550.GA3952__3236.81540689922$1358952408$gmane$org@Krystal>
References: <1358898446-1622-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Ty1aM-0001pf-O6
	for lttng-dev@lists.lttng.org; Wed, 23 Jan 2013 09:45:54 -0500
Content-Disposition: inline
In-Reply-To: <1358898446-1622-1-git-send-email-jeremie.galarneau@efficios.com>
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

* J=E9r=E9mie Galarneau (jeremie.galarneau@efficios.com) wrote:
> =

> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  bindings/python/examples/babeltrace_and_lttng.py | 1 +
>  bindings/python/examples/eventcount.py           | 1 +
>  bindings/python/examples/eventcountlist.py       | 1 +
>  bindings/python/examples/events_per_cpu.py       | 1 +
>  bindings/python/examples/example-api-test.py     | 1 +
>  bindings/python/examples/histogram.py            | 1 +
>  bindings/python/examples/sched_switch.py         | 1 +
>  bindings/python/examples/softirqtimes.py         | 1 +
>  bindings/python/examples/syscalls_by_pid.py      | 1 +
>  9 files changed, 9 insertions(+)
>  mode change 100644 =3D> 100755 bindings/python/examples/babeltrace_and_l=
ttng.py
>  mode change 100644 =3D> 100755 bindings/python/examples/eventcount.py
>  mode change 100644 =3D> 100755 bindings/python/examples/eventcountlist.py
>  mode change 100644 =3D> 100755 bindings/python/examples/events_per_cpu.py
>  mode change 100644 =3D> 100755 bindings/python/examples/example-api-test=
.py
>  mode change 100644 =3D> 100755 bindings/python/examples/histogram.py
>  mode change 100644 =3D> 100755 bindings/python/examples/sched_switch.py
>  mode change 100644 =3D> 100755 bindings/python/examples/softirqtimes.py
>  mode change 100644 =3D> 100755 bindings/python/examples/syscalls_by_pid.=
py
> =

> diff --git a/bindings/python/examples/babeltrace_and_lttng.py b/bindings/=
python/examples/babeltrace_and_lttng.py
> old mode 100644
> new mode 100755
> index cb44796..5ab358c
> --- a/bindings/python/examples/babeltrace_and_lttng.py
> +++ b/bindings/python/examples/babeltrace_and_lttng.py
> @@ -1,3 +1,4 @@
> +#!/usr/bin/python

Please compare with other lttng projects (see tools tests), where I
think we use "env" and then python. So I'm not sure which roule we want
to go, but I think this has to do with Debian not having the same
symlinks that other distros wrt python 2 and 3.

Thanks,

Mathieu

>  # babeltrace_and_lttng.py
>  # =

>  # Babeltrace and LTTng example script
> diff --git a/bindings/python/examples/eventcount.py b/bindings/python/exa=
mples/eventcount.py
> old mode 100644
> new mode 100755
> index 5e96a43..0cc9e19
> --- a/bindings/python/examples/eventcount.py
> +++ b/bindings/python/examples/eventcount.py
> @@ -1,3 +1,4 @@
> +#!/usr/bin/python
>  # eventcount.py
>  # =

>  # Babeltrace event count example script
> diff --git a/bindings/python/examples/eventcountlist.py b/bindings/python=
/examples/eventcountlist.py
> old mode 100644
> new mode 100755
> index 945a960..eb413a8
> --- a/bindings/python/examples/eventcountlist.py
> +++ b/bindings/python/examples/eventcountlist.py
> @@ -1,3 +1,4 @@
> +#!/usr/bin/python
>  # eventcountlist.py
>  # =

>  # Babeltrace event count list example script
> diff --git a/bindings/python/examples/events_per_cpu.py b/bindings/python=
/examples/events_per_cpu.py
> old mode 100644
> new mode 100755
> index be497ec..7e871d1
> --- a/bindings/python/examples/events_per_cpu.py
> +++ b/bindings/python/examples/events_per_cpu.py
> @@ -1,3 +1,4 @@
> +#!/usr/bin/python
>  # events_per_cpu.py
>  # =

>  # Babeltrace events per cpu example script
> diff --git a/bindings/python/examples/example-api-test.py b/bindings/pyth=
on/examples/example-api-test.py
> old mode 100644
> new mode 100755
> index 104f2d5..37e9f4b
> --- a/bindings/python/examples/example-api-test.py
> +++ b/bindings/python/examples/example-api-test.py
> @@ -1,3 +1,4 @@
> +#!/usr/bin/python
>  # example_api_test.py
>  # =

>  # Babeltrace example script based on the Babeltrace API test script
> diff --git a/bindings/python/examples/histogram.py b/bindings/python/exam=
ples/histogram.py
> old mode 100644
> new mode 100755
> index 44616a6..533abeb
> --- a/bindings/python/examples/histogram.py
> +++ b/bindings/python/examples/histogram.py
> @@ -1,3 +1,4 @@
> +#!/usr/bin/python
>  # histogram.py
>  # =

>  # Babeltrace histogram example script
> diff --git a/bindings/python/examples/sched_switch.py b/bindings/python/e=
xamples/sched_switch.py
> old mode 100644
> new mode 100755
> index 7ae834b..cee882f
> --- a/bindings/python/examples/sched_switch.py
> +++ b/bindings/python/examples/sched_switch.py
> @@ -1,3 +1,4 @@
> +#!/usr/bin/python
>  # sched_switch.py
>  # =

>  # Babeltrace example script with sched_switch events
> diff --git a/bindings/python/examples/softirqtimes.py b/bindings/python/e=
xamples/softirqtimes.py
> old mode 100644
> new mode 100755
> index 903bf3e..8e465d2
> --- a/bindings/python/examples/softirqtimes.py
> +++ b/bindings/python/examples/softirqtimes.py
> @@ -1,3 +1,4 @@
> +#!/usr/bin/python
>  # softirqtimes.py
>  # =

>  # Babeltrace time of softirqs example script
> diff --git a/bindings/python/examples/syscalls_by_pid.py b/bindings/pytho=
n/examples/syscalls_by_pid.py
> old mode 100644
> new mode 100755
> index 3ae342e..30ece11
> --- a/bindings/python/examples/syscalls_by_pid.py
> +++ b/bindings/python/examples/syscalls_by_pid.py
> @@ -1,3 +1,4 @@
> +#!/usr/bin/python
>  # syscall_by_pid.py
>  # =

>  # Babeltrace syscall by pid example script
> -- =

> 1.8.1.1
> =

> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
