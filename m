From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Re: Runtime declare tracepoint events
Date: Tue, 04 Aug 2015 12:51:20 -0400
Message-ID: <55C0ED88.7060003__9064.7297133275$1438707161$gmane$org@efficios.com>
References: <BLU169-W81640A18289FB36E6C1DADAB890@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1ZMfR2-0007u5-H3
 for lttng-dev@lists.lttng.org; Tue, 04 Aug 2015 12:51:29 -0400
In-Reply-To: <BLU169-W81640A18289FB36E6C1DADAB890@phx.gbl>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jeffrey Chen <cpthk@hotmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

Just to make sure we are talking about the same thing, do you mean that
you don't know at compile time where the instrumentation sites are in
the code (not supported in LTTng for now), or that you don't know which
one you want to enable (record). If it is the latter case, LTTng
supports enabling/disabling events at runtime (see the "lttng
enable-event" command).

Julien

On 15-07-31 10:39 PM, Jeffrey Chen wrote:
> Hi:
> 
> This is a requirement for us, we do not know the events during compile
> time. I am wondering is it easy to do to register tracepoint events
> during runtime. Has this been done before? Is there any document about
> it? Thanks.
> 
>  
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
