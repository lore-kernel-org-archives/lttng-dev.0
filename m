From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: LTTng on Android
Date: Thu, 2 May 2013 16:59:59 -0400
Message-ID: <20130502205959.GD16536__41837.9966322847$1367528433$gmane$org@Krystal>
References: <CAMJ-Osde+NDU1U8d4Rew7tNfMnqXZU20n0Dq7cKY4YbkAM4hLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UY0bg-0006iu-PB
	for lttng-dev@lists.lttng.org; Thu, 02 May 2013 17:00:00 -0400
Content-Disposition: inline
In-Reply-To: <CAMJ-Osde+NDU1U8d4Rew7tNfMnqXZU20n0Dq7cKY4YbkAM4hLw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Santhosh Samarthyam <srsamarthyam@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Santhosh Samarthyam (srsamarthyam@gmail.com) wrote:
> Dear All,
> 
> I have been closely following the status of LTTng on Android based on
> the discussions in this mailing list.
> I would be great if someone could validate the following
> 
> - No need for LTTng kernel patch if kernel version > 2.6.38

true.

> - No dependency on glibc after version 2.0 of lttng.

false.

There has been interesting progress done on the Android side this
winter by Polytechnique. We should see the patches soon(ish).

The project will likely be continued in a Google Summer of Code project
this summer, especially for UST tracing.

Sorry for the late reply,

Thanks,

Mathieu

> 
> So can I build LTTng on Android (Version details below)
> 
> Android version: Icecream sandwich (4.0.1)
> Kernel version: 3.0.1
> 
> Can we build the following on an ARM based board running android?
> (After creating the android make files)
> LTTng-tools 2.0.4
> LTTng-modules 2.0.4
> LTTng-UST 2.0.4
> liburcu 0.7.3
> 
> I am more interested in getting the LTTng-UST to work.
> Any pointers on how to achieve this would be really helpful.
> 
> -- 
> Cheers,
> Santos
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
