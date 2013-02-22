From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Stream trace data over PCIe (or anything else)
Date: Thu, 21 Feb 2013 21:04:07 -0500
Message-ID: <20130222020407.GA15200__29790.6067492024$1361498693$gmane$org@Krystal>
References: <CAFXXi0=Tf3nEefTvv4EccZVMVg+73xrwdROK=a=zVyV8jmOjTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1U8hzd-0000RK-9S
	for lttng-dev@lists.lttng.org; Thu, 21 Feb 2013 21:04:09 -0500
Content-Disposition: inline
In-Reply-To: <CAFXXi0=Tf3nEefTvv4EccZVMVg+73xrwdROK=a=zVyV8jmOjTA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Simon Marchi <simon.marchi@polymtl.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Simon Marchi (simon.marchi@polymtl.ca) wrote:
> Hello LTTng cyborgs,
> 
> As some of you might know, I am trying to port and adapt LTTng to the
> Tilera TILEncore-Gx card (and later the Intel Xeon Phi). The main
> constraint with these platforms is the non existent disk space, which
> means the trace will have to be streamed. I am thinking of using the
> PCI express connection the two cards have to stream the trace data and
> save it on the host. It seems like this use case is similar to what
> the network consumer and relayd offer, but simply on another medium.
> 
> The consumer currently has two destination types: local and net (enum
> consumer_dst_type in bin/lttng-sessiond/consumer.h). I understand that
> I could create another type of consumer which sends data over the PCI
> port instead. On the other side of the bus, I could adapt relayd to
> receive on the PCI port of the host and save the trace as it currently
> does for the network.
> 
> I would like to hear your comments about this approach. Does it sound
> right, is there a better way ? Would it be worth it to design a system
> that would make it easier to add a new type of "transport" for the
> trace data ?

Is it possible to bind a network interface between the tilera and the
host that uses the PCI express port ?

Thanks,

Mathieu

> 
> Thanks !
> 
> Simon
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
