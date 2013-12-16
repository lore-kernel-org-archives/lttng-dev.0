From: Amit Schreiber <gnobal@outlook.com>
Subject: Re: Viewing existing kernel tracepoints with LTTng
Date: Mon, 16 Dec 2013 08:14:44 +0200
Message-ID: <DUB116-W138810902A63C341036F5B2D5D80__13314.7354041741$1387212842$gmane$org@phx.gbl>
References: <DUB116-W92AC0AF296A377773DFA7CD5D90@phx.gbl>,
	<52AE3204.2030602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from dub0-omc3-s17.dub0.hotmail.com ([157.55.2.26])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <gnobal@outlook.com>) id 1VsRS6-0001rm-3Y
	for lttng-dev@lists.lttng.org; Mon, 16 Dec 2013 01:14:52 -0500
In-Reply-To: <52AE3204.2030602@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Francis Giraldeau <francis.giraldeau@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----------------------------------------
> Date: Sun, 15 Dec 2013 17:49:40 -0500
> From: francis.giraldeau@gmail.com
> To: gnobal@outlook.com
> CC: lttng-dev@lists.lttng.org
> Subject: Re: [lttng-dev] Viewing existing kernel tracepoints with LTTng
>
> Le 2013-12-15 09:39, Amit Schreiber a =E9crit :
>> Hi,
>>
>> I started integrating LTTng into my code, and thought that existing trac=
epoints (which are visible with perf) will be immediately visible to LTTng.=
 I obviously misunderstood or am doing something wrong.
>>
>> What's the correct way to have existing perf tracepoints seen by LTTng?
>
> LTTng adds probes to existing tracepoints in the kernel. Under the hood,
> LTTng probe modules call tracepoint_probe_register() to add a callback
> when the tracepoint is enabled. You can thus hook to any tracepoint
> defined in the kernel, provided that the probe function have the right
> signature. In the case of LTTng, the probe writes an event in the ring
> buffer.
>
> To make things safer and add type checking at compile-time, LTTng
> defines the probe code with macros. In fact, all the module's probe code
> is generated. Each tracepoint in the kernel must also have an LTTng
> probe to be listed, and this is the proper way to do it. For the detail,
> refer to the "probe" directory of lttng-modules.
>
> Cheers,
>
> Francis
>

Thanks a lot, Francis. I appreciate the help and quick response.

Amit 		 	   		  =
