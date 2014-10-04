From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: FD leak in accept error
	handling
Date: Sat, 4 Oct 2014 13:32:41 +0000 (UTC)
Message-ID: <1834426896.2958.1412429561019.JavaMail.zimbra__1674.3418797434$1412429624$gmane$org@efficios.com>
References: <1411861762-17552-1-git-send-email-mathieu.desnoyers@efficios.com>
 <42225267.2928.1412429042743.JavaMail.zimbra@efficios.com>
 <20141004132739.GA6774@thessa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1XaPSG-0001sD-MI
 for lttng-dev@lists.lttng.org; Sat, 04 Oct 2014 09:33:01 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id A8AE63401B7
 for <lttng-dev@lists.lttng.org>; Sat,  4 Oct 2014 13:32:55 +0000 (UTC)
In-Reply-To: <20141004132739.GA6774@thessa>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

OK, thanks! I did not see any reply to the email, this
is why I was wondering what happened there.

----- Original Message -----
> From: "David Goulet" <dgoulet@efficios.com>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: lttng-dev@lists.lttng.org
> Sent: Saturday, October 4, 2014 9:27:39 AM
> Subject: Re: [PATCH lttng-tools] Fix: FD leak in accept error handling
> 
> That has been fix.
> 
> commit 475cd9fa36ab2ad108f94bb8292bdcdbbbc6e38f
> 
> This was a coverity issue fixed on sept. 30th.
> 
> David
> 
> On 04 Oct (13:24:02), Mathieu Desnoyers wrote:
> > Bump.
> > 
> > ----- Original Message -----
> > > From: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> > > To: dgoulet@efficios.com
> > > Cc: lttng-dev@lists.lttng.org, "Mathieu Desnoyers"
> > > <mathieu.desnoyers@efficios.com>
> > > Sent: Saturday, September 27, 2014 7:49:22 PM
> > > Subject: [PATCH lttng-tools] Fix: FD leak in accept error handling
> > > 
> > > *** CID 1241799:  Resource leak  (RESOURCE_LEAK)
> > > /src/common/sessiond-comm/inet.c: 324 in lttcomm_accept_inet_sock()
> > > 318
> > > 319     end:
> > > 320             return new_sock;
> > > 321
> > > 322     error:
> > > 323             free(new_sock);
> > > >>>     CID 1241799:  Resource leak  (RESOURCE_LEAK)
> > > >>>     Handle variable "new_fd" going out of scope leaks the handle.
> > > 324             return NULL;
> > > 325     }
> > > 326
> > > 327     /*
> > > 328      * Make the socket listen using LTTNG_SESSIOND_COMM_MAX_LISTEN.
> > > 329      */
> > > 
> > > Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > ---
> > >  src/common/sessiond-comm/inet.c | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/src/common/sessiond-comm/inet.c
> > > b/src/common/sessiond-comm/inet.c
> > > index cf06ecb..4e34ad0 100644
> > > --- a/src/common/sessiond-comm/inet.c
> > > +++ b/src/common/sessiond-comm/inet.c
> > > @@ -272,7 +272,7 @@ error_connect:
> > >  LTTNG_HIDDEN
> > >  struct lttcomm_sock *lttcomm_accept_inet_sock(struct lttcomm_sock *sock)
> > >  {
> > > -	int new_fd;
> > > +	int new_fd, closeret;
> > >  	socklen_t len;
> > >  	struct lttcomm_sock *new_sock;
> > >  	unsigned long timeout;
> > > @@ -305,10 +305,18 @@ struct lttcomm_sock
> > > *lttcomm_accept_inet_sock(struct
> > > lttcomm_sock *sock)
> > >  
> > >  		ret = lttcomm_setsockopt_rcv_timeout(new_fd, timeout);
> > >  		if (ret) {
> > > +			closeret = close(new_fd);
> > > +			if (closeret) {
> > > +				PERROR("close");
> > > +			}
> > >  			goto error;
> > >  		}
> > >  		ret = lttcomm_setsockopt_snd_timeout(new_fd, timeout);
> > >  		if (ret) {
> > > +			closeret = close(new_fd);
> > > +			if (closeret) {
> > > +				PERROR("close");
> > > +			}
> > >  			goto error;
> > >  		}
> > >  	}
> > > --
> > > 2.1.0
> > > 
> > > 
> > 
> > --
> > Mathieu Desnoyers
> > EfficiOS Inc.
> > http://www.efficios.com
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
