From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Userspace RCU VS spin locks
Date: Thu, 31 Oct 2013 11:36:01 +0000 (UTC)
Message-ID: <990689914.54025.1383219361284.JavaMail.zimbra__9653.6120785915$1383219406$gmane$org@efficios.com>
References: <CAO6Ho0ch2U2r5Ept2qFkOh1_Hxm6FcawsrzEmRQDEVi+KM5+tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VbqXk-0002zX-QD
	for lttng-dev@lists.lttng.org; Thu, 31 Oct 2013 07:36:07 -0400
In-Reply-To: <CAO6Ho0ch2U2r5Ept2qFkOh1_Hxm6FcawsrzEmRQDEVi+KM5+tA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Evgeniy Ivanov <lolkaantimat@gmail.com>
Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Evgeniy Ivanov" <lolkaantimat@gmail.com>
> To: lttng-dev@lists.lttng.org
> Sent: Wednesday, October 30, 2013 9:11:47 AM
> Subject: [lttng-dev] Userspace RCU VS spin locks
> 
> Hi,
> 
> I'm very interested in RCU performance, especially applied to hash
> tables (rculfhash in particular). Did any body compare performance of
> QSBR or signal RCU VS scalable and non-scalable spin locks?
> 

Hi Evgeniy,

You'll probably want to start by looking at my Linux Plumbers slides presenting rculfhash:

https://www.efficios.com/lpc2011-urcu

Also, Paul McKenney's slides of the Userspace RCU tutorial here present other numbers of a hash table example (including bucket-locks), AFAIK using his own statically sized hash table implementation (not rculfhash):

https://events.linuxfoundation.org/sites/events/files/slides/userspace-rcu-tutorial-linuxcon-2013.pdf

Thanks,

Mathieu



> --
> Cheers,
> Evgeniy
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
