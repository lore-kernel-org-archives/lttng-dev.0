From: Matthew Khouzam <matthew.khouzam@ericsson.com>
Subject: Re: TMF current and future developments
Date: Thu, 11 Oct 2012 13:19:08 -0400
Message-ID: <5076FF8C.3040205__4646.40448703921$1349975991$gmane$org@ericsson.com>
References: <20121010160629.dcsyijhgooowckoo@mail.encs.concordia.ca>
	<5076FE7D.4050207@voxpopuli.im>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from imr4.ericy.com ([198.24.6.9])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <matthew.khouzam@ericsson.com>) id 1TMMPt-00019y-55
	for lttng-dev@lists.lttng.org; Thu, 11 Oct 2012 13:19:25 -0400
Received: from eusaamw0706.eamcs.ericsson.se ([147.117.20.31])
	by imr4.ericy.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id
	q9BHKDXf016933
	for <lttng-dev@lists.lttng.org>; Thu, 11 Oct 2012 12:20:22 -0500
In-Reply-To: <5076FE7D.4050207@voxpopuli.im>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

I would personally suggest checking out the state system. It is, in my
opinion, THE place to put abstracted events.
On 12-10-11 01:14 PM, Alexandre Montplaisir wrote:
> Hi Efraim,
>
> On 12-10-10 04:06 PM, Efraim Josue Lopez Sanchez wrote:
>> Hi,
>>
>> We are planning to build on top of TMF. Most recently we have tried
>> implementing some stuffs so that we can familiarize with TMF source
>> code. However, I've been wondering these last days about the future
>> plans/developments related to TMF. Is there any webpage/place/document
>> where I can find information regarding what are you guys
>> working/developing right now? And also about the future
>> developments/versions?
> If you want to track the very latest development, you can look at the
> patches that are going in for review on Gerrit, at
> https://git.eclipse.org/r/#/q/status:open+project:linuxtools/org.eclipse.linuxtools,n,z
> (not everything is related to TMF/LTTng, but it should be obvious what
> is by looking at the modified files).
>
> Most of it is targeted at the "lttng-kepler" branch on git, which should
> ultimately be part of the 2.0 release next June. If you want to try/test
> the latest code, you should use that branch.
>
> There is also a small list of planned features on
> http://eclipse.org/linuxtools/projectPages/lttng/ under "Future Plans".
>
> If you have any question about specific features, let us know!
>
>
> Cheers,
>
