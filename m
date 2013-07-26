From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Re: Misc questions regarding kernel tracing
Date: Fri, 26 Jul 2013 17:41:23 -0400
Message-ID: <51F2ED03.2040608__31781.8003976301$1374874945$gmane$org@efficios.com>
References: <CAPkDDd4QX-Coj5rnqZp5pLjrzWOUDOvRu+6PWZW+EOYAEH0vtw@mail.gmail.com>
	<51F2D902.80701@voxpopuli.im>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fukushima.klipix.org ([194.250.102.243])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1V2plT-00027J-T2
	for lttng-dev@lists.lttng.org; Fri, 26 Jul 2013 17:41:36 -0400
In-Reply-To: <51F2D902.80701@voxpopuli.im>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi S=E9bastien,

[...]

>> I sometimes miss kernel events. Is there a point in using different
>> channels for kernel and user space traces (besides giving them distinct
>> sizes)? I suspect they're already effectively different even if they have
>> the same name. Also, I have increased the subbuffer size a lot, but did =
not
>> change the number of subbuffers. Would that help preventing missed event=
s?

Indeed, kernel and user-space traces are already in different channels.
Enabling different channels for the same domain (kernel or ust) is
especially useful when you have different level of interest for
different events.
For example, if you absolutely want all the sched_switch events, you
could have a dedicated channel for these events, with the appropriate
size and number of subbuffers, and then enable other channels for the
other events you are interested in, that way you limit the risk of
loosing your most important events.

Regarding your question about the state system, I don't know how TMF
handles that, but the contexts are a good way to ensure a consistent
state without any state system. For example, you can attach a pid or
procname context to all the events in a specific channel. Every time an
event is recorded in this channel, the tracer will fetch the current
procname/pid information. That way you are sure to have a consistent
state even if you don't have all the scheduling and statedump events.
The drawback, is that it increases slightly the operations done by the
tracer on the fast path and the trace is bigger.

Hope this helps,

Julien
