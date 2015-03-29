From: Michael Haberler <mail17@mah.priv.at>
Subject: Re: introduction  & usage of LTTNG in machinekit
Date: Sun, 29 Mar 2015 18:06:09 +0200
Message-ID: <5DF2E8F0-B241-43FB-8811-C2CCAC028482__34011.3223800019$1427645246$gmane$org@mah.priv.at>
References: <887B7027-5FE6-4D13-B35A-7DCBD785DC57@mah.priv.at>
 <711173584.2718642.1427481342189.JavaMail.zimbra@polymtl.ca>
 <8187A8CE-F16D-4CDE-B969-380DE308A8D5@mah.priv.at>
 <826926538.3126946.1427639461728.JavaMail.zimbra@polymtl.ca>
 <76BAB974-2B32-469C-82AD-4D5630AFA28E@mah.priv.at>
 <55181EA5.7020402@efficios.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mah2.mah.priv.at ([86.59.12.251] helo=mah.priv.at)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mail17@mah.priv.at>) id 1YcFj1-0001ge-LX
 for lttng-dev@lists.lttng.org; Sun, 29 Mar 2015 12:06:21 -0400
In-Reply-To: <55181EA5.7020402@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Julien -

thanks a lot - cloned, and quickly at it!

bets regards

Michael

> Am 29.03.2015 um 17:47 schrieb Julien Desfossez <jdesfossez@efficios.com>:
> 
> Hi,
> 
> On 15-03-29 11:17 AM, Michael Haberler wrote:
>> Michel,
>> 
>>> Am 29.03.2015 um 16:31 schrieb Michel Dagenais <michel.dagenais@polymtl.ca>:
>>> 
>>> 
>>>> - is there a complete example out-of-tree kernel module instrumented for
>>>> LTTng? I worked through Steve Rostedt's sillymod
>>>> (http://lwn.net/Articles/379903 ff) but am fuzzy on "Adding the LTTng
>>>> adaptation layer" - is the example from the manual available in toto
>>>> somewhere?
>>> 
>>> A few people in my group have done so. I will check on Monday to get sample code for you.
>> 
>> on re-reading, I am almost there, but I'd appreciate an example anyway
> 
> I have a complete example of instrumenting an out-of-tree module in the
> latency_tracker and the patch for lttng-modules (master) in the "extras"
> folder:
> https://github.com/jdesfossez/latency_tracker
> 
> It might be very slow due to access the page to the DDoS in progress, if
> you need it quickly, I'll send you a tar.
> 
> Julien
