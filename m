From: Martin Townsend <martin.townsend@xsilon.com>
Subject: Re: lttng-modules how to automatically load my
 lttng_probe_xxx module
Date: Wed, 09 Jul 2014 13:34:57 +0100
Message-ID: <53BD36F1.7000208__37742.6668805585$1404909362$gmane$org@xsilon.com>
References: <53BD1FB4.8020001@xsilon.com> <53BD22BA.3030808@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mout.kundenserver.de ([212.227.126.130])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <martin.townsend@xsilon.com>) id 1X4r5V-0006zo-6I
 for lttng-dev@lists.lttng.org; Wed, 09 Jul 2014 08:35:10 -0400
In-Reply-To: <53BD22BA.3030808@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Woegerer, Paul" <Paul_Woegerer@mentor.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Thanks Paul, that's exactly what I was looking for.

-Martin

On 09/07/14 12:08, Woegerer, Paul wrote:
> On 07/09/2014 12:55 PM, Martin Townsend wrote:
>> Hi,
>>
>> Using the instructions from
>> http://lists.lttng.org/pipermail/lttng-dev/2013-October/021540.html
>> I have added my own kernel module to lttng-modules and can successfully
>> trace my own custom events.  I have to manually modprobe lttng_probe_xxx
>> to get it to work though.  Is there a way of doing this automatically?
> AFAIK, currently you still also need to add your module to:
> http://git.lttng.org/?p=lttng-tools.git;a=blob;f=src/bin/lttng-sessiond/modprobe.c;hb=HEAD
>
> HTH,
> Paul
>
>> Best Regards,
>> Martin.
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
