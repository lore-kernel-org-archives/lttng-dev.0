From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] Expose kernel tracer to user-space	(version
	5)
Date: Mon, 2 Jul 2012 11:14:58 -0400
Message-ID: <20120702151458.GA14036__23894.9534985752$1341242151$gmane$org@Krystal>
References: <1341236847-16300-1-git-send-email-francis.giraldeau@gmail.com>
	<20120702141353.GA12843@Krystal> <4FF1B5B7.50102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1SliL6-0007Ot-P3
	for lttng-dev@lists.lttng.org; Mon, 02 Jul 2012 11:15:00 -0400
Content-Disposition: inline
In-Reply-To: <4FF1B5B7.50102@gmail.com>
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

* Francis Giraldeau (francis.giraldeau@gmail.com) wrote:
> Le 2012-07-02 16:13, Mathieu Desnoyers a =E9crit :
> > * Francis Giraldeau (francis.giraldeau@gmail.com) wrote:
> >> By writing to the file /proc/lttng, a user-space application creates a
> >> kernel event. The event's payload is by default UTF-8 text, but any da=
ta
> >> can be written, up to 1024 bytes. Null-character is optional and is not
> >> enforced. The event uses sequence for space efficiency and to store any
> >> data as payload.
> > =

> > Why limit to 1024 bytes ? We could use a string_from_user, and write it
> > into a null-terminated string instead.
> =

> This is the same limit as printk:
> =

>   #define LOG_LINE_MAX 1024
> =

> We can't use string_from_user because it's not possible to assume that
> the string from user-space is null terminated and we can't changed it in
> order to avoid double copy. Thus, I think the current mechanism is
> appropriate.

Agreed that the sequence is appropriate in that case. However, why the
1024 byte limit ? What is the technical reason for having this limit ?
By understanding why we have it, we can find a way to remove it...

> =

> Anyway, if the application really wants all the data to be written, then
> it can create another event with the remaining data, since the number of
> bytes written is returned.

I'd like to avoid that. Ideally, I'd let the maximum event size be
limited by the packet size, which is configurable by the user.

> =

> >> The feature is enabled when both lttng-uevent and lttng-probe-uevent a=
re
> >> loaded.
> > =

> > Why not combine those two into a single module ?
> =

> The problem is that the probe code creates it's own module_init and
> module_exit functions, and I didn't found a way to override properly and
> still call the probe registration. The easy way was to create two
> modules, but yes I would prefer it to be combined. What can be done for
> that?

#define TP_MODULE_OVERRIDE

before including the trace header.

see probes/lttng-events.h.

Thanks,

Mathieu

> =

> >> Module unload must be prevented while lttng-uevent is being used.
> >> rcu_synchronized() is call on module unload, and thus rcu_read_lock() =
can be
> > =

> > is call -> is called, or is invoked
> =

> fixed.
> =

> Thanks!
> =

> Francis
> =




> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- =

Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
