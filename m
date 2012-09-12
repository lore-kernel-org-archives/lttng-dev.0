From: Christian Babeux <christian.babeux@efficios.com>
Subject: Re: [PATCH RFC lttng-tools] Testpoint mechanism
Date: Tue, 11 Sep 2012 22:26:10 -0400
Message-ID: <CAGDH53nroLAnBhDYqLNLNwC-_82qoGqKTzVhG1G9di7TsEv0bA__2509.91528523645$1347416812$gmane$org@mail.gmail.com>
References: <1347396978-4661-1-git-send-email-christian.babeux@efficios.com>
	<CAEzWAeK5rh5Qb4421bkjhfsFHwYpeuRk1_SEwtpXjbUoWoCAnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1TBcee-0005y9-QG
	for lttng-dev@lists.lttng.org; Tue, 11 Sep 2012 22:26:16 -0400
Received: by lboi15 with SMTP id i15so975890lbo.35
	for <lttng-dev@lists.lttng.org>; Tue, 11 Sep 2012 19:26:10 -0700 (PDT)
In-Reply-To: <CAEzWAeK5rh5Qb4421bkjhfsFHwYpeuRk1_SEwtpXjbUoWoCAnw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Brosseau, Yannick" <yannick.brosseau@gmail.com>
Cc: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com, David Goulet <dgoulet@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Hi Yannick,

>
> I'm not sure I understand the goal of this feature. Can you explain more?
>

This testpoint mechanism is not a LTTng "feature" per se. Think of it
has a  facility to inject code in order to test different portions of
the LTTng codebase.

Maybe an example will make things more clear:

In the lttng-sessiond, we could add testpoints to some of the threads.
The testpoints could trigger a pthread_exit().
This could be useful to verify that the new health check feature is
working and properly mark the thread that exited as
in "bad health". Without this mechanism, writing tests for that
particular feature would be a lot harder.

Another example would be to randomly add delays in different threads
in order to find race conditions in the codebase.

This mechanism is only triggered when the LTTNG_TESTPOINT_ENABLE env.
var. is set and a proper library is preloaded with the testpoints
symbols (e.g.: LD_PRELOAD=mytestlib.so lttng-sessiond &). The only way
to use this facility is to link against the new libtestpoint.

I hope this make more sense now :).

Christian
