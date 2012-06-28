From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: Re: [PATCH] tracepoint event exclusion
Date: Thu, 28 Jun 2012 11:26:45 +0200
Message-ID: <4FEC2355.2040104__48327.277127146$1340875678$gmane$org@mentor.com>
References: <4FEB13CE.1010206@mentor.com> <20120627183308.GA19735@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1SkAzV-0004U7-3N
	for lttng-dev@lists.lttng.org; Thu, 28 Jun 2012 05:26:21 -0400
In-Reply-To: <20120627183308.GA19735@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 06/27/2012 08:33 PM, Mathieu Desnoyers wrote:
>
> hrm, although possibly interesting, I don't think this semantic follows
> the lttng UI event enabling semantic. There are a few use-cases to
> cover:
>
> 1) enable tracepoints, start tracing, run app.
>
> 2) enable some tracepoints, start tracing, run app, enable more
>     tracepoints while app is running.
>
> 3) start tracing, run app, enable all tracepoints while app is running.
>
> AFAIU, your patch and proposed semantic covers use-case #1, but breaks
> the other 2. Basically, we have to apply a logical "or" between each
> enable-event command (rather than an "and" as your proposed semantic
> suggests), because they can be applied independently.

You are right, I only had use-case #1 in mind when I wrote this patch. I =

intentionally kept my modifications small not to break any of the the =

existing functionality if "!" is not used.

Let me provide a more elaborate description of what this patch is doing:

Original behavior:

match_wildcard():
    Check if a wildcard_entry matches the given lttng_event_desc name. =

If a mach is found and the loglevel also matches return the =

wildcard_entry. Otherwise return 0.

ltt_event_create():
    If an event with the given name does not already exist create one, =

pass a pointer to it (via _event) and return 0. If an event with the =

given name already exists return -EEXIST.

Behavior after patch:

match_wildcard():
    First check if there is a wildcard_entry that starts with "!" that =

matches the given lttng_event_desc name. If a filter matches return 0 =

(no match). If not proceed as before.

ltt_event_create():
    If an event should be created that starts with "!" do not create it =

but instead add a new wildcard_entry (if not already existing in the =

wildcard_list). Otherwise as before.

Note that the change of ltt_event_create() was necessary to make sure =

that also things like:

lttng enable-event -u -c met_tools --tracepoint '!met_func:enter'

work (i.e. filters that do not have a '*' at the end).

>
> We could however try to come up with an event attribute that gets
> applied on a specific event, e.g.:
>
> lttng enable-event -u -a --exclude 'met_func:*' --exclude 'met_call:*'

I would prefer your "--exclude" over my solution but I doubt that I =

could implement it properly. Are you planning to add "--exclude" =

yourself or could you provide me with detailed instructions how to =

implement it (which functions and structures need to be adapted).

--
Thanks,
Paul

-- =

Paul Woegerer | SW Development Engineer
Mentor Embedded(tm) | Prinz Eugen Stra=DFe 72/2/4, Vienna, 1040 Austria
P 43.1.535991320
Nucleus=AE | Linux=AE | Android(tm) | Services | UI | Multi-OS

Android is a trademark of Google Inc. Use of this trademark is subject to G=
oogle Permissions.
Linux is the registered trademark of Linus Torvalds in the U.S. and other c=
ountries.
