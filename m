From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Using same provider:tracepoint probe in
	several	processes
Date: Tue, 10 Mar 2015 13:05:08 +0000 (UTC)
Message-ID: <1293113871.267320.1425992707678.JavaMail.zimbra__32622.8715050549$1425992799$gmane$org@efficios.com>
References: <54F9C841.4080304@oneaccess-net.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YVJqe-0005T4-FO
 for lttng-dev@lists.lttng.org; Tue, 10 Mar 2015 09:05:28 -0400
In-Reply-To: <54F9C841.4080304@oneaccess-net.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Franck Balazot <franck.balazot@oneaccess-net.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Franck Balazot" <franck.balazot@oneaccess-net.com>
> To: lttng-dev@lists.lttng.org
> Sent: Friday, March 6, 2015 10:31:13 AM
> Subject: [lttng-dev] Using same provider:tracepoint probe in several	processes
> 
> Hi all,
> 
> I would like to know if it is possible to use the same
> provider:tracepoint probe in several processes, without getting
> following error :
> 
> LTTng-UST: Error (-17) while registering tracepoint probe. Duplicate
> registration of tracepoint probes having the same name is not allowed.
> Aborted (core dumped)
> 
> And how to do it ?

Yes, it is possible, but they need to have _exactly_ the
same signature. (same parameters and fields).

Thanks,

Mathieu

> 
> Franck
> 
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
