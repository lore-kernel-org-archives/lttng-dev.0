From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: enable-event wildcards
Date: Mon, 29 Apr 2019 12:04:39 -0400
Message-ID: <20190429160439.GA8588__3312.09287266887$1556553913$gmane$org@joraj-alpa>
References: <CAHryLm77cSdg4WDwYrfsCr9fHYyRH5rrQKq7O=Roq3k14_aVjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44t8cX3mJVz1L7L
 for <lttng-dev@lists.lttng.org>; Mon, 29 Apr 2019 12:04:44 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAHryLm77cSdg4WDwYrfsCr9fHYyRH5rrQKq7O=Roq3k14_aVjQ@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Joe Sutker <jomasu22@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Joe,

On Mon, Apr 29, 2019 at 11:13:33AM -0400, Joe Sutker wrote:
> Hello LTTng Devs,
> 
> When using `lttng enable-event -u`, putting a wildcard anywhere but the end
> of the event name causes an error (Invalid event name). Is this intended
> behavior? If so, the man pages should probably be changed.

Could you provide more information on the version used?

I'm currently trying to reproduce on latest stable-2.10 and it seems to
work fine.

joraj@~/lttng/stable-2.10[]$ lttng list -u
UST events:
-------------

PID: 11538 - Name: ../lttng-ust/doc/examples/easy-ust/sample
      lttng_ust_tracelog:TRACE_DEBUG (loglevel: TRACE_DEBUG (14)) (type: tracepoint)
      lttng_ust_tracelog:TRACE_DEBUG_LINE (loglevel: TRACE_DEBUG_LINE (13)) (type: tracepoint)
      lttng_ust_tracelog:TRACE_DEBUG_FUNCTION (loglevel: TRACE_DEBUG_FUNCTION (12)) (type: tracepoint)
      lttng_ust_tracelog:TRACE_DEBUG_UNIT (loglevel: TRACE_DEBUG_UNIT (11)) (type: tracepoint)
      lttng_ust_tracelog:TRACE_DEBUG_MODULE (loglevel: TRACE_DEBUG_MODULE (10)) (type: tracepoint)
      lttng_ust_tracelog:TRACE_DEBUG_PROCESS (loglevel: TRACE_DEBUG_PROCESS (9)) (type: tracepoint)
      lttng_ust_tracelog:TRACE_DEBUG_PROGRAM (loglevel: TRACE_DEBUG_PROGRAM (8)) (type: tracepoint)
      lttng_ust_tracelog:TRACE_DEBUG_SYSTEM (loglevel: TRACE_DEBUG_SYSTEM (7)) (type: tracepoint)
      lttng_ust_tracelog:TRACE_INFO (loglevel: TRACE_INFO (6)) (type: tracepoint)
      lttng_ust_tracelog:TRACE_NOTICE (loglevel: TRACE_NOTICE (5)) (type: tracepoint)
      lttng_ust_tracelog:TRACE_WARNING (loglevel: TRACE_WARNING (4)) (type: tracepoint)
      lttng_ust_tracelog:TRACE_ERR (loglevel: TRACE_ERR (3)) (type: tracepoint)
      lttng_ust_tracelog:TRACE_CRIT (loglevel: TRACE_CRIT (2)) (type: tracepoint)
      lttng_ust_tracelog:TRACE_ALERT (loglevel: TRACE_ALERT (1)) (type: tracepoint)
      lttng_ust_tracelog:TRACE_EMERG (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      lttng_ust_tracef:event (loglevel: TRACE_DEBUG (14)) (type: tracepoint)
      lttng_ust_lib:unload (loglevel: TRACE_DEBUG_LINE (13)) (type: tracepoint)
      lttng_ust_lib:debug_link (loglevel: TRACE_DEBUG_LINE (13)) (type: tracepoint)
      lttng_ust_lib:build_id (loglevel: TRACE_DEBUG_LINE (13)) (type: tracepoint)
      lttng_ust_lib:load (loglevel: TRACE_DEBUG_LINE (13)) (type: tracepoint)
      lttng_ust_statedump:end (loglevel: TRACE_DEBUG_LINE (13)) (type: tracepoint)
      lttng_ust_statedump:debug_link (loglevel: TRACE_DEBUG_LINE (13)) (type: tracepoint)
      lttng_ust_statedump:build_id (loglevel: TRACE_DEBUG_LINE (13)) (type: tracepoint)
      lttng_ust_statedump:bin_info (loglevel: TRACE_DEBUG_LINE (13)) (type: tracepoint)
      lttng_ust_statedump:start (loglevel: TRACE_DEBUG_LINE (13)) (type: tracepoint)
      sample_component:message1 (loglevel: TRACE_DEBUG_LINE (13)) (type: tracepoint)
      sample_component:message (loglevel: TRACE_WARNING (4)) (type: tracepoint)

joraj@~/lttng/stable-2.10[]$ lttng create
Session auto-20190429-120017 created.
Traces will be written in /home/joraj/lttng/stable-2.10//home/lttng-traces/auto-20190429-120017
joraj@~/lttng/stable-2.10[]$ lttng enable-event -u 'lttng*end'
UST event lttng*end created in channel channel0
joraj@~/lttng/stable-2.10[]$ lttng start
Tracing started for session auto-20190429-120017
joraj@~/lttng/stable-2.10[]$ lttng regenerate statedump
State dump successfully regenerated for session auto-20190429-120017
joraj@~/lttng/stable-2.10[]$ lttng stop
Waiting for data availability
Tracing stopped for session auto-20190429-120017
joraj@~/lttng/stable-2.10[]$ lttng view
Trace directory: /home/joraj/lttng/stable-2.10//home/lttng-traces/auto-20190429-120017

[12:00:49.951171757] (+?.?????????) joraj-alpa lttng_ust_statedump:end: { cpu_id = 3 }, { }
[12:00:56.558471131] (+6.607299374) joraj-alpa lttng_ust_statedump:end: { cpu_id = 3 }, { }

We can see that only the events matching "lttng*end" are accounted for here.

Could you give us an example of pattern not working?

Cheers

-- 
Jonathan Rajotte-Julien
EfficiOS
