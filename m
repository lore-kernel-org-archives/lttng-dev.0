From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: Re: Getting function names with	lttng-ust-cyg-profile.so
Date: Tue, 10 Sep 2013 17:45:25 +0200
Message-ID: <522F3E95.7000203__29112.5382799239$1378827993$gmane$org@mentor.com>
References: <522E4FCE.7070000@voxpopuli.im> <20130909234409.GA11082@Krystal>
	<522EC38B.6000501@mentor.com> <522F3CC1.5060005@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1VJQ8E-0002FW-Vm
	for lttng-dev@lists.lttng.org; Tue, 10 Sep 2013 11:45:40 -0400
In-Reply-To: <522F3CC1.5060005@ericsson.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Matthew Khouzam <matthew.khouzam@ericsson.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

On 09/10/2013 05:37 PM, Matthew Khouzam wrote:
> On 13-09-10 03:00 AM, Woegerer, Paul wrote:
>> Hi Alexandre,
>>
>> For trivial examples you can go with 'nm -CS' (or the like), but when
>> you start to use liblttng-ust-cyg-profile.so in combination with shared
>> objects you will need to record base address information as well (to
>> allow you map a virtual memory address at a given point in time to
>> offset and path of a shared object (or executable)).
>>
>> That is one of the reasons why I have submitted:
>> http://lists.lttng.org/pipermail/lttng-dev/2013-August/021264.html
> This is a very interesting approach, +1 from me on that.

Thanks.

With that approach no redundant data (that is already available as
debuginfo) gets replicated in the actual trace data.
Only the bare minimum of information gets traced to allow you at any
time to map a VM address to a debuginfo address + debuginfo location.

-- 
Paul Woegerer, SW Development Engineer
Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
Mentor Graphics, Embedded Software Division
