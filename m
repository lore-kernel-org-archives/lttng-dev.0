From: David Goulet <dgoulet@efficios.com>
Subject: Re: infinite loop invoked using lttng
	enable/disable-event
Date: Tue, 25 Jun 2013 10:01:18 -0400
Message-ID: <51C9A2AE.1060204__28386.2367658459$1372168924$gmane$org@efficios.com>
References: <CA+f7N8kVuJyGCywE1H8ZujrYAmBKzEEUjtDH=poJYdE541APkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UrToE-0001BN-IT
	for lttng-dev@lists.lttng.org; Tue, 25 Jun 2013 10:01:26 -0400
In-Reply-To: <CA+f7N8kVuJyGCywE1H8ZujrYAmBKzEEUjtDH=poJYdE541APkw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Avi Goren <avi@reduxio.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hmmm

Can you report that on bugs.lttng.org with the session daemon logs (-vvv
--verbose-consumer) ?

If indeed the session daemon is stuck or even "lttng", it's a pretty serious issue.

Thanks!
David

Avi Goren:
> Hi,
> I'm using lttng 2.2.0 and encountered an infinite loop:
> -------------------------------------------------------------------------
> root@ubuntu:~# lttng create
> Session auto-20130624-165047 created.
> Traces will be written in /home/avig/lttng-traces/auto-20130624-165047
> root@ubuntu:~# lttng enable-event -a -u --loglevel TRACE_ALERT
> All UST events are enabled in channel channel0 for loglevel TRACE_ALERT
> root@ubuntu:~# lttng enable-event -a -u --loglevel TRACE_CRIT
> All UST events are enabled in channel channel0 for loglevel TRACE_CRIT
> root@ubuntu:~# lttng disable-event -a -u
> All UST events are disabled in channel channel0
> root@ubuntu:~# lttng enable-event -a -u --loglevel TRACE_CRIT
> All UST events are enabled in channel channel0 for loglevel TRACE_CRIT
> root@ubuntu:~# lttng disable-event -a -u
> (infinite loop here...)
> -------------------------------------------------------------------------
> I guess it's probably due to the setting of loglevel through enable-event twice..?
> Avi
> 
> 
> This body part will be downloaded on demand.
