From: Santiago Font <sfont@teldat.com>
Subject: Re: LTTng-ust 2.4.0-rc4 build error with uClibc
Date: Thu, 20 Feb 2014 12:35:12 +0100
Message-ID: <5305E870.5060204__22923.9737768241$1392897144$gmane$org@teldat.com>
References: <530382BA.2060301@teldat.com> <5304729F.5040706@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.teldat.com ([195.53.62.69])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <sfont@teldat.com>) id 1WGRuQ-0001wW-Nr
	for lttng-dev@lists.lttng.org; Thu, 20 Feb 2014 06:35:23 -0500
In-Reply-To: <5304729F.5040706@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Woegerer, Paul" <Paul_Woegerer@mentor.com>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Paul,
      Thank you very much for your help.

      Santi

On 19/02/14 10:00, Woegerer, Paul wrote:
> Hi Santiago,
>
> it looks like uClibc does not have proper support for dlinfo().
>
> You have two options:
>
> Switch to a different C library suitable for embedded systems that does
> have proper support for dlinfo(): http://www.eglibc.org/home
>
> Build without liblttng-ust-dl (simply remove it from the list of SUBDIRS
> in the top-level Makefile.am) and accept that the following LTTng 2.4
> feature is missing in your custom build:
> http://git.lttng.org/?p=lttng-ust.git;a=blob_plain;f=doc/man/lttng-ust-dl.3;hb=HEAD
>
>
> HTH,
> Paul
>
>
> On 02/18/2014 04:56 PM, Santiago Font wrote:
>> Hi,
>>
>> I'm trying to build LTTng-ust using uClibc and I get the following error:
>>
>>                          ustdl.c:95:22: error: 'RTLD_DI_LINKMAP'
>> undeclared (first use in this function)
>>
>> Checking the file dlfcn.h from uClibc, the code defining that enum is
>> disabled by:
>>
>>                          #if 0 /* not supported by uClibc */
>>
>> How can I fix this?
>>
>> Thanks,
>>                Santi
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
