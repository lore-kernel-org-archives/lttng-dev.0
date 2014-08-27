From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@ericsson.com>
Subject: Re: PERF PARAMETERS
Date: Wed, 27 Aug 2014 09:31:11 -0400
Message-ID: <53FDDD9F.8050301__20873.2082661756$1409146331$gmane$org@ericsson.com>
References: <CAPxN80B=S_dYb5kn_UA-sDyOZiMySrsvkWVtg5fDgdLd2V9z2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg20.ericsson.net ([198.24.6.45])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@ericsson.com>)
 id 1XMdJl-00008x-Rg
 for lttng-dev@lists.lttng.org; Wed, 27 Aug 2014 09:31:21 -0400
In-Reply-To: <CAPxN80B=S_dYb5kn_UA-sDyOZiMySrsvkWVtg5fDgdLd2V9z2Q@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Jessica,

When you say " lttng fails to activate" is it on the lttng add-context command or after looking at the trace ?

Can you give us the output from "lttng version"?

If possible can you send the complete sequence of action?

Thanks

On 08/26/2014 11:21 PM, Jessica Foest wrote:
> Hi 
> 
> i tried to retrieve system calls traces with all perf context parameters . the problem is that only a few PERF counters are activated and lttng fails to activate  the other perf context parameters.
> how can i solve it ?
> 
> regards 
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
