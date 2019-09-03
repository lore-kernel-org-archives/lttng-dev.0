From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: Problem with vpid in lttng output
Date: Tue, 3 Sep 2019 11:38:04 -0400
Message-ID: <20190903153804.GB15770__35519.2201839358$1567525116$gmane$org@joraj-alpa>
References: <AM0PR07MB590692B318D8FC8187D54EEB96BE0@AM0PR07MB5906.eurprd07.prod.outlook.com>
 <20190902193349.GA15770@joraj-alpa>
 <AM0PR07MB5906EED53E454550B5A4503396B90@AM0PR07MB5906.eurprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 46NB1K2C6HzsYQ
 for <lttng-dev@lists.lttng.org>; Tue,  3 Sep 2019 11:38:12 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id D8E70257835
 for <lttng-dev@lists.lttng.org>; Tue,  3 Sep 2019 11:38:05 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <AM0PR07MB5906EED53E454550B5A4503396B90@AM0PR07MB5906.eurprd07.prod.outlook.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Aleksander Twardowski <aleksander.twardowski@ericsson.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

Note that the restriction to prevent an add-context command on a
started session is not present in 2.10.2. It is present starting at 2.10.3.

 joraj@~/lttng/stable-2.10/lttng-tools [(v2.10.7)][]$ git tag --contains 3aaf55eaa5aee2db6e2a1a46685e45f2395fc15b
 v2.10.3
 v2.10.4
 v2.10.5
 v2.10.6
 v2.10.7

This would explain why you can issue the commands in the order you are issuing
them currently (add-context after start).

 lttng create csim_session_rpup -o /tmp/csim_session_rpup
 lttng enable-event -u
 lttng start csim_session_rpup
 lttng add-context -u -t vpid
 lttng track -u -s csim_session_rpup --all

To comply with this without upgrading, you can swap the order of the add-context
and start command.

commands:

 lttng create
 lttng enable-event -u ...
 lttng add-context -u -t vpid
 lttng start
 lttng track ...

I did some experiment using v2.10.2 to reproduce the issue.
I used the same sequence of commands you provided:

 lttng create csim_session_rpup -o /tmp/csim_session_rpup
 lttng enable-event -u
 lttng start csim_session_rpup
 lttng add-context -u -t vpid
 lttng track -u -s csim_session_rpup --all

At first, I tried a scenario where the only instrumented (registered) app is run
after the add-context. No other instrumented apps were running at the moment the
"lttng start" was issued. The trace produced contained the vpid context.

What happen if an instrumented app is already running when the "lttng start"
command is issued? The "lttng add-context" does not report any problem yet the
resulting trace does not contain any vpid context.

In the lttng-sessiond logs we see that the add-context command failed for the app:

  DEBUG2 - 11:19:43.718781 [9499/9506]: UST app adding context to channel channel0 (in create_ust_app_channel_context() at ust-app.c:2357)
  DEBUG3 - 11:19:43.718784 [9499/9506]: UST app context 1 allocated (in alloc_ust_app_ctx() at ust-app.c:1146)
  Error: UST app create channel context failed for app (pid: 7350) with ret -1028
  Error: Failed to add context to channel channel0

The first scenario works because we delay the setup of the channel until an app
eligible for tracing is present.

That should be it.

Cheers

-- 
Jonathan Rajotte-Julien
EfficiOS
