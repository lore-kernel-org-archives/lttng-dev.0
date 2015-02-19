From: Neil Bryan <Neil.Bryan@ttp.com>
Subject: Re: lttng-tracer missing
Date: Thu, 19 Feb 2015 14:44:18 +0000
Message-ID: <8369DAE2C5B8814998E89CE414A915381F6B7E6C__17728.4392215826$1424357146$gmane$org@IT-Mailbox3.TTPGroup.com>
References: <8369DAE2C5B8814998E89CE414A915381F6B7DC2@IT-Mailbox3.TTPGroup.com>
 <54E5F553.2030802@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.139])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Neil.Bryan@ttp.com>) id 1YOSLP-0003M2-MD
 for lttng-dev@lists.lttng.org; Thu, 19 Feb 2015 09:44:48 -0500
In-Reply-To: <54E5F553.2030802@mentor.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Nathan Lynch <Nathan_Lynch@mentor.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On 02/19/2015 03:02 AM, Neil Bryan wrote:
> Hi Nathan,
> 
> Thank you for the prompt response. I have fixed the kernel tracing problem and indeed your diagnosis was accurate.

I'm glad to have helped, but...

> Step 4) Within the recipe 
> ~/yocto/meta/recipes-kernel/lttng-2.0/lttng-modules_2.0.5.bb
> 
> Change the following lines:
> 
> SRCREV = "4d3e89e379fc66480d729abe8daa5c86eb585400"
> PV = "2.0.pre11+git${SRCREV}"
> 
> To:
> 
> SRCREV = "497051bdaa2b09c77860eb3be4f93fc4975e388e"
> PV = "2.0.pre12+git${SRCREV}"
> 
> The SRCREV is now pointing at the commit checksum and the package revision is now 2.0.pre12.

This is still very old... I should have been more explicit earlier: you should try to use version 2.5.x or later (both modules and tools) in order to get help with runtime issues here.

I see. My concern is that, at this stage, I am stuck with version 3.7 of the kernel. I shall try modifying the bitbake recipe to pick up more recent versions of modules and tools, but this could send me into a different world of pain (I am new to Yocto and LTTng integration).

My plan is to migrate to a much more recent version of kernel and LTTng when my confidence increases, but Altera provide a snapshot of the Yocto sources and at the moment I am not brave enough to wander too far away from that.
