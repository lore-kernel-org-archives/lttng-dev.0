From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: UST app and lttng-tools compatibility
Date: Sat, 29 Sep 2012 14:28:00 -0400
Message-ID: <20120929182800.GA19994__49159.8572735258$1348943307$gmane$org@Krystal>
References: <50670C5A.4060800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TI1li-0001z5-EZ
	for lttng-dev@lists.lttng.org; Sat, 29 Sep 2012 14:28:02 -0400
Content-Disposition: inline
In-Reply-To: <50670C5A.4060800@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Francis Giraldeau <francis.giraldeau@gmail.com>, dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Francis Giraldeau (francis.giraldeau@gmail.com) wrote:
> Hi,
> 
> I wanted to share my lttng-ust 2.1 update experience, maybe it will save
> time for others.
> 
> I updated lttng-ust recently. After this change, the app would not
> produce a trace anymore. No error message is displayed by the traced app
> to indicate that something is wrong. Even when setting LTTNG_DEBUG_UST
> to the app's environment variable, there is no error message. The debug
> output suggests that probes are registered and everything is fine, while
> it's not.
> 
> By running lttng-sessiond with -vvv --verbose-consumer, I finally got
> this message:
> 
> DEBUG2: UST app PID 8112 is not compatible with major version 3
> (supporting <= 2) [in ust_app_validate_version() at ust-app.c:2633]
> 
> Updating lttng-tools to 2.1 solved the issue. Seems that it's mandatory
> to update lttng-tools to support latest lttng-ust. It may be obvious for
> developers, but it should be clear for users that they must upgrade both.
> 
> IMHO, It would be nice if the app side log could tell if the
> session/consumer refused the registration.

I agree we should do better.

Regarding lttng-tools, I think changing this DBG2 message to a WARN
message would help, so sessiond would show the warning, except in the
case where it is started with "-d".

On the application side, this is a bit tricky. It has no way to find out
that it has been rejected by the sessiond. The application registers at
startup, and then the sessiond keeps the connexion active, but flags it
as incompatible internally. The reason we do that is because we don't
want the application to retry endlessly.

Moreover, I cannot change the code for the existing 2.0 UST libs, so
adding a new message is not possible.

One thing we have in mind for 2.2 or 2.3 is to add syslog support within
the sessiond. This would provide a nice centralized place to look at
those logs.

Thoughts ?

Thanks,

Mathieu


> 
> Cheers,
> 
> Francis Giraldeau
> 



> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
