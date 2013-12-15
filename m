From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: Re: Viewing existing kernel tracepoints with LTTng
Date: Sun, 15 Dec 2013 17:49:40 -0500
Message-ID: <52AE3204.2030602__5244.5110668943$1387148171$gmane$org@gmail.com>
References: <DUB116-W92AC0AF296A377773DFA7CD5D90@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qe0-f43.google.com ([209.85.128.43])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <francis.giraldeau@gmail.com>) id 1VsKZr-0006ly-Ak
	for lttng-dev@lists.lttng.org; Sun, 15 Dec 2013 17:54:28 -0500
Received: by mail-qe0-f43.google.com with SMTP id 2so3320153qeb.16
	for <lttng-dev@lists.lttng.org>; Sun, 15 Dec 2013 14:54:17 -0800 (PST)
In-Reply-To: <DUB116-W92AC0AF296A377773DFA7CD5D90@phx.gbl>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Amit Schreiber <gnobal@outlook.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Le 2013-12-15 09:39, Amit Schreiber a =E9crit :
> Hi,
> =

> I started integrating LTTng into my code, and thought that existing trace=
points (which are visible with perf) will be immediately visible to LTTng. =
I obviously misunderstood or am doing something wrong.
> =

> What's the correct way to have existing perf tracepoints seen by LTTng?

LTTng adds probes to existing tracepoints in the kernel. Under the hood,
LTTng probe modules call tracepoint_probe_register() to add a callback
when the tracepoint is enabled. You can thus hook to any tracepoint
defined in the kernel, provided that the probe function have the right
signature. In the case of LTTng, the probe writes an event in the ring
buffer.

To make things safer and add type checking at compile-time, LTTng
defines the probe code with macros. In fact, all the module's probe code
is generated. Each tracepoint in the kernel must also have an LTTng
probe to be listed, and this is the proper way to do it. For the detail,
refer to the "probe" directory of lttng-modules.

Cheers,

Francis
