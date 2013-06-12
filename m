From: David Goulet <dgoulet@efficios.com>
Subject: Re: Will LTTng overwrite existing trace files after
 reboot, or continue where the previous instance left off?
Date: Wed, 12 Jun 2013 10:52:01 -0400
Message-ID: <51B88B11.3020401__35321.6984695338$1371048763$gmane$org@efficios.com>
References: <OFBF5287EA.D7EE217E-ONC2257B88.004F3A88-C2257B88.004FF39E@il.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UmmPA-0000v0-Ak
	for lttng-dev@lists.lttng.org; Wed, 12 Jun 2013 10:52:08 -0400
In-Reply-To: <OFBF5287EA.D7EE217E-ONC2257B88.004F3A88-C2257B88.004FF39E@il.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Amit Margalit <AMITM@il.ibm.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

It's possible yes if the session path is exactly the same but this is why we add
the date and time to the session directory so we don't end up overwriting old
traces with the same session name.

Can you tell me what is the full path of the session directory. It should look
something like (with some variations).

~/lttng-traces/fo-20130612-104743/ust/uid/1000/64-bit

Upon reboot, can you confirm that the path is different ?

Thanks!
David

Amit Margalit:
> Hi,
> 
> My situation is this:
> 
> lttng-sessiond --no-kernel
> lttng-create foo
> lttng enable-channel channel0 -u --tracefile-size 67108864 --tracefile-count 13
> --buffers-uid --switch-timer 1000000 --num-subbuf 32
> lttng enable-event -u -a
> lttng start foo
> 
> Now this runs for a while collecting traces. I've run du -s on the trace
> directory, and saw that lttng-traces/ takes 2376KB.
> 
> The system was reboot, and upon startup, the exact same scenario as above is
> reproduced.
> 
> When I ran du to see the size of the lttng-traces/ directory, it was 1740KB.
> 
> Can you please help explain this? Is LTTng overwriting the existing trace files?
> 
> Thanks,
> 
> Amit Margalit
> IBM XIV - /Storage Reinvented/
> XIV-NAS Development Team
> Tel. 03-689-7774
> Fax. 03-689-7230
> 
> 
> This body part will be downloaded on demand.
