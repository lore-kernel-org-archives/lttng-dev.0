From: Gerlando Falauto <gerlando.falauto@keymile.com>
Subject: linking of tracepoint probes
Date: Tue, 20 May 2014 18:09:00 +0200
Message-ID: <537B7E1C.3080802__35057.3630109013$1400602228$gmane$org@keymile.com>
References: <5374FBDE.6030305@keymile.com> <5375C8ED.6000909@keymile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-de.keymile.com ([195.8.104.250])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <prvs=021750aae6=gerlando.falauto@keymile.com>)
 id 1WmmbF-0002HY-Kv
 for lttng-dev@lists.lttng.org; Tue, 20 May 2014 12:09:15 -0400
Received: from frodo.de.keymile.net ([10.9.1.54]:56683
 helo=mailrelay.de.keymile.net)
 by mail-de.keymile.com with esmtp (Exim 4.76)
 (envelope-from <gerlando.falauto@keymile.com>) id 1Wmmb7-0005Kv-1d
 for lttng-dev@lists.lttng.org; Tue, 20 May 2014 18:09:01 +0200
Received: from chber1-10555x.ch.keymile.net (chber1-10555x.ch.keymile.net
 [172.31.40.82])
 by mailrelay.de.keymile.net (8.12.2/8.12.2) with ESMTP id s4KG90Lf029755
 for <lttng-dev@lists.lttng.org>; Tue, 20 May 2014 18:09:00 +0200 (MEST)
In-Reply-To: <5375C8ED.6000909@keymile.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

I played a bit more and came to the following conclusion:

- if I compile the application statically (so the tracepoint calls as 
well as their providers are linked with the main executable), 
tracepoints work but tracef() doesn't

- if I compile and link the tracepoints, as well as the tracepoint 
calls, within a shared library, tracef() works but the tracepoint doesn't

- if I change the above setting and recompile without cleaning first, I 
end up with the following message:

LTTng-UST: Error (-17) while registering tracepoint probe. Duplicate 
registration of tracepoint probes having the same name is not allowed.
Aborted

So this means I'm doing something wrong with linking and/or libraries.
As if I had the same symbol defined in two different places and one 
would win over the other according to how I'm compiling.
Since I really have no clue how this whole machinery works, could 
someone please shed some light on this topic?

Thank you!
Gerlando

On 05/16/2014 10:14 AM, Gerlando Falauto wrote:
> Hi,
>
> following up on my own mail:
>
> On 05/15/2014 07:39 PM, Gerlando Falauto wrote:
> [...]
>
>> If I put an additional tracef() call exactly where my tracepoint is
>> located, this gets traced without a problem. So the infrastructure
>> should be all working in my opinion.
>
> I repeated my test by compiling the same tracepoint provider directly on
> the target, and linking it to a no-brainer main(), whose body simply
> calls tracepoint() and tracef(). And I now get the opposite result!
>
> Now tracepoint() requests are perfectly recorded, whereas tracef() is
> nowhere to be seen.
>
> Any hints?
> Thank you!
> Gerlando
