From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Enumerated types in lttng-ust traces?
Date: Thu, 21 Jun 2012 00:00:07 -0400
Message-ID: <20120621040007.GA3080__45803.4914140173$1340251235$gmane$org@Krystal>
References: <jrttfa$8go$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1ShYYz-0002MW-DF
	for lttng-dev@lists.lttng.org; Thu, 21 Jun 2012 00:00:09 -0400
Content-Disposition: inline
In-Reply-To: <jrttfa$8go$1@dough.gmane.org>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: John Steele Scott <toojays@toojays.net>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* John Steele Scott (toojays@toojays.net) wrote:
> It seems that the CTF supports enumerations, and babeltrace has
> support for pretty-printing them. But how do you get lttng-ust to emit
> them? Is this possible?
> 
> Right now I'm just using ctf_integer, but it seems like there should
> be way to show human-readable enumeration names in the trace.

Hi John,

You are right, CTF supports enumerations. Currently, neither
lttng-modules nor lttng-ust allow emitting those enumerations from
tracepoints (it's just not been implemented yet).

We'd have to add that to LTTng-UST tracepoints, e.g., something
resembling to:

TRACEPOINT_ENUM(enum_name,
        TP_ENUM_V(SOMENAMEA)            /* value 0 */
        TP_ENUM_V(SOMENAMEB)            /* value 1 */
        TP_ENUM_V(SOMENAMEC, 5)         /* value 5 */
        TP_ENUM_V(SOMENAMED)            /* value 6 */
        TP_ENUM_R(SOMENAMEE, 8, 10)     /* range 8 to 10 (inclusive) */
        TP_ENUM_V(SOMENAMEF)            /* value 11 */
)

then:

TRACEPOINT_EVENT(prog_module, event,
        TP_ARGS(int, someint),
        TP_FIELDS(
                ctf_enum(enum_name, int, fieldname, someint)
        )
)

where ctf_enum would be:

ctf_enum(name of enumeration,
        type of enumeration container,
        name of the field,
        name of the TP_ARGS entry to use as source
)

I did early experiments with this in lttng-modules (code unfinished and
unused at this stage). You can dig it up in the files:

probes/lttng-type-list.h
probes/lttng-types.h

of lttng-modules. Please keep in mind that these are unfinished and
might need a lot of changes to get straight.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
