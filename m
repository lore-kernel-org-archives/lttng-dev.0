From: "Polzer, Franz" <Franz_Polzer@mentor.com>
Subject: Re: Test pid_ns in local build
Date: Thu, 19 Sep 2019 06:10:24 +0000
Message-ID: <8132a2ff30f649c49c50246545302804__31606.5505075798$1568873585$gmane$org@SVR-IES-MBX-04.mgc.mentorg.com>
References: <5a49b436d1cd4659b96dfcaffe63b38e@SVR-IES-MBX-04.mgc.mentorg.com>
 <e01b5c8b-9534-e726-e5cd-eb499ef3bc43@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from esa1.mentor.iphmx.com (esa1.mentor.iphmx.com [68.232.129.153])
 by lists.lttng.org (Postfix) with ESMTPS id 46Ymfv1d16zpVg
 for <lttng-dev@lists.lttng.org>; Thu, 19 Sep 2019 02:10:30 -0400 (EDT)
In-Reply-To: <e01b5c8b-9534-e726-e5cd-eb499ef3bc43@efficios.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Michael,

Many thanks for your help!

Is there any schedule bringing that feature into LTTng master?

Thanks and br,
Franz

-----Original Message-----
From: lttng-dev [mailto:lttng-dev-bounces@lists.lttng.org] On Behalf Of Michael Jeanson
Sent: Dienstag, 17. September 2019 16:06
To: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] Test pid_ns in local build

On 2019-09-17 4:03 a.m., Polzer, Franz wrote:
> Hello,
> 
> I wanted to give the pid_ns context tracing a try and built LTTng from 
> master, but I get the following error when applying this command:
> 
> lttng add-context -k -t procname -t pid -t vpid -t tid -t vtid -t 
> pid_ns
> 
> Error: Unknown context type pid_ns
> 
> Maybe I need another branch to build from to get that feature in or 
> forgot to enable the feature during building?
> 
> Where can I find documentation about the pid_ns tracing and how to 
> test the current version of that implementation?
> 
> Thanks for your help and best regards,
> 
> Franz


Hi,

The namespace statedump and contexts feature has not been merged in master yet. You can get it from my github in the "ns" feature branches.

https://github.com/mjeanson/lttng-modules/tree/ns
https://github.com/mjeanson/lttng-ust/tree/ns
https://github.com/mjeanson/lttng-tools/tree/ns

It's a bit out of date but should work as-is, or it can be easily rebased on current master branches.


Cheers,

Michael
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
