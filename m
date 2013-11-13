From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: Re: [RELEASE] LTTng-UST 2.3.1
Date: Wed, 13 Nov 2013 13:24:35 +0100
Message-ID: <52836F83.7030005__46441.4189373658$1384345539$gmane$org@mentor.com>
References: <26867984.65245.1384277317013.JavaMail.zimbra@efficios.com>
	<188953759.65246.1384277374704.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1VgZV0-00011e-Hg
	for lttng-dev@lists.lttng.org; Wed, 13 Nov 2013 07:24:47 -0500
In-Reply-To: <188953759.65246.1384277374704.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org, dgoulet@efficios.com
List-Id: lttng-dev@lists.lttng.org

Hi David,

Please also create a v2.3.1 for lttng-tools stable-2.3 so that I can
update all the lttng recipes for yocto/oe-core:
(see:
http://cgit.openembedded.org/openembedded-core/tree/meta/recipes-kernel/lttng)

Many Thanks,
Paul

On 11/12/2013 06:29 PM, Mathieu Desnoyers wrote:
> ----- Original Message -----
>> From: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
>> To: lttng-dev@lists.lttng.org
>> Sent: Tuesday, November 12, 2013 12:28:37 PM
>> Subject: [RELEASE] LTTng-UST 2.3.1
>>
>> LTTng-UST, the Linux Trace Toolkit Next Generation Userspace Tracer, is
>> port of the low-overhead tracing capabilities of the LTTng kernel tracer
>> to user-space. The library "liblttng-ust" enables tracing of
>> applications and libraries.
>>
>> Changelog:
>> 2012-11-12 lttng-ust 2.3.1
> I meant 2013-11-12. This is correct in the Changelog file.
>
> Thanks,
>
> Mathieu
>
>>         * Fix: application SIGBUS when starting in parallel with sessiond
>>         * Fix: Minor corrections to the lttng-ust man page
>>         * Documentation cleanup: Overhaul of the lttng-gen-tp man page
>>         * Warning cleanup: add missing padding initializer
>>         * Fix: socket connect hang on heavy loads
>>         * Cleanup: fix typo
>>         * Fix: ust-comm recvmsg should handle partial receive
>>         * gcc warning fix: -Wextra
>>         * Add usage reference count for tracepoints
>>         * tracepoint.c: Move add_callsite/remove_callsite further down in
>>         file
>>         * Store the callsites into the library callsite list
>>         * Fix linking warning
>>
>> Project website: http://lttng.org
>> Download link: http://lttng.org/download
>> (please refer to the README file for installation instructions)
>>
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> http://www.efficios.com
>>


-- 
Paul Woegerer, SW Development Engineer
Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
Mentor Graphics, Embedded Software Division
