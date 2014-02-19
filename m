From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: Re: LTTng-ust 2.4.0-rc4 build error with uClibc
Date: Wed, 19 Feb 2014 10:00:15 +0100
Message-ID: <5304729F.5040706__25237.6134078533$1392800571$gmane$org@mentor.com>
References: <530382BA.2060301@teldat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1WG32X-0005iO-3x
	for lttng-dev@lists.lttng.org; Wed, 19 Feb 2014 04:02:04 -0500
In-Reply-To: <530382BA.2060301@teldat.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Santiago Font <sfont@teldat.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Santiago,

it looks like uClibc does not have proper support for dlinfo().

You have two options:

Switch to a different C library suitable for embedded systems that does
have proper support for dlinfo(): http://www.eglibc.org/home

Build without liblttng-ust-dl (simply remove it from the list of SUBDIRS
in the top-level Makefile.am) and accept that the following LTTng 2.4
feature is missing in your custom build:
http://git.lttng.org/?p=lttng-ust.git;a=blob_plain;f=doc/man/lttng-ust-dl.3;hb=HEAD


HTH,
Paul


On 02/18/2014 04:56 PM, Santiago Font wrote:
> Hi,
> 
> I'm trying to build LTTng-ust using uClibc and I get the following error:
> 
>                         ustdl.c:95:22: error: 'RTLD_DI_LINKMAP'
> undeclared (first use in this function)
> 
> Checking the file dlfcn.h from uClibc, the code defining that enum is
> disabled by:
> 
>                         #if 0 /* not supported by uClibc */
> 
> How can I fix this?
> 
> Thanks,
>               Santi
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Paul Woegerer, SW Development Engineer
Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
Mentor Graphics, Embedded Software Division
