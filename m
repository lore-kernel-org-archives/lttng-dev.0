From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: LTTng
Date: Fri, 20 Jul 2012 13:02:33 -0400
Message-ID: <20120720170233.GA18851__5249.01593239537$1342803782$gmane$org@Krystal>
References: <C3E76F4DB674C24BA475182F42DDE8B54E5ACE@SOM-EXCH02.nuance.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1SsGb5-0007wC-Eb
	for lttng-dev@lists.lttng.org; Fri, 20 Jul 2012 13:02:35 -0400
Content-Disposition: inline
In-Reply-To: <C3E76F4DB674C24BA475182F42DDE8B54E5ACE@SOM-EXCH02.nuance.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Alawneh, Luay" <Luay.Alawneh@nuance.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

One small detail to keep in mind at this point: only the "discard" and
"overwrite" modes are implemented for handling buffer condition. If you
need to ensure that events are _never_ discarded, even with
high-throughput scenarios, we might need to implement a "blocking" mode,
which makes the application wait until there is space free in the buffer
before it continues. It would probably make more sense for logging.

Other than this detail, LTTng-UST would be a good fit for low-overhead
logging.

Thanks,

Mathieu

* Alawneh, Luay (Luay.Alawneh@nuance.com) wrote:
> Hi,
> 
> I am reading about LTTng and I would like to know if it can replace Log4c for logging user space events in the production environment. In addition to the method enter/exit events we also use Log4c to log many other events to indicate errors and other useful information.
> 
> To summarize, I would like to know if LTTng can be used in a production environment for logging different types of events. We are planning to replace Log4c with another logging framework to improve the performance by reducing the time spent in logging.
> 
> Thanks,
> 
> Luay Alawneh
> Nuance Communications
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
