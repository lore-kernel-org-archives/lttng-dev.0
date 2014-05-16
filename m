From: Gerlando Falauto <gerlando.falauto@keymile.com>
Subject: Re: lttng-ust missing tracepoints
Date: Fri, 16 May 2014 10:14:37 +0200
Message-ID: <5375C8ED.6000909__25469.9979829185$1400228140$gmane$org@keymile.com>
References: <5374FBDE.6030305@keymile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-de.keymile.com ([195.8.104.250])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <prvs=0213a97ac1=gerlando.falauto@keymile.com>)
 id 1WlDHz-00006w-GH
 for lttng-dev@lists.lttng.org; Fri, 16 May 2014 04:14:50 -0400
Received: from frodo.de.keymile.net ([10.9.1.54]:47735
 helo=mailrelay.de.keymile.net)
 by mail-de.keymile.com with esmtp (Exim 4.76)
 (envelope-from <gerlando.falauto@keymile.com>) id 1WlDHr-0001Mn-0P
 for lttng-dev@lists.lttng.org; Fri, 16 May 2014 10:14:39 +0200
Received: from chber1-10555x.ch.keymile.net (chber1-10555x.ch.keymile.net
 [172.31.40.82])
 by mailrelay.de.keymile.net (8.12.2/8.12.2) with ESMTP id s4G8EbLf001713
 for <lttng-dev@lists.lttng.org>; Fri, 16 May 2014 10:14:38 +0200 (MEST)
In-Reply-To: <5374FBDE.6030305@keymile.com>
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

following up on my own mail:

On 05/15/2014 07:39 PM, Gerlando Falauto wrote:
[...]

> If I put an additional tracef() call exactly where my tracepoint is
> located, this gets traced without a problem. So the infrastructure
> should be all working in my opinion.

I repeated my test by compiling the same tracepoint provider directly on 
the target, and linking it to a no-brainer main(), whose body simply 
calls tracepoint() and tracef(). And I now get the opposite result!

Now tracepoint() requests are perfectly recorded, whereas tracef() is 
nowhere to be seen.

Any hints?
Thank you!
Gerlando
