From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: clock_gettime vdso issue
Date: Thu, 26 Mar 2015 16:33:16 +0000 (UTC)
Message-ID: <1722941338.111044.1427387596544.JavaMail.zimbra__36082.4953801513$1427387697$gmane$org@efficios.com>
References: <cf147ee4-5d02-423f-a352-672a739809d4@aliyun.com>
 <DUB123-W38081C479AED1FCAFCDED3DD080@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YbAig-00057c-NG
 for lttng-dev@lists.lttng.org; Thu, 26 Mar 2015 12:33:32 -0400
In-Reply-To: <DUB123-W38081C479AED1FCAFCDED3DD080@phx.gbl>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jesper Derehag <jderehag@hotmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Yes, the clock override feature, as well as the getcpu override,
should be merged within lttng-ust and lttng-tools master branches
this week. Stay tuned!

Thanks,

Mathieu

----- Original Message -----
> There has been discussions regarding adding capability to override the clock
> implementation.
> 
> If that support is arriving, you could always write your own (say a separate
> thread reading clock periodically and storing in a cache, then your own
> clock implementation could get that cached timestamp).
> Obviously you would need to think very carefully about clock resolution and
> frequency for your clock thread, but it should from a performance point of
> view be big improvement..
> 
> Maybe Mathieu(?) could shed some light on the clock override?
> 
> /Jesper
> 
> ________________________________
> > Date: Thu, 26 Mar 2015 15:25:49 +0800
> > From: zhenyu.ren@aliyun.com
> > To: lttng-dev@lists.lttng.org
> > Subject: [lttng-dev] clock_gettime vdso issue
> > 
> > 
> > Hi,Team
> > 
> > You may not feel how painful I am with a too old GLIBC which does
> > NOT support vdso clock_gettime. Especially in ust case,
> > trace_clock_read will call clock_gettime to record the time of every
> > event.
> > Does anyone know how to avoid system_call clock_gettime with this old
> > GLIBC??
> > 
> > Thanks in advance
> > zhenyu.ren
> > 
> > 
> > _______________________________________________ lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
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
